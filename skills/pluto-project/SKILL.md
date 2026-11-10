---
name: pluto-project
description: Initialize and configure Pluto applications using the CLI and pluto.toml. Use for project scaffolding, tool setup and ecosystem upgrades.
---

# pluto-project

## Do

- Read `pluto.toml`, local agent instructions and `pluto version` before
  changing a project.
- Use the CLI for project/frontend initialization, endpoints, jobs, agents,
  state machines, components and auth UI. Inspect help/`--dry-run`; use explicit
  arguments with `--no-input`.
- Generate first; use supported authored extension points. Candidate blueprints
  own domain rules and operations; unsupported hooks require framework changes.
  Edit manifest-owned metadata in `pluto.toml`, then regenerate.
- Declare operation authority and behavior before choosing its HTTP, worker or
  tool entry. Use the installed CLI's supported references; unsupported
  contracts require an explicit framework upgrade, not a handwritten alternate
  gate.
- Persist generator choices in `pluto.toml`; load secrets through the configured
  environment/provider.
- Keep the application environment prefix explicit, uppercase and scoped to the
  app.
- After the final edit, run `pluto fmt`, `pluto openapi` when contracts change,
  `pluto vet` and relevant tests. For frontend edits, run its format/lint/check
  scripts. Fix findings; rerun affected checks.
- Report checks run, failures and missing tools. Do not claim incomplete
  validation passed.

## Feature rollout

- Gate unfinished/staged capabilities behind declared, default-off flags before
  merging. Routine fixes/refactors need no flag unless rollout requires one.
- Where supported, use `pluto add endpoint ... --feature <key>`; add
  `--feature-client-visible` only when needed. The candidate profile rejects
  route-only flags pending shared operation contracts.
- Gate server behavior before side effects; retain authorization. Test both
  states, including no new effects while disabled. Define when to remove the
  flag.

## Don't

- Do not hand-create supported scaffolds or patch generated output to bypass the
  CLI. Resolve/report missing or failing tooling; use documented extension
  points for unsupported work.
- Do not suppress lint rules, shrink tests or skip checks to make a change pass.
- Do not overwrite authored files or migrate old scaffold schemas implicitly.
- Do not commit real secrets or assume generated development integrations are
  production-ready.
- Do not add dependencies when an existing Pluto primitive covers the need.
- Keep candidate local replacements explicit and isolated from release pins. A
  passing candidate consumer is not proof that published dependencies contain
  its APIs.

## Docs

Read only the topic needed; match examples to the installed package version.

- [Setup](https://plutoframework.github.io/pluto-site/docs/getting-started.md)
- [Architecture
  contract](https://plutoframework.github.io/pluto-site/docs/architecture.md)
- [Configuration](https://plutoframework.github.io/pluto-site/docs/configuration.md)
- [Feature
  flags](https://plutoframework.github.io/pluto-site/docs/backend/features.md)
- [Commands](https://plutoframework.github.io/pluto-site/docs/cli/reference.md)
