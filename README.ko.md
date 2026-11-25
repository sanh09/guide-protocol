# guide-protocol: Claude 앱에서 배우는 학습 과정

[English](README.md) | **한국어**

> **응답 언어**: 모든 튜터는 학습자가 쓰는 언어(한국어, 영어, 일본어 등)로 답합니다. All tutors reply in the learner's language.


Claude **웹(claude.ai)·데스크톱 앱의 채팅**에서 Claude Code를 배우는 튜터 스킬 모음입니다.

> **Claude 앱 사용법 튜터(`ai-chat-guide`)는 별도 저장소로 옮겼습니다**: https://github.com/sanh09/app-guide-plugin
> 이 저장소는 Claude 앱에서 배우는 **Claude Code 과정**만 관리합니다.

## Claude Code 과정 (기초 · 중급 · 고급)

Claude 앱의 채팅에서 Claude Code를 한 단계씩 배우는 과정입니다. 각 과정은 튜토리얼, 실습 과제, 퀴즈로 구성되어 있습니다.

> Claude Code 터미널 안에서 쓰는 버전은 별도 저장소에 있어요: https://github.com/sanh09/code-guide-protocol

| 과정 | 스킬 | 대상 | 다루는 내용 |
|---|---|---|---|
| 기초 | `cc-basics-app` | 터미널·코딩이 처음인 사람 | 첫 대화, 입력 기호(`/` `!` `@`)와 단축키, 대화 관리, 권한과 모드, `CLAUDE.md`, `settings.json` |
| 중급 | `cc-intermediate-app` | 개발 경험자 또는 기초 수료자 | 좋은 요청 쓰기, plan 모드 워크플로, git·PR·체크포인트, 권한 규칙 심화, 나만의 슬래시 명령(스킬), 세션 관리, `claude -p` |
| 고급 | `cc-advanced-app` | 중급 수료자 또는 확인 퀴즈 통과자 | 확장 기능 고르기, MCP, 서브에이전트, 훅, 스킬·플러그인 제작과 배포, 자동화, worktree 병렬 작업 |

## 추가하는 방법 (모든 스킬 공통)

1. `dist/` 폴더에서 원하는 과정의 `.zip` 파일을 내려받으세요(파일을 연 뒤 "Download raw file"). 압축은 풀지 않아요.
   - [`dist/cc-basics-app.zip`](dist/cc-basics-app.zip)
   - [`dist/cc-intermediate-app.zip`](dist/cc-intermediate-app.zip)
   - [`dist/cc-advanced-app.zip`](dist/cc-advanced-app.zip)
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
  cc-basics-app/
  cc-intermediate-app/
  cc-advanced-app/
    SKILL.md                     튜터 규칙
    references/curriculum.md     레슨, 실습, 퀴즈 문제 은행
    references/quiz-answers.md   퀴즈 정답표 (채점할 때만 읽음)
    references/facts.md          공식 문서로 확인한 사실 정리 (2026-11 기준)
    references/gating.md         수준 확인 절차 (중급·고급)
dist/                            업로드용 .zip 파일
```

스킬을 고친 뒤에는 `skills/<이름>/` 폴더를 다시 압축해서 `dist/`의 파일을 바꿔 주세요. ZIP 안에는 스킬 폴더가 맨 위에 있어야 해요(예: `cc-basics-app/SKILL.md`).

## 업데이트 내역

### 2026-11-25: 이름에서 `-ko` 제거 (다시 올리기 필요)
- 스킬 이름을 바꿨습니다: `cc-basics-ko-app` → `cc-basics-app`, `cc-intermediate-ko-app` → `cc-intermediate-app`, `cc-advanced-ko-app` → `cc-advanced-app`. 학습자가 쓰는 언어로 답하는 것은 그대로입니다.

**예전 이름으로 추가했다면 바꿔 주세요**: 사용자 정의(Customize) > 스킬(Skills)에서 예전 `-ko-app` 스킬을 지우고, `dist/`의 새 `.zip` 파일을 올리세요.

### 2026-11-25: 영어 README와 라이선스
- README 기본 언어를 영어로 바꾸고, 한국어는 이 파일(README.ko.md)에서 볼 수 있습니다. LICENSE 파일을 추가했습니다.

### 2026-11-25: Claude 앱 사용법 튜터 분리
- `ai-chat-guide-ko`를 이 저장소에서 빼고 [app-guide-plugin](https://github.com/sanh09/app-guide-plugin)에서만 관리합니다. 이미 받아 쓰는 스킬은 그대로 쓸 수 있고, 다음 업데이트부터는 app-guide-plugin의 `dist/ai-chat-guide-ko-skill.zip`을 받으세요.

### 2026-11-25: 학습자 언어로 응답
- 모든 튜터가 학습자가 쓰는 언어(한국어, 영어, 일본어 등)로 답합니다. 참고 파일은 한국어로 두고, 응답할 때 학습자의 언어로 옮깁니다.
- 퀴즈는 옮겨도 보기의 뜻을 유지하고, 채점은 뜻으로 대조합니다.

**업데이트 방법**: 사용자 정의(Customize) > 스킬(Skills)에서 기존 스킬을 지우고, `dist/`의 새 `.zip` 파일을 다시 올려 주세요.

### 2026-11-25: 퀴즈 정답 노출 수정
- 퀴즈를 낼 때 정답이 문제·예시·힌트에 함께 보이던 문제를 고쳤습니다. 정답은 각 스킬의 `references/quiz-answers.md`로 분리되어 채점할 때만 쓰입니다.
- 보기 순서가 매번 섞이고, 답 형식 예시는 `1-?, 2-?`처럼 자리 표시만 씁니다.
- 퀴즈 카드에서는 정답을 정답 칸에만 넣고, 퀴즈 모드로 엽니다. 선택형 질문 버튼으로는 퀴즈를 내지 않습니다.
- 대상: `cc-basics-ko-app`, `cc-intermediate-ko-app`, `cc-advanced-ko-app` (당시에는 `ai-chat-guide-ko`도 포함)

**업데이트 방법**: 사용자 정의(Customize) > 스킬(Skills)에서 기존 스킬을 지우고, `dist/`의 새 `.zip` 파일을 다시 올려 주세요.

전체 변경 기록: https://github.com/sanh09/code-guide-protocol/blob/main/maintenance/CHANGELOG.md

## 변경 방법

이 저장소의 변경은 `main`에 직접 push하지 않고 PR(Pull Request)로 진행합니다. 브랜치를 만들어 수정하고, 검증(`claude plugin validate .` 등)이 통과하면 PR을 merge합니다. 자동 업데이트도 같은 방식으로 PR을 만들고 merge합니다. 자세한 절차: https://github.com/sanh09/code-guide-protocol/blob/main/maintenance/MAINTENANCE.md

## 유지보수

`dist/` 파일은 `bash scripts/build-dist.sh`로 다시 만듭니다. 업데이트 절차와 기록은 https://github.com/sanh09/code-guide-protocol/tree/main/maintenance 에 있습니다.

## 라이선스

MIT 라이선스입니다. [`LICENSE`](LICENSE)를 보세요.
