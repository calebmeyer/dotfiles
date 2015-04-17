# my aliases file

# reconfiguring the shell
alias reconfigure="subl ~/.zshrc"
alias aliases="subl ~/.oh-my-zsh/aliases.zsh"
alias reload_aliases="source ~/.oh-my-zsh/aliases.zsh"
alias reload_theme="rm -rf .antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-calebmeyer-SLASH-cpm-zsh-theme.git/ ; antigen theme calebmeyer/cpm-zsh-theme cpm"

# go to folder aliases
alias haberdasher="cd ~/ruby_workspace/haberdashery/haberdasher"
alias service="cd ~/ruby_workspace/haberdashery/haberdasher_service"
alias ssc="cd ~/ruby_workspace/services/semantic_service_client"
alias ha="cd ~/ruby_workspace/haberdashery/healtheanalytics"
alias hedw="cd ~/ruby_workspace/haberdashery/healtheedw"
alias ms="cd ~/ruby_workspace/services/monocle_service"
alias ss="cd ~/ruby_workspace/services/semantic_service"
alias storefront_service="cd ~/ruby_workspace/services/storefront_service"
alias laptop="cd ~/ruby_workspace/personal/laptop"

# ruby aliases
alias rs="rake site"
alias rr="bundle exec rspec spec"
alias bi="bundle install"
alias bu="bundle update"
alias asset_clear="rake assets:clobber && rake tmp:clear"
alias open_lint="open target/site/Lint-Results/lint-results.html"
alias coverage="open target/site/Code-Coverage/index.html"
alias site_index="open target/site/index.html"

# Other
alias emacs="emacs --daemon"
alias em="emacsclient -t"
alias kill_emacs="emacsclient -e '(kill-emacs)'"
alias ew="/Applications/Emacs.app/Contents/MacOS/Emacs" # emacs window
alias last_diff="git diff HEAD~..HEAD"
alias diff_with_master="git diff master..HEAD"

# general goodies
mkcd () { mkdir $1 && cd $1; }

get_commits () {
  i=1
  url="`git config --get remote.origin.url | sed 's/\.git//'`/commit"
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
