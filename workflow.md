## Workflow

### Tickets, branches and PRs

- One GitHub issue = one branch = one PR. Never commit directly to `main`.
- Branch from the latest `main`, named `<issue-number>-<short-slug>` (e.g. `12-add-login-form`). Always fast-forward local `main` first (`git fetch origin main:main`, or `git switch main && git pull --ff-only`); a stale local `main` makes `main...HEAD` diffs and reviews include work already merged upstream.
- PR title uses Conventional Commits: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`; add `!` for a breaking change (`feat!: …`). The title becomes the commit on `main`, so make it readable as a changelog line.
- PR body starts with `Closes #<issue-number>`.
- Before handing over, start a sub-agent that runs `/ponytail-review` on `git diff main...HEAD`, with the issue number for context. A fresh context reviews the code, not your intentions. Fix what it finds. If the ticket has a written spec, run `/mattpocock-skills:code-review` against `main` at the same time (it starts its own sub-agents).
- PRs are squash-merged by the user. Stop at "PR open, review done"; never merge yourself.

### Ponytail levels

- Planning (`to-spec`, `to-tickets`, grilling): `/ponytail ultra`, which challenges scope before it becomes a ticket.
- Implementing a ticket: `/ponytail` (full, the default).
- Mark known shortcuts in code as `shortcut: <the limit>, <when to upgrade>`.

## Versioning and releases

SemVer `MAJOR.MINOR.PATCH`, recorded only as git tags `vX.Y.Z` on `main`. `v0.0.0` means nothing released yet; the first release is `v0.1.0`.

Release only when the user asks. Bump rules while pre-1.0:
- **MINOR**: any `feat` or breaking (`!`) commit since the last tag.
- **PATCH**: anything else (`fix`, `refactor`, `perf`, `docs`, `test`, `build`, `ci`, `chore`).
- **1.0.0**: only on the user's explicit decision.

Release steps:
1. `git switch main && git pull`.
2. List commits since the last tag (`git log $(git describe --tags --abbrev=0 2>/dev/null || git rev-list --max-parents=0 HEAD)..HEAD --oneline`), propose the next version with reasoning, and wait for the user to confirm.
3. Run `/ponytail-debt`; the user decides which shortcuts become issues. For a MINOR release, also run `/ponytail-audit`.
4. `gh release create vX.Y.Z --target main --generate-notes`.

If the project later gets a manifest with a version field (`package.json` etc.), add a step before 4: open a `chore: release vX.Y.Z` PR that bumps it, and tag only after the user merges it.
