---
name: pluto-data
description: Implement Pluto persistence, pagination, idempotency, jobs and cache boundaries. Use for SQL-backed operations, retries and background delivery.
---

# pluto-data

## Do

- Use PostgreSQL and sqlc query boundaries; include tenant predicates in every
  scoped read/write.
- Consume authority from the operation's verified scope/resource boundary.
  Ordinary tenant strings, request payloads and cached membership do not
  establish authority.
- Keep lifecycle state private to its domain owner. Transition writes require
  the owning machine's evaluated decision and expected version; reject zero,
  foreign, expired or differently bound authority before effects.
- Commit business changes, expected-version checks, durable audit records and
  outbox enqueue in the same transaction when required.
- Use Core bounded pagination and bind cursors to the query context.
- Apply resource visibility and tenant predicates in the query before
  pagination. Exports use an explicit bound and the same visibility contract;
  filtering an unrestricted page afterward is incorrect.
- Use the same-transaction idempotency API when a business write and replay
  completion must be atomic.
- Authorize replay responses too. Bind claims to actor, tenant, operation and
  request fingerprint; reconcile retained pending claims and uncertain commits
  before retrying.
- Make job handlers safe under at-least-once delivery; scope cache keys by app,
  environment and tenant.
- Authorize before every cache access, including hits. Keep key/TTL/loading
  mechanics in a scoped data adapter; operations receive its restricted port.
  Cache invalidation and object delivery are not database rollback guarantees.
- Validate and normalize domain values once at controlled constructors. Define
  typed effect payloads; enqueue declared delivery with the mutation and bound
  retries at the worker.
- Test transaction rollback, competing writes, duplicate delivery and tenant
  isolation with real backing services where relevant.

## Don't

- Do not use a cursor, cache entry or idempotency key as authorization.
- Do not claim generic HTTP replay capture is atomic with the business write, or
  jobs provide exactly-once delivery.
- Do not use memory stores as durable production storage or silently retry
  uncertain writes without reconciliation.
- Reload lifecycle guard facts from authoritative persistence, even on a
  same-version display cache hit. Never make caches authoritative for sessions
  or permissions.
- Do not count a skipped database case, build failure, missing test or unrelated
  error as negative proof. Require the expected business assertion and an
  allowed positive control.

## Docs

Read only the topic needed; match examples to the installed package version.

- [Core data
  primitives](https://plutoframework.github.io/pluto-site/docs/backend/core.md)
- [Data and operation
  boundaries](https://plutoframework.github.io/pluto-site/docs/architecture.md)
- [Jobs and
  outbox](https://plutoframework.github.io/pluto-site/docs/backend/jobs.md)
- [Concurrent
  transitions](https://plutoframework.github.io/pluto-site/docs/backend/state.md)
