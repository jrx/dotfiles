# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

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
plugins=(git brew history kubectl podman vagrant)

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
# autoload -Uz bashcompinit && bashcompinit
# eval "$(dcos completion zsh)"

# dcs() {
#   if [ -z "$1" ]; then
#     echo "Missing URL argument"
#     return
#   fi
#   CLUSTERS=$(dcos cluster list | awk '{print $1}' | grep -v NAME | sed 's/*//g')
#   if [ -n "$CLUSTERS" ]; then
#     echo Wiping clusters: $CLUSTERS
#     echo $CLUSTERS | xargs -n 1 dcos cluster remove
#   fi
#   dcos cluster setup $1 --no-check --insecure --username=admin --password=admßin
#   echo $1/mesos 
# }

# alias dcrm="dcos cluster remove --all"
# alias dclog="for i in \$(dcos task --json | jq --raw-output '.[] | .name') ; do dcos task log --line=10000 \$i > \$i-stdout.log; dcos task log --line=10000 \$i stderr > \$i-stderr.log; done"

# auto completion
fpath=(/usr/local/share/zsh-completions $fpath)

# Ruby
# eval "$(rbenv init -)"

# Golang
export GOPATH=$HOME/go
export PATH=$PATH:$HOME/go/bin/

# Podman
export DOCKER_HOST="unix://$(podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}')"
alias docker=podman

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Vault
export PATH="$HOME/code/vault/bin/:$PATH"
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C $HOME/code/vault/bin/vault vault

# Boundary
export PATH="$HOME/code/boundary/bin:$PATH"
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C $HOME/code/boundary/bin/boundary boundary

# Consul
export PATH="$HOME/code/consul/bin:$PATH"
complete -o nospace -C $HOME/code/consul/bin/consul consul

# Nomad
export PATH="$HOME/code/nomad/bin:$PATH"
complete -o nospace -C $HOME/code/nomad/bin/nomad nomad

# Postgres (psql)
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# GCP
source '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

# Hero
alias hero='podman run -it --rm -v ${PWD}:/output hero -I "Jan Repnak"'

# auxin
export PATH=$PATH:$HOME/csa/internal-csa-docs-hero

# CSA Report Document
pdf() {
  # Check Docker
  if (! podman stats --no-stream &> /dev/null); then
    # On Mac OS this would be the terminal command to launch podman
    open -a 'Podman Desktop'
    # Wait until podman daemon is running and has completed initialisation
    echo "Waiting for podman to launch..."
    while (! podman stats --no-stream &> /dev/null); do
      # podman takes a few seconds to initialize
      sleep 1
    done
  fi

  # Delete .md from the target file and call the script
  target=$(echo ${1} | sed 's/.md$//')

  readonly CSDIR=$HOME/csa/internal-csa-docs-customer-submissions
  readonly DEFAULT_IMG=ghcr.io/hashicorp-sa/internal-csa-docs-customer-submissions/csa-doc-multiarch:latest

  podman run --rm -v ${PWD}:/data -v ${CSDIR}/assets:/assets -e DOCNAME=${target} ${DEFAULT_IMG}
  open ${target}.pdf
}

# Doormat
dm () {
  doormat login -f && doormat aws tf-push --account aws_jrepnak_test --local
}

# Terraform
alias ta='terraform apply -auto-approve'
alias td='terraform destroy -auto-approve'
alias to='terraform output'

# Kubernetes
alias kn='kubectl config set-context --current --namespace '

# JWT
BASE64_DECODER_PARAM="-d" # option -d for Linux base64 tool
echo AAAA | base64 -d > /dev/null 2>&1 || BASE64_DECODER_PARAM="-D" # option -D on MacOS

decode_base64_url() {
  local len=$((${#1} % 4))
  local result="$1"
  if [ $len -eq 2 ]; then result="$1"'=='
  elif [ $len -eq 3 ]; then result="$1"'='
  fi
  echo "$result" | tr '_-' '/+' | base64 $BASE64_DECODER_PARAM
}

decode_jose(){
   decode_base64_url $(echo -n $2 | cut -d "." -f $1) | jq .
}

decode_jwt_part(){
   decode_jose $1 $2 | jq 'if .iat then (.iatStr = (.iat|todate)) else . end | if .exp then (.expStr = (.exp|todate)) else . end | if .nbf then (.nbfStr = (.nbf|todate)) else . end'
}

decode_jwt(){
   decode_jwt_part 1 $1
   decode_jwt_part 2 $1
}

# Decode JWT header
alias jwth="decode_jwt_part 1"

# Decode JWT Payload
alias jwtp="decode_jwt_part 2"

# Decode JWT header and payload
alias jwthp="decode_jwt"

# Decode JWE header
alias jweh="decode_jose 1"
# Created by `pipx` on 2024-05-03 11:01:51
export PATH="$PATH:$HOME/.local/bin"

# NVM
export NVM_DIR="$HOME/.nvm"
# This loads nvm
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
# This loads nvm bash_completion
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
