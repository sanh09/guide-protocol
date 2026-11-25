# Claude Code 고급 사실 정리 (공식 문서 확인본)

마지막 확인: 2026-11 · 전체 문서 목록: https://code.claude.com/docs/llms.txt
고급 기능은 자주 바뀐다. 세부 형식이 여기와 다르게 동작하면 해당 공식 문서를 다시 확인한다.

## 확장 기능 선택
출처: https://code.claude.com/docs/en/best-practices.md, https://code.claude.com/docs/en/features-overview.md
- CLAUDE.md는 권고(advisory)이고, 훅은 결정적(deterministic)이어서 반드시 실행된다.
- 가끔 필요한 지식·워크플로는 스킬(필요할 때만 로드). 많은 파일을 읽는 조사는 서브에이전트. 외부 시스템은 MCP. 묶어서 공유하려면 플러그인.
- 외부 서비스와는 CLI 도구(`gh`, `aws`, `gcloud`, `sentry-cli`)가 가장 컨텍스트 효율적이다.

## MCP
출처: https://code.claude.com/docs/en/mcp.md
- 원격 HTTP(권장): `claude mcp add --transport http <name> <url>`, 예 `claude mcp add --transport http notion https://mcp.notion.com/mcp`
- 헤더: `--header "Authorization: Bearer YOUR_API_KEY"`
- 로컬 stdio: `claude mcp add [options] <name> -- <command> [args...]`, 예 `claude mcp add --env AIRTABLE_API_KEY=YOUR_KEY --transport stdio airtable -- npx -y airtable-mcp-server`. `--`는 Claude 옵션과 서버 실행 명령을 구분한다.
- SSE는 사용 중단(deprecated).
- 플래그: `-s/--scope`, `-e/--env`, `-t/--transport`, `-H/--header`
- 범위: `local`(기본, `~/.claude.json`의 프로젝트 항목, 나만), `project`(`.mcp.json`, 버전 관리로 공유), `user`(`~/.claude.json`, 모든 프로젝트).
- 같은 서버가 여러 곳에 정의되면 local > project > user > 플러그인 > claude.ai 커넥터 순으로 우선하며, 값은 합쳐지지 않는다.
- `.mcp.json` 형식: `{"mcpServers": {"shared-server": {"type": "http", "url": "https://example.com/mcp"}}}`. `${VAR}`, `${VAR:-default}` 확장을 지원한다.
- `.mcp.json` 서버는 대화형 세션에서 사용 전 승인을 묻는다. 선택 초기화는 `claude mcp reset-project-choices`.
- 관리: `claude mcp list`, `claude mcp get <name>`, `claude mcp remove <name>`. 세션에서는 `/mcp`(상태: `✔ Connected`, `! Needs authentication`, `✘ Failed to connect`, `⏸ Pending approval`).
- OAuth: `/mcp`에서 서버 선택 후 브라우저 로그인, 또는 `claude mcp login <name>` / `claude mcp logout <name>`.
- 리소스 참조: `@server:resource`, 예 `@github:repos/owner/repo/issues` (출처: common-workflows)

## 서브에이전트
출처: https://code.claude.com/docs/en/sub-agents.md
- 각자 컨텍스트, 시스템 프롬프트, 도구 권한을 가지고, 끝나면 요약만 돌려준다. 사용량은 메인 대화와 같은 한도에서 차감된다.
- 기본 제공: `Explore`(빠른 코드베이스 탐색, 읽기 전용), `Plan`(plan 모드 조사, 읽기 전용), `general-purpose`(탐색과 수정).
- 위치와 우선순위: 관리형 > `--agents` 플래그 > `.claude/agents/` > `~/.claude/agents/` > 플러그인 `agents/`. 정체성은 파일 이름이 아니라 `name` 필드로 정해진다.
- 필수 필드: `name`(소문자와 하이픈), `description`. 선택: `tools`(생략하면 상속), `model`(`sonnet`, `opus`, `haiku`, `fable`, 전체 모델 ID, `inherit`). 그 밖에 `disallowedTools`, `permissionMode`, `maxTurns`, `skills`, `mcpServers`, `hooks`, `memory`, `effort`, `background`, `isolation: worktree`.
- 만들기: Claude에게 요청하거나, 파일을 직접 쓰거나, `--agents` JSON(세션 한정). 파일 변경은 보통 재시작 없이 반영된다.
- 호출: 자동(description 기반, "use proactively"로 위임 유도), 자연어, `@` 지정, `claude --agent code-reviewer` 또는 settings의 `"agent"`. 끄기: `permissions.deny`에 `Agent(name)`.
- Claude가 띄운 서브에이전트는 기본적으로 백그라운드에서 실행되고, 완료 알림으로 결과가 온다. `Ctrl+B`로 실행 중인 작업을 백그라운드로 보낸다. 백그라운드 서브에이전트의 권한 요청은 메인 세션에 표시된다.

## 훅
출처: https://code.claude.com/docs/en/hooks-guide.md (전체 스키마: https://code.claude.com/docs/en/hooks.md)
- 사용자 정의 셸 명령. 생명주기의 특정 시점에 실행된다. 판단이 필요한 경우를 위한 prompt 기반·agent 기반 훅도 있다.
- 주요 이벤트: `SessionStart`, `UserPromptSubmit`, `PreToolUse`(차단 가능), `PostToolUse`, `Notification`, `SubagentStop`, `Stop`, `PreCompact`. 그 밖에 `FileChanged`, `CwdChanged`, `ConfigChange`, `PermissionRequest`, `SessionEnd` 등이 있다.
- 설정 위치: settings 파일의 `"hooks"` 키. `/hooks`로 훅 브라우저를 연다.
- 형식: `{"hooks": {"<Event>": [{"matcher": "Edit|Write", "hooks": [{"type": "command", "command": "..."}]}]}}`
- 입력은 stdin JSON. 예: `jq -r '.tool_input.file_path'`
- 종료 코드 0 = 통과, 2 = 차단(stderr에 이유. 이벤트에 따라 Claude에게 피드백으로 가거나 사용자에게 표시된다). `SessionStart` 등 일부 이벤트는 차단할 수 없다. 구조화 제어는 exit 0 + JSON 출력. 한 훅에서는 한 방식만 쓴다.
- 스크립트 경로에는 `"$CLAUDE_PROJECT_DIR"`를 쓴다. 실행 권한(`chmod +x`)이 필요하다.
- 일치하는 훅은 병렬로 실행된다. matcher는 최대한 좁게 쓴다. 특히 PermissionRequest 자동 승인 훅에 `.*`는 위험하다.
- `@` 파일 참조는 도구 호출이 아니라서 PreToolUse 훅이 실행되지 않는다. 막아야 할 경로는 Read deny 규칙으로 막는다.

## 스킬 심화
출처: https://code.claude.com/docs/en/skills.md
- 위치: 개인 `~/.claude/skills/`, 프로젝트 `.claude/skills/`, 하위 폴더 `<subdir>/.claude/skills/`, `--add-dir`, 플러그인 `<plugin>/skills/`(호출 `/plugin-name:skill-name`).
- 필드: `name`, `description`(목록에서 `when_to_use`와 합쳐 1,536자에서 잘림), `when_to_use`, `argument-hint`, `arguments`, `disable-model-invocation`, `user-invocable`, `allowed-tools`, `disallowed-tools`, `model`, `effort`, `context`(`fork`면 서브에이전트에서 실행), `agent`, `background`, `hooks`, `paths`, `shell`.
- claude.ai나 Skills API에 올리는 스킬은 `name`, `description`, `license`, `compatibility`, `metadata`, `allowed-tools`만 허용한다.
- 보조 파일: SKILL.md(500줄 이하 권장)에 언제 읽을지 적는다. `scripts/`는 로드하지 않고 실행한다.
- 변수: `$ARGUMENTS`, `$N`, `$name`, `${CLAUDE_SKILL_DIR}`, `${CLAUDE_SESSION_ID}`, `${CLAUDE_PROJECT_DIR}`.

## 플러그인과 마켓플레이스
출처: https://code.claude.com/docs/en/plugin-marketplaces.md
- 마켓플레이스 = `.claude-plugin/marketplace.json`이 있는 디렉터리·저장소. 필수: `name`, `owner`, `plugins`(각 항목 `name`, `source`).
  ```json
  {
    "name": "my-marketplace",
    "owner": { "name": "Your Name" },
    "plugins": [
      { "name": "my-first-plugin", "source": "./plugins/my-first-plugin", "description": "..." }
    ]
  }
  ```
- `source`: 마켓플레이스 루트 기준 상대 경로. `..`는 validate 오류. 다른 소스: `{"source": "github", "repo": "org/repo"}`, `git-subdir`, `url`, `archive`, `npm`.
- 항목 `name` = 설치 ID(`이름@마켓플레이스`). `plugin.json`의 `name` = 스킬 접두사. 둘을 같게 맞춘다.
- 예약 이름: 제3자 플러그인 이름은 `claude-`, `anthropic-`, `anthropics-`, `cc-plugin-`로 시작할 수 없고 `claude`, `anthropic`, `claude-code` 등도 쓸 수 없다(validate가 거부, 2026-11 확인).
- 명령: `claude plugin validate <dir>`, `claude plugin marketplace add <dir|owner/repo>`, `claude plugin install <plugin>@<marketplace>`, `claude plugin list`, `claude plugin details <plugin>`, `claude plugin marketplace remove <name>`. 세션 안에서는 `/plugin ...`, 편집 후 `/reload-plugins`.
- 배포: git 호스트에 push → 사용자는 `claude plugin marketplace add <owner>/<repo>`.
- 실제 사례: `sanh09/code-guide-protocol`(마켓플레이스 `sanh09-skills`, 플러그인 `codeguide-basics`, `codeguide-intermediate`, `codeguide-advanced`. 각 플러그인에 스킬 `cc-basics`, `cc-intermediate`, `cc-advanced`가 하나씩 들어 있다).

## 자동화
출처: https://code.claude.com/docs/en/headless.md, https://code.claude.com/docs/en/best-practices.md, https://code.claude.com/docs/en/github-actions.md
- `--bare`: 훅, 스킬, 커스텀 명령, 서브에이전트, 플러그인, MCP, 자동 메모리, CLAUDE.md 자동 탐색을 건너뛴다. 스크립트·SDK 호출에 권장되며, 앞으로 `-p`의 기본값이 될 예정이다. OAuth·키체인을 읽지 않으므로 `ANTHROPIC_API_KEY`(또는 `--settings`의 `apiKeyHelper`)가 필요하다. 넘길 것은 `--append-system-prompt`, `--settings`, `--mcp-config`, `--agents`, `--plugin-dir`로 명시한다.
- `--bare` 없는 `-p`는 신뢰하지 않은 폴더에서도 프로젝트 `.claude/settings.json`의 훅과 `.mcp.json` 서버를 실행한다. 신뢰 확인 창이나 서버별 승인 창이 뜨지 않는다.
- 권한: `--allowedTools`, `--permission-mode auto|dontAsk|acceptEdits`. `dontAsk`는 확인이 필요한 호출을 모두 거부한다. 무인 실행에는 `--permission-prompts none`(v2.1.259+).
- 구조화 출력: `--output-format json --json-schema '{...}'` → `structured_output` 필드(없을 수 있으니 확인).
- 스트리밍: `--output-format stream-json --verbose --include-partial-messages`
- 시스템 프롬프트: `--append-system-prompt`, `--append-system-prompt-file`, 교체는 `--system-prompt`.
- fan-out: `for file in $(cat files.txt); do claude -p "..." --allowedTools "Edit,Bash(git commit *)" --permission-mode dontAsk; done`. 먼저 2~3개로 시험한다. 세션 안에서는 `/batch <instruction>`(5~30개 서브에이전트, 각자 worktree).
- GitHub Actions 빠른 설정: 저장소에서 `claude` 실행 후 `/install-github-app`(gh CLI 필요, 저장소 관리자 권한 필요).
- 예약 실행: 클라우드 예약 작업(claude.ai/code/routines), 데스크톱 예약 작업, GitHub Actions, `/loop`.
- 종료 조건 강제: `/goal` 조건, Stop 훅.

## 병렬 작업과 리뷰
출처: https://code.claude.com/docs/en/common-workflows.md, https://code.claude.com/docs/en/best-practices.md
- `claude --worktree feature-auth`: 격리된 git worktree에서 세션 시작. 커밋이 하나 이상 있어야 하며, 없으면 `Failed to resolve base branch "HEAD"`로 실패한다.
- Writer/Reviewer 패턴, 테스트 작성자와 구현자 분리.
- 적대적 리뷰: 서브에이전트에게 PLAN.md 기준 diff 리뷰를 맡긴다. 번들 스킬 `/code-review`. 정확성·요구 사항에 영향을 주는 것만 보고하게 해서 과잉 설계를 막는다.
- 그 밖에: 데스크톱 앱 병렬 세션, 클라우드 세션, `claude agents`(에이전트 뷰, 연구 미리보기), 에이전트 팀(실험적, 기본 꺼짐).
