export LSCOLORS=ExFxCxDxBxegedabagacad       
export CLICOLOR=1   


for function_file in $DOTFILES/bash/functions/*
  do
    source $function_file
  done
