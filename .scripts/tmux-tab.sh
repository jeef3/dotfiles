#!/usr/bin/env bash

source $(dirname "$0")/../setup/color.sh

while [ ! -z "$1"  ]; do
  case "$1" in
    --active)
      shift
      IS_ACTIVE=1
      ;;
    *)
  esac
  shift
done

if [ $IS_ACTIVE -eq 1 ]; then
  echo "#[fg=$PURPLE_500]#[bold]#I #W #[default]"
else
  echo "#[fg=$SILVER_500]#I #W #[default]"
fi
