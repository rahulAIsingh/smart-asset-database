CREATE TABLE [dbo].[AssetRequests] (
    [Id] NVARCHAR(128) NOT NULL,
    [RequestNumber] NVARCHAR(40) NOT NULL,
    [RequestType] NVARCHAR(64) NOT NULL,
    [RequesterEmail] NVARCHAR(320) NOT NULL,
    [RequesterName] NVARCHAR(255) NULL,
    [RequesterUserId] NVARCHAR(128) NULL,
    [RequestedForEmail] NVARCHAR(320) NULL,
    [Department] NVARCHAR(128) NOT NULL,
    [CostCenter] NVARCHAR(128) NULL,
    [Location] NVARCHAR(255) NOT NULL,
    [BusinessJustification] NVARCHAR(4000) NOT NULL,
    [Urgency] NVARCHAR(24) NOT NULL,
    [Status] NVARCHAR(64) NOT NULL,
    [CurrentApprovalLevel] NVARCHAR(32) NOT NULL,
    [PmApproverEmail] NVARCHAR(320) NOT NULL,
    [BossApproverEmail] NVARCHAR(320) NOT NULL,
    [DestinationUserEmail] NVARCHAR(320) NULL,
    [DestinationManagerEmail] NVARCHAR(320) NULL,
    [RelatedAssetId] NVARCHAR(128) NULL,
    [RequestedCategory] NVARCHAR(128) NULL,
    [RequestedConfigurationJson] NVARCHAR(MAX) NULL,
    [SecurityIncidentFlag] BIT NOT NULL,
    [IncidentDate] DATETIMEOFFSET NULL,
    [IncidentLocation] NVARCHAR(255) NULL,
    [PoliceReportNumber] NVARCHAR(128) NULL,
    [CreatedAt] DATETIMEOFFSET NOT NULL,
    [UpdatedAt] DATETIMEOFFSET NOT NULL,
    [ClosedAt] DATETIMEOFFSET NULL,
    CONSTRAINT [PK_AssetRequests] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [UX_AssetRequests_RequestNumber]
    ON [dbo].[AssetRequests]([RequestNumber] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_AssetRequests_RequesterEmail]
    ON [dbo].[AssetRequests]([RequesterEmail] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_AssetRequests_Status]
    ON [dbo].[AssetRequests]([Status] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_AssetRequests_CurrentApprovalLevel]
    ON [dbo].[AssetRequests]([CurrentApprovalLevel] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_AssetRequests_PmApproverEmail]
    ON [dbo].[AssetRequests]([PmApproverEmail] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_AssetRequests_BossApproverEmail]
    ON [dbo].[AssetRequests]([BossApproverEmail] ASC);
GO

CREATE TABLE [dbo].[AssetRequestApprovals] (
    [Id] NVARCHAR(128) NOT NULL,
    [RequestId] NVARCHAR(128) NOT NULL,
    [Level] NVARCHAR(32) NOT NULL,
    [ApproverEmail] NVARCHAR(320) NOT NULL,
    [Decision] NVARCHAR(64) NOT NULL,
    [Comment] NVARCHAR(4000) NULL,
    [DecidedAt] DATETIMEOFFSET NOT NULL,
    CONSTRAINT [PK_AssetRequestApprovals] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_AssetRequestApprovals_AssetRequests] FOREIGN KEY ([RequestId]) REFERENCES [dbo].[AssetRequests] ([Id]) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX [IX_AssetRequestApprovals_RequestId]
    ON [dbo].[AssetRequestApprovals]([RequestId] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_AssetRequestApprovals_ApproverEmail]
    ON [dbo].[AssetRequestApprovals]([ApproverEmail] ASC);
GO

CREATE TABLE [dbo].[AssetRequestNotifications] (
    [Id] NVARCHAR(128) NOT NULL,
    [RequestId] NVARCHAR(128) NOT NULL,
    [RecipientEmail] NVARCHAR(320) NOT NULL,
    [Channel] NVARCHAR(32) NOT NULL,
    [Type] NVARCHAR(128) NOT NULL,
    [SentAt] DATETIMEOFFSET NOT NULL,
    [Status] NVARCHAR(32) NOT NULL,
    CONSTRAINT [PK_AssetRequestNotifications] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_AssetRequestNotifications_AssetRequests] FOREIGN KEY ([RequestId]) REFERENCES [dbo].[AssetRequests] ([Id]) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX [IX_AssetRequestNotifications_RequestId]
    ON [dbo].[AssetRequestNotifications]([RequestId] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_AssetRequestNotifications_RecipientEmail]
    ON [dbo].[AssetRequestNotifications]([RecipientEmail] ASC);
GO

CREATE TABLE [dbo].[AssetRequestAttachments] (
    [Id] NVARCHAR(128) NOT NULL,
    [RequestId] NVARCHAR(128) NOT NULL,
    [FileName] NVARCHAR(260) NOT NULL,
    [BlobPath] NVARCHAR(1000) NOT NULL,
    [UploadedBy] NVARCHAR(320) NOT NULL,
    [UploadedAt] DATETIMEOFFSET NOT NULL,
    CONSTRAINT [PK_AssetRequestAttachments] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_AssetRequestAttachments_AssetRequests] FOREIGN KEY ([RequestId]) REFERENCES [dbo].[AssetRequests] ([Id]) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX [IX_AssetRequestAttachments_RequestId]
    ON [dbo].[AssetRequestAttachments]([RequestId] ASC);
GO

CREATE TABLE [dbo].[AssetRequestComments] (
    [Id] NVARCHAR(128) NOT NULL,
    [RequestId] NVARCHAR(128) NOT NULL,
    [AuthorEmail] NVARCHAR(320) NOT NULL,
    [Comment] NVARCHAR(4000) NOT NULL,
    [CreatedAt] DATETIMEOFFSET NOT NULL,
    CONSTRAINT [PK_AssetRequestComments] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_AssetRequestComments_AssetRequests] FOREIGN KEY ([RequestId]) REFERENCES [dbo].[AssetRequests] ([Id]) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX [IX_AssetRequestComments_RequestId]
    ON [dbo].[AssetRequestComments]([RequestId] ASC);
GO

CREATE TABLE [dbo].[AssetRequestAudits] (
    [Id] NVARCHAR(128) NOT NULL,
    [RequestId] NVARCHAR(128) NOT NULL,
    [RequestNumber] NVARCHAR(40) NOT NULL,
    [RequestType] NVARCHAR(64) NOT NULL,
    [Action] NVARCHAR(64) NOT NULL,
    [ActorEmail] NVARCHAR(320) NOT NULL,
    [ActorRole] NVARCHAR(64) NULL,
    [FromStatus] NVARCHAR(64) NULL,
    [ToStatus] NVARCHAR(64) NULL,
    [Decision] NVARCHAR(64) NULL,
    [Comment] NVARCHAR(4000) NULL,
    [CreatedAt] DATETIMEOFFSET NOT NULL,
    CONSTRAINT [PK_AssetRequestAudits] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE NONCLUSTERED INDEX [IX_AssetRequestAudits_RequestId]
    ON [dbo].[AssetRequestAudits]([RequestId] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_AssetRequestAudits_RequestNumber]
    ON [dbo].[AssetRequestAudits]([RequestNumber] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_AssetRequestAudits_ActorEmail]
    ON [dbo].[AssetRequestAudits]([ActorEmail] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_AssetRequestAudits_Action]
    ON [dbo].[AssetRequestAudits]([Action] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_AssetRequestAudits_CreatedAt]
    ON [dbo].[AssetRequestAudits]([CreatedAt] ASC);
GO
