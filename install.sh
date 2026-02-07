#!/bin/bash

# Git AI Assistant - Installer
# Installs scripts, hooks, and templates to the current git repository.

# Determine the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing Git AI Assistant from $SCRIPT_DIR..."

# 1. Ensure we are in a git repository and find root
REPO_ROOT=$(git rev-parse --show-toplevel 2> /dev/null)
if [ -z "$REPO_ROOT" ]; then
    echo "Error: Not a git repository. Please run this script from inside a git repo."
    exit 1
fi

# Prevent installing into the git-ai-assistant repo itself if run from there
# Check if SCRIPT_DIR is the same as REPO_ROOT (meaning we are inside the source package root)
if [ "$REPO_ROOT" == "$SCRIPT_DIR" ]; then
  echo "Error: You are running the installer inside the 'git-ai-assistant' repository itself."
  echo "Usage:"
  echo "  1. Go to your TARGET project root."
  echo "  2. Clone this repo: git clone git@github.com:shanwu/git-ai-assistant.git"
  echo "  3. Run installer: ./git-ai-assistant/install.sh"
  exit 1
fi

echo "Found repository root: $REPO_ROOT"

# 2. Copy scripts
echo "Installing scripts..."
mkdir -p "$REPO_ROOT/scripts"
# Use "$SCRIPT_DIR/scripts/..." to locate source files correctly
cp "$SCRIPT_DIR/scripts/generate_pr_description.sh" "$REPO_ROOT/scripts/"
chmod +x "$REPO_ROOT/scripts/generate_pr_description.sh"
echo "  [CREATE] $REPO_ROOT/scripts/generate_pr_description.sh"

# 3. Copy GitHub template
echo "Installing PR template..."
mkdir -p "$REPO_ROOT/.github"
TARGET_TEMPLATE="$REPO_ROOT/.github/pull_request_template.md"
SOURCE_TEMPLATE="$SCRIPT_DIR/templates/pull_request_template.md"

if [ -f "$TARGET_TEMPLATE" ]; then
    echo "  [SKIP]   $TARGET_TEMPLATE already exists."
    echo "           (Source: $SOURCE_TEMPLATE)"
else
    cp "$SOURCE_TEMPLATE" "$TARGET_TEMPLATE"
    echo "  [CREATE] $TARGET_TEMPLATE"
fi

# 4. Copy Git Hook
echo "Installing Git Hook..."
HOOK_PATH="$REPO_ROOT/.git/hooks/prepare-commit-msg"
SOURCE_HOOK="$SCRIPT_DIR/templates/prepare-commit-msg"

if [ -f "$HOOK_PATH" ]; then
    echo "  [INFO]   $HOOK_PATH already exists."
    read -p "           Do you want to overwrite it? (y/N) " -n 1 -r
    echo 
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cp "$SOURCE_HOOK" "$HOOK_PATH"
        chmod +x "$HOOK_PATH"
        echo "  [UPDATE] $HOOK_PATH"
    else
        echo "  [SKIP]   Skipped hook installation."
    fi
else
    cp "$SOURCE_HOOK" "$HOOK_PATH"
    chmod +x "$HOOK_PATH"
    echo "  [CREATE] $HOOK_PATH"
fi

# 5. Configure Git for Auto-Commit (No Editor)
echo "Configuring git to skip editor confirmation..."
# Run git config in the repo root context
git -C "$REPO_ROOT" config core.editor "true"
echo "  [CONFIG] Set core.editor = true in $REPO_ROOT/.git/config"

# 6. specific ignores
echo "Configuring .gitignore..."
GITIGNORE_FILE="$REPO_ROOT/.gitignore"
if [ ! -f "$GITIGNORE_FILE" ]; then
    touch "$GITIGNORE_FILE"
    echo "Created .gitignore"
fi

if ! grep -q "git-ai-assistant/" "$GITIGNORE_FILE"; then
    echo "" >> "$GITIGNORE_FILE"
    echo "# Git AI Assistant Installer" >> "$GITIGNORE_FILE"
    echo "git-ai-assistant/" >> "$GITIGNORE_FILE"
    echo "Added git-ai-assistant/ to .gitignore"
else
    echo "git-ai-assistant/ already ignored."
fi

# 7. Check dependencies
echo "Checking dependencies..."
if ! command -v gemini &> /dev/null; then
    echo "Warning: 'gemini' CLI tool not found."
    echo "Please install it (e.g., npm install -g gemini-chat-cli) to use the AI features."
else
    echo "gemini CLI found."
fi

if [ -z "$GEMINI_API_KEY" ]; then
    echo "Reminder: Don't forget to export GEMINI_API_KEY='your_key' in your shell."
else
    echo "GEMINI_API_KEY is set."
fi

echo "Installation complete!"
echo "You can now run 'git commit' to automatically generate a description and commit immediately."
