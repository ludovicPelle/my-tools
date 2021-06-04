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

alias vim="vim -p"

#git
alias gti="git"
alias gitpulse='git log --shortstat --pretty="%cE" | sed '"'"'s/\(.*\)@.*/\1/'"'"' | grep -v "^$" | awk '"'"'BEGIN { line=""; } !/^ / { if (line=="" || !match(line, $0)) {line = $0 "," line }} /^ / { print line " # " $0; line=""}'"'"' | sort | sed -E '"'"'s/# //;s/ files? changed,//;s/([0-9]+) ([0-9]+ deletion)/\1 0 insertions\(+\), \2/;s/\(\+\)$/\(\+\), 0 deletions\(-\)/;s/insertions?\(\+\), //;s/ deletions?\(-\)//'"'"' | awk '"'"'BEGIN {name=""; files=0; insertions=0; deletions=0;} {if ($1 != name && name != "") { print name ": " files " files changed, " insertions " insertions(+), " deletions " deletions(-), " insertions-deletions " net"; files=0; insertions=0; deletions=0; name=$1; } name=$1; files+=$2; insertions+=$3; deletions+=$4} END {print name ": " files " files changed, " insertions " insertions(+), " deletions " deletions(-), " insertions-deletions " net";}'"'"''

#Javascript
alias removeconsole="grep -lrZ '^\s*console' src/ | xargs -0 -l sed -i -e 's#^\(\s*\)console#\1//console#g' && git diff"

#Python
alias ve="source $HOME/Projects/v_env/bin/activate"
