# Blink to SQL Migration Utility

Script: `migration/blink-to-sql.mjs`

## Required env
- `BLINK_PROJECT_ID`
- `BLINK_SECRET_KEY` (recommended)
- `API_BASE_URL`
- `API_TOKEN` (optional bearer token)

## Run
```bash
node migration/blink-to-sql.mjs
```

## Behavior
- Deterministic entity order.
- Idempotent upsert by `id`.
- Final JSON report with totals/created/updated.
