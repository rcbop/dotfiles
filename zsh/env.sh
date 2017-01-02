#!/bin/zsh

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export EDITOR='atom -w'
export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools
# export PYTHONPATH=$PYTHONPATH
# export MANPATH="/usr/local/man:$MANPATH"

# Android
export ANDROID_HOME=/usr/local/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/bin

# Virtual Environment
#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/Projects
#source /usr/local/bin/virtualenvwrapper.sh

# Owner
export USER_NAME="Rogério Peixoto"
#eval "$(rbenv init -)"

# FileSearch
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

#mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }

#function dmset() {
#  COUNT=`command docker-machine ls | grep "Running" | wc -l`
#  if [[ "${COUNT// /}" == "1" ]]
#  then
#    RUNNING_MACHINE=`command docker-machine ls | grep "Running" | awk '{print $1;}'`
#    while IFS= read -r line
#    do
#      if [[ $line == 'export'* ]]
#      then
#        eval $line
#      fi
#    done < <(docker-machine env $RUNNING_MACHINE)
#    echo "Docker environment set for $RUNNING_MACHINE"
#  else
#    echo "Unable to set Docker environment"
#  fi
#}

#function dmstart(){
#  command docker-machine start default
#}

#function docker() {
#  case $* in
#    ps* ) shift 1; command docker ps "$@" | grcat $HOME/.grc/conf.dockerps ;;
#    images* ) shift 1; command docker images "$@" | grcat $HOME/.grc/conf.dockerimages ;;
#    info* ) shift 1; command docker info "$@" | grcat $HOME/.grc/conf.dockerinfo ;;
#    * ) command docker "$@" ;;
#  esac
#}

#function docker-machine() {
#   case $* in
#    ls* ) shift 1; command docker-machine ls "$@" | grcat $HOME/.grc/conf.docker-machinels ;;
#     *) command docker-machine "$@" ;;
#   esac
#}

function get-device-screenshot() {
  adb -d shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > $1
}

alias dmls='docker-machine ls'

# Aliases
alias cppcompile='c++ -std=c++11 -stdlib=libc++'
alias cwd='printf "%q\n" "$(pwd)" | pbcopy | echo pwd copied to clipboard'

# Init jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"
alias jenv_set_java_home='export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"'

