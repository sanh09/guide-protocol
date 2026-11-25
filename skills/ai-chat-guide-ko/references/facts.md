# Claude 앱 사실 정리 (도움말 문서 확인본)

마지막 확인: 2026-11 · 도움말 센터: https://support.claude.com (한국어: https://support.claude.com/ko)
- 앱은 자주 바뀐다. 학습자 화면과 다르면 학습자 화면과 최신 도움말이 우선이다.
- 설정 화면은 **새 레이아웃**과 **이전 레이아웃**이 함께 쓰이고 있다. 아래에 경로가 두 개 있으면 둘 다 안내한다.
- Team·Enterprise 플랜은 조직 관리자가 기능을 끄거나 켤 수 있다.
- 요금제 이름: Free, Pro, Max, Ultra, Team, Enterprise. 가격과 사용 한도는 https://claude.com/pricing 과 도움말 문서로 안내하고, 숫자를 단정하지 않는다.

## 시작하기와 화면
출처: https://support.claude.com/en/articles/12997377-getting-started-with-claude-ai, https://support.claude.com/en/articles/10574485-using-extended-thinking
- 웹(claude.ai), 데스크톱 앱, 모바일 앱(iOS·Android)에서 쓸 수 있다.
- 모델·노력(effort)·생각(thinking): 보내기 버튼 옆의 모델 이름을 눌러 모델을 고른다. 노력(Effort) 수준과 생각(Thinking 또는 Extended) 토글은 모델에 따라 다르다.
  - 노력이 높을수록 더 꼼꼼하지만 오래 걸리고, 사용 한도에 더 빨리 닿는다.
  - 생각을 켜면 Claude가 답하기 전에 문제를 나누고 계획한다. 펼쳐 볼 수 있는 영역에 생각 과정이 보인다.
  - 일부 최신 모델은 생각이 항상 켜져 있다.
- 대화 관리: 이름 바꾸기, 삭제, 공유(공유 링크, 특정 사람과 공유)가 가능하다. 도움말의 "Conversation management" 모음 참고.
- 언어: 왼쪽 아래 프로필 아이콘 → 언어(Language)에서 화면 언어를 바꾼다. 화면 언어와 상관없이 어떤 언어로든 대화할 수 있다. (출처: https://support.claude.com/en/articles/10769299)

## 좋은 질문 쓰기
출처: https://support.claude.com/en/articles/12997377-getting-started-with-claude-ai, https://docs.claude.com/en/docs/build-with-claude/prompt-engineering/overview
- 맥락(누구를 위한, 무엇에 쓸), 목표, 원하는 형식(길이, 표, 말투), 예시를 주면 결과가 좋아진다.
- 복잡한 일은 단계로 나눠 요청한다.
- 첫 답이 마음에 안 들면 처음부터 다시 쓰지 말고 무엇을 바꿀지 구체적으로 말한다("더 짧게", "초등학생도 알게").
- 앞에서 한 이야기는 다시 붙여 넣지 말고 "앞에서 말한 그 표"처럼 가리킨다. 사용 한도를 아끼는 방법이기도 하다. (출처: https://support.claude.com/en/articles/9797557-usage-limit-best-practices)

## 파일 올리기
출처: https://support.claude.com/en/articles/8241126-upload-files-to-claude
- 문서: PDF, DOCX, CSV, TXT, HTML, ODT, RTF, EPUB, JSON, XLSX. XLSX는 "코드 실행 및 파일 생성"을 켜야 한다.
- 이미지: JPEG, PNG, GIF, WebP.
- 채팅 업로드 한도: 파일당 500MB, 채팅당 최대 20개, 이미지 최대 8000×8000 픽셀, PDF 최대 1000페이지.
- PDF는 100페이지 이하면 글과 그림(이미지, 차트)을 함께 분석한다. 그보다 길면 글 위주로 처리한다.
- 프로젝트 파일: 파일당 30MB.
- 파일 만들기·편집(코드 실행 기능) 쪽은 업로드·다운로드 파일당 30MB 한도가 따로 있다. (출처: https://support.claude.com/en/articles/12111783)
- Google Drive, GitHub 등 연결된 앱에서도 파일을 가져올 수 있다("+" 메뉴).

## 웹 검색 · Research · 생각
출처: https://support.claude.com/en/articles/11095361-when-should-i-use-web-search-extended-thinking-and-research, https://support.claude.com/en/articles/12997377-getting-started-with-claude-ai
- **웹 검색**: 한두 번의 검색으로 답할 수 있는 간단한 최신 정보(날씨, 뉴스, 회사 정보)에 맞다. Free·Pro·Max·Ultra는 기본으로 켜져 있고, Team·Enterprise는 기본으로 꺼져 있어 관리자가 켤 수 있다. 내 문서만으로 답해야 할 때는 끄거나 "검색하지 마"라고 쓴다.
- **Research**: 1~3분 이상 여러 번 검색해서 출처가 달린 보고서를 만든다. 경쟁사 비교처럼 큰 질문에 쓴다. 유료 플랜에서 쓸 수 있다. Research를 켜면 생각도 함께 켜진다.
- **생각(확장 사고)**: 최신 정보가 필요 없는 복잡한 추론(수학, 분석, 여러 관점 비교)에 맞다.

## 프로젝트
출처: https://support.claude.com/en/articles/9517075-what-are-projects, https://support.claude.com/en/articles/9519177-how-can-i-create-and-manage-projects
- 자체 채팅 기록과 지식 공간을 가진 작업 공간이다.
- 만들기: 왼쪽 메뉴 "프로젝트(Projects)" 또는 claude.ai/projects → "+ 새 프로젝트(New Project)" → 이름과 설명. **Claude는 이름과 설명을 보지 않는다.**
- 프로젝트 지식(knowledge): 프로젝트 페이지 오른쪽. "+"로 문서·텍스트·코드를 올리면 그 프로젝트의 모든 채팅에서 쓰인다.
- 프로젝트 지침: "프로젝트 지침 설정(Set project instructions)" → 지침 작성 → 저장. 프로젝트의 모든 채팅에 적용된다. 지침은 짧고 핵심만 쓰고, 작업별 요청은 채팅에서 한다.
- **프로젝트 안의 채팅끼리는 내용이 공유되지 않는다.** 프로젝트 지식에 올린 것만 공유된다.
- 유료 플랜은 지식이 많아지면 자동으로 RAG(필요한 부분만 찾아 읽는 방식)로 바뀌어 용량이 최대 약 10배로 늘어난다.
- 같은 문서를 프로젝트에 올려 두고 반복해서 쓰면 사용 한도를 덜 쓴다(캐싱).
- Team·Enterprise는 공개 범위(비공개 또는 조직 공유)를 고를 수 있다.
- 새 버전의 프로젝트(베타)가 단계적으로 배포 중이다. 화면이 다르면 도움말을 확인한다.

## 나에게 맞추기: 지침 · 메모리 · 이전 채팅 검색 · 시크릿 채팅
출처: https://support.claude.com/en/articles/10185728-understanding-claude-s-personalization-features, https://support.claude.com/en/articles/11817273, https://support.claude.com/en/articles/12260368-use-incognito-chats
- **Claude 지침(계정 전체)**: 왼쪽 아래 이니셜 → 설정(Settings) → "Your Claude"(이전 레이아웃: "계정(Account)") → "지침(Instructions)"(이전: "Instructions for Claude"). 선호하는 방식, 자주 쓰는 용어, 말투 등을 적는다. 모든 대화에 적용된다.
- 고르는 기준: 모든 대화에는 계정 지침, 특정 작업 묶음에는 프로젝트 지침(유료), 응답 방식이나 반복 작업에는 스킬.
- **이전 채팅 검색**: "지난번에 [주제] 얘기한 거 찾아줘"처럼 물으면 이전 대화를 찾아 참고한다. 검색은 대화 안에 도구 사용으로 표시된다. 프로젝트 밖 채팅 전체, 또는 프로젝트별로 검색한다. 끄기: 설정 > Your Claude(이전: 설정 > 메모리)의 "채팅 검색 및 참조(Search and reference chats)".
- **메모리**: 대화에서 알게 된 맥락(역할, 진행 중인 일, 선호하는 소통 방식 등)을 기억해 새 대화에 이어 쓴다. 켜기·끄기: 설정 > Your Claude(이전: 설정 > 메모리)의 "채팅에서 메모리 생성(Memory from chats / Generate memory from chat history)". 기억된 항목은 설정의 메모리 화면에서 주제(Topics)별로 보고 고치거나 지울 수 있다. 건강·신념 같은 민감한 주제는 따로 켜지 않으면 기억하지 않는다.
- 한 채팅만 메모리를 빼려면, 첫 메시지를 보내기 전에 "+" 메뉴에서 메모리를 끈다. 이 채팅은 기록에 남는다.
- **시크릿 채팅**: 프로젝트 밖 새 채팅에서 오른쪽 위 유령 아이콘. 검은 테두리와 "시크릿 채팅(Incognito chat)" 표시가 보인다. 채팅 기록과 메모리에 저장되지 않고, 이전 채팅 검색에도 잡히지 않는다. 시작한 뒤에는 일반 채팅으로 바꿀 수 없다. 프로필 지침·스타일은 시크릿 채팅에서도 적용된다. 새 Claude 환경에서는 시크릿 채팅에서 파일 만들기나 코드 실행이 안 될 수 있다. 모든 요금제에서 쓸 수 있다.
- 메모리와 이전 채팅 검색 기능의 제공 범위는 요금제와 배포 상황에 따라 다르다. 설정에 없으면 도움말을 확인하게 한다.

## 아티팩트와 파일 만들기
출처: https://support.claude.com/en/articles/17153992-what-are-artifacts-and-how-do-i-use-them, https://support.claude.com/en/articles/12111783-create-and-edit-files-with-claude
- 아티팩트 = Claude가 만들어 주는, 남에게 보여 줄 만한 결과물(문서, 발표 자료, 디자인, 대시보드, 작은 도구 등). 대화 옆에 열리고, 고치고, 다시 열고, 공유할 수 있다. 템플릿은 "아티팩트(Artifacts)" 탭에서 시작할 수 있다.
- 아티팩트를 쓰려면 "클라우드 코드 실행 및 파일 생성"(새 레이아웃 이름: "Create and edit files")을 켜야 한다. 위치: 설정 > 기능(Capabilities)(Free·Pro·Max·Ultra) 또는 조직 설정 > 기능(Team·Enterprise).
- 템플릿으로 만든 문서는 Word, PDF, Markdown, Google Docs로, 발표 자료는 PowerPoint, PDF, Google Slides로 내보낼 수 있다("Export").
- 공유한 아티팩트를 다른 사람이 쓰면 사용량은 각자의 한도에서 차감된다.
- 파일 만들기: Excel(.xlsx), PowerPoint(.pptx), Word(.docx), PDF를 대화에서 바로 만들어 내려받거나 Google Drive에 저장할 수 있다. CSV 같은 데이터를 올려 분석하고 차트를 만들 수도 있다.

## 음성 모드
출처: https://support.claude.com/en/articles/11101966-use-voice-mode
- 말로 대화하고 답을 들을 수 있다. 베타 기능이며, 모든 요금제에서 모바일·데스크톱·웹으로 쓸 수 있다. 휴대폰에 가장 잘 맞다.
- 웹·데스크톱: 채팅 창 오른쪽 아래 음파 아이콘 → 말하기 → 끝낼 때 "중지".
- 모바일: 입력창의 마이크 옆 음파 아이콘 → 목소리 선택 → 말하기.
- 음성 언어는 화면 언어와 따로 설정한다: 설정 > 기능 > 음성 > 말하는 언어(없으면 설정 > 일반 > 음성 > 언어). (출처: https://support.claude.com/en/articles/10769299)

## 커넥터
출처: https://support.claude.com/en/articles/11176164-use-connectors-to-extend-claude-s-capabilities, https://support.claude.com/en/articles/13345190-get-started-with-claude-cowork, https://support.claude.com/en/articles/14730684-how-claude-suggests-connected-apps
- 커넥터 = Claude가 내 앱·서비스(Google Drive, Gmail, Google Calendar, Slack, Notion, Microsoft 365 등)의 데이터를 읽고, 그 안에서 동작도 할 수 있게 하는 연결. 웹 커넥터는 웹·데스크톱·모바일의 모든 사용자가 쓸 수 있다.
- 연결: 사용자 정의(Customize) > 커넥터(Connectors)에서 찾아 추가하고 로그인한다. 커넥터 디렉터리(Connectors Directory)에서 둘러볼 수 있다.
- 채팅마다 쓸 커넥터는 입력창의 "+" 메뉴에서 켜고 끈다.
- 연결한 뒤에는 이름을 말하지 않아도 Claude가 알맞을 때 앱을 쓰자고 제안한다. 비슷한 앱이 여럿이면 고르게 한다.
- 도구별 권한: 사용자 정의 > 커넥터 → 커넥터 선택 → 권한(Permissions) 탭 → 도구 권한에서 "항상 묻기(Always ask)".
- 연결 해제: 사용자 정의 > 커넥터에서 해제하면 바로 접근이 멈춘다.
- 사용자 지정 커넥터(원격 MCP 서버 URL): 모든 요금제에서 쓸 수 있으며, Free는 1개까지다. 데스크톱 확장(내 컴퓨터의 파일·프로그램용)은 데스크톱 앱에서만 쓸 수 있다. (출처: https://support.claude.com/en/articles/11175166, https://support.claude.com/en/articles/11725091)
- Team·Enterprise는 관리자가 조직 설정에서 커넥터를 먼저 허용해야 할 수 있다.

## 스킬과 플러그인
출처: https://support.claude.com/en/articles/12512180-use-skills-in-claude, https://support.claude.com/en/articles/12512198-how-to-create-custom-skills, https://support.claude.com/en/articles/13837440-use-plugins-in-claude
- 스킬 = 특정 작업을 잘하게 해 주는 지시와 자료 묶음. 필요할 때 Claude가 알아서 불러 쓴다(예: 우리 회사 보고서 양식, 내 글쓰기 스타일, 이 튜터 과정).
- 보기·켜기·올리기: 사용자 정의(Customize) > 스킬(Skills). 직접 올리려면 "+" → "+ 스킬 만들기" → "스킬 업로드" → ZIP 파일. ZIP 안의 맨 위에는 스킬 폴더가 있어야 하고, 폴더 이름은 스킬 이름과 같아야 한다.
- 스킬을 쓰려면 코드 실행(파일 생성) 기능이 켜져 있어야 한다. 모든 요금제(Free 포함)에서 쓸 수 있다. Enterprise는 관리자가 허용해야 한다.
- Claude에게 대화로 스킬을 만들어 달라고 할 수도 있다.
- 플러그인 = 스킬·커넥터·하위 에이전트를 직무별로 묶은 꾸러미. 유료 플랜(Pro, Max, Ultra, Team, Enterprise)에서 쓸 수 있다. 자세한 사용법은 도움말을 안내한다.

## 사용 한도 아끼기
출처: https://support.claude.com/en/articles/9797557-usage-limit-best-practices, https://support.claude.com/en/articles/11647753-how-do-usage-and-length-limits-work
- 자주 쓰는 문서는 프로젝트 지식에 올려 두면 반복 사용 시 한도를 덜 쓴다.
- 대화가 너무 길어지면 새 대화를 시작하거나 프로젝트를 쓴다.
- 노력(effort) 수준이 높을수록, Research처럼 오래 걸리는 기능일수록 한도를 더 쓴다.

## 안전·개인정보
출처: 도움말의 "Conversation management"(공유 링크), 시크릿 채팅·메모리 문서
- 공유 링크를 받은 사람은 그 대화를 볼 수 있다. 공유를 해제할 수 있다.
- 시크릿 채팅은 기록·메모리에 남지 않는다.
- 커넥터는 내 권한으로 앱에 접근한다. 필요한 것만 연결하고, 쓰기 동작(메일 보내기 등)은 "항상 묻기"로 둔다.
