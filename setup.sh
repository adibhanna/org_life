#!/bin/bash

# Simple setup script for org CLI
# Run: ./setup.sh [base_dir]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_BASE="$HOME/Life"
BASE_DIR="${1:-$DEFAULT_BASE}"
BASE_DIR="${BASE_DIR/#\~/$HOME}"

CONFIG_FILE="$HOME/.org_life"

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BOLD}Setting up org CLI...${NC}"
echo

# Save config
echo "BASE_DIR=\"$BASE_DIR\"" > "$CONFIG_FILE"
echo -e "${GREEN}Config:${NC} $CONFIG_FILE"

# Create symlink to org in /usr/local/bin (or ~/bin)
if [ -d "/usr/local/bin" ] && [ -w "/usr/local/bin" ]; then
    ln -sf "$SCRIPT_DIR/org" /usr/local/bin/org
    echo -e "${GREEN}Linked:${NC} /usr/local/bin/org"
elif [ -d "$HOME/bin" ]; then
    ln -sf "$SCRIPT_DIR/org" "$HOME/bin/org"
    echo -e "${GREEN}Linked:${NC} ~/bin/org"
else
    mkdir -p "$HOME/bin"
    ln -sf "$SCRIPT_DIR/org" "$HOME/bin/org"
    echo -e "${GREEN}Linked:${NC} ~/bin/org"
    echo -e "${CYAN}Add to PATH:${NC} export PATH=\"\$HOME/bin:\$PATH\""
fi

# Detect shell and setup completions
SHELL_NAME=$(basename "$SHELL")
echo

if [ "$SHELL_NAME" = "zsh" ]; then
    # Setup zsh completions
    COMP_DIR="${ZDOTDIR:-$HOME}/.zfunc"
    mkdir -p "$COMP_DIR"
    cp "$SCRIPT_DIR/org-completion.zsh" "$COMP_DIR/_org"
    echo -e "${GREEN}Completions:${NC} $COMP_DIR/_org"
    echo
    echo -e "${CYAN}Add to ~/.zshrc:${NC}"
    echo "  fpath=(~/.zfunc \$fpath)"
    echo "  autoload -Uz compinit && compinit"
elif [ "$SHELL_NAME" = "bash" ]; then
    echo -e "${CYAN}Add to ~/.bashrc:${NC}"
    echo "  source $SCRIPT_DIR/org-completion.bash"
fi

# Initialize directory structure
echo
"$SCRIPT_DIR/org" init

echo
echo -e "${BOLD}Setup complete!${NC}"
echo
echo -e "Usage:"
echo -e "  ${CYAN}org mv file.pdf docs${NC}     Move file to Documents"
echo -e "  ${CYAN}org open inbox${NC}           Open Inbox in Finder"
echo -e "  ${CYAN}org inbox${NC}                Process inbox files"
echo -e "  ${CYAN}org ls${NC}                   List all destinations"
echo -e "  ${CYAN}org status${NC}               Show status"
echo -e "  ${CYAN}org help${NC}                 Show all commands"
