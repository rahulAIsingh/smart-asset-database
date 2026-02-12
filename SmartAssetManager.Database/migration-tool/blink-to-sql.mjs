import { createClient } from '@blinkdotnew/sdk'

const apiBaseUrl = process.env.API_BASE_URL || 'http://localhost:5000'
const apiToken = process.env.API_TOKEN || ''

const projectId = process.env.BLINK_PROJECT_ID || process.env.VITE_BLINK_PROJECT_ID
const secretKey = process.env.BLINK_SECRET_KEY
const publishableKey = process.env.VITE_BLINK_PUBLISHABLE_KEY

if (!projectId || (!secretKey && !publishableKey)) {
  console.error('Missing Blink credentials. Set BLINK_PROJECT_ID + BLINK_SECRET_KEY (or VITE_BLINK_PUBLISHABLE_KEY).')
  process.exit(1)
}

const blink = createClient({
  projectId,
  ...(secretKey ? { secretKey } : { publishableKey }),
  auth: { mode: 'managed' }
})

const headers = {
  'content-type': 'application/json',
  ...(apiToken ? { authorization: `Bearer ${apiToken}` } : {})
}

const report = {}

async function apiPost(path, body) {
  const res = await fetch(`${apiBaseUrl}${path}`, {
    method: 'POST',
    headers,
    body: JSON.stringify(body)
  })
  if (!res.ok) throw new Error(`${path} failed: ${res.status} ${await res.text()}`)
  return res.json()
}

async function apiPatch(path, body) {
  const res = await fetch(`${apiBaseUrl}${path}`, {
    method: 'PATCH',
    headers,
    body: JSON.stringify(body)
  })
  if (!res.ok) throw new Error(`${path} failed: ${res.status} ${await res.text()}`)
  return res.json()
}

async function upsert(entity, row) {
  const id = row.id
  if (!id) {
    await apiPost(`/api/compat/db/${entity}/create`, row)
    return 'created'
  }

  const existing = await apiPost(`/api/compat/db/${entity}/list`, { where: { id }, limit: 1 })
  if (Array.isArray(existing) && existing.length > 0) {
    await apiPatch(`/api/compat/db/${entity}/${id}`, row)
    return 'updated'
  }

  await apiPost(`/api/compat/db/${entity}/create`, row)
  return 'created'
}

async function migrateEntity(entity, fetchRows) {
  const rows = await fetchRows()
  let created = 0
  let updated = 0

  for (const row of rows) {
    const action = await upsert(entity, row)
    if (action === 'created') created += 1
    else updated += 1
  }

  report[entity] = { total: rows.length, created, updated }
}

async function main() {
  await migrateEntity('categories', () => blink.db.categories.list())
  await migrateEntity('departments', async () => [])
  await migrateEntity('vendors', async () => [])
  await migrateEntity('users', () => blink.db.users.list())
  await migrateEntity('assets', () => blink.db.assets.list())
  await migrateEntity('issuances', () => blink.db.issuances.list())
  await migrateEntity('maintenance', () => blink.db.maintenance.list())
  await migrateEntity('stockTransactions', () => blink.db.stockTransactions.list())
  await migrateEntity('financeProfiles', async () => {
    try {
      return await blink.db.financeProfiles.list()
    } catch {
      return []
    }
  })
  await migrateEntity('financeAssetOverrides', async () => {
    try {
      return await blink.db.financeAssetOverrides.list()
    } catch {
      return []
    }
  })

  console.log('Migration report:')
  console.log(JSON.stringify(report, null, 2))
}

main().catch((error) => {
  console.error(error)
  process.exit(1)
})
