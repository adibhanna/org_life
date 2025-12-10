# Universal Life Organization System Documentation

## 🎯 Overview

A comprehensive file organization system designed to manage every aspect of your digital life, from work projects to personal documents, optimized for cloud synchronization across all your devices.

## 🚀 Quick Start

### 1. Initial Setup

```bash
# Run the main setup script
./organize_life.sh

# You'll be prompted for the base directory
# Recommended: Use your cloud sync folder
# Example: ~/Dropbox/Life or ~/iCloud/Life
```

### 2. Copy Configuration Template

```bash
# Copy and customize the configuration
cp organize_config_template.sh ~/.organize_config
nano ~/.organize_config
```

### 3. Add Helper Scripts to PATH

```bash
# Add to your shell configuration (.bashrc, .zshrc, etc.)
export PATH="$HOME/.dotfiles/bin:$PATH"

# Or create symlinks
ln -s ~/.dotfiles/bin/organize_life.sh /usr/local/bin/organize
ln -s ~/.dotfiles/bin/org-* /usr/local/bin/
```

## 📁 Directory Structure

```
Life/
├── Work/               # Professional life
│   ├── Projects/
│   ├── Career/
│   └── Meetings/
├── Code/               # Programming & development
│   ├── Projects/
│   ├── Learning/
│   └── Resources/
├── Content/            # Creative content
│   ├── Writing/
│   ├── Video/
│   ├── Audio/
│   └── Graphics/
├── Finance/            # Financial management
│   ├── Banking/
│   ├── Investments/
│   ├── Taxes/
│   └── Budget/
├── Education/          # Learning & growth
│   ├── Courses/
│   ├── Books/
│   └── Research/
├── Health/             # Health & wellness
│   ├── Medical/
│   ├── Fitness/
│   └── Nutrition/
├── Personal/           # Personal documents
│   ├── Documents/
│   ├── Family/
│   └── Travel/
├── Hobbies/            # Recreation & interests
├── Business/           # Entrepreneurship
├── System/             # Technical files
├── Inbox/              # Unsorted items
└── Archive/            # Historical items
```

## 🛠️ Available Commands

### Main Scripts

#### `organize` (organize_life.sh)
The main setup script that creates your entire organization structure.

```bash
# First time setup
./organize_life.sh

# Re-run to add missing directories
./organize_life.sh
```

### Helper Scripts

#### `org-quick-add`
Quickly file documents to the right location.

```bash
# Add file to specific category
org-quick-add document.pdf work
org-quick-add receipt.jpg finance
org-quick-add notes.txt code

# Categories: work, code, finance, doc, content, inbox
```

#### `org-inbox-process`
Interactive tool to sort files from your inbox.

```bash
# Process all files in inbox interactively
org-inbox-process

# You'll be shown each file and given options for where to move it
```

#### `org-maintenance`
Run maintenance checks on your organization system.

```bash
# Interactive maintenance check
org-maintenance

# Automated mode (for cron jobs)
org-maintenance --auto

# Features:
# - Check inbox status
# - Find duplicate files
# - Identify large files
# - Find items ready for archiving
# - Clean empty directories
# - Generate statistics
```

#### `org-search`
Search for files across your organization.

```bash
# Search by filename
org-search "project-name"

# Search file contents
org-search "search term"
```

#### `org-archive`
Archive old files to year-based folders.

```bash
# List files that can be archived (>90 days old)
org-archive

# Actually move files (uncomment the mv command in script)
org-archive
```

#### `org-report`
Generate a report on your organization system.

```bash
# Generate usage statistics
org-report

# Shows:
# - Storage usage
# - File counts by category
# - Recently modified files
# - Inbox status
```

## ⚙️ Configuration

### Basic Configuration

Edit `~/.organize_config`:

```bash
# Set your base directory
BASE_DIR="$HOME/Dropbox/Life"

# Enable/disable features
CREATE_WORK_DIRS=true
CREATE_BUSINESS_DIRS=true
CREATE_CODE_DIRS=true
CREATE_CONTENT_DIRS=true

# Customize names
USER_NAME="John Doe"
CLOUD_SERVICE="Dropbox"
```

### Advanced Configuration

#### Custom Directories

Add your own directory structures:

```bash
CUSTOM_DIRS=(
    "$BASE_DIR/Research/PhD|PhD Research|Education|research,academic"
    "$BASE_DIR/Clients/ACME|ACME Corp Project|Work|client,project"
)
```

#### Sync Preferences

Configure which folders to sync:

```bash
# Always keep synced
ALWAYS_SYNC=(
    "Work/Projects/Active"
    "Finance/Budget"
)

# Never sync (too large or sensitive)
NEVER_SYNC=(
    "System/Backups"
    "Archive"
)
```

## ☁️ Cloud Sync Setup

### Dropbox

1. Move the Life folder to your Dropbox
2. Configure selective sync using `.dropboxignore`
3. Enable Smart Sync for large folders

### iCloud Drive

1. Move to `~/Library/Mobile Documents/com~apple~CloudDocs/Life`
2. Enable "Optimize Mac Storage" in System Preferences
3. Configure which folders to keep downloaded

### OneDrive / Google Drive

1. Move to respective sync folder
2. Configure selective sync in client settings
3. Set bandwidth limits for initial sync

## 📅 Maintenance Schedule

### Daily (2 minutes)
```bash
# Process new items
org-inbox-process
```

### Weekly (5 minutes)
```bash
# Run maintenance check
org-maintenance

# Process inbox if needed
org-inbox-process
```

### Monthly (15 minutes)
```bash
# Full maintenance
org-maintenance

# Archive old items
org-archive

# Generate report
org-report

# Review and clean duplicates
```

### Quarterly (30 minutes)
- Full system backup
- Review directory structure
- Update configuration
- Clean Archive folder

## 🔐 Security Best Practices

### Sensitive Files

1. **Use encryption for sensitive folders:**
```bash
# Create encrypted disk image (macOS)
hdiutil create -size 100m -fs HFS+ -encryption AES-256 \
    -volname "Secure" ~/Life/System/Security/secure.dmg
```

2. **Exclude from cloud sync:**
   - Add to `.dropboxignore` or equivalent
   - Store in `System/Security/` (excluded by default)

3. **Use strong passwords:**
   - Enable 2FA on cloud services
   - Use unique passwords for encrypted containers

### Backup Strategy (3-2-1 Rule)

1. **3 copies** of important data
   - Original
   - Cloud sync
   - External backup

2. **2 different storage types**
   - Cloud service
   - External HDD/SSD

3. **1 offsite backup**
   - Cloud counts as offsite
   - Or physical drive in different location

## 🎯 Tips & Tricks

### Naming Conventions

```bash
# Date prefix for chronological sorting
2024-03-15-meeting-notes.md

# Project prefix for grouping
PROJECT-ABC-requirements.pdf

# Version suffix for iterations
design_v1.2.sketch
```

### Quick Access

Create aliases in your shell configuration:

```bash
# ~/.zshrc or ~/.bashrc
alias life="cd ~/Life"
alias inbox="cd ~/Life/Inbox/ToSort"
alias work="cd ~/Life/Work/Projects/Active"
alias organize="org-maintenance && org-inbox-process"
```

### Automation

Add to crontab for automatic maintenance:

```bash
# Weekly maintenance (Sundays at 6 PM)
0 18 * * 0 /path/to/org-maintenance --auto

# Daily inbox reminder (9 AM)
0 9 * * * [ -n "$(ls -A ~/Life/Inbox/ToSort)" ] && echo "Files in inbox need sorting"
```

### Integration with Other Tools

#### Alfred/Raycast Workflow
```bash
# Quick file to inbox
cp "$1" ~/Life/Inbox/ToSort/
```

#### Hazel Rules (macOS)
- Auto-sort downloads by file type
- Move old Desktop items to inbox
- Archive completed projects

#### IFTTT/Zapier
- Save email attachments to inbox
- Archive Slack files
- Backup social media content

## 🐛 Troubleshooting

### Common Issues

**Issue: Permission denied**
```bash
# Fix permissions
chmod +x org-*
```

**Issue: Command not found**
```bash
# Add to PATH or use full path
export PATH="$HOME/.dotfiles/bin:$PATH"
```

**Issue: Slow cloud sync**
```bash
# Exclude large files
echo "*.iso" >> .dropboxignore
echo "node_modules/" >> .dropboxignore
```

**Issue: Duplicate files accumulating**
```bash
# Find and review duplicates
org-maintenance  # Will show duplicates
```

## 📚 Advanced Usage

### Custom Categories

Create specialized organization for your field:

```bash
# For researchers
Life/Research/
├── Papers/
├── Data/
├── Conferences/
└── Grants/

# For photographers
Life/Photography/
├── RAW/
├── Edited/
├── Clients/
└── Portfolio/
```

### Project Templates

Create template structures for new projects:

```bash
# Save as project-template.sh
create_project() {
    PROJECT="$1"
    mkdir -p "Life/Work/Projects/Active/$PROJECT"/{Documents,Resources,Communication,Deliverables}
    echo "# $PROJECT" > "Life/Work/Projects/Active/$PROJECT/README.md"
}
```

### Batch Operations

Process multiple files at once:

```bash
# Move all PDFs to documents
find ~/Downloads -name "*.pdf" -exec org-quick-add {} doc \;

# Archive all completed projects
for dir in Life/Work/Projects/Active/*-DONE; do
    mv "$dir" "Life/Work/Projects/Archive/"
done
```

## 🆘 Getting Help

1. **Check the documentation:**
   - This file (ORGANIZE_SYSTEM_DOCS.md)
   - README.md in each directory
   - ORGANIZATION_TIPS.md for best practices

2. **Run help commands:**
   ```bash
   org-maintenance --help
   ```

3. **Review logs:**
   ```bash
   cat ~/Life/System/maintenance.log
   ```

## 📈 Future Enhancements

Potential improvements you can make:

- [ ] Web interface for remote access
- [ ] Mobile app integration
- [ ] AI-powered auto-categorization
- [ ] Version control for documents
- [ ] Collaboration features
- [ ] Advanced search with tags
- [ ] Automated report emails
- [ ] Integration with task managers
- [ ] Smart contract storage
- [ ] Blockchain document verification

---

*Remember: The best organization system is the one you actually use. Start simple, be consistent, and refine as needed.*