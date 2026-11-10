---
name: pluto-security
description: Integrate Pluto authentication, RBAC, tenant checks and feature flags. Use when changing access control, credential flows or client-visible capabilities.
---

# pluto-security

## Do

- Derive identity from the configured authentication issuer; verify the selected
  tenant against current server-side membership before creating scoped
  execution.
- Use the supported identity issuer and bind evidence to that exact issuer. A
  private type with a public strings-only constructor is not verified authority;
  reject zero, foreign, expired and revoked evidence.
- Check permissions and resource/tenant ownership in application operations,
  including calls made outside HTTP.
- Require the same declared gate for HTTP, worker and tool calls. Resource
  policy is separate from capability permission and must bind the actual
  resource. Revalidate at restricted writes where the contract requires it.
- Couple scoped execution capabilities to private writer callbacks; do not
  expose a separate unrestricted write after a successful check. Capability
  lifetime does not make revocation atomic with SQL.
- Use published Pluto Auth credential flows and the configured Origin, limiter
  and delivery boundaries.
- Use Core feature evaluation; preserve explicit false overrides and expose only
  declared client-visible flags in caller context.
- Keep security middleware enabled; apply explicit migrations and test
  cross-tenant and denied-access cases.

## Don't

- Do not accept roles, tenant authority or permissions from request/model
  arguments.
- Do not trust a queued actor ID, an agent dependency's label, or a fabricated
  principal as proof of identity. Use verified delegation/service authority with
  explicit scope and purpose.
- Do not substitute a feature flag or hidden frontend control for authorization.
- Do not cache credential responses, log secrets or store session credentials in
  browser storage.
- Do not grant business membership during public enrollment or expose
  development issuance routes in production.

## Docs

Read only the topic needed; match examples to the installed package version.

- [Auth](https://plutoframework.github.io/pluto-site/docs/backend/auth.md)
- [Enforced authority
  boundaries](https://plutoframework.github.io/pluto-site/docs/architecture.md)
- [Credentials](https://plutoframework.github.io/pluto-site/docs/backend/credentials.md)
- [RBAC](https://plutoframework.github.io/pluto-site/docs/backend/rbac.md)
- [Flags](https://plutoframework.github.io/pluto-site/docs/backend/features.md)
