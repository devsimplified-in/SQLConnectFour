CREATE TABLE [dbo].[Player] (
    [PlayerID]     INT              IDENTITY (1, 1) NOT NULL,
    [FirstName]    VARCHAR (50)     NOT NULL,
    [LastName]     VARCHAR (50)     NOT NULL,
    [UserName]     VARCHAR (50)     NOT NULL,
    [PublicName]   VARCHAR (50)     NOT NULL,
    [AvitarChar]   CHAR (1)         NOT NULL,
    [CreatedDate]  DATETIME         NOT NULL,
    [ModifiedDate] DATETIME         NOT NULL,
    [CreatedBy]    VARCHAR (100)    NOT NULL,
    [ModifiedBy]   VARCHAR (100)    NOT NULL,
    [RowVersion]   ROWVERSION       NOT NULL,
    [RowGUID]      UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Player] PRIMARY KEY CLUSTERED ([PlayerID] ASC)
);

