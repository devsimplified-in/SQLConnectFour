CREATE TABLE [dbo].[BoardConfig] (
    [BoardConfigID]      INT              IDENTITY (1, 1) NOT NULL,
    [BoardConfigBoardID] INT              NOT NULL,
    [RowID]              INT              NOT NULL,
    [ColumnID]           INT              NOT NULL,
    [CreatedDate]        DATETIME         NOT NULL,
    [ModifiedDate]       DATETIME         NOT NULL,
    [CreatedBy]          VARCHAR (100)    NOT NULL,
    [ModifiedBy]         VARCHAR (100)    NOT NULL,
    [RowVersion]         ROWVERSION       NOT NULL,
    [RowGUID]            UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_BoardConfig] PRIMARY KEY CLUSTERED ([BoardConfigID] ASC),
    CONSTRAINT [FK_BoardConfig_Board] FOREIGN KEY ([BoardConfigBoardID]) REFERENCES [dbo].[Board] ([BoardID])
);

