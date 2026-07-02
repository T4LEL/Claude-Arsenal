# Reference project structures

Standard layouts per app type. Used by `/new-project` for anything beyond the webapp/api presets. Scaffold with the ecosystem's official generator, then trim to the minimal structure below.

## Webapp (preset — see CLAUDE.webapp.md)

Next.js App Router: `src/app/` routes, `src/components/`, `src/lib/`, `supabase/migrations/`.

## API service (preset — see CLAUDE.api.md)

FastAPI: `app/main.py`, `app/routers/`, `app/models.py`, `app/db.py`, `tests/`.

## CLI tool

- **Node:** `src/index.ts` (arg parsing via `commander` or built-in `parseArgs`), `src/commands/` one file per subcommand, `bin` entry in package.json. Test with vitest.
- **Python:** single package dir with `__main__.py`, `argparse` from stdlib, `pytest`. Distribute via `pipx`.

## Browser extension (Chrome MV3)

`manifest.json` (v3), `src/background.ts` (service worker), `src/content.ts`, `src/popup/` (HTML+TS), `assets/`. Build with Vite + `@crxjs/vite-plugin`. Load unpacked from `dist/` while developing.

## Desktop app

Default **Tauri** (small, fast) over Electron unless a Node runtime in-app is required: `src/` (frontend, same as webapp), `src-tauri/` (Rust shell — generator writes it, rarely touched). `npm run tauri dev` / `tauri build`.

## Mobile app

**Expo (React Native):** `npx create-expo-app`. `app/` (expo-router file routes), `components/`, `lib/`. Test on device via Expo Go; ship via EAS. Reuse the Supabase backend from the webapp preset.

## Static site / landing page

Plain Next.js (same preset, no Supabase) or Astro for content-heavy sites: `src/pages/`, `src/components/`, `src/content/` (markdown collections). Deploy Vercel.

## Monorepo (only when 2+ of the above genuinely share code)

npm workspaces: `apps/<web|api|mobile>`, `packages/<shared-types|ui|db>`. Root `package.json` with `workspaces`. Don't start here — graduate to it when duplication actually hurts.
