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
  if pr_body=$(gh pr view --json body -q .body 2>/dev/null) && [ -n "$pr_body" ]; then
    desc=$(
      printf '%s\n' "$pr_body" |
        sed -E 's/[A-Z][A-Z0-9]+-[0-9]+//g' |
        copilot -p "In under 12 words, summarize this PR description. Exclude Jira ticket markers: $(cat)" -s 2>/dev/null |
        sed -E 's/[A-Z][A-Z0-9]+-[0-9]+//g'
    )
  else
    desc=$(
      {
        git log --oneline origin/master..HEAD
        git diff --stat origin/master...HEAD
      } |
        copilot -p "In under 12 words, describe what this branch is working on. Exclude Jira ticket markers: $(cat)" -s 2>/dev/null |
        sed -E 's/[A-Z][A-Z0-9]+-[0-9]+//g'
    )
  fi
  [ -n "$desc" ] && cmux workspace-action --workspace "$ws_id" --action set-description --description "$desc"
) >/dev/null 2>&1 &
disown
