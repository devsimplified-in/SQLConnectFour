CREATE TABLE [dbo].[Log] (
    [LogID]        INT              NOT NULL,
    [LogGameID]    INT              NOT NULL,
    [LogMessage]   NVARCHAR (1000)  NOT NULL,
    [CreatedDate]  DATETIME         NOT NULL,
    [ModifiedDate] DATETIME         NOT NULL,
    [CreatedBy]    VARCHAR (100)    NOT NULL,
    [ModifiedBy]   VARBINARY (100)  NOT NULL,
    [RowVersion]   ROWVERSION       NOT NULL,
    [RowGUID]      UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED ([LogID] ASC),
    CONSTRAINT [FK_Log_Game] FOREIGN KEY ([LogGameID]) REFERENCES [dbo].[Game] ([GameID])
);

