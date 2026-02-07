# Git AI Assistant

An intelligent Git wrapper that automatically generates Pull Request descriptions using Gemini AI when you commit.

## Features
- **Auto-Generation**: Generates concise, structured PR descriptions for every commit.
- **Auto-Commit**: Bypasses the editor to commit immediately with the generated message.
- **Customizable**: Uses `.github/pull_request_template.md` to define the output format.

## Installation

1. Go to the root of your target project.
2. Clone the repo:
   ```bash
   git clone git@github.com:shanwu/git-ai-assistant.git
   ```
3. Run the installer:
   ```bash
   ./git-ai-assistant/install.sh
   ```

## Requirements
- `gemini-cli` installed and in PATH (e.g., `npm install -g gemini-chat-cli`)
- `GEMINI_API_KEY` exported in your environment.

## Usage

### Standard Commit
```bash
git add .
git commit
```
**That's it!**
The system will:
1.  Generate a description from your changes.
2.  Commit immediately with that description (no Vim/Nano will open).
