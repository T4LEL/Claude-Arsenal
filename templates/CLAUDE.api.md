# {{project-name}}

{{One sentence: what this API/service does and who consumes it.}}

## Stack

Python {{3.x}} + FastAPI + {{Postgres/Supabase | SQLite | none}} + pytest.

## Commands

- Activate venv: `.\.venv\Scripts\Activate.ps1` (Windows)
- Dev server: `uvicorn app.main:app --reload` (http://localhost:8000, docs at /docs)
- Test: `pytest`
- Deps: `pip install <pkg>` then `pip freeze > requirements.txt`

## Structure

- `app/main.py` — FastAPI instance, router registration, middleware
- `app/routers/` — one file per resource
- `app/models.py` — Pydantic schemas
- `app/db.py` — database access (only once the service has a database)
- `tests/` — mirrors `app/` layout

## Rules

- Request/response bodies always typed with Pydantic models — no bare dicts across the API boundary.
- Every endpoint: correct status codes, structured error responses, ownership check on any user-scoped resource.
- Secrets from env vars only; `.env.example` kept current.
- Every new endpoint ships with tests (happy path + main failure). `pytest` passes before done — paste output.
- Schema changes via migration files only (applies once a database exists).

## Deploy

{{Platform + command — fill in when first deployed; devops-engineer agent sets this up.}}
