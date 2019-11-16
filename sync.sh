#!/bin/bash
#
# Copies selected files from the repository to the current user's home
# directory.

set -o errexit
set -o nounset

while (( "$#" )); do
  case "$1" in
    -v|--verbose)
      set -o xtrace
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
  .cargo/config
)

for f in ${FILES[*]} ; do
  dir=$(dirname $f)
  if [[ $dir != "." ]] ; then
    mkdir -p "~/$dir"
  fi
  cp $f ~/$f
done
