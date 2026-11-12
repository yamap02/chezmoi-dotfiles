#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Brave (debug port 9222)
# @raycast.mode silent
# @raycast.packageName Brave
# @raycast.icon 🦁
# @raycast.description デバッグポート9222付きで専用プロファイルのBraveを起動する

open -a "Brave Browser" --args --remote-debugging-port=9222 --user-data-dir="$HOME/.brave-debug"
