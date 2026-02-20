# SmartAssetManager.Database

This folder is a SQL Database Project used to build a DACPAC.

## Build DACPAC

```powershell
cd database/SmartAssetManager.Database
dotnet build
```

The output DACPAC is generated under:

`bin/Debug/net8.0/SmartAssetManager.Database.dacpac`

## Structure

- `dbo/Tables` - table and index definitions
- `Security` - roles and security objects
- `Database Triggers` - trigger scripts
- `Import Schema Logs` - legacy migration scripts kept for audit/import reference

