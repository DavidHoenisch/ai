---
name: pluto-frontend
description: Build Pluto React features using configured UI libraries, TOML themes, component registries and typed UI state. Use for frontend scaffolding or behavior changes.
---

# pluto-frontend

## Do

- Read the frontend profile in `pluto.toml`. Use `pluto frontend init` and supported `pluto frontend add` commands for components/auth UI; do not hand-recreate their scaffolds. Use the selected UI adapter and documented extension points.
- Keep feature code together and cross feature boundaries through `public.ts`; put network access in feature query/mutation adapters.
- Keep shared theme tokens in TOML and authored CSS overrides in the designated stylesheet; regenerate managed theme output.
- Hide unfinished/staged UI with declared client-visible flags; retain backend feature and permission enforcement and test both flag states.
- Every async action must acknowledge immediately with accessible pending feedback, prevent conflicting submits, preserve failed input and show its outcome. Use published `/actions`, `/react` `useActions`, or optional `/query` `useActionMutation` helpers.
- Default to pending confirmation. Select optimistic projections explicitly; project over current scoped data and apply confirmed responses before background refresh. Never restore a whole-list snapshot across concurrent writes.
- Treat timeouts as uncertain; reconcile authoritative state before retrying. Test held responses, definite rejection, uncertain outcomes, concurrent actions and actor/tenant changes.
- Use `@plutoframework/frontend/state` for pure UI transitions and `/react` for subscriptions.
- Own controller creation/reset/disposal in the host lifecycle; abort and fence stale work when actor, tenant or resource changes.
- After the final edit, run `npm run fmt`, `npm run lint` and the configured frontend checks; fix findings and rerun affected checks. Report missing tools/failures instead of suppressing rules. Preserve expanded blocks, logical spacing and blank lines above standalone comments except at file line one.

## Don't

- Do not hand-edit generated API/theme artifacts, import feature internals or bypass the configured UI library.
- Do not confuse UI state/request IDs with backend domain state/idempotency keys.
- Do not use client state for authorization or share controllers across server-rendered users.
- Do not assume `useMachine` disposes the controller; it only subscribes.

## Docs

Read only the topic needed; match examples to the installed package version.

- [Frontend conventions](https://plutoframework.github.io/pluto-site/docs/frontend/profiles.md)
- [Themes](https://plutoframework.github.io/pluto-site/docs/frontend/themes.md)
- [Custom components](https://plutoframework.github.io/pluto-site/docs/frontend/registries.md)
- [UI state](https://plutoframework.github.io/pluto-site/docs/frontend/state.md)
