#!/bin/sh
# Run or Show
# Tries to find specified window, if found, shows it from scratchpad
# If can't find, run it. May run with a st terminal.

# Usage:
# run_or_show.sh APP_ID COMMAND [term]
# Where
#   - APP_ID: app id of the program
#   - COMMAND: command to be run if program not found
#   - term: option paramenter, makes the command execute inside a terminal named with the appid

usage() { echo "Usage: $0 [-x] [-h] [-t title] [-i appid] [-c appclass] [command]" 1>&2; exit 1; }

while getopts "i:c:t:hx" opt; do
  case "${opt}" in
      x)
        term=true;;
      i)
        mode=id
        search=$OPTARG;;
      c)
        mode=class
        search=$OPTARG;;
      t)
        mode=title
        search=$OPTARG;;
      h)
        usage;;
  esac
done
shift $((OPTIND-1))
command="$*"

if [ -z "$mode" ]; then
    echo "Choose a mode, either -i or -c (id or class)"
    usage
fi

if [ -z "$command" ]; then
    echo "Inform a command"
    usage
fi

if [ "$mode" = "id" ]; then
    count=$(swaymsg -t get_tree | gron | grep "app_id = \"$search\"" | wc -l)
elif [ "$mode" = "class" ]; then
    count=$(swaymsg -t get_tree | gron | grep "window_properties\[\"class\"\] = \"$search\"" | wc -l)
elif [ "$mode" = "title" ]; then
    count=$(swaymsg -t get_tree | gron | grep "window_properties.title" | grep "$search" | wc -l)
fi

if [ "$count" -eq 0 ]; then
  if [ "$term" = true ]; then
    $TERM -a "$search" -- $command
  else
    $command
  fi
else
    if [ "$mode" = "id" ]; then
        swaymsg "[app_id=\"$search\"] scratchpad show"
    elif [ "$mode" = "class" ]; then
        swaymsg "[class=\"$search\"] scratchpad show"
    elif [ "$mode" = "title" ]; then
        swaymsg "[title=\"^.*$search.*$\"] scratchpad show"
    fi
fi