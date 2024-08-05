#!/usr/bin/env bash

THEME_DIR="$HOME/.config/waybar/colorschemes"

case $1 in 
        waybar -s "$THEME_DIR/catppuccin-mocha.css"
        ;;
esac
