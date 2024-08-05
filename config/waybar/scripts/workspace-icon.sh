#!/bin/bash

#Check for open windows in each worspace

workspace_icons() {
  
  #Get the list of all workspaces amd their statues
  workspaces=$(hyprctl workspaces)

  #Define icons
  default_icon=""
  active_icon="󰮯"
  urgent_icon="󰊠"
  in_use_icon=""

  output=""

  #Parse the workspaces and their statuses
  while IFS= read -r workspace; do
    if [[ "$workspace" == *"active" ]]; then
      icon="$active_icon"
    elif [[ "$workspace" == *"urgent" ]]; then
      icon="$urgent_icon"
    elif [[ "$workspace" == *"in_use" ]]; then
      icon="$in_use_icon"
    else
      icon="$default_icon"
    fi
    output+="$icon"
  done <<< "$workspaces"

  echo "$output"

}

workspace_icons
