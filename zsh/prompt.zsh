autoload colors && colors

#git_branch() {
  #echo $(/usr/local/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
#}

#git_dirty() {
  #st=$(/usr/local/bin/git status 2>/dev/null | tail -n 1)
  #if [[ $st == "" ]]
  #then
    #echo ""
  #else
    #if [[ $st == "nothing to commit (working directory clean)" ]]
    #then
      #echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    #else
      #echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    #fi
  #fi
#}

#git_prompt_info () {
 #ref=$(/usr/local/bin/git symbolic-ref HEAD 2>/dev/null) || return
## echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 #echo "${ref#refs/heads/}"
#}

#project_name () {
  #name=$(pwd | awk -F'Development/' '{print $2}' | awk -F/ '{print $1}')
  #echo $name
#}

#project_name_color () {
##  name=$(project_name)
  #echo "%{\e[0;35m%}${name}%{\e[0m%}"
#}

#unpushed () {
  #/usr/local/bin/git cherry -v origin/$(git_branch) 2>/dev/null
#}

#need_push () {
  #if [[ $(unpushed) == "" ]]
  #then
    #echo " "
  #else
    #echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  #fi
#}

#rvm_prompt(){
  #if $(which rvm &> /dev/null)
  #then
		#echo "%{$fg_bold[yellow]%}$(rvm tools identifier)%{$reset_color%}"
	#else
		#echo ""
  #fi
#}

## This keeps the number of todos always available the right hand side of my
## command line. I filter it to only count those tagged as "+next", so it's more
## of a motivation to clear out the list.
#todo(){
  #if $(which todo.sh &> /dev/null)
  #then
    #num=$(echo $(todo.sh ls +next | wc -l))
    #let todos=num-2
    #if [ $todos != 0 ]
    #then
      #echo "$todos"
    #else
      #echo ""
    #fi
  #else
    #echo ""
  #fi
#}

#directory_name(){
  #echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
#}

  #export PROMPT=$'\n%{$fg_bold[green]%}%n@%m $(directory_name) $(project_name_color)$(git_dirty)$(need_push)\n› '
#set_prompt () {
  #export RPROMPT="%{$fg_bold[grey]%}$(todo)%{$reset_color%}"
#}

#precmd() {
  #title "zsh" "%m" "%55<...<%~"
  #set_prompt
#}
# Apply theming defaults
PS1="%n@%m:%~%# "

# git theming default: Variables for theming the git info prompt
ZSH_THEME_GIT_PROMPT_PREFIX="git:("         # Prefix at the very beginning of the prompt, before the branch name
ZSH_THEME_GIT_PROMPT_SUFFIX=")"             # At the very end of the prompt
ZSH_THEME_GIT_PROMPT_DIRTY="*"              # Text to display if the branch is dirty
ZSH_THEME_GIT_PROMPT_CLEAN=""               # Text to display if the branch is clean

# Setup the prompt with pretty colors
setopt prompt_subst
