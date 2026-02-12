CREATE TABLE [dbo].[Issuances] (
    [Id] NVARCHAR(128) NOT NULL,
    [AssetId] NVARCHAR(128) NOT NULL,
    [UserName] NVARCHAR(512) NOT NULL,
    [UserEmail] NVARCHAR(320) NOT NULL,
    [Status] NVARCHAR(64) NOT NULL,
    [IssueDate] DATETIMEOFFSET NOT NULL,
    [ReturnDate] DATETIMEOFFSET NULL,
    [CreatedAt] DATETIMEOFFSET NOT NULL,
    [UpdatedAt] DATETIMEOFFSET NOT NULL,
    CONSTRAINT [PK_Issuances] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Issuances_Assets] FOREIGN KEY ([AssetId]) REFERENCES [dbo].[Assets] ([Id])
);
GO

CREATE TABLE [dbo].[Maintenance] (
    [Id] NVARCHAR(128) NOT NULL,
    [AssetId] NVARCHAR(128) NOT NULL,
    [Type] NVARCHAR(64) NOT NULL,
    [Description] NVARCHAR(4000) NOT NULL,
    [Cost] DECIMAL(18, 2) NULL,
    [WarrantyExpiry] DATE NULL,
    [Date] DATETIMEOFFSET NOT NULL,
    [PerformedBy] NVARCHAR(255) NOT NULL,
    CONSTRAINT [PK_Maintenance] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Maintenance_Assets] FOREIGN KEY ([AssetId]) REFERENCES [dbo].[Assets] ([Id])
);
GO

CREATE TABLE [dbo].[StockTransactions] (
    [Id] NVARCHAR(128) NOT NULL,
    [AssetId] NVARCHAR(128) NOT NULL,
    [Type] NVARCHAR(16) NOT NULL,
    [Quantity] DECIMAL(18, 2) NOT NULL,
    [Reason] NVARCHAR(MAX) NULL,
    [CreatedAt] DATETIMEOFFSET NOT NULL,
    CONSTRAINT [PK_StockTransactions] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_StockTransactions_Assets] FOREIGN KEY ([AssetId]) REFERENCES [dbo].[Assets] ([Id])
);
GO
