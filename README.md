# claude-workflow

Shared Claude Code rules for my projects: one branch and squash-merged PR per ticket, Conventional Commit titles, ponytail review, and SemVer releases from git tags.

## Use in a project

The repo is a Claude Code plugin marketplace with one plugin, `workflow-rules`. Its `SessionStart` hook prints `workflow.md` into every session, local or remote.

1. Commit this to the project's `.claude/settings.json`, so every local session on the repo installs the plugins the rules rely on (for cloud sessions, see [Cloud sessions](#cloud-sessions)):

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

### Cloud sessions

Cloud sessions (claude.ai/code, `claude --cloud`) don't install plugins from a repo's `.claude/settings.json`. Add this as the setup script of your cloud environment instead. It runs before Claude Code starts, and its result is cached:

```bash
#!/bin/bash
claude plugin marketplace add mattpocock/skills
claude plugin marketplace add DietrichGebert/ponytail
claude plugin marketplace add simonrenlund/claude-workflow
claude plugin install mattpocock-skills@mattpocock
claude plugin install ponytail@ponytail
claude plugin install workflow-rules@claude-workflow
```

The script needs this repo to stay public. A local session reached through Remote Control needs none of this.

## Updating

Change `workflow.md` through a PR, like any other change. To ship it, open a `chore: release vX.Y.Z` PR that bumps `version` in `.claude-plugin/plugin.json`, and tag after it merges. Installed copies pick it up with `/plugin marketplace update claude-workflow`. Cloud environments keep their cached copy until the setup script runs again: when you edit the script, or when the cache expires after about seven days.
