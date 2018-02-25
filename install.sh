#!/bin/sh

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  OS=linux
elif [[ "$OSTYPE" == "darwin"* ]]; then
  OS=osx
fi

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
      DEFAULT=YES
      shift # past argument
      ;;
    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
  esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

function ask_remove() {
  if [ ${ARG_FORCE} ];then
    return
  fi
  read -p "  - File/directory already exists, remove $1 (y/n)? " answer
  case ${answer:0:1} in
    y|Y )
      rm -rf $1
      ;;
    * )
      ;;
  esac
}

function install_file() {
  local source=$1
  local target=$2
  if [ ! -e $source ];then
    return
  fi
  if [ -e $target ];then
    ask_remove $target
  fi
  if [ ! -e $target ];then
    echo "  $source -> $target"
    ln -s $source $target
  fi
}

function echo_green() {
  echo -e "\e[32m$1\e[39m"
}

git submodule update --init

echo_green "** Linking files"
for line in $(cat files);do
  aray=($(echo "$line"|tr ';' '\n'))
  from_path=$DIR/${aray[0]}
  to_path=$HOME/${aray[1]}
  install_file $from_path $to_path
done

if [ -f files.$OS ];then
  echo_green "** Linking $OS specific files"
  for line in $(cat files.$OS);do
    aray=($(echo "$line"|tr ';' '\n'))
    from_path=$DIR/${aray[0]}
    to_path=$HOME/${aray[1]}
    install_file $from_path $to_path
  done
fi
