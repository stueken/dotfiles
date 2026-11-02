---
name: doom-release-review
description: >-
  Read-only review of what `doom up` would change in a Doom Emacs setup (core,
  modules and all packages from init.el, packages.el and config.org), compared with
  the installed state on a named machine. Use before running doom up. Answers
  UPDATE, PREPARE FIRST, WAIT or NO ACTION (optional packages) and, for UPDATE and
  PREPARE FIRST, adds a readable release note. Never updates, syncs, fetches,
  commits, or writes project files.
---

# Doom release review

## What this review answers

Should the user run `doom up` now (UPDATE), change something first (PREPARE FIRST),
or wait because the update could break something, for example an unfixed upstream
issue (WAIT)? The user wants to know the expected effects in readable form.

`doom up` (same as `doom upgrade`) checks the core first. If the core is already at
the upstream revision, it stops with "Doom is already up-to-date!" and changes
nothing else. Only when the core has a new revision does it update the core, reset
the modules checkout to the revision that core pins, and then run `doom sync -u`,
which updates all installed packages. `doom upgrade -p` (`doom up -p`) skips the core
check and updates only packages. Doom has no dry run, so determine the target state
from upstream. Confirm with `doom upgrade --help` if in doubt (read-only).

Modules and packages are both installed by `doom sync`. Modules are Doom's own
bundles: config code plus a `packages.el` from the modules repository, activated in
init.el (with optional flags). Packages are Emacs Lisp libraries fetched by straight.
The user's `packages.el` in the Doom directory declares extra packages. Keep this distinction in
the report.

Two verdict groups:

- **Core changes (new core or modules revision):** UPDATE, PREPARE FIRST or WAIT, as
  below, with a full release note.
- **Only package changes (core already current):** no `doom up` is needed. Package
  updates are optional and require `doom up -p`. Report them with the issue check
  and a short note, and answer NO ACTION (optional packages) when nothing blocks
  them.

## Limits

- Read-only. Do not run `doom up`, `doom upgrade`, `doom sync`, `doom doctor`,
  `git fetch`, `git pull`, `git clone`, package updates, or anything that changes
  files, Git state or packages.
- Do not write any file during the review, except intermediate lists (for example
  package revisions) under `/tmp/opencode/`. Never write to the project, to `docs/`,
  or to the home directory. This restriction also applies to shell redirection.
- Do not print full configuration files. Quote only the lines needed.
- Do not read secrets, credential files, or Org notes and journals.
- Network use is limited to (a) web fetches of official sources and (b)
  `git ls-remote` against the remote URLs recorded in the installed repositories.
  `git ls-remote` only requests a ref list. Send no local data and no credentials.
  Skip remotes that are not public hosting URLs or look private or internal, and list
  them as not checked.
- Shell commands are approved per the session permissions. Use only the commands
  named in the steps. Do not use `--auto` or approve broad patterns.
- `doom doctor` is run by the user. Ask for its output; if it is missing, list it as
  an evidence gap.

## Start (before any other step)

1. **Machine label.** If the prompt does not name one, ask first, in the same
   question as step 2. List the labels from `docs/machines.md`. Do not guess from the
   hostname and do not start the check without a label.
2. **`doom doctor` output (optional).** Ask in the same question whether the user
   wants to paste it. If the user declines or does not answer, continue and list it
   as an evidence gap.
3. **Model and mode.** Report the mode you see (Plan is required) and the model.
   Check the model against the current GitHub Copilot list (the `opencode.models` tool,
   called inside the `execute` tool, with the configured provider). Use the default
   variant of a Sonnet-class model from the list, and name the choice in the report.
   If no suitable model is listed, name the available alternative and ask before
   proceeding. If the mode is not Plan, tell the
   user to switch and stop.
4. Private context, if present: `docs/updating-doom.md` and `docs/machines.md`. If
   absent, name the missing knowledge and continue with local evidence.

## Steps

1. **Local baseline.** Confirm the paths before use. Read-only commands:
   - `emacs --version`
   - `git -C <doom-core-dir> rev-parse HEAD`, `describe --tags --always`, `status --short`
   - `git -C <modules-dir> rev-parse HEAD`, `describe --tags --always`, `status --short`
   - `git -C <core-dir> status --ignored --short` (ignore `eln-cache/`): leftovers
     can shadow modules
   - the dotfiles status for the user directory, using the form AGENTS.md defines
   Read init.el (enabled modules and flags), packages.el (`package!`, `:pin`,
   `unpin!`, recipes) and the parts of config.org that configure, advise or work
   around packages. Use targeted searches instead of printing whole files.
   Report command output as "observed".
2. **Machine record.** Compare with the entry for the label in `docs/machines.md`:
   same, behind, ahead, or not recorded. Other machines are not compared.
3. **Target state of core and modules.**
   - Core: `git ls-remote <core-url> HEAD` and tags; compare with the local HEAD.
   - Modules: the target revision is the one the target core pins. If it cannot be
     determined, say so.
   - Use the upstream compare view of the repository host to read the commits between
     the local and the target revision. Focus on changed `:pin` and `unpin!` lines
     for every module enabled in init.el, plus CLI, doctor and autoload changes.
4. **Package layer (required).**
   - Scope: every package installed through the modules enabled in init.el, every
     package declared in packages.el, and every package configured in config.org.
     Do not limit this to a fixed list of well-known packages.
   - Installed state: for each repository in the straight repos directory, read
     `git -C <repo> rev-parse HEAD` and `git -C <repo> remote get-url origin`.
   - Target state: pinned packages use the pin in the target modules revision (or in
     packages.el). Match pins by the package name in the `:pin` line, not by a hash
     prefix alone; a hash-prefix match is only a heuristic and must be labelled so. Unpinned packages and `unpin!` packages use upstream HEAD from
     `git ls-remote <url> HEAD`.
   - For each package whose revision would change, read the upstream changes between
     the installed and the target revision (compare view or release notes). Examine
     in detail the packages that config.org configures, advises, or works around, and
     those with open issues. For the rest give a count and mark them "no
     configuration intersection found".
   - Report how many packages would change and which could not be checked.
5. **Existing problems.** Use the pasted `doom doctor` output and the status above.
   Do not call a problem new or old without a dated source.
6. **Open upstream issues.** Check issues relevant to the installed modules and the
   changing packages in the official repositories. Date every status.
7. **Intersection with this configuration.** For each relevant change write: change
   -> enabled module, package or config.org block -> established, plausible or not
   applicable -> preparation or focused test. Verify module enablement in init.el.
8. **Verdict.** Choose exactly one:
   - UPDATE: nothing relevant breaks or changes in a harmful way for this setup.
   - PREPARE FIRST: name the concrete preparation and the test that follows.
   - WAIT: name the blocking issue or change and the condition for re-checking.
   - NO ACTION (optional packages): core and modules are current, and the package
     changes are not blocked by an open issue. Updating packages is optional
     (`doom up -p`), so the user may ignore them.
   If a layer (core, modules, packages) could not be reviewed, the verdict is at most
   "WAIT (incomplete)" with the missing layer and what is needed. Never present an
   unreviewed layer as safe.
9. **Report in German,** informal, selective, no commit dump:
   - Date, label, verdict
   - Verified baseline (observed output and commands)
   - Machine record comparison
   - Relevant changes with source and access date
   - Required preparation, separate from optional cleanup
   - For new core or modules: a readable release note. Name new modules and
     features with their purpose (what they do, why one would enable them), changed
     defaults, fixes that matter, changes to enabled modules and configured packages,
     and what to test afterwards. For package-only changes, list the affected
     packages briefly and point out only those touching the configuration.
   - Checks after a manual update
   - Uncertainty, untested points, evidence gaps

## After the review

The review records nothing. If the user later updates a machine, recording the new
state in `docs/machines.md` for that label only is a separate Build step with the date
and the checks actually performed.

Do not treat an issue title or an old assistant conclusion as proof. Distinguish
observed results from source-based expectations.
