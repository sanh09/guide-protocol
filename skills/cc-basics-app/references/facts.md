# Claude Code 기초 사실 정리 (공식 문서 확인본)

마지막 확인: 2026-11 · 출처: https://code.claude.com/docs (전체 목록: https://code.claude.com/docs/llms.txt)
Claude Code는 자주 업데이트된다. 여기와 학습자 화면이 다르면 학습자 화면(`/help`)이 우선이다.

## 입력 기호 (Quick commands)
출처: https://code.claude.com/docs/en/interactive-mode.md

| 입력 | 뜻 |
|---|---|
| `/` (맨 앞) | 명령 또는 스킬. `/`만 치면 쓸 수 있는 명령 목록이 뜨고, 글자를 더 치면 걸러진다 |
| `!` (맨 앞) | 셸 모드. Claude를 거치지 않고 터미널 명령을 바로 실행하고, 그 결과를 대화에 넣어 Claude가 반응하게 한다. 예: `! ls` |
| `@` | 파일 경로 멘션. 자동완성으로 파일을 골라 Claude에게 가리킬 수 있다. 예: `@README.md 요약해줘` |
| `?` (빈 입력에서) | 단축키 도움말 패널 열기/닫기 |

명령은 메시지 맨 앞에 있을 때만 인식된다. 명령 뒤에 오는 글은 그 명령의 인자가 된다.

※ 예전 자료의 "`#`으로 시작하면 메모리 저장" 기능은 현재 문서에 없다. 가르치지 말 것.

## 주요 단축키
출처: https://code.claude.com/docs/en/interactive-mode.md

| 단축키 | 기능 |
|---|---|
| `Esc` | Claude의 응답/작업을 중간에 멈춤(지금까지 한 작업은 유지). 대화창(dialog) 닫기 |
| `Esc` 두 번 | 입력 중이면 입력 지우기(기록에 저장되어 `↑`로 되돌릴 수 있음). 입력이 비어 있으면 되감기(rewind) 메뉴 |
| `Ctrl+C` | 실행 중인 작업 중단. 아무것도 실행 중이 아니면 첫 번째는 입력 지우기, 두 번째는 종료 |
| `Ctrl+D` | 세션 종료(두 번 눌러 확인) |
| `Shift+Tab` | 권한 모드 순환: `default`(Manual) → `acceptEdits` → `plan` → (가능할 때) `bypassPermissions` → `auto`. `auto`에서 누르면 `default`로 |
| `↑` / `↓` | 이전 입력 기록 탐색 |
| `Ctrl+R` | 입력 기록 검색 |
| `Ctrl+O` | 자세한 작업 내역(transcript) 보기 |
| `Ctrl+L` | 화면 다시 그리기(화면이 깨졌을 때) |
| `Ctrl+G` | 프롬프트를 기본 텍스트 편집기에서 편집 |
| 줄바꿈 | `\` + `Enter`(모든 터미널), `Ctrl+J`(모든 터미널), `Shift+Enter`(iTerm2, Windows Terminal, Apple 터미널 등 대부분) |

## 입력창 자동 제안 (Prompt suggestions)
출처: https://code.claude.com/docs/en/interactive-mode.md

- Claude가 답한 뒤, 다음에 입력할 만한 내용을 입력창에 회색 글씨로 제안할 수 있다. `Tab` 또는 `→`로 채우고 `Enter`로 보낸다. 직접 타이핑을 시작하면 사라진다.
- 끄는 법: `/config`에서 **Prompt suggestions** 끄기, 또는 settings 파일에 `"promptSuggestionEnabled": false`, 또는 환경 변수 `CLAUDE_CODE_ENABLE_PROMPT_SUGGESTION=false`(설정보다 우선).
- plan 모드에서는 제안하지 않는다.

## 주요 슬래시 명령
출처: https://code.claude.com/docs/en/commands.md

| 명령 | 기능 |
|---|---|
| `/help` | 도움말과 쓸 수 있는 명령 보기 |
| `/clear` | 빈 컨텍스트로 새 대화 시작. 이전 대화는 `/resume`으로 다시 열 수 있음 |
| `/compact [지시]` | 지금까지의 대화를 요약해 공간 확보, 같은 대화를 이어감. 요약에 집중할 내용을 지시로 줄 수 있음 |
| `/context` | 현재 컨텍스트 사용량을 색깔 격자로 보기. 어떤 CLAUDE.md가 로드됐는지도 확인 가능 |
| `/resume` | 이전 대화 이어서 열기(목록에서 선택) |
| `/rewind` | 대화 및/또는 코드를 이전 시점으로 되감기 (별칭: `/undo`, `/checkpoint`) |
| `/init` | 프로젝트를 분석해 시작용 `CLAUDE.md` 생성. 이미 있으면 덮어쓰지 않고 개선을 제안 |
| `/memory` | CLAUDE.md 파일 열어 편집, 자동 메모리 켜기/끄기, 자동 메모리 보기 |
| `/config` | 설정 화면(테마, 모델 등). `/config key=value`로 바로 설정도 가능 |
| `/permissions` | 허용(allow)/확인(ask)/거부(deny) 권한 규칙 관리 |
| `/model` | 모델 바꾸기(새 세션 기본값으로 저장됨) |
| `/plan [설명]` | 계획 모드로 바로 들어가기 |
| `/status` | 버전, 모델, 계정, 연결 상태, 로드된 설정 파일(Setting sources) 확인 |
| `/usage` | 사용량·비용 보기 (`/cost`는 별칭) |
| `/doctor` | 설치·설정·CLAUDE.md 문제 점검 |
| `/exit` | 종료 (별칭: `/quit`) |

## 권한 모드 (Shift+Tab으로 전환)
출처: https://code.claude.com/docs/en/permission-modes.md

**중요: v2.1.283부터 터미널·VS Code 대화형 세션은 기본적으로 `auto` 모드로 시작한다.** 그래서 학습자 화면에서는 권한 요청 창이 거의 안 뜰 수 있다. 화면 아래 상태 표시줄로 현재 모드를 확인시킨다.

| 모드 | 상태 표시줄 | 뜻 |
|---|---|---|
| `default` (Manual) | `⏸ manual mode on` | 파일 수정·명령 실행 전에 물어봄. 권한 요청을 직접 보며 배우기 좋음 |
| `acceptEdits` | `⏵⏵ accept edits on` | 파일 수정과 `mkdir`·`cp` 같은 흔한 파일 명령은 묻지 않음 |
| `plan` | `⏸ plan mode on` | 파일을 바꾸지 않고 읽고 계획만 세움 |
| `auto` | `⏵⏵ auto mode on` | 별도 검사 모델이 각 작업을 미리 검토해서 일상적인 확인 창을 건너뜀. 요청 범위를 넘거나 위험해 보이는 작업은 막음. 확인 창은 줄지만 안전을 보장하지는 않음 |
| `bypassPermissions` | `⏵⏵ bypass permissions on` | 거의 묻지 않고 진행. 위험, 초보자에게 권하지 않음 |

- 학습 중 권한 요청을 직접 보고 싶다면 `Shift+Tab`으로 Manual(`⏸ manual mode on`)로 바꾸면 된다.
- 항상 Manual로 시작하게 하려면 `~/.claude/settings.json`에:
  ```json
  { "permissions": { "defaultMode": "default" } }
  ```

권한 요청에서 "Yes, and don't ask again"을 고르면 그 허용 규칙이 `.claude/settings.local.json`에 저장된다.

## CLAUDE.md (프로젝트 메모리)
출처: https://code.claude.com/docs/en/memory.md

CLAUDE.md는 Claude가 매 세션 시작 때 읽는 "지침 메모". 매번 같은 설명을 반복하지 않게 해 준다. 강제 규칙이 아니라 참고 맥락이므로, 짧고 구체적으로 쓸수록 잘 지켜진다.

| 종류 | 위치 | 적용 대상 |
|---|---|---|
| 사용자 지침 | `~/.claude/CLAUDE.md` | 나, 모든 프로젝트 |
| 프로젝트 지침 | `./CLAUDE.md` 또는 `./.claude/CLAUDE.md` | 프로젝트의 모든 사람(git에 커밋해 공유) |
| 로컬 지침 | `./CLAUDE.local.md` | 나, 이 프로젝트만 (`.gitignore`에 추가) |

- 여러 파일이 있으면 덮어쓰지 않고 **모두 합쳐서** 읽는다. 현재 폴더와 그 위 폴더들의 파일은 시작 때 로드, 하위 폴더 파일은 그 폴더 작업 시 로드.
- `/init`: 코드베이스를 분석해 빌드 명령, 테스트 방법, 관례를 담은 CLAUDE.md 초안을 만든다.
- 다른 파일 가져오기: CLAUDE.md 안에 `@path/to/file` 형식으로 쓰면 그 파일 내용도 함께 로드된다. 예: `@README.md`
- 추가·수정 방법: `/memory`로 파일 열어 편집, 또는 Claude에게 "이 내용을 CLAUDE.md에 추가해줘"라고 요청.
- 자동 메모리(auto memory): "항상 pnpm 써"처럼 기억해 달라고 하면 Claude가 스스로 `~/.claude/projects/<프로젝트>/memory/`에 메모를 남긴다. `/memory`에서 켜고 끌 수 있다.
- 로드됐는지 확인: `/context`의 Memory files 목록 또는 `/memory`.
- 저장소에 AGENTS.md만 있고 CLAUDE.md가 없으면 AGENTS.md를 대신 읽는다.

좋은 CLAUDE.md 예시:
```markdown
# 프로젝트 안내
- 실행: `npm run dev`
- 테스트: `npm test`
- 코드 스타일: 들여쓰기 2칸, 세미콜론 사용
- 답변은 한국어로
```

## settings.json (설정 파일)
출처: https://code.claude.com/docs/en/settings.md, https://code.claude.com/docs/en/permissions.md

설치만 해서는 설정 파일이 생기지 않는다. `/config`에서 옵션을 바꾸거나 권한을 "다시 묻지 않기"로 허용하면 Claude Code가 만든다.

| 범위 | 파일 | 적용 대상 |
|---|---|---|
| 사용자 | `~/.claude/settings.json` | 나, 이 컴퓨터의 모든 프로젝트 |
| 공유 프로젝트 | `.claude/settings.json` | 이 프로젝트의 모든 사람(git에 커밋) |
| 프로젝트 로컬 | `.claude/settings.local.json` | 나, 이 프로젝트만(git에서 제외) |
| 관리형 | `managed-settings.json` 등 | 조직이 배포. 사용자가 못 바꿈 |

우선순위(높은 것부터): 관리형 > 명령줄(`--settings`) > 프로젝트 로컬 > 공유 프로젝트 > 사용자.
단, `permissions.allow` 같은 **목록은 덮어쓰지 않고 합쳐진다**.

- 설정 파일은 엄격한 JSON: `//` 주석이나 마지막 쉼표가 있으면 오류(Settings Error).
- 대부분의 수정은 저장하면 바로 반영(재시작 불필요). `model` 등 일부는 세션 시작 때만 읽음.
- 확인: `/status`의 `Setting sources` 줄.

권한 예시:
```json
{
  "permissions": {
    "allow": [
      "Bash(npm run lint)",
      "Bash(npm run test *)"
    ],
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)"
    ]
  }
}
```
- `allow`: 묻지 않고 허용 / `ask`: 항상 물어봄 / `deny`: 금지
- `.env`처럼 비밀번호·키가 담긴 파일은 `deny`로 막아 두는 것이 좋은 습관.
