# guide-protocol: learn Claude Code in the Claude app

**English** | [한국어](README.ko.md)

> **Reply language**: every tutor replies in the language the learner writes in (English, Korean, Japanese, and so on).

Tutor skills for learning Claude Code **in a chat in the Claude web (claude.ai) or desktop app**.

> **The Claude app tutor (`ai-chat-guide`) has moved to its own repository**: https://github.com/sanh09/app-guide-plugin
> This repository only holds the **Claude Code courses** you take in the Claude app.

## Claude Code courses (Basics · Intermediate · Advanced)

Courses that teach Claude Code one step at a time in a Claude app chat. Each course is made of tutorials, hands-on exercises, and quizzes.

> The version you use inside the Claude Code terminal is in a separate repository: https://github.com/sanh09/code-guide-protocol

| Course | Skill | For | Covers |
|---|---|---|---|
| Basics | `cc-basics-app` | People new to the terminal and coding | First conversation, input prefixes (`/` `!` `@`) and shortcuts, managing a conversation, permissions and modes, `CLAUDE.md`, `settings.json` |
| Intermediate | `cc-intermediate-app` | Developers, or people who finished Basics | Writing good requests, the plan-mode workflow, git, PRs and checkpoints, permission rules in depth, your own slash commands (skills), session management, `claude -p` |
| Advanced | `cc-advanced-app` | People who finished Intermediate or passed its check quiz | Choosing an extension type, MCP, subagents, hooks, building and publishing skills and plugins, automation, parallel work with worktrees |

## How to add a skill (same for every course)

1. Download the `.zip` file of the course you want from the `dist/` folder (open the file, then "Download raw file"). Don't unzip it.
   - [`dist/cc-basics-app.zip`](dist/cc-basics-app.zip)
   - [`dist/cc-intermediate-app.zip`](dist/cc-intermediate-app.zip)
   - [`dist/cc-advanced-app.zip`](dist/cc-advanced-app.zip)
2. In the Claude web or desktop app, go to **Customize > Skills**.
3. Select "+" → "+ Create skill" → "Upload a skill", and upload the `.zip` file.
4. Check that the skill is turned on in the list.

Skills need code execution (file creation) turned on in settings. On the Enterprise plan, an organization admin has to allow skills.

## Using the courses

Start a new chat and say something like this to begin the right course:

- Basics: "Teach me Claude Code from the start", "Give me a CLAUDE.md quiz"
- Intermediate: "Start the Claude Code intermediate course", "How do I use plan mode well?"
- Advanced: "How do I connect an MCP server?", "I want to set up hooks"

### How the lessons work

- Claude in the chat can't see your computer. So you **learn in the chat → try it in Claude Code in your own terminal → post the result (output or a screenshot) back in the chat**.
- Commands typed into the chat box don't run. Type them in your terminal.
- To do the exercises, you need Claude Code on your computer. If you don't have it, see the official guide: https://code.claude.com/docs/en/quickstart
- Before posting a settings file or log in the chat, remove secrets such as API keys and tokens.

### Level checks (Intermediate and Advanced)

- **Intermediate**: asks about your development experience first. With experience, you start right away. Without it, the tutor asks whether you finished Basics; if you did, you take a check quiz (4 of 5 correct). If you didn't, it sends you to Basics.
- **Advanced**: you need to pass the Intermediate check quiz. Without development experience, finish Basics and Intermediate first.
- The chat app keeps no completion record, so starting the next course in a new chat means a check quiz. Continuing in the same chat skips it.

## Structure

```
skills/
  cc-basics-app/
  cc-intermediate-app/
  cc-advanced-app/
    SKILL.md                     tutor rules
    references/curriculum.md     lessons, exercises, quiz bank
    references/quiz-answers.md   quiz answer key (read only when grading)
    references/facts.md          facts checked against the official docs (as of 2026-11)
    references/gating.md         level check (Intermediate, Advanced)
dist/                            .zip files for upload (each includes the license files)
LICENSE, LICENSE-CC-BY-4.0.txt, NOTICE.txt  licenses (code MIT, content CC BY 4.0)
```

After editing a skill, rebuild its archive in `dist/` with `bash scripts/build-dist.sh`. The skill folder must be at the top of the ZIP (for example `cc-basics-app/SKILL.md`).

## Release notes

### 2026-11-26: License file names and a wording fix in the Advanced course
- The license files are now `LICENSE-CC-BY-4.0.txt` and `NOTICE.txt` (they were `LICENSE-CC-BY-4.0` and `NOTICE`), the same names as in the plugin repositories. The license terms are the same.
- Advanced course: the MCP scope lesson no longer spells out the path of the user settings file, and the sample key is written as `YOUR_API_KEY`, to match the Claude Code plugin. Nothing changes in what the lesson teaches, so you do not need to upload the skill again.

### 2026-11-26: Dual license (code MIT, content CC BY 4.0)
- Code stays under MIT; the tutor content is now under CC BY 4.0. See [License](#license) and [`NOTICE.txt`](NOTICE.txt).
- Every `.zip` in `dist/` now includes `LICENSE`, `LICENSE-CC-BY-4.0.txt` and `NOTICE.txt`, and each `SKILL.md` has a `license` field. A skill you already added keeps working; upload the new `.zip` only if you want the license files with it.

### 2026-11-25: `-ko` dropped from the names (action needed)
- The skills are renamed: `cc-basics-ko-app` → `cc-basics-app`, `cc-intermediate-ko-app` → `cc-intermediate-app`, `cc-advanced-ko-app` → `cc-advanced-app`. The tutors still reply in the learner's language.

**If you added the old names, replace them**: in Customize > Skills, delete the old `-ko-app` skills and upload the new `.zip` files from `dist/`.

### 2026-11-25: English README and license
- The README is now in English by default, with the Korean version in [README.ko.md](README.ko.md). A LICENSE file was added.

### 2026-11-25: Claude app tutor moved out
- `ai-chat-guide-ko` was removed from this repository and is now kept only in [app-guide-plugin](https://github.com/sanh09/app-guide-plugin). A copy you already added keeps working; for future updates, download `dist/ai-chat-guide-ko-skill.zip` from app-guide-plugin.

### 2026-11-25: Replies in the learner's language
- Every tutor replies in the language the learner writes in (English, Korean, Japanese, and so on). The reference files stay in Korean and are translated when the tutor replies.
- Translated quizzes keep the meaning of each option, and grading compares meanings.

**How to update**: in Customize > Skills, delete the old skill and upload the new `.zip` file from `dist/`.

### 2026-11-25: Quiz answers no longer leak
- Fixed quiz answers showing up in the question, examples, or hints. Answers now live in each skill's `references/quiz-answers.md` and are read only when grading.
- Options are shuffled every time, and answer-format examples use placeholders only, such as `1-?, 2-?`.
- Quiz cards put the answer only in the answer field and open in quiz mode. Quizzes are never asked with multiple-choice question buttons.
- Applies to `cc-basics-ko-app`, `cc-intermediate-ko-app`, `cc-advanced-ko-app` (and, at that time, `ai-chat-guide-ko`)

**How to update**: in Customize > Skills, delete the old skill and upload the new `.zip` file from `dist/`.

Full change log: https://github.com/sanh09/code-guide-protocol/blob/main/maintenance/CHANGELOG.md

## Contributing

Changes go through pull requests, not direct pushes to `main`. Make a branch, edit, and merge the PR once the checks pass. The automatic updates follow the same flow. Details: https://github.com/sanh09/code-guide-protocol/blob/main/maintenance/MAINTENANCE.md

## Maintenance

Rebuild the `dist/` files with `bash scripts/build-dist.sh`. The update procedure and records are in https://github.com/sanh09/code-guide-protocol/tree/main/maintenance

## License

This project uses two licenses:
- **Code** — shell scripts (`*.sh`) and JSON/YAML configuration files — is under the [MIT License](LICENSE). Code examples inside the lessons may also be used under MIT.
- **Content** — `SKILL.md`, the reference files (lessons, facts, quizzes, answer keys), evals, READMEs, maintenance documents and images — is under [Creative Commons Attribution 4.0 (CC BY 4.0)](LICENSE-CC-BY-4.0.txt).

When you reuse the content, credit it like this: `guide-protocol by sanh09 (https://github.com/sanh09/guide-protocol), CC BY 4.0`. [`NOTICE.txt`](NOTICE.txt) has the details and the note on Anthropic trademarks. Every `.zip` in `dist/` includes all three files.
