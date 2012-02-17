# Rutger personal bash RC file

# PS1
# git specialized prompt
PS1="\w\[\e[0;33;49m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[\e[0;0m\]$ "


parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_stash))/"
}
parse_git_stash() {
  git stash list 2> /dev/null | wc -l | sed -e "s/ *\([0-9]*\)/\ \+\1/g" | sed -e "s/ \+0//"
}
parse_svn_branch() {
  parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print " ("$1 "/" $2 ")"}'
}
parse_svn_url() {
  svn info 2>/dev/null | grep -e '^URL*' | sed -e 's#^URL: *\(.*\)#\1#g '
}
parse_svn_repository_root() {
  svn info 2>/dev/null | grep -e '^Repository Root:*' | sed -e 's#^Repository Root: *\(.*\)#\1\/#g '
}

#export PS1="\w\[\e[0;33;49m\]\$(parse_svn_branch)\[\e[0;0m\]$ "
export PS1="\w\[\e[0;33;49m\]\[\e[0;0m\]$ "



source ~/.shared/config
source ~/.shared/aliases
export PATH=$HOME/local/bin:$PATH
