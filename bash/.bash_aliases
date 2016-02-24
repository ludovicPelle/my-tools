alias ll="ls -al"

alias s_file="~/my-tools/search/srchfile"
alias replace_all="~/my-tools/search/replace"
alias s_fct="~/my-tools/search/srchfct"
alias s_str="~/my-tools/search/srch"
alias ng="~/my-tools/generator/angular/ng.py"

#alias subreb="~/my-tools/git/submodulerebase"

#alias gen-gh-pages="~/my-tools/git/create-gh-pages"
#alias upd-gh-pages="~/my-tools/git/github/update-gh-pages"

#alias sf="symfony"
#alias sf-build="symfony propel:build --all --and-load --no-confirmation"
#alias sf-build-test="symfony propel:build --all --and-load --env=test --no-confirmation"
#alias sf-test="symfony test:all"
#alias sf-build-all-and-test="symfony propel:build --all --and-load --no-confirmation;symfony propel:build --all --and-load --env=test --no-confirmation;symfony cc;symfony test:all"
#alias sf-build-all-and-test-failed="symfony propel:build --all --and-load --no-confirmation;symfony propel:build --all --and-load --env=test --no-confirmation;symfony cc;symfony test:all --only-failed"
#alias sf-build-all="symfony propel:build --all --and-load --no-confirmation;symfony propel:build --all --and-load --env=test --no-confirmation;symfony cc"

#alias dev-term="gnome-terminal --tab --title=modele --tab --title=actions --tab --title=tmpl --tab --title=form --tab --title=conf --tab --title=test"
alias dev-term='gnome-terminal --tab --title="local" --tab --title="server" --tab --title="preprod" --tab --title="log"'

#alias bt-term="gnome-terminal --tab --title=solr --command=\"/var/www/t-resa/start-index.sh \" --tab --title=compass --command=\"compass watch /var/www/t-resa/web/sass/users/ \" --tab --title=apache --command=\"tail -f /var/log/apache2/error.log\" "

#alias gt="git status"
#alias gd="git diff"
#alias ga="git add"
#alias gall="git add ."
#alias gco="git commit"
#alias gce="git checkout"
#alias gpull="git pull --rebase"
#alias gpush="git push"
#alias gl="git log"

#alias dump-load-t-resa="dropdb t-resa && createdb t-resa -O t-resa -E UTF-8 && psql -f"

#alias win="sudo mount -t vboxsf partage ~/win"

alias ssh_prod="ssh root@62.210.151.225"
alias ssh_recipe="ssh -t root@62.210.151.225 cd /var/www/cop1/iproteg/iprotego/api-recipe"
alias ssh_dev="ssh alex@62.210.78.111"
alias ssh_dev_root="ssh root@62.210.78.111"
alias sshramuh="ssh root@ramuh"
alias screen_prod="ssh -t root@prod screen -x api"
alias screen_recipe="ssh -t root@prod screen -x recipe"
alias deploy_frontend="rsync -e ssh -avz ~/Projects/osculteo/bin/ root@ramuh:/var/www/www.osculteo.com/bin/"
alias deploy_backend="rsync -e ssh -avz ~/Projects/osculteo-backoffice/bin/ root@ramuh:/var/www/backoffice.osculteo.com/bin/"
alias start_webdriver="./node_modules/protractor/bin/webdriver-manager start"
alias update_webdriver="./node_modules/protractor/bin/webdriver-manager update"
alias test_client="grunt test"
alias sys_update="yaourt -Suya --devel"
alias rm="trash"
