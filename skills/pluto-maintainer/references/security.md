# Security investigation and validation

## Establish scope and evidence

- Identify the requested modules/diff and threat model. Trace callers and protections across the codebase before reporting a finding.
- Trace attacker-controlled input through validation, authentication, authorization, state/persistence and external effects. State required access and deployment conditions.
- Authenticated callers can still exploit IDOR, cross-tenant access and privilege escalation; authentication alone is not a mitigation.
- Separate demonstrated vulnerabilities, hypotheses needing verification and optional hardening. Scanner warnings and suspicious patterns are leads, not proof.

## Inspect relevant Pluto boundaries

- Auth: credential enumeration, challenge purpose/expiry/single use, session revocation/version fences, Origin/CSRF controls and rate-limit boundaries.
- Authorization: verified identity/tenant derivation, resource ownership, default deny and enforcement through both HTTP and direct operation/tool calls.
- Data: tenant predicates, parameterized SQL, pagination binding, state guard freshness, optimistic concurrency and transaction atomicity.
- Delivery: idempotency ownership, uncertain claims, replay after authorization, fenced leases/retries and duplicate external effects.
- External calls/AI: server-controlled capabilities, destinations, redirect handling, cancellation/limits, approval and tool authority. Treat model output as untrusted.
- Frontend/observability: unsafe HTML, credential storage, stale actor/tenant state, secret/PII logging and unbounded telemetry labels.
- Generators/supply chain: path traversal, symlinks, overwrite boundaries, command injection, user-hook execution, dependency/module integrity and CI publishing permissions.

## Reproduce safely

- Prefer a minimal deterministic regression using synthetic users/tenants and disposable local services. Do not probe third-party or production systems without authorization.
- Show the forbidden outcome before the fix and its denial afterward; keep allowed behavior working.
- For races/replays, use controlled barriers or transactional integration tests; avoid timing-only assertions.
- Add relevant bounded fuzz/mutation coverage and repository-required checks. Record actual commands, versions, service setup, failures and skips.
- Never print/commit real credentials, tokens or private payloads. Verify secret handling without copying secrets into fixtures or reports.

## Report and remediate

- Include file/line, attacker prerequisites, input-to-effect trace, minimal reproduction, impact, severity rationale and confidence.
- Explain the existing protections checked and why they fail. Label unverified assumptions explicitly.
- Fix the owning layer and affected generation paths; avoid cosmetic handler-only patches when operations remain vulnerable.
- Follow repository disclosure policy. Use a private channel for embargoed details; do not create public issues/commits containing an undisclosed exploit without authorization.
- State review coverage and residual limits; never claim an independent audit or absence of vulnerabilities from self-review.
