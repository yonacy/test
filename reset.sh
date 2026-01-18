#!/bin/bash

echo"🛑 Killing CrossOver..."
pkill CrossOver && echo"✅ CrossOver processes killed."

echo"🕒 Setting new trial time..."
DATETIME=$(date -u -v -3H '+%Y-%m-%dT%TZ')
echo"✅ New trial date: ${DATETIME}"

defaults write com.codeweavers.CrossOver FirstRunDate -date"${DATETIME}"
defaults write com.codeweavers.CrossOver SULastCheckTime -date"${DATETIME}"
killall cfprefsd

echo"🧹 Cleaning bottle flags..."
find "$HOME/Library/Application Support/CrossOver/Bottles" -type f \( -name ".eval" -o -name ".update-timestamp" \) -execrm -f "{}" +

echo"🧽 Cleaning cxoffice registry block..."
find "$HOME/Library/Application Support/CrossOver/Bottles" -name system.reg -exec sed -i '''/cxoffice/{N;N;N;N;d;}' {} \;

echo"🚀 Restarting CrossOver..."
CO_APP_PATH="/Applications/CrossOver.app/Contents/MacOS"
"$CO_APP_PATH/CrossOver" >> /tmp/co_log.log 2>&1 &

echo "🎉 Done! Trial reset applied successfully."
