CREATE TABLE [dbo].[GameBoardState] (
    [GameBoardStateID]       INT              IDENTITY (1, 1) NOT NULL,
    [BSBoardConfigID]        INT              NOT NULL,
    [BSGameID]               INT              NOT NULL,
    [OccupiedByGamePlayerID] INT              NULL,
    [CreatedDate]            DATETIME         NOT NULL,
    [ModifiedDate]           DATETIME         NOT NULL,
    [CreatedBy]              VARCHAR (100)    NOT NULL,
    [ModifiedBy]             VARCHAR (100)    NOT NULL,
    [RowVersion]             ROWVERSION       NOT NULL,
    [RowGUID]                UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_GameBoardState] PRIMARY KEY CLUSTERED ([GameBoardStateID] ASC),
    CONSTRAINT [FK_GameBoardState_GamePlayer] FOREIGN KEY ([BSGameID]) REFERENCES [dbo].[GamePlayer] ([GamePlayerID])
);

