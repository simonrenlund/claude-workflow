# claude-workflow

Shared Claude Code rules for my projects: one branch and squash-merged PR per ticket, Conventional Commit titles, ponytail review, and SemVer releases from git tags.

## Use in a project

The repo is a Claude Code plugin marketplace with one plugin, `workflow-rules`. Its `SessionStart` hook prints `workflow.md` into every session, local or remote.

1. Commit this to the project's `.claude/settings.json`, so every session on the repo (including Claude Code on the web) installs the plugins the rules rely on:

   ```json
   {
     "extraKnownMarketplaces": {
       "mattpocock": { "source": { "source": "git", "url": "https://github.com/mattpocock/skills.git" } },
       "ponytail": { "source": { "source": "git", "url": "https://github.com/DietrichGebert/ponytail.git" } },
       "claude-workflow": { "source": { "source": "github", "repo": "simonrenlund/claude-workflow" } }
     },
     "enabledPlugins": {
       "mattpocock-skills@mattpocock": true,
       "ponytail@ponytail": true,
       "workflow-rules@claude-workflow": true
     }
   }
   ```

   To install it by hand instead: `/plugin marketplace add simonrenlund/claude-workflow`, then `/plugin install workflow-rules@claude-workflow`.
2. Clone this repo to `~/git/claude-workflow` (only needed for this script), then apply the GitHub settings and triage labels from inside the project:

   ```bash
   ~/git/claude-workflow/setup-repo.sh
   ```

The rules assume the project has run `/setup-matt-pocock-skills` with GitHub as its issue tracker.

Remote sessions can only fetch the marketplace while this repo is public.

## Updating

Change `workflow.md` through a PR, like any other change. To ship it, open a `chore: release vX.Y.Z` PR that bumps `version` in `.claude-plugin/plugin.json`, and tag after it merges. Installed copies pick it up with `/plugin marketplace update claude-workflow`.
