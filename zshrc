# ~/.zshrc: ported from config.fish. Login shells (Ghostty, tmux) run ~/.zprofile first.

## Env
export GPG_TTY=$TTY
export EDITOR=nvim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export CONFIG_DIR=$HOME/.config
export HOMEBREW_NO_AUTO_UPDATE=1

## Homebrew: ~/.zprofile runs `brew shellenv` for login shells; cover the rest.
if [[ -z $HOMEBREW_PREFIX ]]; then
  for _brew in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
    [[ -x $_brew ]] && { eval "$($_brew shellenv zsh)"; break }
  done
  unset _brew
fi

## PATH: first copy wins. Brew goes before /usr/bin so brew's python3 shadows
## Apple's; this also undoes the reorder done by path_helper in /etc/zprofile.
typeset -U path fpath
path=(
  ~/.local/bin
  $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin
  ~/go/bin /usr/local/go/bin
  ~/.local/share/solana/install/active_release/bin
  ~/.bun/bin
  /usr/local/sbin
  $path
  $HOMEBREW_PREFIX/share/google-cloud-sdk/bin
)
path=($^path(N-/)) # drop missing dirs

## Options
bindkey -e # EDITOR=nvim would otherwise make zle start in vi mode
setopt AUTO_CD INTERACTIVE_COMMENTS
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

## Completion: OrbStack adds docker/kubectl/orb; cf and ocr are generated into
## ~/.local/share/zsh/site-functions (`cf complete zsh`, `ocr completion zsh`).
fpath=(~/.local/share/zsh/site-functions $fpath)
source ~/.orbstack/shell/init.zsh 2>/dev/null
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

## Keys: fish-style prefix history search on Up/Down, Ctrl-X Ctrl-E edits the line
autoload -Uz edit-command-line up-line-or-beginning-search down-line-or-beginning-search
zle -N edit-command-line
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^X^E' edit-command-line
bindkey '^[[A' up-line-or-beginning-search '^[OA' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search '^[OB' down-line-or-beginning-search

## Aliases
alias v="nvim"
alias vim="nvim"
alias vi="nvim"
alias tconfig="vim ~/.tmux.conf"
alias resh='exec $SHELL'
alias lg="lazygit"
alias mp="mkdir -p"
alias hs="history 1"
alias vc="vault-converter"
alias wk="watch kubectl"
alias vk="viddy -n1 kubectl"
alias oapp="open -a"
alias ll="eza -lag"
alias tiga="tig --all"
alias dc="docker-compose"
alias dcu="dc up"
alias dcd="dc down"
alias dcs="dc stop"
alias tp="telepresence"
alias k="kubectl"
alias ktun="k tunnel"
alias ktop="k ktop"
alias kctx="kubectx"
alias kns="kubens"
alias vg="vagrant"
alias reset-gpg="gpgconf --kill gpg-agent"
alias glp="git pull && git push"
alias gpf="git push --force-with-lease"
alias sd="sudo shutdown -h"
alias todev='ssh dev.remote'
alias tg="terragrunt"
alias tgra="terragrunt run --all apply"
alias tgrp="terragrunt run --all plan"
alias tf="terraform"
alias coder="code --remote=ssh-remote+dev.remote"
(( $+commands[batcat] )) && alias bat="batcat" # Debian names it batcat
alias oc="opencode"
alias cld="claude"
alias gauth='gcloud auth login --update-adc'

## Minikube
alias mkk="minikube kubectl --"
alias mks="minikube start"

## Git
alias gst="git status"
alias gl="git pull"
alias gp="git push"
alias gd="git diff"
alias ga="git add"
alias gb="git branch"
alias gco="git checkout"
alias gc="git commit"
alias grb="git rebase"
alias gap="git add -p"

## Tmux
alias t="tmux"
alias tksv="command tmux kill-server"
alias tl="command tmux list-sessions"
alias tmuxconf='$EDITOR ~/.tmux.conf'
# -t/-s need an argument: drop the flag when called with no args or with an
# option first. See https://github.com/ohmyzsh/ohmyzsh/issues/12230
_tmux_alias() {
  eval "$1() { if [[ \$# -eq 0 || \$1 == -* ]]; then command tmux $2 \"\$@\"; else command tmux $2 $3 \"\$@\"; fi }"
}
_tmux_alias ta attach -t
_tmux_alias tad 'attach -d' -t
_tmux_alias ts switch -t
_tmux_alias tn new-session -s
_tmux_alias tkss kill-session -t
unfunction _tmux_alias

## Prompt: user@host ~/p/dotfiles (main) [1] $
autoload -Uz add-zsh-hook vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats ' (%b)'
zstyle ':vcs_info:*' actionformats ' (%b|%a)'
_prompt_precmd() {
  vcs_info
  setopt localoptions extendedglob
  local p=${(%):-%~}
  p=${p//(#b)(.#[^\/])[^\/]#\//$match[1]/} # fish prompt_pwd: ~/projects/x -> ~/p/x
  _prompt_dir=${p//\%/%%}
}
add-zsh-hook precmd _prompt_precmd
setopt PROMPT_SUBST
PROMPT='%n@%m %F{green}${_prompt_dir}%F{13}${vcs_info_msg_0_}%f %(?..%F{red}[%?]%f )%(!.#.$) '

## Functions
## [C]hange [D]irectory to [G]it [D]irectory: no arg -> repo root
cdgd() {
  local root
  root=$(git rev-parse --show-toplevel 2>/dev/null) || {
    print -u2 "Error: Not a git repository (or any of the parent directories): .git"
    return 128
  }
  if (( $# == 0 )); then cd -- $root
  elif [[ -d $1 ]]; then cd -- $1
  elif [[ -f $1 ]]; then cd -- ${1:h}
  else print -u2 "The path '$1' does not exist"; return 1
  fi
}

# Apple Bundle ID
app_id() {
  [[ $OSTYPE == darwin* ]] || { print -u2 "Error: This function is only available on macOS"; return 1 }
  (( $# )) || { print -u2 "Usage: app_id <app_name>"; return 1 }
  osascript -e "id of app \"$1\""
}

vpn() {
  [[ -f /etc/systemd/system/enable-vpn.service ]] || { print -u2 "No VPN service set up!"; return 1 }
  case $1 in
    stop) sudo service enable-vpn stop ;;
    status) sudo systemctl status enable-vpn ;;
    *) sudo service enable-vpn start ;;
  esac
}

# pbcopy/pbpaste over SSH
pbcopy() {
  if [[ -n $SSH_TTY ]]; then nc -q1 localhost 2224
  elif [[ $OSTYPE == darwin* ]]; then /usr/bin/pbcopy
  else xsel --clipboard --input
  fi
}
pbpaste() {
  if [[ -n $SSH_TTY ]]; then nc -q1 -d localhost 2225
  elif [[ $OSTYPE == darwin* ]]; then /usr/bin/pbpaste
  else xsel --clipboard --output
  fi
}

## nvm: Homebrew's nvm, loaded on first use to keep startup fast
export NVM_DIR=~/.nvm
if [[ -f $HOMEBREW_PREFIX/opt/nvm/nvm.sh ]]; then
  nvm() {
    unfunction nvm
    mkdir -p $NVM_DIR
    source $HOMEBREW_PREFIX/opt/nvm/nvm.sh
    nvm "$@"
  }
  [[ -f ~/.nvmrc ]] && nvm use $(<~/.nvmrc) >/dev/null
fi

## Ranger cd, bound to Ctrl-O
ranger-cd() {
  local dir=$(mktemp -t ranger_cd.XXX)
  ranger --choosedir=$dir <$TTY
  cd -- "$(<$dir)"
  rm -f $dir
  _prompt_precmd
  zle reset-prompt
}
zle -N ranger-cd
bindkey '^O' ranger-cd

[[ -f ~/.private.zsh ]] && source ~/.private.zsh
[[ -f ~/config.extra.zsh ]] && source ~/config.extra.zsh

# One persistent ssh-agent on a fixed socket, shared by every shell, so the key
# is loaded once and survives across sessions/reboots (no passphrase prompt on
# every pull/push). `--apple-use-keychain` stores the passphrase in the macOS
# Keychain on first load and reads it back silently afterwards.
if [[ -o interactive && -f ~/.ssh/id_ed25519 ]]; then
  export SSH_AUTH_SOCK=~/.ssh/agent.sock
  ssh-add -l &>/dev/null
  case $? in
    2) rm -f $SSH_AUTH_SOCK; ssh-agent -a $SSH_AUTH_SOCK &>/dev/null ;& # no agent: start one, then add
    1) ssh-add --apple-use-keychain ~/.ssh/id_ed25519 2>/dev/null ;;
  esac
fi

## fish-like suggestions and highlighting; syntax-highlighting must load last
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#666666'
for _plugin in zsh-autosuggestions zsh-syntax-highlighting; do
  [[ -f $HOMEBREW_PREFIX/share/$_plugin/$_plugin.zsh ]] && source $HOMEBREW_PREFIX/share/$_plugin/$_plugin.zsh
done
unset _plugin
