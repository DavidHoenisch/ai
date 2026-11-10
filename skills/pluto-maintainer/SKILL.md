---
name: pluto-maintainer
description: Maintain Pluto libraries, generators, examples and documentation. Use for framework bugs, features, UI/UX, developer or agent experience, and scoped security investigation; application feature work uses the application skills.
---

# pluto-maintainer

## Mission

- Make Go APIs and full-stack apps fast to build, explicit to understand and
  safe by default.
- Prefer standard Go, small dependency surfaces, readable code and typed,
  testable boundaries.
- Keep framework mechanics in shared primitives; generate application intent and
  authored extension points.

## Do

- Read the target repository's `AGENTS.md`, checks, published API and relevant
  docs. Identify affected modules, generators and consumers before editing;
  change only authorized repositories.
- Trace each violation to its introduction and missed check. Fix the owner;
  prove intended rejection, a nearby bypass and an allowed consumer.
- Use the CLI for supported application scaffolding. Maintainers edit generator
  source/templates directly, then rebuild and exercise the CLI; do not patch
  generated output to hide generator defects.
- Assign compiler, canonical-check, runtime/database and skill obligations.
  Declare compatibility, dependency costs and migration requirements.
- Gate unfinished/staged application behavior off by default; test both states.
  Flags cannot make unsafe migrations or broken public contracts safe to merge.
- After the final edit in a library repository, run `make fmt`, then `make vet`,
  and `make check` for the standard checks and tests. Where these targets are
  unavailable, use the repository's documented formatter, linter and test
  commands. `pluto fmt` and `pluto vet` are application commands, not library
  checks. Fix findings and rerun affected checks; report failures, skips and
  untested boundaries accurately.

- Reflect public behavior changes in the product docs on `pluto-site`, including
  package-owned snapshot sources; repository docs alone are insufficient. Follow
  the documentation authoring guide for ownership and refresh steps. Report
  blocked site work explicitly.
- Update existing docs first. Keep work plans, summaries and test evidence in
  the conversation or PR; add Markdown only for a lasting reader need or
  explicit request. Lead examples with real wiring.

## Read for the task

- [Documentation
  authoring](https://plutoframework.github.io/pluto-site/docs/maintainers/documentation.md):
  realistic examples, source checks and publishing.
- [Implementation](references/implementation.md): bugs, features, generator and
  release validation.
- [Experience](references/experience.md): UI/UX, DX and agent ergonomics.
- [Security](references/security.md): trust boundaries, safe reproduction and
  evidence.
- [Ecosystem
  conventions](https://plutoframework.github.io/pluto-site/docs/conventions.md):
  canonical application rules.

## Don't

- Do not turn a focused task into an ecosystem rewrite or add dependencies
  without justification.
- Do not bypass lint/tests, overwrite authored code, weaken access checks or
  invent framework guarantees.
- Do not publish, deploy, disclose vulnerabilities or make paid/live calls
  without task authorization.
- Do not call a change secure from scanner output, passing tests or self-review
  alone.
