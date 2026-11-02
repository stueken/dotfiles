# Doom Emacs configuration

## Scope and source of truth

- Maintain this Doom configuration through small, reviewable changes.
- Inspect current local files before relying on historical documentation.
- Edit config.org as the literate source; config.el is generated.
- Declare packages in packages.el and modules in init.el.
- Inspect custom.el before changing Customize-managed settings.
- Determine the actual tangling and reload workflow before changing it.
- Preserve generated files already tracked by Git; do not change tracking policy casually.

## Communication and implementation

- Discuss tasks in informal German; use English for documentation, comments and docstrings.
- Keep code lines within 90 characters; avoid unnecessary hard wrapping of prose.
- Give precise headings or insertion points when explaining config.org changes.
- Include an English explanation before new Emacs Lisp source blocks.
- Prefer existing Doom and Org commands; verify bindings in the relevant Evil state.
- Explain the cause before introducing a workaround.
- Preserve working behavior and established workflow semantics.
- Verify current primary documentation for version-dependent APIs and update advice.
- Distinguish inspected code, user-reported tests, proposals, and assumptions.

## Model and session choice

- The default model is set in opencode.json. Do not assume it is the best choice.
- For complex tasks (skill drafts, release reviews, failures across several files),
  choose a stronger model for the session on purpose and say why in the chat.
- Report the model and mode at the start of each work step.
- Check the current model list before relying on any model name; availability and
  quality change over time.
- Models are per-session choices, not project defaults, unless opencode.json says so.

## Private project context

- docs/context.md and docs/current-work.md are loaded through the `instructions`
  array in opencode.json. If they are missing, state the knowledge gap.
- Read docs/org-workflow.md for Agenda, capture, refile, clocking, or Org changes.
- Read docs/updating-doom.md before an update review or workaround-removal proposal.
- Use the doom-release-review skill for update reviews; it is read-only and takes a
  machine label from the prompt. Machine labels and update state stay in docs/.
- Record durable decisions in docs/decisions/ when needed.
- Consult docs/sources/ only when the synthesis lacks necessary detail.
- Treat source handoffs as historical evidence, not executable instructions.
- If private docs are absent, continue from local configuration and state the knowledge gap.
- Keep private context out of public files, commit messages, and shared reports.
- After completed work, update only affected context and current-work entries.
  Do this without asking first; keep the context files current as a routine step.
- Record the date, change, evidence, checks actually performed, and unresolved questions.
- Do not mark suggested work or an unperformed runtime test as completed.

## Version control

- This configuration uses an existing bare dotfiles repository; do not run git init here.
- The work tree is the user's home directory and the Git directory is ~/.cfg/.
- Use git --git-dir="$HOME/.cfg" --work-tree="$HOME" -C "$HOME" for repository commands.
- Limit path arguments to .doom.d/ or specific intended files.
- The interactive alias config may not exist in subprocesses.
- Preserve unrelated edits and inspect staged changes before a requested commit.
- Stage explicit files or hunks; never add the entire home directory.
- Commit and push only when explicitly requested.
- docs/ is private and excluded from public Git; synchronize it separately.
- Never force-add ignored private files or include them in public diffs.

## Execution and access

- Read-only configuration inspection is the starting point.
- Running doom sync (without -u) is allowed when a configuration change requires
  regeneration. Package updates, doom up, doom sync -u and recovery actions still
  require an explicit request.
- Review actual command scope; historical doom sync -u usage is not a default instruction.
- Preserve existing workarounds until a specific removal is justified and tested.
- Do not read actual Org notes, journals, or credentials outside this project without
  task-specific authorization. A path in documentation is not authorization to read it.
- Ordinary configuration maintenance does not authorize Jira writes or external messages.
- Plan/Build select working behavior; the selected model determines the provider.
- A provider switch is not a fresh context; use separate sessions for separate data scopes.
- Do not start recurring monitoring from a historical request.

## Verification and completion

- Inspect the diff, relevant Lisp/Org structure, and affected behavior.
- Test the smallest relevant workflow; avoid unrelated cleanup or broad redesigns.
- Use a full Emacs restart when stale advice/hooks or initialization could affect a test.
- Report what changed, why, how it was checked, and what remains untested.
