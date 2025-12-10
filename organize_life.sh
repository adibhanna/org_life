#!/bin/bash

# =========================================================================
# Universal Life Organization System
# A comprehensive directory structure for organizing all aspects of digital life
# Designed to work seamlessly with cloud sync services (Dropbox, iCloud, etc.)
# =========================================================================

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$HOME/.organize_config"
LOG_FILE="$HOME/.organize_setup.log"

# Default base directory (can be overridden)
DEFAULT_BASE="$HOME/Life"

# Function to print colored output
print_color() {
    local color=$1
    shift
    echo -e "${color}$@${NC}"
}

# Function to log actions
log_action() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $@" >> "$LOG_FILE"
}

# Load or create configuration
load_config() {
    if [ -f "$CONFIG_FILE" ]; then
        source "$CONFIG_FILE"
        print_color "$GREEN" "✓ Loaded configuration from $CONFIG_FILE"
    else
        BASE_DIR="$DEFAULT_BASE"
        print_color "$YELLOW" "→ Using default base directory: $BASE_DIR"
    fi
}

# Interactive setup
interactive_setup() {
    print_color "$CYAN" "\n╔════════════════════════════════════════════════════════╗"
    print_color "$CYAN" "║     Universal Life Organization System Setup          ║"
    print_color "$CYAN" "╚════════════════════════════════════════════════════════╝\n"

    # Ask for base directory
    print_color "$BLUE" "Where would you like to create your organization system?"
    print_color "$BLUE" "This should be inside your cloud sync folder (Dropbox/iCloud/etc.)"
    echo -n "Base directory [$DEFAULT_BASE]: "
    read user_input
    BASE_DIR=${user_input:-$DEFAULT_BASE}

    # Expand ~ to home directory
    BASE_DIR="${BASE_DIR/#\~/$HOME}"

    # Save configuration
    echo "BASE_DIR=\"$BASE_DIR\"" > "$CONFIG_FILE"
    echo "SETUP_DATE=\"$(date '+%Y-%m-%d')\"" >> "$CONFIG_FILE"

    print_color "$GREEN" "✓ Configuration saved to $CONFIG_FILE"
}

# Function to create directory with README and metadata
create_structured_dir() {
    local dir_path="$1"
    local description="$2"
    local category="$3"
    local tags="$4"
    local template="$5"

    # Create directory
    if [ ! -d "$dir_path" ]; then
        mkdir -p "$dir_path"
        print_color "$GREEN" "  ✓ Created: ${dir_path#$BASE_DIR/}"
        log_action "Created directory: $dir_path"
    else
        print_color "$YELLOW" "  → Exists: ${dir_path#$BASE_DIR/}"
    fi

    # Create README with metadata
    local readme="$dir_path/README.md"
    if [ ! -f "$readme" ]; then
        cat > "$readme" << EOF
# ${dir_path##*/}

**Description:** $description
**Category:** $category
**Tags:** $tags
**Created:** $(date '+%Y-%m-%d')

---

## Purpose
$description

## Organization Rules
- Keep files organized by date or project
- Use clear, descriptive names
- Archive old items regularly
- Review and clean up quarterly

## Quick Links
- [Parent Directory](../)

EOF

        # Add template-specific content
        if [ -n "$template" ]; then
            echo -e "\n## Structure\n$template" >> "$readme"
        fi

        log_action "Created README: $readme"
    fi

    # Create .gitkeep for empty directories (helps with git)
    touch "$dir_path/.gitkeep" 2>/dev/null || true
}

# Function to create the complete directory structure
create_directory_structure() {
    print_color "$BOLD" "\n📁 Creating Directory Structure in: $BASE_DIR\n"

    # ═══════════════════════════════════════════════════════════════
    # 01. WORK & CAREER
    # ═══════════════════════════════════════════════════════════════
    print_color "$CYAN" "Setting up Work & Career directories..."

    create_structured_dir "$BASE_DIR/Work/Projects/Active" \
        "Currently active work projects" \
        "Work" "projects,active,current" \
        "Organize by project name with date prefix (YYYY-MM-ProjectName)"

    create_structured_dir "$BASE_DIR/Work/Projects/Archive" \
        "Completed and archived work projects" \
        "Work" "projects,archive,completed"

    create_structured_dir "$BASE_DIR/Work/Career/Resume" \
        "Resume versions and templates" \
        "Work" "career,resume,cv"

    create_structured_dir "$BASE_DIR/Work/Career/Certifications" \
        "Professional certifications and courses" \
        "Work" "career,education,certificates"

    create_structured_dir "$BASE_DIR/Work/Career/Performance" \
        "Performance reviews and achievements" \
        "Work" "career,reviews,achievements"

    create_structured_dir "$BASE_DIR/Work/Meetings" \
        "Meeting notes and agendas" \
        "Work" "meetings,notes" \
        "Organize by date (YYYY/MM/DD-MeetingName)"

    # ═══════════════════════════════════════════════════════════════
    # 02. CODING & DEVELOPMENT
    # ═══════════════════════════════════════════════════════════════
    print_color "$CYAN" "Setting up Coding & Development directories..."

    create_structured_dir "$BASE_DIR/Code/Projects/Personal" \
        "Personal coding projects and experiments" \
        "Development" "code,projects,personal"

    create_structured_dir "$BASE_DIR/Code/Projects/OpenSource" \
        "Open source contributions" \
        "Development" "code,opensource,contributions"

    create_structured_dir "$BASE_DIR/Code/Projects/Freelance" \
        "Freelance and client projects" \
        "Development" "code,freelance,clients"

    create_structured_dir "$BASE_DIR/Code/Learning/Courses" \
        "Programming courses and tutorials" \
        "Development" "learning,courses,tutorials"

    create_structured_dir "$BASE_DIR/Code/Learning/Books" \
        "Programming books and notes" \
        "Development" "learning,books,references"

    create_structured_dir "$BASE_DIR/Code/Learning/Playground" \
        "Code experiments and snippets" \
        "Development" "learning,experiments,sandbox"

    create_structured_dir "$BASE_DIR/Code/Resources/Snippets" \
        "Reusable code snippets" \
        "Development" "resources,snippets,utilities"

    create_structured_dir "$BASE_DIR/Code/Resources/Documentation" \
        "Technical documentation and references" \
        "Development" "resources,documentation,reference"

    create_structured_dir "$BASE_DIR/Code/Resources/Tools" \
        "Development tools and configurations" \
        "Development" "resources,tools,configs"

    # ═══════════════════════════════════════════════════════════════
    # 03. CONTENT CREATION
    # ═══════════════════════════════════════════════════════════════
    print_color "$CYAN" "Setting up Content Creation directories..."

    create_structured_dir "$BASE_DIR/Content/Writing/Blog" \
        "Blog posts and articles" \
        "Content" "writing,blog,articles"

    create_structured_dir "$BASE_DIR/Content/Writing/Newsletter" \
        "Newsletter drafts and archives" \
        "Content" "writing,newsletter,email"

    create_structured_dir "$BASE_DIR/Content/Writing/Ideas" \
        "Writing ideas and outlines" \
        "Content" "writing,ideas,brainstorm"

    create_structured_dir "$BASE_DIR/Content/Video/YouTube" \
        "YouTube videos and scripts" \
        "Content" "video,youtube,social"

    create_structured_dir "$BASE_DIR/Content/Video/Courses" \
        "Video courses and tutorials" \
        "Content" "video,courses,education"

    create_structured_dir "$BASE_DIR/Content/Video/Raw" \
        "Raw video footage and materials" \
        "Content" "video,raw,footage"

    create_structured_dir "$BASE_DIR/Content/Audio/Podcasts" \
        "Podcast episodes and notes" \
        "Content" "audio,podcast,episodes"

    create_structured_dir "$BASE_DIR/Content/Audio/Music" \
        "Music compositions and recordings" \
        "Content" "audio,music,creative"

    create_structured_dir "$BASE_DIR/Content/Graphics/Designs" \
        "Graphic designs and artwork" \
        "Content" "graphics,design,visual"

    create_structured_dir "$BASE_DIR/Content/Graphics/Photos" \
        "Photography and edited images" \
        "Content" "graphics,photos,images"

    create_structured_dir "$BASE_DIR/Content/Graphics/Assets" \
        "Design assets and templates" \
        "Content" "graphics,assets,templates"

    # ═══════════════════════════════════════════════════════════════
    # 04. FINANCES
    # ═══════════════════════════════════════════════════════════════
    print_color "$CYAN" "Setting up Finance directories..."

    create_structured_dir "$BASE_DIR/Finance/Banking" \
        "Bank statements and account info" \
        "Finance" "banking,accounts,statements"

    create_structured_dir "$BASE_DIR/Finance/Investments" \
        "Investment portfolios and analysis" \
        "Finance" "investments,portfolio,stocks"

    create_structured_dir "$BASE_DIR/Finance/Taxes/$(date +%Y)" \
        "Tax documents for current year" \
        "Finance" "taxes,documents,returns"

    create_structured_dir "$BASE_DIR/Finance/Budget" \
        "Budget planning and tracking" \
        "Finance" "budget,planning,tracking"

    create_structured_dir "$BASE_DIR/Finance/Receipts/$(date +%Y)" \
        "Receipts organized by year" \
        "Finance" "receipts,expenses,records"

    create_structured_dir "$BASE_DIR/Finance/Insurance" \
        "Insurance policies and claims" \
        "Finance" "insurance,policies,coverage"

    create_structured_dir "$BASE_DIR/Finance/Crypto" \
        "Cryptocurrency wallets and records" \
        "Finance" "crypto,blockchain,digital"

    # ═══════════════════════════════════════════════════════════════
    # 05. EDUCATION & LEARNING
    # ═══════════════════════════════════════════════════════════════
    print_color "$CYAN" "Setting up Education directories..."

    create_structured_dir "$BASE_DIR/Education/Courses/Active" \
        "Currently enrolled courses" \
        "Education" "courses,learning,active"

    create_structured_dir "$BASE_DIR/Education/Courses/Completed" \
        "Completed courses and certificates" \
        "Education" "courses,completed,certificates"

    create_structured_dir "$BASE_DIR/Education/Books/Reading" \
        "Currently reading books" \
        "Education" "books,reading,current"

    create_structured_dir "$BASE_DIR/Education/Books/Library" \
        "Digital book library" \
        "Education" "books,library,collection"

    create_structured_dir "$BASE_DIR/Education/Books/Notes" \
        "Book notes and summaries" \
        "Education" "books,notes,summaries"

    create_structured_dir "$BASE_DIR/Education/Research/Papers" \
        "Academic papers and research" \
        "Education" "research,papers,academic"

    create_structured_dir "$BASE_DIR/Education/Languages" \
        "Language learning materials" \
        "Education" "languages,learning,study"

    # ═══════════════════════════════════════════════════════════════
    # 06. HEALTH & FITNESS
    # ═══════════════════════════════════════════════════════════════
    print_color "$CYAN" "Setting up Health & Fitness directories..."

    create_structured_dir "$BASE_DIR/Health/Medical/Records" \
        "Medical records and history" \
        "Health" "medical,records,history"

    create_structured_dir "$BASE_DIR/Health/Medical/Prescriptions" \
        "Prescription information" \
        "Health" "medical,prescriptions,medications"

    create_structured_dir "$BASE_DIR/Health/Fitness/Workouts" \
        "Workout plans and routines" \
        "Health" "fitness,workouts,exercise"

    create_structured_dir "$BASE_DIR/Health/Fitness/Progress" \
        "Fitness progress tracking" \
        "Health" "fitness,progress,tracking"

    create_structured_dir "$BASE_DIR/Health/Nutrition/Meals" \
        "Meal plans and recipes" \
        "Health" "nutrition,meals,recipes"

    create_structured_dir "$BASE_DIR/Health/Nutrition/Tracking" \
        "Nutrition tracking and logs" \
        "Health" "nutrition,tracking,diet"

    create_structured_dir "$BASE_DIR/Health/Mental/Journal" \
        "Personal journal and reflections" \
        "Health" "mental,journal,wellbeing"

    # ═══════════════════════════════════════════════════════════════
    # 07. PERSONAL LIFE
    # ═══════════════════════════════════════════════════════════════
    print_color "$CYAN" "Setting up Personal Life directories..."

    create_structured_dir "$BASE_DIR/Personal/Documents/Identity" \
        "Identity documents (passport, licenses, etc.)" \
        "Personal" "documents,identity,official"

    create_structured_dir "$BASE_DIR/Personal/Documents/Legal" \
        "Legal documents and contracts" \
        "Personal" "documents,legal,contracts"

    create_structured_dir "$BASE_DIR/Personal/Documents/Property" \
        "Property documents and deeds" \
        "Personal" "documents,property,real-estate"

    create_structured_dir "$BASE_DIR/Personal/Family/Photos" \
        "Family photos and memories" \
        "Personal" "family,photos,memories"

    create_structured_dir "$BASE_DIR/Personal/Family/Documents" \
        "Family important documents" \
        "Personal" "family,documents,records"

    create_structured_dir "$BASE_DIR/Personal/Travel/Past" \
        "Past travel memories and documents" \
        "Personal" "travel,past,memories"

    create_structured_dir "$BASE_DIR/Personal/Travel/Planning" \
        "Future travel plans and research" \
        "Personal" "travel,planning,future"

    create_structured_dir "$BASE_DIR/Personal/Contacts" \
        "Contact information and networks" \
        "Personal" "contacts,network,connections"

    # ═══════════════════════════════════════════════════════════════
    # 08. HOBBIES & INTERESTS
    # ═══════════════════════════════════════════════════════════════
    print_color "$CYAN" "Setting up Hobbies directories..."

    create_structured_dir "$BASE_DIR/Hobbies/Gaming/Games" \
        "Game files and saves" \
        "Hobbies" "gaming,games,entertainment"

    create_structured_dir "$BASE_DIR/Hobbies/Gaming/Streaming" \
        "Game streaming content" \
        "Hobbies" "gaming,streaming,content"

    create_structured_dir "$BASE_DIR/Hobbies/Music/Practice" \
        "Music practice and sheets" \
        "Hobbies" "music,practice,learning"

    create_structured_dir "$BASE_DIR/Hobbies/Music/Compositions" \
        "Original music compositions" \
        "Hobbies" "music,compositions,creative"

    create_structured_dir "$BASE_DIR/Hobbies/Photography" \
        "Photography projects" \
        "Hobbies" "photography,photos,creative"

    create_structured_dir "$BASE_DIR/Hobbies/Collections" \
        "Digital collections and catalogs" \
        "Hobbies" "collections,catalog,inventory"

    create_structured_dir "$BASE_DIR/Hobbies/DIY" \
        "DIY projects and instructions" \
        "Hobbies" "diy,projects,crafts"

    # ═══════════════════════════════════════════════════════════════
    # 09. BUSINESS & ENTREPRENEURSHIP
    # ═══════════════════════════════════════════════════════════════
    print_color "$CYAN" "Setting up Business directories..."

    create_structured_dir "$BASE_DIR/Business/Ideas" \
        "Business ideas and validation" \
        "Business" "ideas,entrepreneurship,startups"

    create_structured_dir "$BASE_DIR/Business/Plans" \
        "Business plans and strategies" \
        "Business" "plans,strategy,documents"

    create_structured_dir "$BASE_DIR/Business/Marketing" \
        "Marketing materials and campaigns" \
        "Business" "marketing,promotion,advertising"

    create_structured_dir "$BASE_DIR/Business/Clients" \
        "Client information and projects" \
        "Business" "clients,customers,crm"

    create_structured_dir "$BASE_DIR/Business/Legal" \
        "Business legal documents" \
        "Business" "legal,contracts,agreements"

    create_structured_dir "$BASE_DIR/Business/Accounting" \
        "Business accounting and bookkeeping" \
        "Business" "accounting,bookkeeping,finance"

    # ═══════════════════════════════════════════════════════════════
    # 10. SYSTEM & UTILITIES
    # ═══════════════════════════════════════════════════════════════
    print_color "$CYAN" "Setting up System directories..."

    create_structured_dir "$BASE_DIR/System/Backups" \
        "System and data backups" \
        "System" "backups,recovery,archive"

    create_structured_dir "$BASE_DIR/System/Configs" \
        "Application configurations and dotfiles" \
        "System" "configs,dotfiles,settings"

    create_structured_dir "$BASE_DIR/System/Licenses" \
        "Software licenses and keys" \
        "System" "licenses,keys,software"

    create_structured_dir "$BASE_DIR/System/Security" \
        "Security-related files (encrypted)" \
        "System" "security,passwords,sensitive"

    # ═══════════════════════════════════════════════════════════════
    # 11. INBOX & PROCESSING
    # ═══════════════════════════════════════════════════════════════
    print_color "$CYAN" "Setting up Processing directories..."

    create_structured_dir "$BASE_DIR/Inbox/Downloads" \
        "Temporary downloads to be sorted" \
        "Utility" "inbox,downloads,temporary"

    create_structured_dir "$BASE_DIR/Inbox/Screenshots" \
        "Screenshots to be processed" \
        "Utility" "inbox,screenshots,temporary"

    create_structured_dir "$BASE_DIR/Inbox/Scans" \
        "Scanned documents to be filed" \
        "Utility" "inbox,scans,documents"

    create_structured_dir "$BASE_DIR/Inbox/ToSort" \
        "Files waiting to be organized" \
        "Utility" "inbox,sort,pending"

    # ═══════════════════════════════════════════════════════════════
    # 12. ARCHIVE
    # ═══════════════════════════════════════════════════════════════
    print_color "$CYAN" "Setting up Archive directories..."

    for year in $(seq $(($(date +%Y)-2)) $(date +%Y)); do
        create_structured_dir "$BASE_DIR/Archive/$year" \
            "Archive for year $year" \
            "Archive" "archive,history,$year"
    done
}

# Create special organizational files
create_organizational_files() {
    print_color "$BOLD" "\n📄 Creating organizational files...\n"

    # Create master README
    cat > "$BASE_DIR/README.md" << 'EOF'
# Life Organization System

Welcome to your comprehensive life organization system. This structure is designed to help you organize every aspect of your digital life efficiently.

## 🎯 Quick Start

1. **Inbox**: Drop new files in `Inbox/` for later sorting
2. **Active Work**: Current projects go in respective `/Active` folders
3. **Archive**: Move completed items to `Archive/YYYY/`
4. **Search**: Use the search script to find files quickly

## 📁 Main Categories

- **Work**: Professional projects and career documents
- **Code**: Programming projects and learning resources
- **Content**: Creative content and media production
- **Finance**: Financial records and planning
- **Education**: Learning materials and courses
- **Health**: Medical records and fitness tracking
- **Personal**: Personal documents and memories
- **Hobbies**: Recreational activities and interests
- **Business**: Entrepreneurial ventures
- **System**: Technical configurations and backups

## 🔧 Maintenance Schedule

### Daily
- Process items in `Inbox/`
- Update current project files

### Weekly
- Archive completed items
- Review and organize recent additions

### Monthly
- Clean up Downloads and Screenshots
- Update financial records

### Quarterly
- Full archive review
- Remove duplicates
- Update backup

## 🔐 Security Notes

- Keep sensitive documents encrypted
- Use cloud service's 2FA
- Regular backups to external drive
- Don't sync `System/Security/` folder

## 🏷️ Naming Conventions

- Dates: `YYYY-MM-DD` format
- Projects: `YYYY-MM-ProjectName`
- Versions: `filename_v1.2.ext`
- Archives: Move to `Archive/YYYY/` when done

## 📱 Sync Settings

Recommended sync settings for cloud services:
- Selective sync for large media files
- Offline access for frequently used folders
- Exclude `System/Backups/` from sync

## 🛠️ Tools & Scripts

Run these helper scripts from your terminal:
- `organize` - Main organization script
- `org-search [term]` - Search across all files
- `org-archive` - Archive old items
- `org-report` - Generate organization report

---

*System created on $(date '+%Y-%m-%d')*
EOF

    # Create .gitignore for version control
    cat > "$BASE_DIR/.gitignore" << 'EOF'
# Private and sensitive files
System/Security/
Personal/Documents/Identity/
Finance/Banking/
Health/Medical/

# Large files
*.zip
*.tar.gz
*.iso
*.dmg

# Temporary files
.DS_Store
Thumbs.db
*.tmp
*.temp
*.swp

# Cache and logs
*.log
.cache/
node_modules/

# Encrypted files
*.gpg
*.encrypted
*.key
EOF

    # Create organization tips file
    cat > "$BASE_DIR/ORGANIZATION_TIPS.md" << 'EOF'
# Organization Best Practices

## File Naming Rules

### Use Consistent Date Format
- Always use: `YYYY-MM-DD`
- Example: `2024-03-15-meeting-notes.md`

### Version Control
- Use semantic versioning: `document_v1.0.pdf`
- Keep max 3 versions, archive older ones

### Descriptive Names
- Bad: `doc1.pdf`
- Good: `2024-03-15-project-proposal-clientname.pdf`

## Folder Organization

### Active vs Archive
- Keep only current items in main folders
- Move completed items to Archive immediately

### Project Structure
```
ProjectName/
├── Documents/
├── Resources/
├── Communication/
├── Deliverables/
└── Archive/
```

## Regular Maintenance

### The 2-Minute Rule
If it takes less than 2 minutes to file something properly, do it now.

### Weekly Review Checklist
- [ ] Empty Inbox folder
- [ ] Archive completed projects
- [ ] Delete duplicate files
- [ ] Update task lists
- [ ] Backup important changes

### Quarterly Cleanup
- [ ] Archive old emails
- [ ] Compress large projects
- [ ] Update financial records
- [ ] Review and delete unused files
- [ ] Full system backup

## Search & Retrieval

### Tagging Strategy
Use consistent tags in file names:
- `#urgent` - Needs immediate attention
- `#review` - Needs review
- `#waiting` - Waiting for response
- `#reference` - Reference material

### Quick Find Tips
1. Use spotlight/search with quotes: "exact phrase"
2. Search by date: modified:this week
3. Search by type: kind:pdf
4. Create smart folders for frequent searches

## Cloud Sync Optimization

### What to Sync
- Documents and text files (always)
- Active projects (always)
- Photos (selective)
- Archives (optional/manual)

### What NOT to Sync
- System backups (too large)
- Temporary files
- Cache folders
- Virtual machines

## Security Practices

### Sensitive Files
1. Encrypt before uploading
2. Use separate encrypted containers
3. Enable 2FA on cloud services
4. Regular password updates

### Backup Strategy (3-2-1 Rule)
- 3 copies of important data
- 2 different storage media
- 1 offsite backup

---

*Remember: A good organization system is one you'll actually use!*
EOF

    print_color "$GREEN" "✓ Created organizational files"
}

# Create helper scripts
create_helper_scripts() {
    print_color "$BOLD" "\n🔨 Creating helper scripts...\n"

    # Search script
    cat > "$SCRIPT_DIR/org-search" << 'EOF'
#!/bin/bash
# Quick search across organization structure

if [ -z "$1" ]; then
    echo "Usage: org-search <search-term>"
    exit 1
fi

source "$HOME/.organize_config" 2>/dev/null || BASE_DIR="$HOME/Life"

echo "Searching for '$1' in $BASE_DIR..."
find "$BASE_DIR" -type f -name "*$1*" 2>/dev/null | grep -v -E "(\.git|\.DS_Store)" | head -20

echo -e "\nSearching file contents..."
grep -r "$1" "$BASE_DIR" --include="*.txt" --include="*.md" 2>/dev/null | head -10
EOF
    chmod +x "$SCRIPT_DIR/org-search"

    # Archive script
    cat > "$SCRIPT_DIR/org-archive" << 'EOF'
#!/bin/bash
# Archive old items to year-based folders

source "$HOME/.organize_config" 2>/dev/null || BASE_DIR="$HOME/Life"

CURRENT_YEAR=$(date +%Y)
ARCHIVE_DIR="$BASE_DIR/Archive/$CURRENT_YEAR"

echo "Archiving items older than 3 months to $ARCHIVE_DIR"

# Create archive directory if it doesn't exist
mkdir -p "$ARCHIVE_DIR"

# Find and move old files (modify the find command based on needs)
# This is a safe example that just lists files - uncomment to actually move
find "$BASE_DIR" -type f -mtime +90 -not -path "*/Archive/*" -not -path "*/System/*" | while read file; do
    echo "Would archive: $file"
    # Uncomment below to actually move files:
    # mv "$file" "$ARCHIVE_DIR/"
done

echo "Archive review complete. Uncomment the mv command to actually move files."
EOF
    chmod +x "$SCRIPT_DIR/org-archive"

    # Report generation script
    cat > "$SCRIPT_DIR/org-report" << 'EOF'
#!/bin/bash
# Generate organization report

source "$HOME/.organize_config" 2>/dev/null || BASE_DIR="$HOME/Life"

echo "═══════════════════════════════════════════════════════"
echo "     Organization System Report - $(date '+%Y-%m-%d')"
echo "═══════════════════════════════════════════════════════"
echo

echo "📊 Storage Usage:"
du -sh "$BASE_DIR" 2>/dev/null
echo

echo "📁 Top 10 Largest Directories:"
du -sh "$BASE_DIR"/*/* 2>/dev/null | sort -hr | head -10
echo

echo "📄 File Counts by Category:"
for dir in "$BASE_DIR"/*/; do
    if [ -d "$dir" ]; then
        count=$(find "$dir" -type f 2>/dev/null | wc -l)
        printf "%-20s %5d files\n" "$(basename $dir):" $count
    fi
done
echo

echo "🗓️ Recently Modified Files:"
find "$BASE_DIR" -type f -mtime -7 -not -path "*/\.*" 2>/dev/null | head -10
echo

echo "⚠️ Inbox Status:"
inbox_count=$(find "$BASE_DIR/Inbox" -type f 2>/dev/null | wc -l)
if [ $inbox_count -gt 0 ]; then
    echo "WARNING: $inbox_count files need sorting in Inbox!"
else
    echo "✓ Inbox is empty"
fi
EOF
    chmod +x "$SCRIPT_DIR/org-report"

    print_color "$GREEN" "✓ Created helper scripts: org-search, org-archive, org-report"
}

# Create cloud sync configuration
create_cloud_config() {
    print_color "$BOLD" "\n☁️ Creating cloud sync configuration...\n"

    # Dropbox selective sync config
    cat > "$BASE_DIR/.dropboxignore" << 'EOF'
# Large files and folders
System/Backups
*.iso
*.dmg
*.zip
*.tar.gz

# Temporary files
*.tmp
*.temp
.DS_Store
Thumbs.db

# Development
node_modules
.git
target/
build/
dist/
EOF

    # iCloud optimization hints
    cat > "$BASE_DIR/.icloud_settings.md" << 'EOF'
# iCloud Drive Optimization Settings

## Recommended Settings

1. **Turn on "Optimize Mac Storage"** for automatic management
2. **Keep these folders downloaded:**
   - Work/Projects/Active
   - Code/Projects/Personal
   - Finance/Budget
   - Personal/Documents

3. **Allow these to be cloud-only when space needed:**
   - Archive/*
   - Content/Video/Raw
   - System/Backups

## Exclude from iCloud

These folders contain sensitive data or are too large:
- System/Security (use encrypted disk image instead)
- Large media projects over 50GB

## Mobile Access

Ensure these folders are available offline on mobile:
- Personal/Documents/Identity
- Finance/Budget
- Health/Medical/Records
EOF

    print_color "$GREEN" "✓ Created cloud sync configurations"
}

# Main execution
main() {
    # Check if config exists, otherwise run interactive setup
    if [ ! -f "$CONFIG_FILE" ]; then
        interactive_setup
    else
        load_config
    fi

    # Create directory structure
    create_directory_structure

    # Create organizational files
    create_organizational_files

    # Create helper scripts
    create_helper_scripts

    # Create cloud configuration
    create_cloud_config

    # Final summary
    print_color "$GREEN" "\n╔════════════════════════════════════════════════════════╗"
    print_color "$GREEN" "║         ✓ Organization System Setup Complete!         ║"
    print_color "$GREEN" "╚════════════════════════════════════════════════════════╝\n"

    print_color "$BOLD" "📍 Your organization system is ready at:"
    print_color "$CYAN" "   $BASE_DIR\n"

    print_color "$BOLD" "🛠️ Helper commands available:"
    print_color "$CYAN" "   org-search [term]  - Search for files"
    print_color "$CYAN" "   org-archive        - Archive old files"
    print_color "$CYAN" "   org-report         - Generate usage report\n"

    print_color "$BOLD" "📱 Next steps:"
    print_color "$YELLOW" "   1. Move this folder to your cloud sync location"
    print_color "$YELLOW" "   2. Configure selective sync based on .dropboxignore"
    print_color "$YELLOW" "   3. Start organizing your files into the Inbox"
    print_color "$YELLOW" "   4. Run 'org-report' weekly to maintain organization\n"

    # Log completion
    log_action "Organization system setup completed successfully"
}

# Run main function
main "$@"