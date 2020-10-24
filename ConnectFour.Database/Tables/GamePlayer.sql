CREATE TABLE [dbo].[GamePlayer] (
    [GamePlayerID] INT              IDENTITY (1, 1) NOT NULL,
    [GPGameID]     INT              NOT NULL,
    [GPPlayerID]   INT              NOT NULL,
    [CreatedDate]  DATETIME         NOT NULL,
    [ModifiedDate] DATETIME         NOT NULL,
    [CreatedBy]    VARCHAR (100)    NOT NULL,
    [ModifiedBy]   VARCHAR (100)    NOT NULL,
    [RowVersion]   ROWVERSION       NOT NULL,
    [RowGUID]      UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_GamePlayer] PRIMARY KEY CLUSTERED ([GamePlayerID] ASC),
    CONSTRAINT [FK_GamePlayer_Game] FOREIGN KEY ([GPGameID]) REFERENCES [dbo].[Game] ([GameID]),
    CONSTRAINT [FK_GamePlayer_Player] FOREIGN KEY ([GPPlayerID]) REFERENCES [dbo].[Player] ([PlayerID])
);

