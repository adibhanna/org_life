#compdef org

# Zsh completion for org CLI
# Add to ~/.zshrc:
#   fpath=(/path/to/org_life $fpath)
#   autoload -Uz compinit && compinit

_org() {
    local -a commands destinations

    commands=(
        'mv:Move file to destination'
        'cp:Copy file to destination'
        'ls:List all destinations'
        'cd:Print path for cd'
        'open:Open destination in Finder'
        'inbox:Process inbox interactively'
        'status:Show organization status'
        'init:Initialize directory structure'
        'find:Search for files'
        'help:Show help'
    )

    destinations=(
        'work:Work'
        'meetings:Work/Meetings'
        'projects:Projects'
        'code:Projects/Code'
        'personal:Projects/Personal'
        'finance:Finance'
        'receipts:Finance/Receipts'
        'taxes:Finance/Taxes'
        'docs:Documents'
        'identity:Documents/Identity'
        'legal:Documents/Legal'
        'media:Media'
        'photos:Media/Photos'
        'screenshots:Media/Screenshots'
        'videos:Media/Videos'
        'designs:Media/Designs'
        'learn:Learning'
        'courses:Learning/Courses'
        'books:Learning/Books'
        'notes:Learning/Notes'
        'archive:Archive'
        'inbox:Inbox'
        'system:System'
        'backups:System/Backups'
        'configs:System/Configs'
    )

    case "$words[2]" in
        mv|cp)
            case "$CURRENT" in
                3)
                    _files
                    ;;
                4)
                    _describe 'destination' destinations
                    ;;
            esac
            ;;
        cd|open|o)
            _describe 'destination' destinations
            ;;
        find|search|f)
            _message 'search term'
            ;;
        *)
            if (( CURRENT == 2 )); then
                _describe 'command' commands
                _describe 'destination' destinations
            fi
            ;;
    esac
}

_org "$@"
