# set homebrew environment
if [[ -x "$HOME/homebrew/bin/brew" ]]
then
    eval "$($HOME/homebrew/bin/brew shellenv)"
fi

# include user-specific binaries and scripts
export BIN_DIR=$HOME/.local/bin
export PATH=$BIN_DIR:$PATH

# set the locale of the shell
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export LC_CTYPE=$LANG

# set the location and filename of the history file
export HISTFILE="$HOME/.zsh_history"

# set the maximum number of lines to be saved in the history file
export HISTSIZE="100000"
export SAVEHIST="$HISTSIZE"

# enable comments "#" expressions in the prompt shell
setopt INTERACTIVE_COMMENTS

# append new history entries to the history file
setopt APPEND_HISTORY

# save each command to the history file as soon as it is executed
setopt INC_APPEND_HISTORY

# ignore recording duplicate consecutive commands in the history
setopt HIST_IGNORE_DUPS

# ignore commands that start with a space in the history
#setopt HIST_IGNORE_SPACE

# enable completion
autoload -U compinit; compinit
# setopt GLOB_COMPLETE      # Show autocompletion menu with globs
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.
zstyle ':completion:*' completer _extensions _complete _approximate # Define completers
zstyle ':completion:*' use-cache on # Use cache for commands using cache
zstyle ':completion:*' menu select # Allow you to select in a menu
zstyle ':completion:*' group-name '' # Required for completion to be in good groups (named after the tags)
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
if ! [[ -v LS_COLORS ]]; then
    if command -v dircolors >/dev/null 2>&1; then
        eval "$(dircolors -b)"
    elif command -v gdircolors >/dev/null 2>&1; then
        eval "$(gdircolors -b)"
    fi
fi
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS} # Colors for files and directory

# load zsh plugins
source "$HOME/.my-custom-zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.my-custom-zsh/f-sy-h/F-Sy-H.plugin.zsh"
source "$HOME/.my-custom-zsh/zsh-history-substring-search/zsh-history-substring-search.zsh"

# search history using up and down keys
typeset -g -A key
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         history-substring-search-up
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       history-substring-search-down

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# search history using up and down keys
#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down

# start starship prompt
eval "$(starship init zsh)"

