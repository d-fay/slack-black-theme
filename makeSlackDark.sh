#!/bin/bash

declare -ra LOCATIONS=(
   /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/index.js
   /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js
   /usr/lib/slack/resources/app.asar.unpacked/src/static/index.js
   /usr/lib/slack/resources/app.asar.unpacked/src/static/ssb-interop.js
)

declare -r REPO_DIRECTORY="${0%/*}"

for location in "${LOCATIONS[@]}"; do
   # check if location exists
   if [[ -e $location ]]; then
      # if so, make sure we can write to it
      if [[ -w $location ]]; then
         cat "${REPO_DIRECTORY}/static-css-injections.js" >>$location
      else
         # if we can't, probably needs sudo
         cat "${REPO_DIRECTORY}/static-css-injections.js" | sudo tee -a $location >/dev/null
      fi
   fi
done
