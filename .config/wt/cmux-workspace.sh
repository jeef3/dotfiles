#!/usr/bin/env bash
set -euo pipefail

ws=$(cmux layout open user-portal --cwd "$WT_WORKTREE_PATH" --focus true --json | jq -r '.workspace_ref')
cmux workspace rename "$ws" --title "$WT_BRANCH"

group=$(cmux workspace-group list --json |
  jq -er '[.groups[] | select(.name == "User Portal")] |
    if length == 1 then .[0].ref else error("expected exactly one User Portal group") end')
cmux workspace-group add --group "$group" --workspace "$ws"

ws_id=$(cmux workspace list --json | jq -r --arg ref "$ws" '.workspaces[] | select(.ref == $ref) | .id')

(
  cd "$WT_WORKTREE_PATH"
  # Prefer the PR title if a PR exists; otherwise ask an AI to summarise the branch.
  desc=$(gh pr view --json title -q .title 2>/dev/null) || desc=$(
    {
      git log --oneline origin/master..HEAD
      git diff --stat origin/master...HEAD
    } |
      copilot -p "In under 12 words, describe what this branch is working on: $(cat)" -s 2>/dev/null
  )
  [ -n "$desc" ] && cmux workspace-action --workspace "$ws_id" --action set-description --description "$desc"
) >/dev/null 2>&1 &
disown
