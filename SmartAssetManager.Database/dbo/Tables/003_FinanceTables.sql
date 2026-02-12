CREATE TABLE [dbo].[FinanceProfiles] (
    [Id] NVARCHAR(128) NOT NULL,
    [Category] NVARCHAR(128) NOT NULL,
    [Method] NVARCHAR(64) NOT NULL,
    [UsefulLifeMonths] INT NOT NULL,
    [SalvageType] NVARCHAR(64) NOT NULL,
    [SalvageValue] DECIMAL(18, 2) NOT NULL,
    [Frequency] NVARCHAR(64) NOT NULL,
    [ExpenseGl] NVARCHAR(128) NULL,
    [AccumDepGl] NVARCHAR(128) NULL,
    [Active] BIT NOT NULL,
    [CreatedBy] NVARCHAR(255) NOT NULL,
    [CreatedDate] DATETIMEOFFSET NOT NULL,
    [UpdatedBy] NVARCHAR(255) NULL,
    [UpdatedDate] DATETIMEOFFSET NULL,
    CONSTRAINT [PK_FinanceProfiles] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UX_FinanceProfiles_Category]
    ON [dbo].[FinanceProfiles]([Category] ASC);
GO

CREATE TABLE [dbo].[FinanceAssetOverrides] (
    [Id] NVARCHAR(128) NOT NULL,
    [AssetId] NVARCHAR(128) NOT NULL,
    [Method] NVARCHAR(64) NOT NULL,
    [UsefulLifeMonths] INT NOT NULL,
    [SalvageType] NVARCHAR(64) NOT NULL,
    [SalvageValue] DECIMAL(18, 2) NOT NULL,
    [EffectiveFrom] DATE NOT NULL,
    [CreatedBy] NVARCHAR(255) NOT NULL,
    [CreatedDate] DATETIMEOFFSET NOT NULL,
    CONSTRAINT [PK_FinanceAssetOverrides] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UX_FinanceAssetOverrides_AssetId]
    ON [dbo].[FinanceAssetOverrides]([AssetId] ASC);
GO
