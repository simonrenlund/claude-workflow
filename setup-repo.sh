#!/usr/bin/env bash
# Apply the workflow's GitHub settings to a repo: squash-only merges, PR title/body
# as the squash commit, auto-delete merged branches, and the triage labels.
# Usage: setup-repo.sh [owner/repo]   (defaults to the repo of the current directory)
set -euo pipefail

repo="${1:-$(gh repo view --json nameWithOwner --jq .nameWithOwner)}"

gh repo edit "$repo" --enable-squash-merge --enable-merge-commit=false \
  --enable-rebase-merge=false --delete-branch-on-merge
gh api -X PATCH "repos/$repo" --silent \
  -f squash_merge_commit_title=PR_TITLE -f squash_merge_commit_message=PR_BODY

for label in needs-triage needs-info ready-for-agent ready-for-human wontfix; do
  gh label create "$label" --repo "$repo" --force >/dev/null
done

echo "Configured $repo"
