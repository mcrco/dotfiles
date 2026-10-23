# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme
export PATH="$HOME/.local/bin/:$PATH"
export PATH="/Library/TeX/texbin/:$PATH"
export PATH="/Users/marco/.cargo/bin/:$PATH"
alias vim='nvim'
alias scenv='source .venv/bin/activate'

export CPATH=/opt/homebrew/include
export LIBRARY_PATH=/opt/homebrew/lib

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH=/Users/marco/.meteor:$PATH
export PATH=/usr/local/texlive/2023basic/bin/universal-darwin:$PATH
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"

# zoxide
eval "$(zoxide init zsh)"
alias cd=z
alias gcom="git commit -m"
alias gpush="git push"
alias dots="git -C ~/.config"

export JAVA_HOME="/Users/marco/Library/Java/JavaVirtualMachines/openjdk-21.0.2/Contents/Home/"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
#         . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<
#

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
# [[ -f /Users/marco/dev/bwstat/app/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /Users/marco/dev/bwstat/app/node_modules/tabtab/.completions/electron-forge.zsh

. "$HOME/.local/bin/env"


# make auto-complete go to last command with current prefix
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search


export GPG_TTY=$TTY

# for dbus stuff like neovim and typst
export DBUS_SESSION_BUS_ADDRESS='unix:path='$DBUS_LAUNCHD_SESSION_BUS_SOCKET

# Added by Antigravity
export PATH="/Users/marco/.antigravity/antigravity/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"

load_nvm() {
  unset -f node npm npx corepack nvm
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
}

node() { load_nvm; node "$@"; }
npm() { load_nvm; npm "$@"; }
npx() { load_nvm; npx "$@"; }
corepack() { load_nvm; corepack "$@"; }
nvm() { load_nvm; nvm "$@"; }
