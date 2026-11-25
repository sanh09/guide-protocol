# guide-protocol: Claude 앱에서 배우는 학습 과정

> **응답 언어**: 모든 튜터는 학습자가 쓰는 언어(한국어, 영어, 일본어 등)로 답합니다. 스킬 이름의 `-ko`는 처음 만든 이름을 그대로 둔 것입니다. All tutors reply in the learner's language.


Claude **웹(claude.ai)·데스크톱 앱의 채팅**에서 쓰는 튜터 스킬 모음입니다. 두 종류가 있습니다.

- **Claude 앱 사용법** (`ai-chat-guide-ko`): Claude 앱 자체를 잘 쓰는 법
- **Claude Code 과정** (`cc-*-ko-app`): 터미널에서 쓰는 코딩 도구 Claude Code 배우기

## Claude 앱 사용법 (`ai-chat-guide-ko`)

Claude를 처음 쓰는 분부터 기능을 더 깊이 쓰고 싶은 분까지를 위한 과정입니다. 코딩 지식은 필요 없습니다. 실습은 Claude 앱의 새 채팅에서 바로 해 봅니다.

- 기초: 첫 대화와 화면, 좋은 질문 쓰기, 파일·이미지 올리기, 웹 검색·Research·생각 설정
- 활용: 프로젝트, 지침·메모리·이전 채팅 검색·시크릿 채팅, 아티팩트와 파일 만들기, 음성 모드와 모바일
- 고급: 커넥터, 스킬, 여러 기능 조합하기, 안전하고 믿을 수 있게 쓰기

파일: [`dist/ai-chat-guide-ko.zip`](dist/ai-chat-guide-ko.zip) · 시작하기: 새 채팅에서 "Claude 사용법 알려주세요", "프로젝트 기능이 뭐예요?"

## Claude Code 과정 (기초 · 중급 · 고급)

Claude 앱의 채팅에서 Claude Code를 한 단계씩 배우는 과정입니다. 각 과정은 튜토리얼, 실습 과제, 퀴즈로 구성되어 있습니다.

> Claude Code 터미널 안에서 쓰는 버전은 별도 저장소에 있어요: https://github.com/sanh09/code-guide-protocol

| 과정 | 스킬 | 대상 | 다루는 내용 |
|---|---|---|---|
| 기초 | `cc-basics-ko-app` | 터미널·코딩이 처음인 사람 | 첫 대화, 입력 기호(`/` `!` `@`)와 단축키, 대화 관리, 권한과 모드, `CLAUDE.md`, `settings.json` |
| 중급 | `cc-intermediate-ko-app` | 개발 경험자 또는 기초 수료자 | 좋은 요청 쓰기, plan 모드 워크플로, git·PR·체크포인트, 권한 규칙 심화, 나만의 슬래시 명령(스킬), 세션 관리, `claude -p` |
| 고급 | `cc-advanced-ko-app` | 중급 수료자 또는 확인 퀴즈 통과자 | 확장 기능 고르기, MCP, 서브에이전트, 훅, 스킬·플러그인 제작과 배포, 자동화, worktree 병렬 작업 |

## 추가하는 방법 (모든 스킬 공통)

1. `dist/` 폴더에서 원하는 과정의 `.zip` 파일을 내려받으세요(파일을 연 뒤 "Download raw file"). 압축은 풀지 않아요.
   - [`dist/ai-chat-guide-ko.zip`](dist/ai-chat-guide-ko.zip) (Claude 앱 사용법)
   - [`dist/cc-basics-ko-app.zip`](dist/cc-basics-ko-app.zip)
   - [`dist/cc-intermediate-ko-app.zip`](dist/cc-intermediate-ko-app.zip)
   - [`dist/cc-advanced-ko-app.zip`](dist/cc-advanced-ko-app.zip)
2. Claude 웹 또는 데스크톱 앱에서 **사용자 정의(Customize) > 스킬(Skills)**로 가세요.
3. "+" 버튼 → "+ 스킬 만들기" → "스킬 업로드"를 누르고 `.zip` 파일을 올리세요.
4. 목록에 나타난 스킬이 켜져 있는지 확인하세요.

스킬을 쓰려면 설정에서 코드 실행(파일 생성) 기능이 켜져 있어야 해요. Enterprise 플랜은 조직 관리자가 스킬 기능을 허용해야 해요.

## Claude Code 과정 사용법

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
  ai-chat-guide-ko/             Claude 앱 사용법
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

## 업데이트 내역

### 2026-11-25: 퀴즈 정답 노출 수정
- 퀴즈를 낼 때 정답이 문제·예시·힌트에 함께 보이던 문제를 고쳤습니다. 정답은 각 스킬의 `references/quiz-answers.md`로 분리되어 채점할 때만 쓰입니다.
- 보기 순서가 매번 섞이고, 답 형식 예시는 `1-?, 2-?`처럼 자리 표시만 씁니다.
- 퀴즈 카드에서는 정답을 정답 칸에만 넣고, 퀴즈 모드로 엽니다. 선택형 질문 버튼으로는 퀴즈를 내지 않습니다.
- 대상: `cc-basics-ko-app`, `cc-intermediate-ko-app`, `cc-advanced-ko-app`, `ai-chat-guide-ko`

**업데이트 방법**: 사용자 정의(Customize) > 스킬(Skills)에서 기존 스킬을 지우고, `dist/`의 새 `.zip` 파일을 다시 올려 주세요.

전체 변경 기록: https://github.com/sanh09/code-guide-protocol/blob/main/maintenance/CHANGELOG.md

## 변경 방법

이 저장소의 변경은 `main`에 직접 push하지 않고 PR(Pull Request)로 진행합니다. 브랜치를 만들어 수정하고, 검증(`claude plugin validate .` 등)이 통과하면 PR을 merge합니다. 자동 업데이트도 같은 방식으로 PR을 만들고 merge합니다. 자세한 절차: https://github.com/sanh09/code-guide-protocol/blob/main/maintenance/MAINTENANCE.md
## 유지보수

`dist/` 파일은 `bash scripts/build-dist.sh`로 다시 만듭니다. 업데이트 절차와 기록은 https://github.com/sanh09/code-guide-protocol/tree/main/maintenance 에 있습니다.
