#!/bin/bash

error() {
  echo_red "ERROR: $1\n"
  exit 1
}

echo_green() {
  echo -e "\e[32m$1\e[39m"
}

echo_yellow() {
  echo -e "\e[33m$1\e[39m"
}

echo_red() {
  echo -ne "\e[31m$1\e[39m"
}

echo_blue() {
  echo -e "\e[34m$1\e[39m"
}


case "$OSTYPE" in
  "linux"*)
    OS=linux
    ;;
  "darwin"*)
    OS=osx
    ;;
  *)
    error "Unknown operating system"
    ;;
esac

# if hash X; then
#   XORG=yes
# else
#   XORG=no
# fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    -f|--force)
      ARG_FORCE=1
      shift # past argument
      ;;
    --default)
      shift # past argument
      ;;
    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
  esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

ask_remove() {
  # if [ ${ARG_FORCE} ];then
  #   return
  # fi
  echo_red "  - File/directory already exists, remove $1 (y/n)? "
  local answer=0
  read -r answer < /dev/tty
  case ${answer:0:1} in
    y|Y )
      local target=${1%/}
      if [ -L "$1" ];then
        rm -rf "$target"
      else
        mv "$target" "$target".bak
      fi
      ;;
    * )
      ;;
  esac
}

link_file() {
  local source=$1
  local target=${2%/}
  if [ ! -e "$source" ];then
    echo_red "$source does not exist"
    return
  fi

  # if [ ! -e "$target" ];then
  #   rm -rf "$target"
  # fi
  if [ ! -e "$target" ];then
    echo_red "$target\n"
    ask_remove "$target"
  fi

  if [ -e "$target" ];then
    if [ "$(readlink -f "$target")" != "$source" ];then
      echo_red "$target\n"
      ask_remove "$target"
    fi
  fi
  if [ -s "$target" ];then
    if [[ $(realpath "$target") =~ $HOME/.dotfiles ]];then
      echo_yellow "  Skipping ${source} -> ${target}, already linked."
      return
    fi
  fi
  if [ ! -e "$target" ];then
    echo_green "  $source -> $target"
    if [ ! -d "$(dirname "$target")" ];then
      mkdir -p "$(dirname "$target")"
    fi
    ln -s "$source" "$target"
  fi
}

echo_blue "** Linking files"
while IFS=\; read -r from_path to_path; do
  link_file "$DIR/$from_path" "$HOME/$to_path"
done < files

if [ -f files.$OS ];then
  echo_blue "** Linking $OS specific files"
  while IFS=\; read -r from_path to_path; do
    link_file "$DIR/$from_path" "$HOME/$to_path"
  done < files.$OS
fi
