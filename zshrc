# Path to your oh-my-zsh installation.
export ZSH=/Users/jan/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="sammy"
#ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew history kubectl docker vagrant)

# User configuration

export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH=/usr/local/bin:$PATH

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# DC/OS cli
autoload -Uz bashcompinit && bashcompinit
eval "$(dcos completion zsh)"

dcs() {
  if [ -z "$1" ]; then
    echo "Missing URL argument"
    return
  fi
  CLUSTERS=$(dcos cluster list | awk '{print $1}' | grep -v NAME | sed 's/*//g')
  if [ -n "$CLUSTERS" ]; then
    echo Wiping clusters: $CLUSTERS
    echo $CLUSTERS | xargs -n 1 dcos cluster remove
  fi
  dcos cluster setup $1 --no-check --insecure --username=admin --password=admin
  echo $1/mesos 
}

alias dcrm="dcos cluster remove --all"
alias dclog="for i in \$(dcos task --json | jq --raw-output '.[] | .name') ; do dcos task log --line=10000 \$i > \$i-stdout.log; dcos task log --line=10000 \$i stderr > \$i-stderr.log; done"

# auto completion
fpath=(/usr/local/share/zsh-completions $fpath)

# Ruby
eval "$(rbenv init -)"

# Golang
export GOPATH=$HOME/go
export PATH=$PATH:$HOME/go/bin/

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Vault
export PATH="/Users/jan/test/vault/bin:$PATH"
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /Users/jan/test/vault/bin/vault vault

# Consul
export PATH="/Users/jan/test/consul/bin:$PATH"
complete -o nospace -C /Users/jan/test/consul/bin/consul consul

# Nomad
export PATH="/Users/jan/test/nomad/bin:$PATH"
complete -o nospace -C /Users/jan/test/nomad/bin/nomad nomad

# GCP
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

# CSA Report Document
csa() {
  # Check Docker
  if (! docker stats --no-stream &> /dev/null); then
    # On Mac OS this would be the terminal command to launch Docker
    open -a Docker
    # Wait until Docker daemon is running and has completed initialisation
    echo "Waiting for Docker to launch..."
    while (! docker stats --no-stream &> /dev/null); do
      # Docker takes a few seconds to initialize
      sleep 1
    done
  fi

  # Delete .md from the target file and call the script
  target=$(echo ${1} | sed 's/.md$//')
  ../../build.sh ${target}
  open ${target}.pdf
}

# Doormat
dm () {
  doormat login -f && doormat aws tf-push --account support_eng1_dev  --local
}

# Kubernetes

alias kn='kubectl config set-context --current --namespace '