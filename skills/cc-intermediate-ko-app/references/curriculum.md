# 커리큘럼: Claude Code 중급

수업할 레슨 부분만 읽는다. 사실 확인은 `facts.md`. 학습자의 실제 프로젝트가 있으면 그 프로젝트로 실습하게 한다. 없으면 각 레슨의 연습 예제를 쓴다.

목차
- 레슨 1. 좋은 요청 쓰기
- 레슨 2. 탐색 → 계획 → 구현 → 커밋
- 레슨 3. git과 함께 쓰기 (커밋, PR, 체크포인트)
- 레슨 4. 권한 규칙 심화
- 레슨 5. 나만의 슬래시 명령(스킬) 만들기
- 레슨 6. 세션과 컨텍스트 관리 심화
- 레슨 7. `claude -p` 비대화형 실행
- 졸업 과제

연습용 프로젝트 준비 (실제 프로젝트가 없을 때):
```bash
mkdir cc-mid-practice && cd cc-mid-practice && git init
claude
```
그다음 "간단한 할 일 목록 CLI 프로그램을 Python(또는 Node.js)으로 만들어줘. 테스트도 같이"라고 요청해 재료를 만든다.

---

## 레슨 1. 좋은 요청 쓰기

**목표**: 막연한 요청을 구체적이고 검증 가능한 요청으로 바꿀 수 있다.

핵심 개념
- Claude는 "다 된 것 같으면" 멈춘다. **스스로 확인할 방법**(테스트, 빌드, 기대 결과)을 주면 맞을 때까지 고친다. 효과가 가장 큰 습관이다.
- 구체적으로 쓴다: 어떤 파일인지, 어떤 상황인지, 무엇이 "완료"인지.
- 예시 패턴을 가리킨다: "기존 `HotDogWidget.php`처럼 만들어줘"
- `@파일`로 직접 참조하고, 오류 화면은 이미지로 붙여 넣는다(드래그 또는 `Ctrl+V`).
- 증상과 위치와 완료 조건을 함께 쓴다.

비교 예시 (공식 문서 기반)
| 나쁜 요청 | 좋은 요청 |
|---|---|
| "이메일 검증 함수 만들어줘" | "validateEmail 함수를 만들어줘. user@example.com은 true, invalid는 false, user@.com은 false. 구현 후 테스트를 실행해줘" |
| "foo.py 테스트 추가해줘" | "foo.py에 로그아웃 상태일 때의 엣지 케이스 테스트를 추가해줘. mock은 쓰지 마" |
| "로그인 버그 고쳐줘" | "세션 만료 후 로그인이 실패한대. src/auth/의 토큰 갱신 부분을 봐줘. 먼저 재현하는 실패 테스트를 쓰고, 그다음 고쳐줘" |
| "빌드가 실패해" | "빌드가 [오류 붙여넣기]로 실패해. 고치고 빌드가 성공하는지 확인해줘. 오류를 숨기지 말고 원인을 고쳐줘" |

실습
1. 자기 프로젝트에서 최근에 했던(또는 하고 싶은) 요청 하나를 적는다.
2. 위 표처럼 "검증 방법 + 위치 + 완료 조건"을 넣어 고쳐 쓴다. 튜터가 피드백한다.
3. 고친 요청을 실제로 보내 보고, Claude가 테스트를 돌렸는지 확인한다.

퀴즈 문제 은행
- Q. Claude가 혼자 오래 작업해도 결과가 맞을 가능성을 가장 높이는 방법은? ① 요청을 짧게 쓴다 ② 실행할 수 있는 확인 방법(테스트 등)을 준다 ③ 여러 번 다시 묻는다 ④ 대문자로 강조한다 → ②
- Q. 기존 코드 스타일에 맞춘 새 위젯을 만들게 하려면? ① "예쁘게 만들어줘" ② 비슷한 기존 파일을 예시로 가리킨다 ③ 라이브러리를 새로 설치하게 한다 ④ 아무 설명 없이 맡긴다 → ②
- Q. 오류 화면을 보여주고 싶을 때 가장 빠른 방법은? ① 화면 내용을 손으로 옮겨 적기 ② 스크린샷을 붙여넣기 ③ /clear ④ 설명하지 않기 → ②
- Q. 막연한 요청이 오히려 좋은 경우는? ① 탐색하며 아이디어를 얻고 싶을 때 ② 배포 직전 ③ 보안 수정 ④ 결제 코드 → ①

---

## 레슨 2. 탐색 → 계획 → 구현 → 커밋

**목표**: 큰 작업에서 plan 모드로 먼저 계획을 세우고, 언제 계획을 건너뛸지 판단할 수 있다.

핵심 개념
- 4단계: **탐색**(plan 모드에서 읽기만) → **계획**(변경할 파일과 흐름 정리) → **구현**(계획을 승인하거나 `Shift+Tab`으로 나와서 구현, 테스트까지) → **커밋**.
- plan 모드 진입: `Shift+Tab`으로 `⏸ plan mode on`이 될 때까지 누르기, `claude --permission-mode plan`, 또는 `/plan 할일`.
- `Ctrl+G`: 계획을 텍스트 편집기에서 직접 고칠 수 있다.
- 계획이 필요 없는 경우: 오타 수정, 로그 한 줄 추가, 변수 이름 바꾸기처럼 **diff를 한 문장으로 설명할 수 있는 작업**.
- 큰 기능이라면 Claude에게 인터뷰를 받아 SPEC.md를 쓰게 하고, 새 세션에서 구현하는 방법도 있다.

실습
1. plan 모드로 들어가서: "이 프로젝트 구조를 읽고, 할 일에 마감일 기능을 추가하려면 어떤 파일을 바꿔야 하는지 계획을 세워줘"
2. `Ctrl+G`로 계획을 열어 한 줄 고쳐 보기.
3. 계획을 승인하고 "계획대로 구현하고 테스트를 실행해서 실패하면 고쳐줘"
4. "설명적인 메시지로 커밋해줘"

퀴즈 문제 은행
- Q. 변수 이름 하나를 바꾸는 작업이라면? ① 반드시 plan 모드 ② 그냥 바로 요청 ③ SPEC.md 작성 ④ 서브에이전트 사용 → ②
- Q. plan 모드에서 Claude가 하지 않는 것은? ① 파일 읽기 ② 계획 제시 ③ 소스 파일 수정 ④ 질문에 답하기 → ③
- Q. Claude가 세운 계획을 직접 고치고 싶다면? ① `Ctrl+G` ② `Ctrl+L` ③ `Esc` 두 번 ④ `/compact` → ①
- Q. 여러 파일을 바꾸고 접근 방법도 확실하지 않은 기능이다. 가장 알맞은 첫 단계는? ① acceptEdits 모드로 바로 구현 ② plan 모드로 탐색과 계획 ③ /clear ④ 커밋부터 → ②

---

## 레슨 3. git과 함께 쓰기

**목표**: 커밋과 PR을 Claude와 함께 만들고, 체크포인트와 git의 차이를 안다.

핵심 개념
- git 용어 한 줄: 커밋 = 변경 사항 저장 지점, 브랜치 = 갈래 작업 공간, PR = 내 브랜치를 합쳐 달라는 요청.
- "내 변경 사항을 요약하고 커밋해줘", "PR 만들어줘": Claude가 `git diff`·`git log`를 보고 메시지를 쓴다. PR은 GitHub CLI(`gh`)가 있으면 Claude가 `gh pr create`로 만든다.
- PR을 올리기 전에 "이 PR의 위험 요소를 짚어줘"라고 한 번 더 물어본다.
- 체크포인트: 보내는 요청마다 자동으로 저장된다. `Esc` 두 번 또는 `/rewind`로 대화와 코드 중 원하는 것을 되돌린다.
- **주의**: 체크포인트는 Claude의 파일 편집 도구로 바꾼 것만 추적한다. Bash 명령이나 외부 프로그램으로 바뀐 것은 되돌리지 못한다. git을 대신하지 못한다.
- 낯선 코드 이해: "이 함수가 왜 이렇게 생겼는지 git 기록을 보고 설명해줘"

실습
1. 레슨 2의 변경으로 새 브랜치를 만들어 커밋하게 한다: "feature/due-date 브랜치를 만들고 커밋해줘"
2. 일부러 이상한 요청("모든 함수 이름을 이모지로 바꿔줘")을 한 뒤 `/rewind`로 코드만 되돌리기.
3. (`gh`와 원격 저장소가 있다면) "PR을 만들어줘" → 생성된 설명 검토.

퀴즈 문제 은행
- Q. Claude가 `rm` 같은 Bash 명령으로 지운 파일을 체크포인트로 되돌릴 수 있나? ① 항상 된다 ② 안 된다. 체크포인트는 파일 편집 도구로 바꾼 것만 추적한다 ③ /clear로 된다 ④ /compact로 된다 → ②
- Q. 위험한 리팩터링을 시도하기 전 가장 안전한 준비는? ① 그냥 시도 ② 먼저 커밋해 두기 ③ /clear ④ auto 모드 → ②
- Q. PR을 올리기 전에 Claude에게 추가로 부탁하면 좋은 것은? ① 위험 요소와 고려 사항 짚기 ② 이모지 추가 ③ 테스트 삭제 ④ 아무것도 → ①

---

## 레슨 4. 권한 규칙 심화

**목표**: allow/ask/deny 규칙을 정확한 문법으로 쓰고, 평가 순서를 이해한다.

핵심 개념
- 평가 순서: **deny → ask → allow**. 먼저 맞는 것이 결과를 정한다. allow로 deny의 예외를 만들 수 없다.
- Bash 규칙: `Bash(npm run build)`는 정확히 그 명령만. `Bash(npm run *)`는 `npm run`으로 시작하는 명령. **`*` 앞의 공백이 중요하다.** `Bash(git diff*)`는 `git diff-index`까지 맞는다.
- 경로 규칙: `Read(./.env)`(현재 폴더 기준), `Read(~/Documents/*.pdf)`(홈 기준), `Read(//Users/alice/secrets/**)`(파일시스템 루트 기준, 슬래시 두 개).
- 웹: `WebFetch(domain:example.com)`. MCP: `mcp__서버이름__*`.
- 어디에 둘까: 팀 공통은 `.claude/settings.json`, 나만은 `.claude/settings.local.json` 또는 `~/.claude/settings.json`. `/permissions`로 대화형 관리.
- 모드 복습: 최신 버전은 기본 `auto` 모드(검사 모델이 검토). 항상 Manual로 시작하려면 `~/.claude/settings.json`에 `"permissions": {"defaultMode": "default"}`. `auto`·`bypassPermissions`는 프로젝트·로컬 설정 파일에서는 적용되지 않는다.

실습
1. 다음 요구를 만족하는 `.claude/settings.json`을 직접 써 보고 튜터가 검토한다: 테스트·린트 명령은 묻지 않기, `git push`는 항상 묻기, `.env`와 `secrets/` 폴더는 읽기 금지.
2. 모범 답안 예시:
   ```json
   {
     "permissions": {
       "allow": ["Bash(npm run test *)", "Bash(npm run lint)"],
       "ask": ["Bash(git push *)"],
       "deny": ["Read(./.env)", "Read(./.env.*)", "Read(./secrets/**)"]
     }
   }
   ```
3. `/permissions`에서 규칙이 보이는지, `/status`의 Setting sources를 확인한다.

퀴즈 문제 은행
- Q. allow에 `Bash(aws s3 ls)`, deny에 `Bash(aws *)`가 있다. `aws s3 ls`는? ① 허용 ② 거부. deny가 먼저 평가된다 ③ 물어본다 ④ 오류 → ②
- Q. `git diff`로 시작하는 명령만 허용하고 `git diff-index`는 제외하려면? ① `Bash(git diff*)` ② `Bash(git diff *)` ③ `Bash(git*)` ④ `Bash(*)` → ②
- Q. 홈 폴더의 `.ssh` 전체 읽기를 막는 규칙은? ① `Read(./.ssh)` ② `Read(~/.ssh/**)` ③ `Write(.ssh)` ④ `Bash(ssh)` → ②
- Q. 팀 저장소의 `.claude/settings.json`에 `"defaultMode": "bypassPermissions"`를 넣으면? ① 모든 팀원이 bypass 모드 ② 프로젝트 파일에서는 적용되지 않는다 ③ 오류로 Claude Code가 안 켜진다 ④ auto 모드가 된다 → ②

---

## 레슨 5. 나만의 슬래시 명령(스킬) 만들기

**목표**: 반복하는 작업을 `/이름`으로 부를 수 있는 스킬로 만든다.

핵심 개념
- 예전의 "커스텀 명령"(`.claude/commands/이름.md`)은 스킬로 합쳐졌다. 기존 파일은 계속 작동하지만, 새로 만들 때는 스킬을 권한다.
- 위치: `~/.claude/skills/<이름>/SKILL.md`(모든 프로젝트), `.claude/skills/<이름>/SKILL.md`(이 프로젝트, 팀 공유).
- 구조: 맨 위에 `---`로 감싼 YAML(머리말), 그 아래 지시 내용. `description`이 가장 중요하다. Claude는 이것을 보고 언제 스킬을 쓸지 정한다.
- `$ARGUMENTS`: `/이름` 뒤에 쓴 내용으로 바뀐다. `$0`, `$1`은 순서대로 나눈 값.
- `disable-model-invocation: true`: Claude가 알아서 실행하지 않고, 사용자가 `/이름`으로 부를 때만 실행된다. 커밋·배포처럼 부작용이 있는 작업에 쓴다.
- 언제 CLAUDE.md, 언제 스킬? 항상 필요한 짧은 규칙은 CLAUDE.md, 가끔 필요한 절차나 지식은 스킬(필요할 때만 로드돼서 컨텍스트를 아낀다).

예시 (`.claude/skills/fix-issue/SKILL.md`, 공식 문서 기반)
```markdown
---
description: Fix a GitHub issue by number following our coding standards
argument-hint: [issue-number]
disable-model-invocation: true
---

Fix GitHub issue $ARGUMENTS.

1. Read the issue with `gh issue view $0`.
2. Implement the fix and add tests.
3. Commit with a message that references #$0.
```
→ `/fix-issue 123`으로 실행.

실습
1. 자주 하는 작업 하나를 고른다(예: "변경 사항 리뷰", "README 업데이트").
2. `~/.claude/skills/review-changes/SKILL.md`를 만든다(직접 쓰거나 Claude에게 부탁). `$ARGUMENTS`로 초점을 받게 한다.
3. `/review-changes 보안 위주로` 실행해 보기.
4. description을 바꿔 가며 "변경 사항 봐줘"라고만 했을 때 자동으로 쓰이는지 관찰하기.

퀴즈 문제 은행
- Q. 배포처럼 부작용이 큰 스킬을 Claude가 알아서 실행하지 못하게 하려면? ① `disable-model-invocation: true` ② `user-invocable: false` ③ description 비우기 ④ 파일 이름 바꾸기 → ①
- Q. `/fix-issue 42`를 실행하면 SKILL.md의 `$ARGUMENTS`는? ① 빈 값 ② `42` ③ `fix-issue` ④ 오류 → ②
- Q. Claude가 스킬을 언제 쓸지 판단할 때 주로 보는 것은? ① 파일 크기 ② `description` ③ 폴더 생성 날짜 ④ 파일 확장자 → ②
- Q. 가끔만 필요한 긴 배포 절차를 적어 두기에 더 알맞은 곳은? ① CLAUDE.md ② 스킬 ③ settings.json ④ .gitignore → ②

---

## 레슨 6. 세션과 컨텍스트 관리 심화

**목표**: 긴 작업을 여러 세션에 걸쳐 이어 가고, 컨텍스트를 깨끗하게 유지한다.

핵심 개념
- 컨텍스트가 찰수록 성능이 떨어진다. 가장 중요하게 관리할 자원이다.
- 관련 없는 작업 사이에는 `/clear`. **같은 문제를 두 번 넘게 고쳐 달라고 했는데도 안 되면** `/clear` 후 배운 점을 넣어 더 좋은 첫 요청으로 다시 시작한다.
- `/compact 지시`: 예 `/compact API 변경 위주로`. CLAUDE.md에 "압축할 때 수정한 파일 목록과 테스트 명령은 꼭 남겨"라고 적어 둘 수도 있다.
- `/btw`: 대화 기록에 남기지 않고 잠깐 묻기.
- 세션 이어 가기: `claude --continue`(이 폴더의 최근 대화), `claude --resume`(목록에서 고르기), `/rename`으로 이름 붙이기(예: `oauth-migration`).
- 조사는 서브에이전트에게: "서브에이전트로 인증 시스템의 토큰 갱신 방식을 조사해줘". 파일 읽기는 별도 컨텍스트에서 하고 요약만 돌아온다(자세한 내용은 고급 과정).
- CLAUDE.md 다듬기: 줄마다 "이 줄을 지우면 Claude가 실수할까?"라고 물어보고, 아니면 지운다. 너무 길면 중요한 규칙이 묻힌다.

실습
1. `/context`로 현재 사용량 확인.
2. `/rename practice-session`으로 이름 붙이고 종료 → `claude --resume`으로 찾아 열기.
3. 지금 프로젝트의 CLAUDE.md를 열어 위 기준으로 세 줄 이상 정리해 보기.
4. "서브에이전트로 이 프로젝트의 테스트 구조를 조사해서 요약해줘" 실행 후 `/context` 변화 비교.

퀴즈 문제 은행
- Q. 같은 버그를 세 번째 고쳐 달라고 했는데 여전히 틀린다. 가장 좋은 다음 행동은? ① 같은 말 반복 ② `/clear` 후 배운 점을 넣어 새로 요청 ③ 대문자로 다시 요청 ④ auto 모드로 전환 → ②
- Q. 어제 하던 대화를 목록에서 골라 이어 가려면? ① `claude --resume` ② `claude -p` ③ `/init` ④ `/clear` → ①
- Q. 대화 기록을 늘리지 않고 잠깐 사실 하나만 확인하려면? ① `/btw` ② `/compact` ③ `/init` ④ `/memory` → ①
- Q. 큰 코드베이스 조사가 메인 대화의 컨텍스트를 채우지 않게 하려면? ① 서브에이전트에게 조사를 맡긴다 ② 모든 파일을 @로 붙인다 ③ /model 변경 ④ /rewind → ①

---

## 레슨 7. `claude -p` 비대화형 실행

**목표**: 대화창 없이 한 번 실행하고 끝나는 Claude를 스크립트와 파이프에 쓴다.

핵심 개념
- `claude -p "요청"`: 결과를 출력하고 종료. 파이프 용어 한 줄: `|`는 앞 명령의 출력을 뒤 명령의 입력으로 넘긴다.
- 예: `git log --oneline -20 | claude -p "최근 커밋을 요약해줘"`, `cat build-error.txt | claude -p '이 빌드 오류의 원인을 간단히 설명해줘' > output.txt`
- 출력 형식: `--output-format text`(기본) / `json`(결과는 `result` 필드, 세션 ID 포함) / `stream-json`.
- 권한: `-p` 실행에서는 확인 창을 띄울 수 없다. 필요한 도구를 `--allowedTools`로 미리 허용한다. 예 `--allowedTools "Bash(git diff *),Bash(git commit *)"`
- 이어 가기: `claude -p "..." --continue`
- `package.json` 스크립트로 넣으면 팀 전용 린터처럼 쓸 수 있다.
- 주의: 무인 실행 결과는 꼭 검토한다. 고급 과정에서 `--bare`, `--permission-mode dontAsk`, CI 연동을 다룬다.

실습
1. `git log --oneline -10 | claude -p "이 커밋들을 한국어로 세 줄 요약해줘"`
2. `claude -p "이 프로젝트를 한 문장으로 설명해줘" --output-format json` 실행 후 `result` 필드 찾기(`jq`가 있으면 `| jq -r '.result'`).
3. `claude -p "staged 변경 사항을 보고 알맞은 커밋을 만들어줘" --allowedTools "Bash(git diff *),Bash(git log *),Bash(git status *),Bash(git commit *)"`

퀴즈 문제 은행
- Q. `claude -p` 결과를 스크립트에서 JSON으로 다루려면? ① `--output-format json` ② `--json` ③ `/config json` ④ `-j` → ①
- Q. `-p` 실행에서 git 커밋이 권한 때문에 거부됐다. 해결 방법은? ① `--allowedTools "Bash(git commit *)"` 추가 ② `/clear` ③ `--continue` ④ CLAUDE.md 수정 → ①
- Q. `git log | claude -p "요약"`에서 `|`의 역할은? ① 주석 ② 앞 명령의 출력을 Claude의 입력으로 넘김 ③ 파일 저장 ④ 명령 취소 → ②

---

## 졸업 과제

학습자 자신의 프로젝트(없으면 연습 프로젝트)에서 혼자 해 보게 하고, 막히는 단계만 돕는다.

1. plan 모드로 작은 기능 하나 계획 → `Ctrl+G`로 수정 → 구현 + 테스트 실행 → 브랜치에 커밋
2. `.claude/settings.json`에 테스트 명령 allow, `git push` ask, `.env` deny 규칙 추가
3. 반복 작업 하나를 `/이름` 스킬로 만들고 실행
4. `claude -p`로 오늘 커밋 요약을 JSON으로 출력
5. `/rename`으로 세션 이름을 붙이고 종료 후 `claude --resume`으로 다시 열기

마친 뒤 레슨 1~7을 섞은 종합 퀴즈 5문제를 낸다. 4문제 이상 맞히면 수료로 보고, 고급 과정(`cc-advanced-ko`: MCP, 서브에이전트, 훅, 스킬·플러그인 제작, 자동화, 병렬 작업)을 소개한다. 3문제 이하라면 틀린 레슨을 복습하고 다시 퀴즈를 낸다.
