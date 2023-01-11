# my aliases file

# reconfiguring the shell
alias reconfigure="$EDITOR ~/.zshrc"
alias aliases="$EDITOR ~/.aliases.zsh"
alias reload_aliases="source ~/.aliases.zsh"

# git aliases
alias master="git checkout master; git pull"
alias last_diff="git diff HEAD~..HEAD"
alias diff_with_master="git diff master..HEAD"
alias reset="git reset --hard"
alias clc="copy_last_commit"

# Other
alias se="/Applications/Emacs.app/Contents/MacOS/Emacs" # emacs window
alias spacemacs="se"
alias e="emacsclient -t"
alias eff='eval $(thefuck $(fc -ln -1))'
alias oauth="java -jar /Users/cm022291/java_workspace/auth-header/target/auth-header-1.5-SNAPSHOT.jar -c"
alias pickmeup="fortune | cowsay | lolcat"
alias duu="~/java_workspace/data-upload-1.0.2/bin/upload"
alias oozie="~/java_workspace/oozie-client-2.3.2-cdh3u6/bin/oozie"

alias ls="exa"
alias ll="exa -l"
alias la="exa -a"

# general goodies
mkcd () { mkdir $1 && cd $1; }

get_commits () {
  i=1
  url="`git config --get remote.origin.url | sed 's/\.git//' | sed 's/:/\//' | sed 's/git@/https:\/\//'`/commit"
  git log --pretty=oneline -$1 | while read line; do
    commit="$url/`echo $line | sed 's/^\([0-9a-f]*\) .*$/\1/'`"
    message="`echo $line | sed 's/^[0-9a-f]* \(.*\)$/\1/'`"
    echo "[$i] $message:\n$commit\n"
    i=`expr $i + 1`
  done
}

copy_last_commit () {
  get_commits 1 | head -2 | tail -1 | tr -d "\n" | pbcopy
  echo "Copied to clipboard"
}

code () {
  if [[ $# = 0 ]]
  then
    open -a "Visual Studio Code"
  else
    [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
    open -a "Visual Studio Code" --args "$F"
  fi
}
