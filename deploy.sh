#!/bin/bash
if [ -z $1 ]; then
  echo "Pas de selection! ";
  exit;
fi

for dir in `find $1 -maxdepth 0 -name '.git' -prune -o -type d -print`; do
  if [ -x "$dir/_scripts/install.sh" ]; then
    cd $dir       # go to the "module" dir
    ./_scripts/install.sh  # install it
    cd ..         # go back to the "modules" repository
  fi
done
