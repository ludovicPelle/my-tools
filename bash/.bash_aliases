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

alias debian-update="sudo aptitude update;sudo aptitude safe-upgrade;"
alias arch-update="yaourt -Syua --devel"
#alias win="sudo mount -t vboxsf partage ~/win"
alias gitpulse='git log --shortstat --pretty="%cE" | sed '"'"'s/\(.*\)@.*/\1/'"'"' | grep -v "^$" | awk '"'"'BEGIN { line=""; } !/^ / { if (line=="" || !match(line, $0)) {line = $0 "," line }} /^ / { print line " # " $0; line=""}'"'"' | sort | sed -E '"'"'s/# //;s/ files? changed,//;s/([0-9]+) ([0-9]+ deletion)/\1 0 insertions\(+\), \2/;s/\(\+\)$/\(\+\), 0 deletions\(-\)/;s/insertions?\(\+\), //;s/ deletions?\(-\)//'"'"' | awk '"'"'BEGIN {name=""; files=0; insertions=0; deletions=0;} {if ($1 != name && name != "") { print name ": " files " files changed, " insertions " insertions(+), " deletions " deletions(-), " insertions-deletions " net"; files=0; insertions=0; deletions=0; name=$1; } name=$1; files+=$2; insertions+=$3; deletions+=$4} END {print name ": " files " files changed, " insertions " insertions(+), " deletions " deletions(-), " insertions-deletions " net";}'"'"''

alias sshprod="ssh root@prod"
alias sshdev="ssh ludo@62.210.78.111"
alias sshdevroot="ssh root@62.210.78.111"
alias sshramuh="ssh root@ramuh"
alias removeconsole="grep -lrZ '^\s*console' src/ | xargs -0 -l sed -i -e 's#^\(\s*\)console#\1//console#g' && git diff"
alias deploy_frontend="rsync -e ssh -avz bin/ root@ramuh:/var/www/www.osculteo.com/bin/"
alias deploy_backend="rsync -e ssh -avz bin/ root@ramuh:/var/www/backoffice.osculteo.com/bin/"
#alias deploy_connot="rsync -e ssh -avz ~/Projects/GoogleConnot/templates/* root@ramuh:/var/www/backoffice.osculteo.com/bin/assets/connot/templates;rsync -e ssh -avz ~/Projects/GoogleConnot/css/* root@ramuh:/var/www/backoffice.osculteo.com/bin/assets/connot/;cp  ~/Projects/GoogleConnot/src/* /home/loodub/.mozilla/firefox/ip0j6j0o.default/gm_scripts/Google_connot"
alias deploy_connot="rsync -e ssh -avz ~/Projects/GoogleConnot/templates/* root@ramuh:/var/www/backoffice.osculteo.com/bin/assets/connot/templates;rsync -e ssh -avz ~/Projects/GoogleConnot/css/* root@ramuh:/var/www/backoffice.osculteo.com/bin/assets/connot/;chmod 644 ~/Projects/GoogleConnot/build/*;rsync -e ssh -avz ~/Projects/GoogleConnot/build/*  root@ramuh:/var/www/backoffice.osculteo.com/bin/assets/connot/;rsync -e ssh -avz ~/Projects/GoogleConnot/templates/* ~/Projects/osculteo-backoffice/src/assets/connot/templates;rsync -e ssh -avz ~/Projects/GoogleConnot/css/* ~/Projects/osculteo-backoffice/src/assets/connot/;chmod 644 ~/Projects/GoogleConnot/build/*;rsync -e ssh -avz ~/Projects/GoogleConnot/build/*  ~/Projects/osculteo-backoffice/src/assets/connot/"
alias gti="git"
alias grutn="grunt"
alias rm="echo 'Sent to trash, (trash-list and trash-restore to restore)';trash-put -v"
alias django-clear-migrations="rm -rf tagcloud/migrations/0* && rm -rf osculteo/migrations/0* && rm -rf payment/migrations/0* && rm -rf authentication/migrations/0*"
alias django-migrate-requirements="pip install -r requirements.txt && ./manage.py makemigrations osculteo payment tagcloud authentication && ./manage.py migrate && ./manage.py load_fixtures && ./manage.py install_phantomjs && ./manage.py install_chromedriver"
alias django-start-api="./manage.py redis_build_conf && ./manage.py rabbitmqctl restart && ./manage.py redisctl stop && ./manage.py redisctl start && ./manage.py celeryctl restart w1 w2 && ./manage.py runserver_plus"
alias ve="source /home/loodub/Projects/v_env/bin/activate"
alias cp_ppt_from_vm="cp ~/Downloads/template-devis-2016-part*.pptx ~/Projects/api/lib/PPTXRenderer/templates/"
alias scp_ppt_from_repo="scp ~/Projects/api/lib/PPTXRenderer/templates/template-devis-2016-part* root@prod:/var/www/cop1/iproteg/iprotego/api-recipe/lib/PPTXRenderer/templates/"
alias vim="vim -p"
