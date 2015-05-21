# Apparix Plugin

# Author: Simon Gate
# Date: May 20, 2015
# Based on bookmark by Brother Rain

# show help
function apparix_help {
  echo "Usage: to [NAME]"
  echo "Change directory\n"

  apparix_list
}

# list bookmarks
function apparix_list {
  echo "Available bookmarks: \n"
  apparix | sed -n '4,$'p | uniq
  echo ""
}

# bookmark a folder
function apparix_add {
  apparix --add-mark $1
}

# to bookmark
function apparix_to {
  if [[ $# -gt 0 ]]; then
    folder=$(apparix $1)
    cd $folder
  else
    apparix_help
  fi
}

# delete bookmark
function apparix_delete {
  if [[ $# -gt 0 ]]; then
    apparix -purge-mark $1
    apparix_list
  else
    apparix_help
  fi
}

# auto complete
_apparix_complete() {
  A=$(apparix | sed -n '4,$'p  | awk '{ print $2 }')
  _arguments ":::($A)"
}

compdef _apparix_complete apparix_to
compdef _apparix_complete apparix_delete

alias to=apparix_to
alias al=apparix_list
alias aa=apparix_add
alias ad=apparix_delete
