#!/bin/bash

# Update script

check_git() {
  git remote update
  # git reset --hard

  UPSTREAM='@{u}'
  LOCAL=$(git rev-parse '@')
  REMOTE=$(git rev-parse "$UPSTREAM")
  BASE=$(git merge-base '@' "$UPSTREAM")


  if [ $LOCAL = $REMOTE ]
  then
    echo "Repository is up to date."
    echo "Do nothing."
    exit 0
  elif [ $LOCAL = $BASE ]
  then
    echo "Need to pull."
    update_git
  elif [ $REMOTE = $BASE ]
  then
    echo "Need to push."
    echo "Do nothing."
    exit 0
  else
    echo "Diverged."
    echo "Do nothing."
    exit 0
  fi
}

update_git() {
    echo "Pulling newest version..."
    git pull
}



main() {
  cd $( cd $(dirname $0) && pwd )

  LEAVE=0
  while [ $LEAVE -eq 0 ]
  do
    read -p "Server services are going to be turned off during update. Continue? [y|n] " TEMP
    case $TEMP in
      [yY] | [yY][eE][sS])
        check_git
        source etc/update-helper.sh
        update
        LEAVE=1
        ;;
      [nN] | [nN][oO])
        LEAVE=1
        ;;
      *)
        :
        ;;
    esac
  done
}

main
