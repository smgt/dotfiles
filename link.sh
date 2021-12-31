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

install_file() {
  local source=$1
  local target=${2%/}
  if [ ! -e "$source" ];then
    echo_red "$source does not exist"
    return
  fi

  # if [ ! -e "$target" ];then
  #   rm -rf "$target"
  # fi

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
  install_file "$DIR/$from_path" "$HOME/$to_path"
done < files

if [ -f files.$OS ];then
  echo_blue "** Linking $OS specific files"
  while IFS=\; read -r from_path to_path; do
    install_file "$DIR/$from_path" "$HOME/$to_path"
  done < files.$OS
fi

exit 0

function install_pkg() {
  local manager="$1"
  local package="$2"
  installed=0
  exists=0
  valid=0

  if ! [[ $package =~ ^# ]] && [ -n "$package" ];then
    valid=1
  fi

  if [ "$valid" != 1 ];then
    return
  fi

  # Check if it's installed
  if $manager -Qiq "$package" > /dev/null; then
    installed=1
  fi

  # Check if it exists
  #if yay -Ss "$package" > /dev/null; then
  #  echo "exists"
  #  exists=1
  #fi
  exists=1

  if [ "$installed" -eq 0 ] && [ "$exists" -eq 1 ] && [ "$valid" -eq 1 ];then
    echo_green "Installing Arch package: $package"
    $manager -Sq "$package" --noconfirm
  fi
}

function install_pkg_pacman() {
  install_pkg "sudo pacman" "$1"
}

function install_pkg_yay() {
  install_pkg yay "$1"
}

echo_blue "** Installing Arch packages"
sudo pacman -Syy
install_pkg_pacman "git"
install_pkg_pacman "base-devel"

if ! pacman -Qiq "yay" > /dev/null; then
  mkdir "$HOME/.aur"
  git clone https://aur.archlinux.org/yay.git "$HOME/.aur/yay"
  pushd "$HOME/.aur/yay" || exit
  makepkg -si --noconfirm
  popd || exit
fi


while IFS= read -r package; do
  install_pkg_yay "$package"
done < pacman.cli

chsh -s /bin/zsh

# Setup vim
#echo_blue "** Installing vim plugins"
#curl -s -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#vim +PlugInstall +qall
echo_blue "** Installing nvim plugins"
curl -s -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
echo_blue "** Installing antigen"
curl -s -L git.io/antigen > zsh/antigen.zsh
if [ -f "$HOME/.tmux/plugins/tpm" ];then
  echo_blue "** Installing tmux tpm"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -d "$HOME/.asdf" ];then
  echo_blue "** Installing asdf"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  cd ~/.asdf || exit
  git checkout "$(git describe --abbrev=0 --tags)"
fi

if [ -d "$HOME/.asdf" ];then
  source $HOME/.asdf/asdf.sh
  echo_blue "** Installing asdf plugins"
  asdf plugin add ruby
  asdf plugin add golang
  asdf plugin add rust
  asdf plugin add python
fi
