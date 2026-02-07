# 🤖 Git AI Assistant

**Turn your commits into professional updates.**  
This tool automatically writes clear, detailed Pull Request descriptions and commit messages for you using Google's Gemini AI. No more staring at a blinking cursor trying to remember what you changed.

---

## 🚀 Features

-   **Automatic Descriptions**: Generates a professional PR description based on your code clianges.
-   **One-Command Workflow**: Just run `git commit`, and it handles the rest.
-   **Customizable**: Uses your own templates if you want to tweak the style.

---

## 🛠️ Prerequisites (Do this first!)

Before installing, make sure you have these two things:

1.  **Node.js**: You need Node.js installed to run the AI tool.
    -   [Download Node.js here](https://nodejs.org/) if you don't have it.
2.  **Gemini API Key**: You need a free API key from Google.
    -   [Get your API Key here](https://aistudio.google.com/app/apikey)
    -   Copy the key, you will need it in a moment.

---

## 📦 Installation

Follow these steps to add the assistant to your project.

### Step 1: Install the AI CLI Tool
Open your terminal and run this command to install the helper tool:

```bash
npm install -g gemini-chat-cli
```

### Step 2: Set up your API Key
Tell your computer your API key so it can talk to Google.
*(Replace `YOUR_ACTUAL_API_KEY` with the key you copied earlier)*

**For Mac/Linux:**
```bash
export GEMINI_API_KEY="YOUR_ACTUAL_API_KEY"
```
*(Tip: Add this line to your `~/.zshrc` or `~/.bash_profile` so you don't have to do it every time!)*

**For Windows (PowerShell):**
```powershell
$env:GEMINI_API_KEY="YOUR_ACTUAL_API_KEY"
```

### Step 3: Install into your Repository
Navigate to the **root folder of your project** (not inside the `git-ai-assistant` folder) and run:

```bash
# Clone the assistant repo
git clone git@github.com:shanwu/git-ai-assistant.git

# Run the installer script
./git-ai-assistant/install.sh
```

---

## 🎮 How to Use

Once installed, just use Git like normal!

1.  Make some changes to your code.
2.  Stage your changes:
    ```bash
    git add .
    ```
3.  Commit:
    ```bash
    git commit
    ```

**What happens next?**
-   The AI will look at your changes.
-   It will generate a description.
-   It will automatically commit your changes with that description.
-   🚀 **Done!**


---

## 🎨 Customizing the Template

Don't like the default PR description? You can change it!

The assistant uses a file in your project to decide how the description looks.

1.  Open the file: `.github/pull_request_template.md`
2.  Edit it however you want! You can add sections like "Testing Instructions", "Jira Ticket", or change the emojis.
3.  The next time you run `git commit`, the AI will follow your new structure.

---

## ❓ Troubleshooting

**"Command not found: gemini"**
-   You probably didn't install the CLI tool. Run `npm install -g gemini-chat-cli`.
-   If you installed it but it still fails, try closing and reopening your terminal.

**"Error: GEMINI_API_KEY not found"**
-   You forgot to set the API key. Run the `export GEMINI_API_KEY=...` command again.

**"Not a git repository"**
-   Make sure you are running the installation script from the *root* folder of your project (where the `.git` folder is hidden).

---

## 🗑️ Uninstalling

If you want to remove the assistant from your project:

1.  Delete the hook execution file:
    ```bash
    rm .git/hooks/prepare-commit-msg
    ```
2.  (Optional) Remove the scripts folder if you don't want it anymore:
    ```bash
    rm -rf git-ai-assistant
    ```
