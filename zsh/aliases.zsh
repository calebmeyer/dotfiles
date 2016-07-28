# my aliases file

# reconfiguring the shell
alias reconfigure="$EDITOR ~/.zshrc"
alias aliases="$EDITOR ~/.aliases.zsh"
alias reload_aliases="source ~/.aliases.zsh"
alias reload_theme="rm -rf .antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-calebmeyer-SLASH-cpm-zsh-theme.git/ ; antigen theme calebmeyer/cpm-zsh-theme cpm"

# go to folder aliases
alias hd="cd ~/ruby_workspace/haberdashery/haberdasher"
alias hds="cd ~/ruby_workspace/haberdashery/haberdasher_service"
alias ssc="cd ~/ruby_workspace/services/semantic_service_client"
alias ha="cd ~/ruby_workspace/haberdashery/healtheanalytics"
alias hedw="cd ~/ruby_workspace/haberdashery/healtheedw"
alias monocle="cd ~/ruby_workspace/clients/monocle"
alias ms="cd ~/ruby_workspace/services/monocle_service"
alias ss="cd ~/ruby_workspace/services/semantic_service"
alias sfs="cd ~/ruby_workspace/services/storefront_service"
alias laptop="cd ~/personal/laptop"
alias msc="cd ~/chef_workspace/monocle_service_cookbook"
alias secrets="cd ~/chef_workspace/secrets_chef"
alias rcdash="cd ~/ruby_workspace/other_teams/rev_cycle_dashboard"
alias sf="cd ~/ruby_workspace/clients/storefront"
alias theme="cd ~/personal/cpm-zsh-theme"
alias rust_workspace="cd ~/personal/rust_workspace"
alias bletchley="cd ~/chef_workspace/bletchley"
alias cmd="cd ~/ruby_workspace/other_teams/command_center"
alias ds="cd ~/personal/dev_setup"
alias tw="cd ~/ruby_workspace/clients/tabwhoa"
alias d="cd ~/ruby_workspace/clients/dossier"

# ruby aliases
alias rs="rake site"
alias rr="bundle exec rspec"
alias rit="ruby spec/integration/integration.rb"
alias rake_clean_db="rake db:drop db:create db:migrate db:reset"
alias bi="bundle install"
alias bu="bundle update"
alias asset_clear="rake assets:clobber && rake tmp:clear"
alias open_lint="open target/site/Lint-Results/lint-results.html"
alias coverage="open target/site/Code-Coverage/index.html"
alias site_index="open target/site/index.html"
alias kill_rails='kill "$(lsof -i :3000 -t)"'
alias tags='ctags -R --languages=ruby --exclude=.git --exclude=log .'

# git aliases
alias master="git checkout master"
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

alias ls="k"
alias ll="k"
alias la="k -a"

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
