# claude-workflow

Shared Claude Code rules for my projects: one branch and squash-merged PR per ticket, Conventional Commit titles, ponytail review, and SemVer releases from git tags.

## Use in a project

1. Clone this repo to `~/git/claude-workflow`.
2. Add this line to the project's `CLAUDE.md`:

   ```markdown
   @~/git/claude-workflow/workflow.md
   ```

   Claude Code asks once to approve the external import.
3. Apply the GitHub settings and triage labels from inside the project:

   ```bash
   ~/git/claude-workflow/setup-repo.sh
   ```

The rules assume the `mattpocock-skills` and `ponytail` plugins are installed, and that the project has run `/setup-matt-pocock-skills` with GitHub as its issue tracker.

## Updating

Edit `workflow.md` here and push. Other machines pick it up with `git pull`. Every project that imports it gets the change in its next session.
