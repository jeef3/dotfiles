#!/usr/bin/env bash

SESSION_NAME="Workspace"

# Check if the session already exists
/opt/homebrew/bin/tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? -eq 0 ]; then
  # If the session exists, reattach to it
  /opt/homebrew/bin/tmux attach-session -t $SESSION_NAME
else
  # If the session doesn't exist, start a new one
  /opt/homebew/bin/tmux new-session -s $SESSION_NAME -d
  /opt/homebew/bin/tmux attach-session -t $SESSION_NAME
fi
