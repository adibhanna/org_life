# org

Simple CLI to organize your files.

## Install

```bash
./setup.sh              # Uses ~/Life as base
./setup.sh ~/Dropbox    # Custom location
```

## Usage

```bash
# Move files quickly
org mv invoice.pdf receipts
org mv photo.jpg photos
org mv notes.md docs

# Copy instead of move
org cp backup.zip backups

# Open folders
org open work        # Opens in Finder
org open inbox
org work             # Shortcut: just the destination name

# Navigate
cd $(org cd projects)

# Process inbox
org inbox            # Interactive file sorting

# Status
org status           # Overview of your files
org ls               # List all destinations

# Search
org find budget      # Search by filename/content

# Initialize structure
org init
```

## Destinations

| Alias       | Path                |
|-------------|---------------------|
| work        | Work                |
| meetings    | Work/Meetings       |
| projects    | Projects            |
| code        | Projects/Code       |
| personal    | Projects/Personal   |
| finance     | Finance             |
| receipts    | Finance/Receipts    |
| taxes       | Finance/Taxes       |
| docs        | Documents           |
| identity    | Documents/Identity  |
| legal       | Documents/Legal     |
| media       | Media               |
| photos      | Media/Photos        |
| screenshots | Media/Screenshots   |
| videos      | Media/Videos        |
| designs     | Media/Designs       |
| learn       | Learning            |
| courses     | Learning/Courses    |
| books       | Learning/Books      |
| notes       | Learning/Notes      |
| archive     | Archive/YYYY        |
| inbox       | Inbox               |
| system      | System              |
| backups     | System/Backups      |
| configs     | System/Configs      |

## Tab Completion

Setup adds tab completion automatically:
- **zsh**: Copies to `~/.zfunc/_org`
- **bash**: Source `org-completion.bash`

## Config

Config stored in `~/.org_life`:

```bash
BASE_DIR="$HOME/Life"
```
