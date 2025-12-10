# org

Simple CLI to organize your files.

## Install

```bash
# Clone the repo
git clone https://github.com/adibhanna/org_life.git
cd org_life

# Add to your PATH (add this to ~/.zshrc)
export PATH="$PATH:/path/to/org_life"

# Run setup
org setup
```

Setup will prompt for:
- **Base directory** (default: `~/Life`)
- **Organization mode**: Work and Personal, Work only, or Personal only
- **Company/project name** (for work directories)

## Zsh Autocomplete

Add to your `~/.zshrc` **before** `compinit`:

```bash
# Add org_life to fpath for completions
fpath=(/path/to/org_life $fpath)

# Then compinit (if not already present)
autoload -Uz compinit && compinit
```

Restart your shell or run `source ~/.zshrc`.

Works with [fzf-tab](https://github.com/Aloxaf/fzf-tab) for fuzzy completion.

## Optional Dependencies

- **fzf** - Fuzzy finder for interactive selection (`brew install fzf`)
- **ripgrep** - Fast search (`brew install ripgrep`)

Without these, commands fall back to numbered menus and grep.

## Usage

```bash
# Move/copy files to destinations
org mv invoice.pdf receipts
org cp photo.jpg photos

# Archive files (adds date prefix, organizes by year)
org archive old-report.pdf        # -> Archive/2025/2025-12-10_old-report.pdf
org archive doc.pdf work          # -> Work archive

# List all destinations
org ls

# Open in Finder
org open inbox
org inbox              # Shortcut

# Navigate (use with cd)
cd $(org cd wcode)

# Search files
org find               # Browse all files
org find budget        # Search content

# Open code project in editor
org code               # Interactive picker
org code myproject     # Open specific project

# Process inbox interactively
org inbox

# Show status
org status
```

## Project Management

```bash
# List projects
org projects ls

# Add a new project
org projects add YouTube/TechTips              # Uses default template
org projects add YouTube/TechTips -t youtube   # Uses youtube template

# Rename a project
org projects rename oldname newname

# Archive a project (moves to Archive/YYYY/ with date prefix)
org projects archive myproject

# Remove a project (deletes directory and config entry)
org projects rm myproject

# Open project in editor
org projects code              # Interactive picker
org projects code myproject    # Open specific project

# Sync config with directory structure
org sync

# Manage templates
org template list
org template show youtube
org template edit youtube
org template new podcast
```

## Configuration

```bash
# Edit config
org edit

# Create directories from config
org create
```

Config is stored at `~/.config/orglife/org.yaml`:

```yaml
base: ~/Life

# Work - Acme
wcode: Work/Acme/Code | Code and repos
wdocs: Work/Acme/Docs | Documents
winbox: Work/Acme/Inbox | Files to sort
warchive: Work/Acme/Archive | Archived files

# Personal
docs: Personal/Docs | Personal documents
finance: Personal/Finance | Financial documents
inbox: Personal/Inbox | Files to sort
archive: Personal/Archive | Archived files
```

Format: `alias: path | description`

## Templates

Templates are stored in `~/.config/orglife/templates/` as YAML files.

**default.yaml:**
```yaml
# Default project template
Code: Code and repos
Docs: Documents
Inbox: Files to sort
Archive: Archived files
```

**youtube.yaml:**
```yaml
# YouTube channel template
Recordings: Raw recordings and footage
Edits: Work in progress edits
Published: Final exported videos
Thumbnails: Thumbnail images
Assets: Graphics, music, b-roll
Scripts: Scripts and outlines
```

## Commands

| Command | Description |
|---------|-------------|
| `org mv <file> <dest>` | Move file to destination |
| `org cp <file> <dest>` | Copy file to destination |
| `org archive <file> [work]` | Archive file with date prefix |
| `org projects ls` | List projects |
| `org projects add <path> [-t tpl]` | Add new project with template |
| `org projects rename <old> <new>` | Rename project |
| `org projects archive <alias>` | Archive entire project |
| `org projects rm <alias>` | Remove project and config entry |
| `org projects code [project]` | Open project in editor |
| `org ls` | List all destinations |
| `org cd <dest>` | Print path (use: `cd $(org cd work)`) |
| `org open <dest>` | Open destination in Finder |
| `org inbox` | Process inbox interactively |
| `org status` | Show organization status |
| `org find [term]` | Search files, then open or archive |
| `org code [project]` | Open code project in editor |
| `org template` | Manage project templates |
| `org sync` | Sync config with directory structure |
| `org edit` | Edit config in $EDITOR |
| `org create` | Create directories from config |
| `org setup` | Initial setup |
