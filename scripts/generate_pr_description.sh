#!/bin/bash

# Check if gemini is installed
if ! command -v gemini &> /dev/null; then
    echo "Error: gemini command not found."
    exit 1
fi

# Get the diff from staged changes
DIFF_CONTENT=$(git diff --cached)

# Check if there are staged changes
if [ -z "$DIFF_CONTENT" ]; then
    echo "No staged changes found. Please stage your changes before running this script."
    exit 1
fi

# Read template
TEMPLATE_FILE="$(git rev-parse --show-toplevel)/.github/pull_request_template.md"
if [ -f "$TEMPLATE_FILE" ]; then
    TEMPLATE_CONTENT=$(cat "$TEMPLATE_FILE")
else
    # Fallback template
    TEMPLATE_CONTENT="**PR Subject:** <summary>\n\n**PR Description:**\n<description>"
fi

# Prepare the prompt
PROMPT="Generate a concise PR description based on the following git diff. Follow this format exactly:\n\n$TEMPLATE_CONTENT\n\nDiff:\n$DIFF_CONTENT"

# Call Gemini CLI
# Assuming 'gemini prompt' is the command based on help
gemini prompt "$PROMPT"
