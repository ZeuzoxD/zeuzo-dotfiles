# -- Plugin manager --
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d $ZINIT_HOME ]; then
  mkdir -p $(dirname $ZINIT_HOME)
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# -- Plugins --
zinit light zsh-users/zsh-autosuggestions

source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

# now load zsh-syntax-highlighting plugin
zinit light zsh-users/zsh-syntax-highlighting
zinit light MichaelAquilina/zsh-auto-notify

# -- Snippets --
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# -- Shell integrations --
eval "$(fzf --zsh)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"

# -- Load Completions --
autoload -Uz compinit && compinit
zinit cdreplay -q

autoload -U select-word-style
select-word-style bash

# -- Keybindings --
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# -- History --
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
HISTDUP=erase

setopt sharehistory
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt hist_verify


# -- Envs --
export EDITOR=nvim
export GTK_THEME=Flat-Remix-GTK-Violet-Darkest-Solid
export PATH=/home/zeuzo/.local/bin:/sbin:/bin:$PATH
export PATH=$PATH:/home/zeuzo/.spicetify
export WAYLAND_DISPLAY=wayland-1
export AUTO_NOTIFY_THRESHOLD=20
export AUTO_NOTIFY_TITLE="Hey! '%command' has just finished"
export AUTO_NOTIFY_BODY="It completed in %elapsed seconds"

# -- Aliases --
alias v="nvim"
alias gc="git clone"
alias zshconf="$EDITOR ~/.zshrc && source ~/.zshrc"

# -- FZF --
fg="#f2f4f8"
bg="#161616"
bg_highlight="#161616"
purple="#78a9ff"
blue="#be95ff"
cyan="#33b1ff"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# Use fd for fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ----- Bat (better cat) -----

export BAT_THEME=Catppuccin_Mocha

# ---- Eza (better ls) -----

alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user"
alias lst="eza --tree --color=always --long --icons=always --no-time --no-user"
alias lst1="eza --tree --color=always --long --icons=always --no-time --no-user --level=1"
alias lst2="eza --tree --color=always --long --icons=always --no-time --no-user --level=2"
alias lst3="eza --tree --color=always --long --icons=always --no-time --no-user --level=3"
# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

