#!/bin/sh

swaymsg input $(swaymsg -t get_inputs --raw | jq '[.[] | select(.type == "keyboard")][0] | .identifier') xkb_switch_layout next

VALUE=$(swaymsg -t get_inputs --raw | gron | grep xkb_active_layout_name | sed 's/.*"\(.*\)";/\1/' | head -n 1 )

notify-send \
    --expire-time 800 \
    --hint "int:transient:1" \
    --category "hud" \
    "Keyboard" \
    "Current layout: <b>󰌌  ${VALUE}</b>"
