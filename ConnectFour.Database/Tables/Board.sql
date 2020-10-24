CREATE TABLE [dbo].[Board] (
    [BoardID]        INT              IDENTITY (1, 1) NOT NULL,
    [BoardName]      VARCHAR (100)    NOT NULL,
    [BoardIsActive]  BIT              NOT NULL,
    [BoardIsDeleted] BIT              NOT NULL,
    [CreatedDate]    DATETIME         NOT NULL,
    [ModifiedDate]   DATETIME         NOT NULL,
    [CreatedBy]      VARCHAR (100)    NOT NULL,
    [ModifiedBy]     VARCHAR (100)    NOT NULL,
    [RowVersion]     ROWVERSION       NOT NULL,
    [RowGUID]        UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Board] PRIMARY KEY CLUSTERED ([BoardID] ASC)
);

