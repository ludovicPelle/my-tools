alias ll="ls -al"

alias srf="~/my-tools/search/srchfile"
alias srft="~/my-tools/search/srchfct"
alias srs="~/my-tools/search/srch"

alias subreb="~/my-tools/git/submodulerebase"

alias gen-gh-pages="~/my-tools/git/create-gh-pages"
alias upd-gh-pages="~/my-tools/git/github/update-gh-pages"

alias sf="symfony"
alias sf-build="symfony propel:build --all --and-load --no-confirmation"
alias sf-build-test="symfony propel:build --all --and-load --env=test --no-confirmation"
alias sf-test="symfony test:all"
alias sf-build-all-and-test="symfony propel:build --all --and-load --no-confirmation;symfony propel:build --all --and-load --env=test --no-confirmation;symfony cc;symfony test:all"
alias sf-build-all-and-test-failed="symfony propel:build --all --and-load --no-confirmation;symfony propel:build --all --and-load --env=test --no-confirmation;symfony cc;symfony test:all --only-failed"
alias sf-build-all="symfony propel:build --all --and-load --no-confirmation;symfony propel:build --all --and-load --env=test --no-confirmation;symfony cc"

alias dev-term="gnome-terminal --tab --title=modele --tab --title=actions --tab --title=tmpl --tab --title=form --tab --title=conf --tab --title=test"

alias bt-term="gnome-terminal --tab --title=solr --command=\"/var/www/t-resa/start-index.sh \" --tab --title=compass --command=\"compass watch /var/www/t-resa/web/sass/users/ \" --tab --title=apache --command=\"tail -f /var/log/apache2/error.log\" "

alias gt="git status"
alias gd="git diff"
alias ga="git add"
alias gall="git add ."
alias gco="git commit"
alias gce="git checkout"
alias gpull="git pull --rebase"
alias gpush="git push"

alias dump-load-t-resa="dropdb t-resa && createdb t-resa -O t-resa -E UTF-8 && psql -f"

alias debian-update="sudo aptitude update;sudo aptitude safe-upgrade;"
