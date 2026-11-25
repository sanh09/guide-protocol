# Claude Code 중급 사실 정리 (공식 문서 확인본)

마지막 확인: 2026-11 · 전체 문서 목록: https://code.claude.com/docs/llms.txt
버전마다 다를 수 있다. 학습자 화면이나 `claude --help`, `/help`와 다르면 학습자 환경이 우선이다.

## 좋은 요청 (Best practices)
출처: https://code.claude.com/docs/en/best-practices.md
- 가장 효과가 큰 습관: Claude가 **스스로 실행할 수 있는 확인 방법**(테스트, 빌드 종료 코드, 린터, 스크린샷 비교)을 준다. 성공했다고 말만 하게 하지 말고 증거(테스트 출력 등)를 보여 달라고 한다.
- 구체적으로: 범위(파일, 상황, 테스트 방식), 출처(git 기록 등), 기존 패턴(예시 파일), 증상과 완료 조건.
- `@파일` 참조, 이미지 붙여넣기(드래그, `Ctrl+V`, Windows·WSL은 `Alt+V`), URL 제공, 파이프(`cat error.log | claude -p "..."`).
- 큰 기능: "AskUserQuestion 도구로 나를 자세히 인터뷰하고 SPEC.md를 써줘" → 새 세션에서 구현.
- 같은 문제를 두 번 넘게 고쳐도 안 되면 `/clear` 후 더 나은 첫 요청으로 다시 시작.
- CLAUDE.md는 짧게. 줄마다 "지우면 Claude가 실수할까?"를 물어본다. 가끔 필요한 지식은 스킬로 옮긴다.

## 탐색 → 계획 → 구현 → 커밋
출처: https://code.claude.com/docs/en/best-practices.md, https://code.claude.com/docs/en/common-workflows.md
- plan 모드: `Shift+Tab`으로 `⏸ plan mode on`, `claude --permission-mode plan`, `/plan [설명]`.
- plan 모드에서는 파일을 읽고 읽기 전용 명령만 실행하며, 소스 파일은 수정하지 않는다.
- `Ctrl+G`: 계획(또는 프롬프트)을 기본 텍스트 편집기에서 편집.
- 계획을 건너뛸 때: diff를 한 문장으로 설명할 수 있는 작업(오타, 로그 한 줄, 변수 이름 바꾸기).

## git, PR, 체크포인트
출처: https://code.claude.com/docs/en/common-workflows.md, https://code.claude.com/docs/en/best-practices.md
- "create a pr"처럼 직접 요청하면 PR을 만든다. GitHub는 `gh` CLI가 있으면 가장 효율적이다.
- `claude --from-pr 1234`: 그 PR과 연결된 세션 찾기.
- 체크포인트: 요청을 보낼 때마다 생긴다. `Esc` 두 번 또는 `/rewind`로 대화만, 코드만, 둘 다 되돌리거나 선택한 지점부터 요약할 수 있다.
- **체크포인트는 Claude의 파일 편집 도구로 바뀐 것만 추적한다. Bash 명령이나 외부 프로세스로 바뀐 것은 포함되지 않는다. git을 대신하지 않는다.**

## 권한 규칙
출처: https://code.claude.com/docs/en/permissions.md, https://code.claude.com/docs/en/permission-modes.md
- 평가 순서: deny → ask → allow. 처음 맞는 규칙이 결과를 정하며, 더 구체적인 규칙이라고 순서가 바뀌지 않는다. 넓은 deny `Bash(aws *)`는 좁은 allow `Bash(aws s3 ls)`보다 우선한다.
- `Bash(npm run build)`: 정확히 그 명령. `Bash(npm run *)`: `npm run build`, `npm run test --watch`, `npm run`에 맞고 `npm install`에는 안 맞는다.
- `*` 앞 공백: `Bash(git diff *)`는 `git diff`로 시작하는 명령, `Bash(git diff*)`는 `git diff-index`도 맞는다.
- `timeout`, `time`, `nice`, `nohup`, `stdbuf` 같은 감싸는 명령은 떼고 비교한다(`Bash(npm test *)`는 `timeout 30 npm test`에도 맞는다).
- 경로: `Read(./.env)` 현재 기준, `Read(~/Documents/*.pdf)` 홈 기준, `Read(//Users/alice/secrets/**)` 루트 기준(슬래시 두 개).
- `WebFetch(domain:example.com)`, MCP 도구 `mcp__puppeteer__*`.
- 모드: `default`(Manual), `acceptEdits`, `plan`, `auto`, `dontAsk`, `bypassPermissions`.
- **v2.1.283부터 대화형 세션은 기본 `auto` 모드로 시작한다.** `claude -p`와 Agent SDK는 Manual로 시작한다.
- 항상 Manual로 시작: `~/.claude/settings.json`에 `{"permissions": {"defaultMode": "default"}}`. `"manual"`도 별칭으로 쓸 수 있다. `auto`와 `bypassPermissions`는 프로젝트·로컬 설정 파일에서는 적용되지 않는다.
- "Yes, and don't ask again"은 `.claude/settings.local.json`에 allow 규칙으로 저장된다.

## 스킬 (= 나만의 슬래시 명령)
출처: https://code.claude.com/docs/en/skills.md
- 위치: `~/.claude/skills/<이름>/SKILL.md`(개인, 모든 프로젝트), `.claude/skills/<이름>/SKILL.md`(프로젝트, 팀 공유), 플러그인 `<plugin>/skills/<이름>/SKILL.md`(`/플러그인:스킬`로 호출).
- 이름이 겹치면 enterprise > 개인 > 프로젝트 순으로 우선한다. 스킬은 같은 이름의 `.claude/commands/` 파일보다 우선한다.
- 커스텀 명령은 스킬로 합쳐졌다. `.claude/commands/deploy.md`와 `.claude/skills/deploy/SKILL.md`는 둘 다 `/deploy`를 만든다. 기존 commands 파일은 계속 작동하지만, 새로 만들 때는 스킬을 권한다.
- 머리말 주요 필드: `name`(기본값은 폴더 이름), `description`(가장 중요. 핵심 용도를 앞에), `when_to_use`, `argument-hint`, `arguments`, `disable-model-invocation`(true면 사용자만 호출), `user-invocable`(false면 `/` 메뉴에서 숨김, Claude만 호출), `allowed-tools`(그 턴에 묻지 않고 쓸 도구).
- 인자: `$ARGUMENTS`(이름 뒤 전체), `$0`·`$1`(0부터 시작하는 순서), `${CLAUDE_SKILL_DIR}`.
- 파일을 고치면 보통 재시작 없이 반영된다.

## 세션과 컨텍스트
출처: https://code.claude.com/docs/en/best-practices.md, https://code.claude.com/docs/en/common-workflows.md
- `claude --continue`: 이 폴더의 가장 최근 세션. `claude --resume`: 목록에서 선택. 세션 안에서는 `/resume`.
- `/rename`: 세션 이름 붙이기.
- `/compact <지시>`: 예 `/compact Focus on the API changes`. `/rewind`의 "Summarize from here / up to here"로 일부만 요약할 수 있다.
- `/btw`: 답이 대화 기록에 들어가지 않는 곁가지 질문.
- 컨텍스트가 거의 차면 자동으로 압축된다.
- 조사 위임: "use a subagent to investigate ...". 별도 컨텍스트에서 읽고 요약만 돌려준다.

## `claude -p` 비대화형 실행
출처: https://code.claude.com/docs/en/headless.md
- `claude -p "What does the auth module do?"`, 성공 시 종료 코드 0.
- 파이프: `cat build-error.txt | claude -p '...' > output.txt`. stdin 입력은 최대 10MB.
- `--output-format text|json|stream-json`. json은 `result`, `session_id`, `total_cost_usd`(추정치)를 담는다. 예: `claude -p "Summarize this project" --output-format json | jq -r '.result'`
- `--allowedTools "Read,Edit,Bash"`, 세밀하게 `--allowedTools "Bash(git diff *),Bash(git log *),Bash(git status *),Bash(git commit *)"`
- Manual 모드 `-p`에서는 승인이 필요한 호출을 아무것도 승인하지 않으면 거부된다.
- 이어 가기: `claude -p "..." --continue`, `claude -p "..." --resume "$session_id"`
- `-p` 안에서도 사용자가 부르는 스킬은 작동한다(프롬프트에 `/스킬이름` 포함).
