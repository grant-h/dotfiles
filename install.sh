#!/bin/sh

# Configuration variables
DRYRUN=0

prompt()
{
  while true; do
    read -p "$1 (y/n): " CHOICE
    case $CHOICE in
      y|Y|yes) return 1 ;;
      n|N|no) return 0 ;;
      *) echo "Invalid choice" ;;
    esac
  done

  return $RET
}

install_dotfile()
{
  SRC=$1
  DST=$2
  
  echo "Linking $DST -> $SRC..."

  if [ $DRYRUN = 0 ]; then
    ln -s "$SRC" "$DST"
  fi
}

install_dotdir()
{
  SRC=$1
  DST=$2

  echo "Linking directory $DST -> $SRC..."

  if [ $DRYRUN = 0 ]; then
    ln -s "$SRC" "$DST"
  fi
}

remove()
{
  FILE=$1
  echo "Removing $FILE"

  if [ $DRYRUN = 0 ]; then
    rm "$FILE"
  fi
}

remove()
{
  DIR=$1
  echo "Removing directory $DIR"

  if [ $DRYRUN = 0 ]; then
    rm -r "$DIR"
  fi
}

find_ignore()
{
  RET=""
  while true; do
    if [ $# -le 0 ]; then
      break
    fi

    RET="$RET"' -and ! -name '"$1"
    shift
  done
}

echo "~~~ Grant-H Dotfiles installer ~~~"
if [ $(basename $PWD) != "dotfiles" ]; then
  echo "$0: must be run from dotfiles directory"
  exit 1
fi

while getopts "nh" o; do
  case "$o" in
    n) DRYRUN=1;;
    ?|h) echo "Usage: $0 [-n dry-run]"; exit 1;;
  esac
done

# get all dotfiles and dot dirs
find_ignore README.md install.sh
DOTFILES=$(find . -maxdepth 1 \( -type f -and \! -iname '.*' $RET \))

find_ignore .git old
DOTDIRS=$(find . -maxdepth 1 \( -type d -and \! -iname '.*' $RET \))

if [ $DRYRUN = 1 ]; then
  prompt "Install files (dry-run)?"
else
  prompt "Install files?"
fi

if [ $? != 1 ]; then
  exit 0
fi

for f in $DOTFILES; do
  base=$(basename "$f")
  DST="$HOME/.$base"
  SRC="$PWD/$base"
  base="."$base

  if [ -e "$DST" ]; then
    if [ -L "$DST" ]; then
      echo "Skipping already linked file $base"
      continue
    else
      prompt "Would you like to overwrite existing dotfile $base"

      if [ $? != 1 ]; then
	echo "Not overwriting existing dotfile $base"
        continue
      fi

      remove "$DST"
    fi
  fi

  install_dotfile "$SRC" "$DST"
done

for f in $DOTDIRS; do
  base=$(basename "$f")
  DST="$HOME/.$base"
  SRC="$PWD/$base"
  base="."$base

  if [ -e "$DST" ]; then
    if [ -L "$DST" ]; then
      echo "Skipping already linked directory $base"
      continue
    else
      prompt "Would you like to overwrite existing dotdirectory $base"

      if [ $? != 1 ]; then
	echo "Not overwriting existing dotdirectory $base"
        continue
      fi

      remove_dir "$DST"
    fi
  fi

  install_dotdir "$SRC" "$DST"
done
