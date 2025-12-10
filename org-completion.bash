# Bash completion for org CLI
# Source this file or add to ~/.bashrc:
#   source /path/to/org-completion.bash

_org_get_destinations() {
    local yaml_file="${HOME}/Life/org.yaml"
    if [ -f "$yaml_file" ]; then
        grep -v '^#' "$yaml_file" | grep ':' | cut -d: -f1 | tr -d ' '
    fi
}

_org_completions() {
    local cur prev words cword
    _get_comp_words_by_ref -n : cur prev words cword

    local commands="mv cp ls cd open inbox status init create find help"
    local destinations=$(_org_get_destinations)

    case "$prev" in
        org)
            COMPREPLY=($(compgen -W "$commands $destinations" -- "$cur"))
            return 0
            ;;
        mv|cp)
            if [ "$cword" -eq 2 ]; then
                COMPREPLY=($(compgen -f -- "$cur"))
            elif [ "$cword" -eq 3 ]; then
                COMPREPLY=($(compgen -W "$destinations" -- "$cur"))
            fi
            return 0
            ;;
        cd|open|o)
            COMPREPLY=($(compgen -W "$destinations" -- "$cur"))
            return 0
            ;;
        *)
            if [ "$cword" -eq 3 ] && [[ "${words[1]}" =~ ^(mv|cp)$ ]]; then
                COMPREPLY=($(compgen -W "$destinations" -- "$cur"))
                return 0
            fi
            ;;
    esac

    return 0
}

complete -F _org_completions org
