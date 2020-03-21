#!/bin/bash
#
# Copies selected files from the repository to the current user's home
# directory.
#
# Options:
# --verbose | -v : Echo commands.
# --reverse | -r : Instead copy files from home directory to the repo.

set -o errexit
set -o nounset

REV=0

while (( "$#" )); do
  case "$1" in
    -v|--verbose)
      set -o xtrace
      shift
      ;;
    -r|--reverse)
      REV=1
      shift
      ;;
    *) # unsupported flags or extra arguments.
      echo "Error: Bad arg $1" >&2
      exit 1
      ;;
  esac
done

FILES=(
  .gitconfig
  .tmux.conf
  .inputrc
  .rustfmt.toml
  .cargo/config
)

for f in ${FILES[*]} ; do
  if (( $REV )) ; then
    if test -f ~/$f ; then
      cp ~/$f $f
    else
      echo "~/$f doesn't exist." >&2
    fi
  else
    dir=$(dirname $f)
    if [[ $dir != "." ]] ; then
      mkdir -p "~/$dir"
    fi
    cp $f ~/$f
  fi
done
