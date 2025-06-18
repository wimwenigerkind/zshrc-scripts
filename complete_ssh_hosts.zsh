#### initialize completion system ####
# see https://unix.stackexchange.com/questions/593433/bash-like-autocompletion-for-ssh-command-in-zsh-shell-with-etc-hosts-file
# see https://zsh.sourceforge.io/Doc/Release/Completion-System.html
autoload -Uz compinit; compinit


# enable bash style autocomplete (requires compinit to be called before this)
# see https://stackoverflow.com/questions/3249432/can-a-bash-tab-completion-script-be-used-in-zsh
# see https://zsh.sourceforge.io/Doc/Release/Completion-System.html
autoload -Uz bashcompinit; bashcompinit


# replace the default ssh autocomplete that comes from compinit
# with this _complete_ssh_hosts function which looks for hosts in ~/.ssh/config and ~/.ssh/known_hosts
# Note: requires bashcompinit to enable this bash style autocomplete function
# see https://stackoverflow.com/questions/52438964/mac-autocomplete-for-ssh-hosts-in-terminal
# see https://gist.github.com/aliang/1024466

            #cat ~/.ssh/known_hosts | \
            #    cut -f1 -d' ' | \
            #    sed 's/,.*//' | \
            #    grep -v '^#' | \
            #    grep -v '\['

_complete_ssh_hosts ()
{
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    comp_ssh_hosts=$(
        {
            cat ~/.ssh/config ~/.ssh/config.d/* 2>/dev/null | \
                grep '^Host ' | \
                awk '{print $2}'
        } | uniq
    )
    COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- "$cur") )
    return 0
}
complete -F _complete_ssh_hosts ssh
