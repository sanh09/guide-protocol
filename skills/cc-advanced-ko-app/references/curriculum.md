# 커리큘럼: Claude Code 고급

> 퀴즈 문제 은행의 정답은 이 파일에 없다. 정답은 `quiz-answers.md`에 문제 번호(예: L3-2)별로 있고, 학습자가 답한 뒤 채점할 때만 읽는다. 문제를 낼 때는 보기 순서를 섞는다.

수업할 레슨 부분만 읽는다. 사실 확인은 `facts.md`. 실습은 **연습용 저장소**에서 먼저 한다(훅·MCP·자동화는 실제 명령을 실행하기 때문이다).

연습 저장소 준비:
```bash
mkdir cc-adv-practice && cd cc-adv-practice && git init
echo '{"name":"cc-adv-practice","scripts":{"test":"echo ok"}}' > package.json
git add -A && git commit -m init
claude
```

목차
- 레슨 1. 확장 기능 지도: 무엇을 언제 쓰나
- 레슨 2. MCP 서버 연결
- 레슨 3. 커스텀 서브에이전트
- 레슨 4. 훅(hooks)
- 레슨 5. 스킬 심화와 플러그인 제작·배포
- 레슨 6. 자동화: `-p`, `--bare`, CI, GitHub Actions
- 레슨 7. 병렬 작업과 리뷰 패턴
- 졸업 과제

레슨 1 다음 추천 순서: 개인 생산성이 목표면 3 → 5 → 2 → 4 → 7 → 6, 팀 자동화가 목표면 4 → 6 → 5 → 2 → 3 → 7.

---

## 레슨 1. 확장 기능 지도

**목표**: 원하는 결과에 맞는 확장 기능을 고를 수 있다.

| 하고 싶은 것 | 쓸 기능 | 이유 |
|---|---|---|
| 항상 지켜야 할 짧은 규칙·명령 | CLAUDE.md | 매 세션 로드. 단, 권고일 뿐 강제는 아니다 |
| 가끔 필요한 절차·도메인 지식, `/이름` 명령 | 스킬 | 필요할 때만 로드해서 컨텍스트를 아낀다 |
| **반드시, 예외 없이** 일어나야 하는 동작(포맷, 차단, 알림) | 훅 | 결정적(deterministic). LLM의 판단에 맡기지 않는다 |
| 많은 파일을 읽는 조사, 독립적인 리뷰 | 서브에이전트 | 별도 컨텍스트에서 작업하고 요약만 돌려준다 |
| 외부 시스템(Notion, DB, Figma, 이슈 트래커) | MCP | 외부 도구·데이터에 직접 접근한다 |
| 위의 것들을 묶어 팀·남과 공유 | 플러그인 | 한 번에 설치·업데이트 |
| 외부 서비스에 CLI가 있다면 | CLI 도구(`gh`, `aws` 등) | 컨텍스트를 가장 적게 쓴다 |

핵심: "CLAUDE.md에 '절대 X 하지 마'라고 썼는데 가끔 어긴다" → 훅이나 권한 deny로 옮긴다.

실습: 학습자의 고민 3가지를 듣고 각각 어떤 기능으로 풀지 함께 표로 정리한다.

퀴즈 문제 은행
- **L1-1.** "파일을 수정할 때마다 반드시 prettier를 실행"하려면? ① CLAUDE.md ② 훅 ③ 서브에이전트 ④ MCP
- **L1-2.** 사내 Notion 문서를 읽고 기능을 구현하게 하려면? ① 훅 ② MCP ③ CLAUDE.md ④ /compact
- **L1-3.** 리팩터링 결과를 편견 없이 검토하게 하려면? ① 같은 대화에서 "검토해줘" ② 새 컨텍스트의 서브에이전트에게 diff 리뷰 맡기기 ③ CLAUDE.md에 "잘 검토해" ④ /rewind
- **L1-4.** CLAUDE.md의 "migrations 폴더 수정 금지"를 Claude가 가끔 어긴다. 확실한 방법은? ① 문장을 대문자로 ② PreToolUse 훅이나 Edit deny 규칙 ③ 더 길게 설명 ④ /clear

---

## 레슨 2. MCP 서버 연결

**목표**: 원격(HTTP)·로컬(stdio) MCP 서버를 알맞은 범위(scope)로 추가하고 상태를 확인한다.

핵심 개념
- MCP = AI와 외부 도구를 잇는 공개 표준. 서버를 추가하면 Claude가 그 시스템의 도구를 쓸 수 있다.
- 원격: `claude mcp add --transport http notion https://mcp.notion.com/mcp`
- 로컬: `claude mcp add --env AIRTABLE_API_KEY=YOUR_KEY --transport stdio airtable -- npx -y airtable-mcp-server`. `--` 뒤는 서버 실행 명령이다.
- 범위: `local`(기본, 나만·이 프로젝트, `~/.claude.json`) / `project`(`.mcp.json`, 팀 공유) / `user`(나만·모든 프로젝트).
- `.mcp.json`은 `${VAR}` 환경 변수 확장을 지원한다. 토큰은 여기에 직접 쓰지 않는다.
- 상태 확인: 세션에서 `/mcp`(연결 상태, 도구 수, OAuth 로그인), 터미널에서 `claude mcp list`, `claude mcp get <이름>`, `claude mcp remove <이름>`.
- `@서버:리소스`로 MCP 리소스를 참조할 수 있다. 예: `@github:repos/owner/repo/issues`
- 보안: `.mcp.json`의 서버는 처음 쓸 때 승인을 묻는다. 모르는 서버는 승인하지 않는다.

실습
1. 학습자가 쓰는 서비스 중 공식 MCP 서버가 있는 것을 골라 `--scope local`로 추가한다(없으면 문서의 예시 서버).
2. `/mcp`로 상태 확인. 필요하면 인증.
3. 같은 서버를 `--scope project`로 추가하면 `.mcp.json`이 어떻게 생기는지 확인(토큰은 `${VAR}`로).
4. 실습이 끝나면 `claude mcp remove`로 정리.

퀴즈 문제 은행
- **L2-1.** 팀원 모두가 같은 MCP 서버 설정을 git으로 공유하려면? ① `--scope local` ② `--scope project` ③ `--scope user` ④ CLAUDE.md에 URL 적기
- **L2-2.** `claude mcp add ... airtable -- npx -y airtable-mcp-server`에서 `--`의 의미는? ① 주석 ② Claude 옵션과 서버 실행 명령을 구분 ③ 백그라운드 실행 ④ 오류 무시
- **L2-3.** MCP 서버가 `! Needs authentication`으로 보인다면? ① `/mcp`에서 서버를 골라 로그인 ② `/clear` ③ 재설치 ④ settings.json 삭제
- **L2-4.** `.mcp.json`에 API 토큰을 넣는 가장 안전한 방법은? ① 토큰을 그대로 적고 커밋 ② `${MY_TOKEN}`처럼 환경 변수로 참조 ③ CLAUDE.md에 적기 ④ 파일 이름에 넣기

---

## 레슨 3. 커스텀 서브에이전트

**목표**: 역할·도구·모델이 정해진 서브에이전트를 만들고 호출한다.

핵심 개념
- 서브에이전트 = 자기 컨텍스트, 시스템 프롬프트, 도구 권한을 가진 전문 보조. 끝나면 요약만 메인 대화로 돌려준다. 사용량은 메인 대화와 같은 한도에서 차감된다.
- 기본 제공: `Explore`(빠른 읽기 전용 탐색), `Plan`(plan 모드 조사, 읽기 전용), `general-purpose`(탐색과 수정을 함께).
- 위치: `.claude/agents/`(프로젝트, 커밋해서 공유), `~/.claude/agents/`(개인). 머리말의 `name`과 `description`은 필수, `tools`와 `model`은 선택.
- 호출: 자동(description을 보고 위임. "use proactively"라고 쓰면 더 자주 위임한다), 자연어("test-runner 서브에이전트로..."), `@`로 지정, 세션 전체 `claude --agent code-reviewer`.
- Claude가 띄우는 서브에이전트는 기본적으로 백그라운드에서 돌고, 끝나면 알림으로 결과가 온다. `Ctrl+B`로 실행 중인 작업을 백그라운드로 보낼 수 있다.
- 도구를 좁게: 리뷰어라면 `Read, Grep, Glob`만 주는 식으로.

예시 (`~/.claude/agents/code-improver.md`, 공식 문서 기반)
```markdown
---
name: code-improver
description: Scans files and suggests improvements for readability, performance, and best practices. Use after writing or modifying code.
tools: Read, Grep, Glob
model: sonnet
---

You are a code improvement specialist. For each issue you find, explain
the problem, show the current code, and provide an improved version.
```

실습
1. 위 예시를 참고해 `.claude/agents/security-reviewer.md`(읽기 전용 도구 + 보안 체크리스트)를 만든다. Claude에게 만들어 달라고 해도 된다.
2. "security-reviewer 에이전트로 이 프로젝트를 검토해줘" 실행.
3. description에 "Use proactively after code changes"를 넣고, 코드 수정 후 자동으로 위임되는지 관찰.

퀴즈 문제 은행
- **L3-1.** 서브에이전트 파일에서 반드시 있어야 하는 필드는? ① name, description ② tools, model ③ model만 ④ 없음
- **L3-2.** 코드를 읽기만 하는 리뷰어 서브에이전트의 도구로 알맞은 것은? ① `Read, Grep, Glob` ② `Bash, Write, Edit` ③ 모든 도구 ④ `WebFetch`만
- **L3-3.** 서브에이전트를 쓰는 가장 큰 이유는? ① 더 빠른 타이핑 ② 조사·리뷰를 별도 컨텍스트에서 해서 메인 컨텍스트를 깨끗하게 유지 ③ 비용이 0 ④ 인터넷 없이 실행
- **L3-4.** 특정 서브에이전트가 이번 작업에 반드시 쓰이게 하려면? ① `@`로 그 에이전트를 지정 ② /clear ③ /compact ④ 파일 이름 변경

---

## 레슨 4. 훅(hooks)

**목표**: 정해진 시점에 셸 명령을 자동으로 실행하는 훅을 설정하고, 차단 훅의 동작을 이해한다.

핵심 개념
- 훅 = Claude Code 생명주기의 특정 시점에 실행되는 사용자 정의 셸 명령. CLAUDE.md와 달리 **항상** 실행된다.
- 주요 이벤트: `SessionStart`(세션 시작·재개), `UserPromptSubmit`(요청 제출 직후), `PreToolUse`(도구 실행 전, 차단 가능), `PostToolUse`(도구 성공 후), `Notification`(입력·권한을 기다릴 때), `SubagentStop`, `Stop`(응답 완료), `PreCompact`(압축 전).
- 설정 위치: settings 파일의 `"hooks"` 키(`.claude/settings.json`이면 팀 공유). `/hooks`로 설정된 훅을 확인한다.
- `matcher`: 어떤 도구에 반응할지 정한다. 예 `"Edit|Write"`. 범위는 최대한 좁게.
- 훅은 JSON 입력을 stdin으로 받는다. 예: `jq -r '.tool_input.file_path'`로 편집된 파일 경로 추출.
- 종료 코드: `0` = 통과, **`2` = 차단**(stderr의 이유가 이벤트에 따라 Claude나 사용자에게 전달된다). `SessionStart`처럼 차단할 수 없는 이벤트도 있다.
- Claude에게 써 달라고 할 수 있다: "파일을 편집할 때마다 eslint를 실행하는 훅을 만들어줘"
- **안전**: 훅은 내 계정 권한으로 실행된다. 남의 저장소 훅은 실행 전에 읽어 본다.

예시 1: 편집 후 자동 포맷 (`.claude/settings.json`, 공식 문서)
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          { "type": "command", "command": "jq -r '.tool_input.file_path' | xargs npx prettier --write" }
        ]
      }
    ]
  }
}
```

예시 2: 보호 파일 편집 차단 (`.claude/hooks/protect-files.sh` + PreToolUse)
```bash
#!/bin/bash
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
PROTECTED_PATTERNS=(".env" "package-lock.json" ".git/")
for pattern in "${PROTECTED_PATTERNS[@]}"; do
  if [[ "$FILE_PATH" == *"$pattern"* ]]; then
    echo "Blocked: $FILE_PATH matches protected pattern '$pattern'" >&2
    exit 2
  fi
done
exit 0
```
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          { "type": "command", "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/protect-files.sh" }
        ]
      }
    ]
  }
}
```
`chmod +x .claude/hooks/protect-files.sh` 필요(macOS·Linux). `jq`가 없으면 설치한다.

실습 (연습 저장소에서)
1. 예시 2를 설정하고 `/hooks`로 확인.
2. "`.env` 파일을 만들어 API_KEY=test를 써줘" → 차단되는지, Claude가 이유를 어떻게 전달받는지 관찰.
3. (선택) `Notification` 훅으로 입력 대기 시 데스크톱 알림 받기. Claude에게 학습자 OS에 맞게 써 달라고 한다.

퀴즈 문제 은행
- **L4-1.** 도구 실행을 **막을 수 있는** 이벤트는? ① PostToolUse ② PreToolUse ③ Stop ④ Notification
- **L4-2.** 차단 훅 스크립트가 작업을 막으려면 어떤 종료 코드로 끝나야 하나? ① 0 ② 1 ③ 2 ④ 127
- **L4-3.** 편집 도구에만 반응하게 하는 matcher는? ① `".*"` ② `"Edit|Write"` ③ 비워 두기 ④ `"Bash"`
- **L4-4.** 클론한 오픈소스 저장소에 `.claude/settings.json` 훅이 있다. 가장 먼저 할 일은? ① 바로 실행 ② 훅이 무슨 명령을 실행하는지 읽어 보기 ③ 삭제 후 커밋 ④ bypass 모드로 전환

---

## 레슨 5. 스킬 심화와 플러그인 제작·배포

**목표**: 보조 파일이 있는 스킬을 만들고, 스킬·에이전트·훅을 플러그인으로 묶어 마켓플레이스로 배포한다.

핵심 개념 (스킬 심화)
- 스킬 폴더에 `references/`, `scripts/` 같은 보조 파일을 둔다. SKILL.md에는 "언제 어떤 파일을 읽을지"를 적어서, 필요할 때만 컨텍스트에 들어가게 한다(점진적 공개). SKILL.md는 500줄 이하를 권장한다.
- `description`이 호출 여부를 결정한다. 핵심 용도를 먼저 쓰고 트리거 문구를 넣는다.
- `allowed-tools`, `context: fork`(서브에이전트에서 실행), `disable-model-invocation`, `${CLAUDE_SKILL_DIR}`.

핵심 개념 (플러그인)
- 플러그인 = 스킬·서브에이전트·훅·MCP 서버를 묶은 설치 단위. 스킬은 `/플러그인이름:스킬이름`으로 호출된다.
- 구조:
  ```
  my-marketplace/
    .claude-plugin/marketplace.json
    plugins/my-plugin/
      .claude-plugin/plugin.json
      skills/<skill>/SKILL.md
      agents/            (선택)
  ```
- `marketplace.json` 필수 필드: `name`, `owner`, `plugins`(각 항목에 `name`, `source`). `source`는 마켓플레이스 루트 기준 상대 경로(`./plugins/my-plugin`), `..` 금지.
- 항목 `name`과 `plugin.json`의 `name`을 같게 맞춘다.
- 이름 규칙: 제3자 플러그인은 `claude-`, `anthropic-`로 시작하는 이름 등 예약된 이름을 쓸 수 없다. 기능을 나타내는 이름을 쓴다.
- 검증: `claude plugin validate ./my-marketplace`
- 로컬 테스트: `claude plugin marketplace add ./my-marketplace` → `claude plugin install my-plugin@my-marketplace` → `claude plugin details my-plugin`
- 배포: GitHub에 push → 사용자는 `/plugin marketplace add owner/repo` → `/plugin install 플러그인@마켓플레이스`
- 업데이트: `plugin.json`의 `version`을 올려 push한다.
- 실제 사례: 이 튜터 과정 자체가 `sanh09/code-guide-protocol` 저장소의 `sanh09-skills` 마켓플레이스로 배포되어 있다. 구조를 참고 자료로 보여 줘도 좋다.

실습
1. 레슨 3의 서브에이전트와 중급에서 만든 스킬 하나를 `plugins/my-tools/`로 옮겨 플러그인을 만든다.
2. `marketplace.json`과 `plugin.json` 작성 → `claude plugin validate`가 통과할 때까지 고친다.
3. 로컬 마켓플레이스로 설치하고 `/my-tools:스킬이름` 실행.
4. (선택) GitHub 저장소에 올리고 다른 컴퓨터나 팀원이 설치해 본다.

퀴즈 문제 은행
- **L5-1.** 마켓플레이스의 `source`를 `"../plugins/x"`로 쓰면? ① 정상 ② validate가 `..` 경로 오류를 낸다 ③ 자동 수정 ④ 설치는 된다
- **L5-2.** 플러그인 `my-tools`의 스킬 `review`를 직접 부르는 명령은? ① `/review` ② `/my-tools:review` ③ `@review` ④ `!review`
- **L5-3.** 스킬 하나에 긴 참고 문서가 필요하다. 가장 좋은 구성은? ① 전부 SKILL.md에 ② `references/`에 두고 SKILL.md에 언제 읽을지 적기 ③ CLAUDE.md에 ④ description에
- **L5-4.** 배포한 플러그인을 고쳤다. 사용자가 새 버전을 받게 하려면? ① `plugin.json`의 `version`을 올려 push ② 저장소 이름 변경 ③ 아무것도 안 해도 즉시 반영 ④ 사용자가 재설치해야만

---

## 레슨 6. 자동화: `-p`, `--bare`, CI, GitHub Actions

**목표**: Claude를 스크립트·CI에서 안전하고 재현 가능하게 실행한다.

핵심 개념
- CI·스크립트에서는 `--bare`를 권장한다. 훅, 스킬, 플러그인, MCP, CLAUDE.md 자동 탐색을 건너뛰어 어느 컴퓨터에서나 같은 결과가 나온다. `ANTHROPIC_API_KEY`가 필요하다(구독 로그인을 쓰지 않음). 필요한 것은 `--settings`, `--mcp-config`, `--agents`, `--append-system-prompt`로 명시해서 넘긴다.
- **주의**: `--bare` 없이 `-p`를 실행하면, 신뢰하지 않은 폴더라도 프로젝트의 훅과 `.mcp.json` 서버가 확인 창 없이 실행된다.
- 권한: `--allowedTools`로 필요한 도구만 허용하고 `--permission-mode dontAsk`(나머지는 자동 거부)를 함께 쓴다. `auto` 모드는 검사 모델이 검토하는 방식이다.
- 구조화 출력: `--output-format json --json-schema '<스키마>'` → `structured_output` 필드.
- 시스템 프롬프트 추가: `--append-system-prompt "You are a security engineer..."`
- 여러 파일에 나눠 실행(fan-out): 파일 목록을 만들고 `for` 루프로 `claude -p`를 반복한다. 먼저 2~3개로 시험한다. 세션 안에서는 `/batch <지시>`가 작업을 5~30개 서브에이전트(각자 worktree)로 나눈다.
- GitHub Actions: 저장소에서 `claude` 실행 → `/install-github-app`이 인증 비밀 값과 워크플로 파일을 설정한다(저장소 관리자 권한 필요). PR·이슈에서 Claude를 부를 수 있다.
- 예약 실행: 클라우드 예약 작업(claude.ai/code/routines), 데스크톱 예약 작업, GitHub Actions cron, 세션 안의 `/loop`.

예시
```bash
# PR diff 보안 리뷰 (review.sh)
gh pr diff "$1" | claude -p \
  --append-system-prompt "You are a security engineer. Review for vulnerabilities." \
  --output-format json

# 무인 마이그레이션 fan-out
for file in $(cat files.txt); do
  claude -p "Migrate $file from Python 2 to Python 3. Return OK or FAIL." \
    --allowedTools "Edit,Bash(git commit *)" \
    --permission-mode dontAsk
done
```

실습
1. 연습 저장소에서 `claude --bare -p "Summarize README.md" --allowedTools "Read"` 실행(API 키가 있을 때). 없으면 `--bare` 없이 실행하고 차이를 설명.
2. `--json-schema`로 함수 이름 목록을 JSON 배열로 받아 `jq '.structured_output'`로 꺼내기.
3. (GitHub 저장소가 있다면) `/install-github-app`으로 Actions 설정 흐름 살펴보기.

퀴즈 문제 은행
- **L6-1.** CI에서 팀원 컴퓨터의 훅이나 MCP 설정에 영향받지 않고 같은 결과를 내려면? ① `--bare` ② `--verbose` ③ `--continue` ④ `/clear`
- **L6-2.** 무인 실행에서 허용한 도구 외에는 묻지 않고 거부하려면? ① `--permission-mode dontAsk` ② `--permission-mode bypassPermissions` ③ `--permission-mode plan` ④ 옵션 없음
- **L6-3.** 신뢰하지 않은 저장소에서 `--bare` 없이 `claude -p`를 실행할 때의 위험은? ① 없다 ② 프로젝트의 훅과 MCP 서버가 확인 창 없이 실행될 수 있다 ③ 결과가 영어로만 나온다 ④ 실행이 느려진다
- **L6-4.** 2,000개 파일 마이그레이션을 fan-out으로 하기 전에 먼저 할 일은? ① 바로 전체 실행 ② 2~3개 파일로 시험하고 프롬프트 다듬기 ③ bypass 모드 켜기 ④ git 기록 삭제

---

## 레슨 7. 병렬 작업과 리뷰 패턴

**목표**: 여러 세션을 충돌 없이 동시에 돌리고, 독립적인 리뷰로 품질을 높인다.

핵심 개념
- worktree = 같은 저장소의 다른 브랜치를 별도 폴더에 체크아웃한 것. `claude --worktree feature-auth`로 격리된 세션을 시작한다. 다른 터미널에서 다른 이름으로 하나 더 띄우면 동시에 작업해도 편집이 섞이지 않는다. 커밋이 하나 이상 있어야 한다.
- Writer/Reviewer 패턴: 세션 A가 구현하고, 새 세션 B가 리뷰한다(자기가 쓴 코드에 대한 편향이 없다). 리뷰 결과를 다시 A에 넣는다. 테스트를 쓰는 Claude와 구현하는 Claude를 나눌 수도 있다.
- 적대적 리뷰 단계: "서브에이전트로 PLAN.md 기준으로 diff를 리뷰해줘. 요구 사항 누락, 엣지 케이스 테스트, 범위 밖 변경만 보고해". 번들 스킬 `/code-review`도 있다.
- 리뷰어는 무엇이든 찾아내려는 경향이 있다. 정확성과 요구 사항에 영향을 주는 것만 보고하게 해서 과잉 설계를 막는다.
- 그 밖의 병렬 방법: 데스크톱 앱의 여러 세션, 클라우드 세션, `claude agents`(에이전트 뷰, 연구 미리보기).
- 장기 무인 작업 마무리: `/goal` 조건이나 Stop 훅으로 "테스트가 통과할 때까지" 같은 종료 조건을 강제할 수 있다.

실습
1. 연습 저장소에서 두 터미널로 `claude --worktree feature-a`, `claude --worktree feature-b`를 띄워 서로 다른 작은 기능을 동시에 구현한다.
2. 한쪽 결과를 새 세션에서 리뷰시킨다: "@src/... 를 리뷰해줘. 엣지 케이스와 기존 패턴과의 일관성 위주로"
3. 리뷰 결과를 구현 세션에 넣어 반영하고 커밋.
4. worktree 정리 방법을 공식 문서(worktrees)로 확인하게 한다.

퀴즈 문제 은행
- **L7-1.** 두 기능을 동시에 Claude 두 개로 구현할 때 편집 충돌을 피하려면? ① 같은 폴더에서 두 세션 ② `claude --worktree 이름`으로 각자 격리 ③ /compact ④ /clear
- **L7-2.** 방금 구현한 세션에게 "검토해줘"라고 하는 것보다 새 세션 리뷰가 나은 이유는? ① 더 싸다 ② 자기가 쓴 코드에 대한 편향 없이 결과만 본다 ③ 더 빠르다 ④ 차이 없다
- **L7-3.** 리뷰어가 사소한 지적을 쏟아내 과잉 설계로 이어진다. 해결책은? ① 리뷰어를 없앤다 ② 정확성·요구 사항에 영향을 주는 것만 보고하게 지시 ③ 모든 지적을 반영 ④ 모델을 바꾼다
- **L7-4.** 커밋이 하나도 없는 새 저장소에서 `claude --worktree x`를 실행하면? ① 정상 작동 ② 기준 브랜치를 찾지 못해 실패한다. 먼저 커밋 필요 ③ 자동으로 커밋 생성 ④ plan 모드로 전환

---

## 졸업 과제

학습자의 실제 프로젝트(없으면 연습 저장소)에서 다음 중 **4개 이상**을 혼자 해 보게 하고, 막히는 부분만 돕는다.

1. 레슨 1의 표로 자기 팀의 문제 2개에 알맞은 확장 기능을 고르고 이유 설명
2. MCP 서버 하나를 알맞은 범위로 연결하고 `/mcp`로 확인
3. 읽기 전용 리뷰어 서브에이전트를 만들어 실행
4. 보호 파일 차단 PreToolUse 훅을 설정하고 차단되는지 검증
5. 스킬 + 서브에이전트를 플러그인으로 묶어 `claude plugin validate` 통과 후 로컬 설치
6. `--bare`(또는 `--allowedTools` + `dontAsk`)로 `-p` 자동화 스크립트 하나 작성
7. worktree 두 개로 병렬 구현 후 새 세션에서 리뷰

마친 뒤 레슨 1~7을 섞은 종합 퀴즈 5문제를 낸다. 4문제 이상 맞히면 수료로 보고, 마지막으로 더 깊이 볼 공식 문서(hooks reference, plugins reference, Agent SDK, sandboxing)를 한 줄씩 소개한다.
