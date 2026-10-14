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

   To install it by hand instead: `/plugin install workflow-rules --marketplace simonrenlund/claude-workflow`.
2. Apply the GitHub settings and triage labels from inside the project:

   ```bash
   ~/git/claude-workflow/setup-repo.sh
   ```

The rules assume the project has run `/setup-matt-pocock-skills` with GitHub as its issue tracker.

Remote sessions can only fetch the marketplace while this repo is public.

## Updating

Edit `workflow.md` here, bump `version` in `.claude-plugin/plugin.json`, and push. Installed copies pick up the change on the next plugin update (`/plugin marketplace update claude-workflow`).
