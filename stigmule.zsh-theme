# vim:et sts=2 sw=2 ft=zsh
#
# Gitster theme
# https://github.com/shashankmehta/dotfiles/blob/master/thesetup/zsh/.oh-my-zsh/custom/themes/gitster.zsh-theme
#
# Requires the `git-info` zmodule to be included in the .zimrc file.

_prompt_stigmule_pwd() {
  local git_root current_dir
  if git_root=$(command git rev-parse --show-toplevel 2>/dev/null); then
    current_dir="${PWD#${git_root:h}/}"
  else
    current_dir=${(%):-%~}
  fi
  print -n "%F{cyan}${current_dir}"
}

setopt nopromptbang prompt{cr,percent,sp,subst}

typeset -gA git_info
if (( ${+functions[git-info]} )); then
  zstyle ':zim:git-info:branch' format '%b'
  zstyle ':zim:git-info:commit' format '%c'
  # zstyle ':zim:git-info:clean' format ' %F{green}✔︎'
  zstyle ':zim:git-info:clean' format ''
  zstyle ':zim:git-info:dirty' format ' %F{yellow}ϟ'
  zstyle ':zim:git-info:keys' format \
      'prompt' ' %F{blue}» %F{red}%b%c%C%D'

  autoload -Uz add-zsh-hook && add-zsh-hook precmd git-info
fi

PS1='%(?:%F{green}➜%F{black}:%F{red}✱%F{yellow}) %T $(_prompt_stigmule_pwd)${(e)git_info[prompt]}%f '
unset RPS1