alias ls="ls -G"
alias ll="ls -al"

#Trash rm
alias trm="echo 'Sent to trash, (trash-list and trash-restore to restore)';trash-put -v"

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
if [ -f ~/my-tools/search/conf ]; then
    . ~/my-tools/search/conf
fi

alias grepfile="~/my-tools/search/srchfile"
alias openall="~/my-tools/search/open_all"
alias replace="~/my-tools/search/replace"
alias grepfct="~/my-tools/search/srchfct"
alias grepstr="~/my-tools/search/srch"

#alias gen-gh-pages="~/my-tools/git/create-gh-pages"
#alias upd-gh-pages="~/my-tools/git/github/update-gh-pages"
alias arch-update="yaourt -Syua --noconfirm"
alias arch-update-devel="yaourt -Syua --devel --noconfirm"
#alias win="sudo mount -t vboxsf partage ~/win"


alias vim="vim -p"

#git
alias gti="git"
alias gitpulse='git log --shortstat --pretty="%cE" | sed '"'"'s/\(.*\)@.*/\1/'"'"' | grep -v "^$" | awk '"'"'BEGIN { line=""; } !/^ / { if (line=="" || !match(line, $0)) {line = $0 "," line }} /^ / { print line " # " $0; line=""}'"'"' | sort | sed -E '"'"'s/# //;s/ files? changed,//;s/([0-9]+) ([0-9]+ deletion)/\1 0 insertions\(+\), \2/;s/\(\+\)$/\(\+\), 0 deletions\(-\)/;s/insertions?\(\+\), //;s/ deletions?\(-\)//'"'"' | awk '"'"'BEGIN {name=""; files=0; insertions=0; deletions=0;} {if ($1 != name && name != "") { print name ": " files " files changed, " insertions " insertions(+), " deletions " deletions(-), " insertions-deletions " net"; files=0; insertions=0; deletions=0; name=$1; } name=$1; files+=$2; insertions+=$3; deletions+=$4} END {print name ": " files " files changed, " insertions " insertions(+), " deletions " deletions(-), " insertions-deletions " net";}'"'"''

alias sshprod="ssh root@prod"
alias sshdev="ssh ludo@62.210.78.111"
alias sshdevroot="ssh root@62.210.78.111"
alias sshramuh="ssh root@ramuh"

#Javascript
alias removeconsole="grep -lrZ '^\s*console' src/ | xargs -0 -l sed -i -e 's#^\(\s*\)console#\1//console#g' && git diff"
#gulpfiles
alias sync_gulpfiles="cd gulpfiles && git stash && git pull origin master && cd -"
alias update_gulpfiles="sync_gulpfiles && git commit gulpfiles -m 'Update gulpfiles'"
alias update_all_gulpfiles="CURRENT=$(pwd); for i in $(find ./**/* -maxdepth 0 -name "gulpfiles" | cut -c 3-);do cd $i;cd ..;update_gulpfiles;cd $CURRENT;done;"
alias status_all_gulpfiles="CURRENT=$(pwd); for i in $(find ./**/* -maxdepth 0 -name "gulpfiles" | cut -c 3-);do cd $i;cd ..;git status;cd $CURRENT;done;"

alias deploy_frontend="rsync -e ssh -avz bin/ root@ramuh:/var/www/www.osculteo.com/bin/"
alias deploy_backend="rsync -e ssh -avz bin/ root@ramuh:/var/www/backoffice.osculteo.com/bin/"
#alias deploy_connot="rsync -e ssh -avz ~/Projects/GoogleConnot/templates/* root@ramuh:/var/www/backoffice.osculteo.com/bin/assets/connot/templates;rsync -e ssh -avz ~/Projects/GoogleConnot/css/* root@ramuh:/var/www/backoffice.osculteo.com/bin/assets/connot/;cp  ~/Projects/GoogleConnot/src/* /home/loodub/.mozilla/firefox/ip0j6j0o.default/gm_scripts/Google_connot"
alias deploy_connot="rsync -e ssh -avz ~/Projects/GoogleConnot/templates/* root@ramuh:/var/www/backoffice.osculteo.com/bin/assets/connot/templates;rsync -e ssh -avz ~/Projects/GoogleConnot/css/* root@ramuh:/var/www/backoffice.osculteo.com/bin/assets/connot/;chmod 644 ~/Projects/GoogleConnot/build/*;rsync -e ssh -avz ~/Projects/GoogleConnot/build/*  root@ramuh:/var/www/backoffice.osculteo.com/bin/assets/connot/;rsync -e ssh -avz ~/Projects/GoogleConnot/templates/* ~/Projects/osculteo-backoffice/src/assets/connot/templates;rsync -e ssh -avz ~/Projects/GoogleConnot/css/* ~/Projects/osculteo-backoffice/src/assets/connot/;chmod 644 ~/Projects/GoogleConnot/build/*;rsync -e ssh -avz ~/Projects/GoogleConnot/build/*  ~/Projects/osculteo-backoffice/src/assets/connot/"

#Python
alias ve="source /home/loodub/Projects/v_env/bin/activate"
alias django-clear-migrations="rm -f */migrations/0*"
alias django-migrate-requirements="pip install -r requirements.txt && ./manage.py makemigrations && ./manage.py migrate && ./manage.py load_initial_data && ./manage.py load_fixtures && ./manage.py install_phantomjs && ./manage.py install_chromedriver"
alias django-restart-rabbit="docker ps;docker stop docker_rabbit;docker rm docker_rabbit;docker run -d --hostname my-rabbit --name docker_rabbit -p 5672:5672 -e RABBITMQ_DEFAULT_USER=osculteo_ng -e RABBITMQ_DEFAULT_PASS=yfT4D8Hu -e RABBITMQ_DEFAULT_VHOST=osculteo_ng rabbitmq:3.6.12"
alias django-restart-workers="./manage.py celeryctl stop w1 w2 && ./manage.py celeryctl start w1 w2"
alias django-restart-redis="./manage.py redisctl stop && ./manage.py redis_build_conf && ./manage.py redisctl start"
alias django-restart-api="django-restart-rabbit && django-restart-redis && django-restart-workers && ./manage.py runserver 0.0.0.0:8000"
alias django-restart-all="./manage.py reset_db --noinput;django-clear-migrations;django-migrate-requirements;django-admin compilemessages;django-restart-api;"

#Docker
alias dc-up="dc-down && docker-compose up --scale worker=2"
alias dc-down="docker-compose down"
alias dc-test="docker-compose run web python manage.py test -v 2"
alias dc-clean='docker stop $(docker ps -aq)\" ||  docker rm $(docker ps -aq) || docker rmi $(docker images | awk "/^<none/ {print $3}" | xargs)'
alias dc-shell="docker-compose run web python manage.py shell_plus"
alias dc-load-data="docker-compose run web bash -c \"python manage.py load_initial_data && python manage.py load_fixtures && python manage.py load_web_categories && python manage.py create_agency\""
alias dc-migrate="docker-compose run web bash -c \"python manage.py migrate\""
alias dc-make-migrate="docker-compose run web bash -c \"python manage.py makemigrations\""
alias dc-reset-db="docker-compose run web bash -c \"python manage.py reset_db --noinput --close-sessions\""
alias dc-rebuild="dc-clean && docker build -f dev_env/Dockerfile.test_workers -t registry.osculteo.com/nicolas/api_ng:worker-dev-env . && docker build -f dev_env/Dockerfile.test_env -t registry.osculteo.com/nicolas/api_ng:dev-env ."
alias dc-reset-all="dc-clean || dc-reset-db && dc-make-migrate && dc-migrate && dc-load-data && dc-up"

#Dev env
alias launchAll="mate-terminal --tab --title=API -e \"bash -c 'cd ~/Projects/api_ng/ &&  docker-compose up';bash\" && mate-terminal --tab --title=NG -e \"bash -c 'cd ~/Projects/osculteo-ng && gulp serve-dev --env env_local.json';bash\" && mate-terminal --tab --title=BO -e \"bash -c 'cd ~/Projects/backoffice-ng && gulp serve-dev --env env_local.json;bash'\" && mate-terminal --tab --title=CONNOT -e \"bash -c 'cd ~/Projects/connoter-ng/ && npm run start';bash\" && mate-terminal --tab --title=NGROK -e \"bash -c 'cd ~/Projects/api_ng/ && ngrok http 8080'; bash\""
alias launchDev="cd ~/Projects/osculteo-ng; mate-terminal --tab --title=API -e \"bash -c 'cd ~/Projects/api_ng/;bash'\" && mate-terminal --tab --title=BO -e \"bash -c 'cd ~/Projects/backoffice-ng; bash'\" && mate-terminal --tab --title=CONNOT -e \"bash -c 'cd ~/Projects/connoter-ng/; bash'\""

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
