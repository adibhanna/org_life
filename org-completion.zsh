#compdef org

# Zsh completion for org CLI
# Add to ~/.zshrc:
#   fpath=(/path/to/org_life $fpath)
#   autoload -Uz compinit && compinit

_org_get_destinations() {
    local yaml_file="${HOME}/Life/org.yaml"
    if [[ -f "$yaml_file" ]]; then
        grep -v '^#' "$yaml_file" | grep ':' | while IFS=': ' read -r key value; do
            [[ -n "$key" ]] && echo "${key// /}:${value// /}"
        done
    fi
}

_org() {
    local -a commands
    local -a destinations

    commands=(
        'mv:Move file to destination'
        'cp:Copy file to destination'
        'ls:List all destinations'
        'cd:Print path for cd'
        'open:Open destination in Finder'
        'inbox:Process inbox interactively'
        'status:Show organization status'
        'init:Create org.yaml config'
        'create:Create directories from yaml'
        'find:Search for files'
        'help:Show help'
    )

    # Dynamically get destinations from yaml
    destinations=(${(f)"$(_org_get_destinations)"})

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
