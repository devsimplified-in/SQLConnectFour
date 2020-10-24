CREATE TABLE [dbo].[Game] (
    [GameID]        INT              IDENTITY (1, 1) NOT NULL,
    [GameName]      NVARCHAR (50)    NOT NULL,
    [GameIsActive]  BIT              NOT NULL,
    [GameState]     VARCHAR (20)     NULL,
    [GameStartTime] DATETIME         NOT NULL,
    [CreatedDate]   DATETIME         NOT NULL,
    [ModifiedDate]  DATETIME         NOT NULL,
    [CreatedBy]     VARCHAR (100)    NOT NULL,
    [ModifiedBy]    VARCHAR (100)    NOT NULL,
    [RowVersion]    ROWVERSION       NOT NULL,
    [RowGUID]       UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Game] PRIMARY KEY CLUSTERED ([GameID] ASC)
);

