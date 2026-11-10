# Implementation

## Find the owner

- Inspect current code and committed docs before proposing a new primitive;
  avoid rebuilding an existing package.
- Put reusable runtime mechanics in Core; keep integration dependencies in
  adapter modules. Preserve stdlib-only module boundaries where declared.
- Put generator policy/templates in CLI, examples in the example repo, frontend
  primitives in the frontend library and guidance in docs/skills.
- Keep explicit injection, small consumer-owned interfaces, pure state decisions
  and thin transport adapters. Business operations retain authorization and
  transaction ownership.

## Fix bugs

- Capture trigger, expected result and actual result; add a regression that
  fails before the fix and passes afterward where practical.
- Test the root cause at its owning boundary. Add a consumer regression when
  unit tests miss generation, registration or integration behavior.
- Preserve unrelated behavior; inspect error, cancellation, retry and
  concurrency paths relevant to the fix.

## Introduce features

- Define the smallest useful public contract, defaults, error behavior and
  compatibility impact.
- Prefer existing primitives and standard libraries. Justify new dependencies by
  benefit, transitive cost, maintenance and module placement.
- Keep source readable: configured 80-column target, expanded blocks, files
  under 1,000 lines and blank lines above standalone comment blocks except at
  file line one. Preserve required directives.
- For staged application capabilities, declare default-off flags, gate before
  side effects, test both states and define removal criteria. Runtime-disabled
  code must still compile and preserve startup, migrations and existing
  contracts.

## Validate generators and consumers

- Rebuild embedded templates before testing commands. Generate disposable apps
  with explicit `--no-input` arguments.
- Exercise affected profiles: tenancy modes, frontend adapters, enabled/disabled
  integrations and supported combinations; choose the matrix from the changed
  behavior.
- Verify dry-run/no writes, collision rejection and preservation of authored
  files when touching generation.
- Format, lint, compile and test generated consumers; check OpenAPI/schema/theme
  freshness where affected.
- Treat templates, embedded source strings and `.go.txt`/`.tmpl` fixtures as
  authored code. Check their layout explicitly and inspect rendered source
  before generated-file exclusions can hide it. Running the root formatter
  alone does not establish coverage of these source classes.
- Follow repository-required race, bounded fuzz, mutation and real-service
  checks. Count skips separately; surviving mutants need explanation, never a
  manufactured pass.

## Deliver

- Use the [architecture enforcement
  map](https://plutoframework.github.io/pluto-site/docs/architecture.md): domain
  values and lifecycle, operation identity/resource policy, scoped
  data/query/cache, atomic commit and typed delivery each need an owning API,
  canonical check and runtime proof. Skills explain that path; they cannot
  compensate for an optional enforcement mechanism.
- Preserve a frozen negative consumer while repairing upstream tools. Pin its
  revision and contents, require the specific expected findings and reject
  unrelated failures. Do not rewrite the consumer or its checks to manufacture a
  pass. Migrate only after the required upstream coverage is demonstrated.
- Test installed and candidate versions explicitly. Candidate local replacements
  must not be presented as released dependency compatibility. Unsupported
  required contracts must fail the compliance gate, even if draft scaffolding
  can still compile.

- Update relevant docs, templates and examples within authorized scope; report
  follow-ups outside it.
- For authorized releases, use module-specific tags, correct pins and existing
  pipelines. Verify installation with published dependencies, normal checksums
  and no local replacements.
- Report behavior changed, evidence, compatibility/migrations and material
  limits. Keep unrelated working-tree edits and secrets out of commits.
