---
name: pluto-agents
description: Build typed Pluto Agent runs and tools with verified dependencies and RBAC. Use when adding AI capabilities or external API tools to a Pluto application.
---

# pluto-agents

## Do

- Use typed run dependencies for verified identity, tenant scope and application
  services.
- Register tools explicitly; narrow the allowed tool set per run and enforce
  policy at the execution boundary.
- Bind tools to declared managed operations. Tool adapters decode typed inputs
  and call the same gate used by HTTP/workers; operation code owns
  orchestration, with candidate workflows derived from managed declarations. Do
  not add an alternate business `Handle` callback or reproduce gate logic in a
  tool.
- Obtain caller/delegation evidence from the supported verifier and exact
  trusted issuer. A model-supplied actor, tenant, resource label or copied role
  snapshot cannot create authority.
- Wrap external API tools in the same permission/resource boundaries; keep
  destinations and credentials server-controlled.
- Candidate write tools require host-owned approval and operation idempotency.
  Bind the approved intent to the exact identity, gate, resource and normalized
  input/key; model arguments cannot issue or widen that approval.
- Test with scripted providers and HTTP mocks first; verify denied runs make
  zero external calls.
- Exercise direct tool invocation, mismatched/expired authority and restricted
  writes after the run ends. A tool-level permission check does not replace
  resource policy or the operation's required gate.

## Don't

- Do not let the model select its authority, role, credentials or arbitrary
  outbound destinations.
- Do not describe token accounting as a hard billing cap or cooperative
  cancellation as guaranteed interruption.
- Do not promise durable recovery or exactly-once execution from in-memory
  runs/replay guards.
- Do not make live paid model calls unless the user authorized that test.

## Docs

Read only the topic needed; match examples to the installed package version.

- [Agent API and
  limits](https://plutoframework.github.io/pluto-site/docs/backend/agents.md)
- [Entry adapters and
  operations](https://plutoframework.github.io/pluto-site/docs/architecture.md)
- [Tool
  authorization](https://plutoframework.github.io/pluto-site/docs/backend/rbac.md)
- [Telemetry
  privacy](https://plutoframework.github.io/pluto-site/docs/backend/telemetry.md)
