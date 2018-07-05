alias ll="ls -al"
if [ -f ~/my-tools/search/conf ]; then
    . ~/my-tools/search/conf
fi

alias s_file="~/my-tools/search/srchfile"
alias open_all="~/my-tools/search/open_all"
alias replace_all="~/my-tools/search/replace"
alias s_fct="~/my-tools/search/srchfct"
alias s_str="~/my-tools/search/srch"
alias ngpy="~/my-tools/generator/angular/ng.py"

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
alias arch-update="yaourt -Syua --devel --noconfirm"
#alias win="sudo mount -t vboxsf partage ~/win"

alias sync_gulpfiles="cd gulpfiles && git stash && git pull origin master && cd -"
alias update_gulpfiles="sync_gulpfiles && git commit gulpfiles -m 'Update gulpfiles'"
alias update_all_gulpfiles="CURRENT=$(pwd); for i in $(find ./**/* -maxdepth 0 -name "gulpfiles" | cut -c 3-);do cd $i;cd ..;update_gulpfiles;cd $CURRENT;done;"
alias status_all_gulpfiles="CURRENT=$(pwd); for i in $(find ./**/* -maxdepth 0 -name "gulpfiles" | cut -c 3-);do cd $i;cd ..;git status;cd $CURRENT;done;"

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
alias django-clear-migrations="rm -f */migrations/0*"
alias django-migrate-requirements="pip install -r requirements.txt && ./manage.py makemigrations && ./manage.py migrate && ./manage.py load_initial_data && ./manage.py load_fixtures && ./manage.py install_phantomjs && ./manage.py install_chromedriver"
alias django-restart-rabbit="docker ps;docker stop docker_rabbit;docker rm docker_rabbit;docker run -d --hostname my-rabbit --name docker_rabbit -p 5672:5672 -e RABBITMQ_DEFAULT_USER=osculteo_ng -e RABBITMQ_DEFAULT_PASS=yfT4D8Hu -e RABBITMQ_DEFAULT_VHOST=osculteo_ng rabbitmq:3.6.12"
alias django-restart-workers="./manage.py celeryctl stop w1 w2 && ./manage.py celeryctl start w1 w2"
alias django-restart-redis="./manage.py redisctl stop && ./manage.py redis_build_conf && ./manage.py redisctl start"
alias django-restart-api="django-restart-rabbit && django-restart-redis && django-restart-workers && ./manage.py runserver 0.0.0.0:8000"
alias django-restart-all="./manage.py reset_db --noinput;django-clear-migrations;django-migrate-requirements;django-admin compilemessages;django-restart-api;"
alias dc-up="docker-compose up --scale worker=2"
alias dc-shell="docker-compose run web python manage.py shell_plus"
alias dc-load-data="docker-compose run web bash -c \"python manage.py load_initial_data && python manage.py load_fixtures\""
alias dc-migrate="docker-compose run web bash -c \"python manage.py migrate\""
alias dc-make-migrate="dc-reset-db && django-clear-migrations && docker-compose run web bash -c \"python manage.py makemigrations\""
alias dc-reset-db="docker-compose run web bash -c \"python manage.py reset_db --noinput\""
alias dc-rebuild="docker build -f dev_env/Dockerfile.test_workers -t registry.osculteo.com/nicolas/api_ng:worker-dev-env . && docker build -f dev_env/Dockerfile.test_env -t registry.osculteo.com/nicolas/api_ng:dev-env ."
alias dc-reset-all="dc-rebuild && dc-make-migrate && dc-migrate && dc-load-data && dc-up"
alias ve="source /home/loodub/Projects/v_env/bin/activate"
alias cp_ppt_from_vm="cp ~/Downloads/template-devis-2016-part*.pptx ~/Projects/api/lib/PPTXRenderer/templates/"
alias scp_ppt_from_repo="scp ~/Projects/api/lib/PPTXRenderer/templates/template-devis-2016-part* root@prod:/var/www/cop1/iproteg/iprotego/api-recipe/lib/PPTXRenderer/templates/"
alias vim="vim -p"
alias git-tag-demo="git tag -d demo;git push --tags origin :refs/tags/demo;git tag -a demo -m demo;git push --tags origin master;"
