alias ls='ls --color=auto'
# verbose ls
alias ll="ls -al"
# sort by filesize
alias lz='ls --human-readable --size -1 -S --classify'
#
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

#verbose report file system disk space usage
alias df="df -Tha --total"

#List file/dir size
alias du="du -ach"
alias dus="du | sort -h"

#verbose free
alias free="free -mt"

# verbose ps
alias ps="ps auxf"

# find process | grep
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

# mkdir recursive
alias mkdir="mkdir -pv"
# Easy unzip/tar/etc
function extract {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
        return 1
    else
        for n in $@
        do
            if [ -f "$n" ] ; then
                case "${n%,}" in
                    *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                        tar xvf "$n"       ;;
                    *.lzma)      unlzma ./"$n"      ;;
                    *.bz2)       bunzip2 ./"$n"     ;;
                    *.rar)       unrar x -ad ./"$n" ;;
                    *.gz)        gunzip ./"$n"      ;;
                    *.zip)       unzip ./"$n"       ;;
                    *.z)         uncompress ./"$n"  ;;
                    *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                        7z x ./"$n"        ;;
                    *.xz)        unxz ./"$n"        ;;
                    *.exe)       cabextract ./"$n"  ;;
                    *)
                        echo "extract: '$n' - unknown archive method"
                        return 1
                        ;;
                esac
            else
                echo "'$n' - file does not exist"
                return 1
            fi
        done
        fi
    }
function cd() {
    new_directory="$*";
    if [ $# -eq 0 ]; then
        new_directory=..;
    fi;
    builtin cd "${new_directory}" && ls
}
#score command hit ^^
alias scorehistory="history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] \" \" CMD[a]/count*100 \"% \" a;}' | grep -v \"./\" | column -c3 -s \" \" -t | sort -nr | nl |  head -n10"
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
alias arch-light-update="sudo pacman -Syu"
alias arch-update="yay"
alias arch-update-devel="yay -Syu --devel --timeupdate"
#alias win="sudo mount -t vboxsf partage ~/win"

# open glob pattern as tabs (not buffer)
alias vim="vim -p"
alias gim="vim \$(git status --short | awk '{print \$2}')"
alias commit="for file in \$(git status -s | awk '/^ M|A/{print \$2}'); do git dsf $file; read -p 'What have you do?: ' msg; git commit $file -m '$msg'; done;"

#git
alias gti="git"

#git activity report
alias gitpulse='git log --shortstat --pretty="%cE" | sed '"'"'s/\(.*\)@.*/\1/'"'"' | grep -v "^$" | awk '"'"'BEGIN { line=""; } !/^ / { if (line=="" || !match(line, $0)) {line = $0 "," line }} /^ / { print line " # " $0; line=""}'"'"' | sort | sed -E '"'"'s/# //;s/ files? changed,//;s/([0-9]+) ([0-9]+ deletion)/\1 0 insertions\(+\), \2/;s/\(\+\)$/\(\+\), 0 deletions\(-\)/;s/insertions?\(\+\), //;s/ deletions?\(-\)//'"'"' | awk '"'"'BEGIN {name=""; files=0; insertions=0; deletions=0;} {if ($1 != name && name != "") { print name ": " files " files changed, " insertions " insertions(+), " deletions " deletions(-), " insertions-deletions " net"; files=0; insertions=0; deletions=0; name=$1; } name=$1; files+=$2; insertions+=$3; deletions+=$4} END {print name ": " files " files changed, " insertions " insertions(+), " deletions " deletions(-), " insertions-deletions " net";}'"'"''

#Javascript
alias removeconsole="grep -lrZ '^\s*console' src/ | xargs -0 -l sed -i -e 's#^\(\s*\)console#\1//console#g' && git diff"
#gulpfiles
alias sync_gulpfiles="cd gulpfiles && git stash && git pull origin master && cd -"
alias update_gulpfiles="sync_gulpfiles && git commit gulpfiles -m 'Update gulpfiles'"
alias update_all_gulpfiles="CURRENT=$(pwd); for i in $(find ./**/* -maxdepth 0 -name "gulpfiles" | cut -c 3-);do cd $i;cd ..;update_gulpfiles;cd $CURRENT;done;"
alias status_all_gulpfiles="CURRENT=$(pwd); for i in $(find ./**/* -maxdepth 0 -name "gulpfiles" | cut -c 3-);do cd $i;cd ..;git status;cd $CURRENT;done;"

#Python
alias ve="source /home/loodub/Projects/v_env/bin/activate"

#Docker
alias dc-up="dc-down && docker-compose up --scale worker=2"
alias dc-down="docker-compose down"
alias dc-test="docker-compose run web python manage.py test -v 2"
alias dc-stop="if [ \$(docker ps -aq | wc -l) -gt 0 ]; then echo 'STOP DOCKERS'; docker stop \$(docker ps -aq); else echo 'No docker to stop'; fi"
alias dc-rm="if [ \$(docker ps -aq | wc -l) -gt 0 ]; then echo 'REMOVE DOCKERS'; docker rm \$(docker ps -aq); else echo 'No docker to rm';fi"
alias dc-rmi="if [ \$(docker images | awk '/^<none/ {print $3}' | wc -l) -gt 0 ]; then echo 'REMOVE DOCKERS IMAGES'; docker rmi \$(docker images | awk '/^<none/ {print $3}' | xargs); else docker images; fi"
alias dc-clean="dc-stop && dc-rm && dc-rmi"
alias dc-shell="docker-compose run web python manage.py shell_plus"
alias dc-load-data="docker-compose run web bash -c \"python manage.py load_initial_data && python manage.py load_fixtures && python manage.py load_web_categories && python manage.py create_agency && python manage.py add_offers && python manage.py add_achievements && python manage.py add_real_quizzes && python manage.py create_b2b && python manage.py display_client_ids && python manage.py create_stripe_plans && python manage.py load_document_categories\""
alias dc-migrate="docker-compose run web bash -c \"python manage.py migrate\""
alias dc-make-migrate="docker-compose run web bash -c \"python manage.py makemigrations\""
alias dc-reset-db="docker-compose run web bash -c \"python manage.py reset_db --noinput --close-sessions\""
alias dc-rebuild="dc-clean && ./scripts/build_dev_images.sh"
alias dc-reset-all="dc-clean && dc-reset-db && dc-make-migrate && dc-migrate && dc-load-data && launchApi"
alias dc-bash="docker-compose run web bash"

#Dev env
alias launchApi="cd ~/Projects/api_ng/ && dc-stop && mate-terminal --tab --title=NGROK -e \"bash -c 'cd ~/Projects/api_ng/ && ngrok http 8080'; bash\" && sleep 2 && ./scripts/stripe_ngrok.sh && dc-up"
alias launchDev="cd ~/Projects/osculteo-ng; mate-terminal --tab --title=FWC -e \"bash -c 'cd ~/Projects/fwc;bash'\" && mate-terminal --tab --title=API -e \"bash -c 'cd ~/Projects/api_ng/;bash'\" && mate-terminal --tab --title=BO -e \"bash -c 'cd ~/Projects/backoffice-ng; bash'\""

alias launchClients="cd ~/Projects/osculteo-ng &&  mate-terminal --tab --title=FWC -e \"bash -c 'cd ~/Projects/fwc && gulp serve-dev --env env_fwc.json;bash'\" && mate-terminal --tab --title=CONNOTER -e \"bash -c 'cd ~/Projects/connoter-ng/ && npm start;bash'\" && mate-terminal --tab --title=BO -e \"bash -c 'cd ~/Projects/backoffice-ng && gulp serve-dev --env env_local.json; bash'\" && gulp serve-dev --env env_local.json;"
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
