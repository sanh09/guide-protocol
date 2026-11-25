# guide-protocol: Claude 앱에서 배우는 한국어 Claude Code 과정 (기초 · 중급 · 고급)

Claude **웹(claude.ai)·데스크톱 앱의 채팅**에서 Claude Code를 한국어로, 한 단계씩 배우는 튜터 스킬 모음입니다. 각 과정은 튜토리얼, 실습 과제, 퀴즈로 구성되어 있습니다.

> Claude Code 터미널 안에서 쓰는 버전은 별도 저장소에 있어요: https://github.com/sanh09/code-guide-protocol

| 과정 | 스킬 | 대상 | 다루는 내용 |
|---|---|---|---|
| 기초 | `cc-basics-ko-app` | 터미널·코딩이 처음인 사람 | 첫 대화, 입력 기호(`/` `!` `@`)와 단축키, 대화 관리, 권한과 모드, `CLAUDE.md`, `settings.json` |
| 중급 | `cc-intermediate-ko-app` | 개발 경험자 또는 기초 수료자 | 좋은 요청 쓰기, plan 모드 워크플로, git·PR·체크포인트, 권한 규칙 심화, 나만의 슬래시 명령(스킬), 세션 관리, `claude -p` |
| 고급 | `cc-advanced-ko-app` | 중급 수료자 또는 확인 퀴즈 통과자 | 확장 기능 고르기, MCP, 서브에이전트, 훅, 스킬·플러그인 제작과 배포, 자동화, worktree 병렬 작업 |

## 추가하는 방법

1. `dist/` 폴더에서 원하는 과정의 `.zip` 파일을 내려받으세요(파일을 연 뒤 "Download raw file"). 압축은 풀지 않아요.
   - [`dist/cc-basics-ko-app.zip`](dist/cc-basics-ko-app.zip)
   - [`dist/cc-intermediate-ko-app.zip`](dist/cc-intermediate-ko-app.zip)
   - [`dist/cc-advanced-ko-app.zip`](dist/cc-advanced-ko-app.zip)
2. Claude 웹 또는 데스크톱 앱에서 **사용자 정의(Customize) > 스킬(Skills)**로 가세요.
3. "+" 버튼 → "+ 스킬 만들기" → "스킬 업로드"를 누르고 `.zip` 파일을 올리세요.
4. 목록에 나타난 스킬이 켜져 있는지 확인하세요.

스킬을 쓰려면 설정에서 코드 실행(파일 생성) 기능이 켜져 있어야 해요. Enterprise 플랜은 조직 관리자가 스킬 기능을 허용해야 해요.

## 사용법

새 채팅에서 이렇게 말하면 알맞은 과정이 시작돼요.

- 기초: "Claude Code 처음부터 알려주세요", "CLAUDE.md 퀴즈 내주세요"
- 중급: "Claude Code 중급 시작할래요", "plan 모드 잘 쓰는 법"
- 고급: "MCP 서버 연결하는 법", "훅 설정하고 싶어요"

### 수업 방식

- 채팅의 Claude는 내 컴퓨터를 볼 수 없어요. 그래서 **채팅에서 배우고 → 내 터미널의 Claude Code에서 해 보고 → 결과(출력이나 스크린샷)를 채팅에 올리는** 방식으로 진행해요.
- 채팅창에 명령어를 입력하면 실행되지 않아요. 명령어는 터미널에 입력하세요.
- 실습하려면 내 컴퓨터에 Claude Code가 있어야 해요. 없다면 공식 안내를 보세요: https://code.claude.com/docs/en/quickstart
- 설정 파일이나 로그를 채팅에 올릴 때는 API 키·토큰 같은 비밀 값을 지우고 올리세요.

### 수준 확인 (중급·고급)

- **중급**: 시작할 때 개발 경험을 물어요. 개발 경험이 있으면 바로 시작해요. 없으면 기초를 마쳤는지 묻고, 마쳤다면 확인 퀴즈(5문제 중 4문제 이상)를 봐요. 마치지 않았다면 기초 과정으로 안내해요.
- **고급**: 중급 확인 퀴즈를 통과해야 시작해요. 개발 경험이 없으면 기초와 중급을 먼저 마쳐야 해요.
- 채팅 앱에는 수료 기록이 남지 않아서, 새 채팅에서 다음 과정을 시작하면 확인 퀴즈를 봐요. 같은 채팅에서 이어서 하면 퀴즈 없이 넘어가요.

## 구조

```
skills/
  cc-basics-ko-app/
  cc-intermediate-ko-app/
  cc-advanced-ko-app/
    SKILL.md                     튜터 규칙
    references/curriculum.md     레슨, 실습, 퀴즈 문제 은행
    references/facts.md          공식 문서로 확인한 사실 정리 (2026-11 기준)
    references/gating.md         수준 확인 절차 (중급·고급)
dist/                            업로드용 .zip 파일
```

스킬을 고친 뒤에는 `skills/<이름>/` 폴더를 다시 압축해서 `dist/`의 파일을 바꿔 주세요. ZIP 안에는 스킬 폴더가 맨 위에 있어야 해요(예: `cc-basics-ko-app/SKILL.md`).
