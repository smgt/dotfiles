#!/bin/bash

error() {
  echo "ERROR: $1"
  exit 1
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
  if [ ${ARG_FORCE} ];then
    return
  fi
  read -rp "  - File/directory already exists, remove $1 (y/n)? " answer
  case ${answer:0:1} in
    y|Y )
      #rm -rf $1
      mv "$1" "$1".bak
      ;;
    * )
      ;;
  esac
}

install_file() {
  local source=$1
  local target=$2
  if [ ! -e "$source" ];then
    return
  fi
  if [ -s "$target" ];then
    if [[ $(realpath "$target") =~ $HOME/.dotfiles ]];then
      echo "Skipping ${source} -> ${target}, already linked."
      return
    fi
  fi
  if [ -e "$target" ];then
    ask_remove "$target"
  fi
  if [ ! -e "$target" ];then
    echo "  $source -> $target"
    if [ ! -d "$(dirname "$target")" ];then
      mkdir -p "$(dirname "$target")"
    fi
    ln -s "$source" "$target"
  fi
}

echo_green() {
  echo -e "\e[32m$1\e[39m"
}


#git submodule update --init

echo_green "** Linking files"
while IFS=\; read -r from_path to_path; do
  install_file "$DIR/$from_path" "$HOME/$to_path"
done < files

if [ -f files.$OS ];then
  echo_green "** Linking $OS specific files"
  while IFS=\; read -r from_path to_path; do
    install_file "$DIR/$from_path" "$HOME/$to_path"
  done < files.$OS
fi

echo "Installing vim plugins"
vim +PlugInstall
