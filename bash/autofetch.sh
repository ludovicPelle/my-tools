#!/bin/bash

function pull() {
    if [`git status | grep -q "nothing"` ]; then
        git pull && watch $1
    else
        git stash && git pull && git stash apply && watch $1
    fi
}

function watch() {
    if [ -z $1 ]; then
        echo "NO HOOK SPCIFIED"
    else
        eval "$1";
    fi
    while [ ! `git status | grep -q "Your branch is up to date"` ]; do

        echo -n "."

        sleep 5;
    done;
    echo "HAVE TO UPDATE $(date | awk '{print $5}')"
    git status;
    pull $1;
}

watch $1
