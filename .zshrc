if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
# zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ll="eza --icons --git -laTL 1"
alias reload="source ~/.zshrc"

# Brew
alias ibrew="arch -x86_64 /usr/local/bin/brew"
alias abrew="arch -arm64 brew"

# Java
alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias java11='export JAVA_HOME=$JAVA_11_HOME'
alias java17='export JAVA_HOME=$JAVA_17_HOME'
alias java21='export JAVA_HOME=$JAVA_21_HOME'

# Emacs
alias joemacs="/Applications/Emacs.app/Contents/MacOS/Emacs-arm64-11 --with-profile=joemacs & disown"
alias regular="/Applications/Emacs.app/Contents/MacOS/Emacs-arm64-11 --with-profile=joemacs & disown"
alias magit="/Applications/Emacs.app/Contents/MacOS/Emacs-arm64-11 --with-profile=magit -nw -f magit-status"
alias spacemacs="/Applications/Emacs.app/Contents/MacOS/Emacs-arm64-11 --with-profile=spacemacs & disown"
alias doom-emacs="/Applications/Emacs.app/Contents/MacOS/Emacs-arm64-11 --with-profile=doom-emacs & disown"

# Docker containers
alias docker-restart-mocrest='cd ~/workspace/ace-docker-compose-dev && docker stop mocrest && docker compose up -d mocrest && cd -'
alias docker-restart-mocsoap='cd ~/workspace/ace-docker-compose-dev && docker stop mocsoap && docker compose up -d mocsoap && cd -'
alias docker-restart-mocaceapi='cd ~/workspace/ace-docker-compose-dev && docker stop mocaceapi && docker compose up -d mocaceapi && cd -'
alias docker-restart-mocrestcas='cd ~/workspace/ace-docker-compose-dev && docker stop mocrestcas && docker compose up -d mocrestcas && cd -'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

eval "$(starship init zsh)"
eval "$(java17)"
# export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
