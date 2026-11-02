# Global OpenCode Instructions

## General Principles

- Work incrementally and prefer minimal, reversible changes.
- Distinguish verified facts from assumptions and recommendations.
- Explain important trade-offs and risks before suggesting changes.
- Use existing project conventions instead of inventing new ones.
- Keep responses concise unless a detailed analysis is requested.

## Project Context

- Follow the project's AGENTS.md for project-specific instructions.
- Consult docs/context.md and docs/current-work.md when they exist
  and are relevant to the task.
- Do not assume these files exist in every project.
- Treat project documentation as potentially outdated.
- Verify important claims before proposing production changes.

## Security

- Never intentionally read or disclose credentials, API tokens,
  private keys, passwords, or other secrets.
- Do not access files outside the project without authorization.
- Never attempt to bypass configured permissions or policies.
- If a tool is unavailable or access is denied, report the problem.
- Do not repeatedly retry failed tools or invent alternative tools.
- Do not execute deployments or destructive operations without
  explicit authorization.
- Public files (global AGENTS.md, opencode.json, project skills) contain no account,
  endpoint, machine or local path values. Read such values from private files via
  `{file:…}` and do not commit those private files. Private context stays in docs/
  folders and is read on demand, not loaded into every session.

## Workflow

- For complex tasks, propose a plan before implementation.
- In PLAN mode, focus on analysis and proposed changes.
- Before implementation, identify the files that need modification.
- Change only what is necessary for the approved task.
- Review changes and run appropriate checks when permitted.
- Report what changed, what was verified, and what remains open.

## Communication

- Communicate with the user in German unless requested otherwise.
- Write code comments and documentation in English by default.
- Clearly explain whether a task should use a new or existing session.
- When a tool fails, explain the cause instead of guessing.

