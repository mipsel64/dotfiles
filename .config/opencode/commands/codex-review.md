---
description: Second-opinion code review via Codex CLI (read-only)
agent: codex
subtask: true
---

Run a Codex code review on the current repository and report its findings
verbatim.

Arguments (optional): $ARGUMENTS
- If empty, review uncommitted changes: `codex exec review --uncommitted`.
- If the first token looks like a git ref (e.g. `main`, `origin/main`,
  `develop`, or starts with `origin/`), treat it as a base branch and run
  `codex exec review --base <ref>`. Any remaining text becomes the focus
  prompt appended to the command.
- Otherwise treat the whole string as adversarial focus text and run
  `codex exec review --uncommitted "$ARGUMENTS"`.

Current repository state for context:

!`git rev-parse --abbrev-ref HEAD 2>/dev/null && git status --short 2>/dev/null | head -30`

Now execute the appropriate `codex exec review ...` command and return
Codex's output. Do not modify files. Do not add your own review on top —
just relay what Codex said.
