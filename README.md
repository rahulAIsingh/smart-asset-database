# Smart Asset Database

SQL migration scripts and DACPAC-ready SQL project for Smart Asset Manager.

## SQL Database Project (DACPAC)

Project path:

`SmartAssetManager.Database/SmartAssetManager.Database.sqlproj`

Build DACPAC:

```powershell
cd SmartAssetManager.Database
dotnet build SmartAssetManager.Database.sqlproj
```

## Migration Scripts (legacy/apply order)

1. `Migrations/0001_Initial.sql`
2. `Migrations/0002_RequestWorkflow.sql`
3. `Migrations/0003_RequestAudit.sql`
