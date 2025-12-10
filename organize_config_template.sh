#!/bin/bash

# =========================================================================
# Organization System Configuration Template
# Copy this to ~/.organize_config and customize to your needs
# =========================================================================

# Base directory for your organization system
# This should be inside your cloud sync folder (Dropbox, iCloud Drive, etc.)
BASE_DIR="$HOME/Life"

# Alternative locations:
# BASE_DIR="$HOME/Dropbox/Life"
# BASE_DIR="$HOME/Documents/Life"
# BASE_DIR="/Volumes/ExternalDrive/Life"

# =========================================================================
# Feature Toggles
# =========================================================================

# Create work-related directories (set to false if personal use only)
CREATE_WORK_DIRS=true

# Create business/entrepreneurship directories
CREATE_BUSINESS_DIRS=true

# Create coding/development directories
CREATE_CODE_DIRS=true

# Create content creation directories (YouTube, Blog, etc.)
CREATE_CONTENT_DIRS=true

# =========================================================================
# Customization
# =========================================================================

# Your name (used in document templates)
USER_NAME="Your Name"

# Default cloud service
CLOUD_SERVICE="iCloud"  # Options: iCloud, Dropbox, OneDrive, GoogleDrive, Other

# Archive retention (days before suggesting archive)
ARCHIVE_AFTER_DAYS=90

# =========================================================================
# Directory Name Customization
# Uncomment and modify to use different names
# =========================================================================

# DIR_WORK="Career"           # Instead of "Work"
# DIR_CODE="Programming"      # Instead of "Code"
# DIR_FINANCE="Money"         # Instead of "Finance"
# DIR_HEALTH="Wellness"       # Instead of "Health"

# =========================================================================
# Additional Custom Directories
# Add your own directory structures here
# =========================================================================

CUSTOM_DIRS=(
    # Format: "path|description|category|tags"
    # "$BASE_DIR/CustomFolder|Description here|Category|tag1,tag2"
)

# =========================================================================
# Sync Preferences
# =========================================================================

# Folders to always keep synced
ALWAYS_SYNC=(
    "Work/Projects/Active"
    "Personal/Documents"
    "Finance/Budget"
)

# Folders to exclude from sync (large or sensitive)
NEVER_SYNC=(
    "System/Backups"
    "Content/Video/Raw"
    "Archive"
)

# =========================================================================
# Security Settings
# =========================================================================

# Encrypt sensitive folders (requires GPG)
ENCRYPT_SENSITIVE=false

# Folders to encrypt
SENSITIVE_DIRS=(
    "Finance/Banking"
    "Personal/Documents/Identity"
    "System/Security"
)

# =========================================================================
# Notification Settings
# =========================================================================

# Send notifications for maintenance tasks
ENABLE_NOTIFICATIONS=true

# Email for reports (leave empty to disable)
REPORT_EMAIL=""

# =========================================================================
# DO NOT MODIFY BELOW THIS LINE
# =========================================================================

SETUP_DATE="$(date '+%Y-%m-%d')"
CONFIG_VERSION="1.0"