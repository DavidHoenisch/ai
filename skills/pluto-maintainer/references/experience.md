# UI/UX, developer and agent experience

## UI/UX

- Start from the user task and acceptance criteria; preserve the application's chosen UI library, theme tokens and feature structure.
- Use supported CLI generators for application components. Fix the generator when every new component would inherit the defect.
- Test loading, empty, error, success and permission/flag-disabled states relevant to the change. Hold write responses open to verify immediate feedback, duplicate protection and preserved input.
- Default generated actions to pending confirmation; make optimism explicit. Test concurrent projections, uncertain commit outcomes and old-scope completion. Confirmed writes must not wait for background refresh or become failures when refresh fails.
- Verify keyboard navigation, focus, labels, validation feedback, contrast, reduced motion and narrow layouts where affected.
- Inspect the rendered result and real interactions; compilation and screenshots alone do not prove a flow works.
- Keep transport/auth details out of presentation components. Client visibility never replaces server enforcement.

## Developer experience

- Optimize the complete path: discover command, preview changes, generate, implement, validate and recover from errors.
- Prefer one canonical command/configuration point over duplicated instructions and hand-maintained registries.
- Make errors actionable: name the invalid input, explain the constraint and show the next valid step without leaking secrets.
- Preserve explicit defaults, stable response contracts and readable authored extension points. Avoid hidden registration, startup DDL and silent migrations.
- Test documented commands from a clean consumer; do not rely on workspace replacements, unpublished pins or a warmed local environment.

## Agent experience

- Keep raw commands deterministic and noninteractive; wizards remain terminal-only presentation over the same command semantics.
- Preserve dry-run, validation before writes, safe collision handling and clear generated/authored ownership.
- Prefer bounded, task-specific diagnostics and Markdown docs. Put short decision rules in skills; link the canonical topic rather than copying manuals.
- Never reward agents for suppressing rules or compacting code to evade file limits. Fix the source, run canonical checks and report missing prerequisites.
- Verify examples match current CLI help and published versions. Do not introduce documentation-only APIs.

## Show improvement

- Compare the relevant before/after behavior: fewer manual edits, clearer failure recovery, accessible completion or a reproducible agent workflow.
- Support performance claims with a representative benchmark; support usability claims with exercised tasks.
- Avoid unrelated redesigns and promotional claims. Explain any intentional workflow or compatibility change.
