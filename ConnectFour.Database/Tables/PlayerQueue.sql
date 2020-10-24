CREATE TABLE [dbo].[PlayerQueue] (
    [PlayerQueueID] INT              IDENTITY (1, 1) NOT NULL,
    [PQPlayerID]    INT              NOT NULL,
    [CreatedDate]   DATETIME         NOT NULL,
    [ModifiedDate]  DATETIME         NOT NULL,
    [CreatedBy]     VARCHAR (100)    NOT NULL,
    [ModifiedBy]    VARCHAR (100)    NOT NULL,
    [RowVersion]    ROWVERSION       NOT NULL,
    [RowGUID]       UNIQUEIDENTIFIER NOT NULL,
    [IsOnline]      BIT              NOT NULL,
    CONSTRAINT [PK_PlayerQueue] PRIMARY KEY CLUSTERED ([PlayerQueueID] ASC),
    CONSTRAINT [FK_PlayerQueue_Player] FOREIGN KEY ([PQPlayerID]) REFERENCES [dbo].[Player] ([PlayerID])
);

