-- =============================================
-- Author:		One2Nine_Dev
-- Create date: 10/21/2020
-- Description:	Start a new game
-- =============================================
CREATE PROCEDURE [dbo].[usp_CreateBoard] 
	
AS
BEGIN
	SET NOCOUNT ON;
	
	-- Insert data in the Board table
		DECLARE @CurrentDate DATETIME = Getdate()
		INSERT INTO [dbo].[Board]
				   (	
						[BoardName]
					   ,[BoardIsActive]
					   ,[BoardIsDeleted]
					   ,[CreatedDate]
					   ,[ModifiedDate]
					   ,[CreatedBy]
					   ,[ModifiedBy]
					   ,[RowGUID]
					)
			 VALUES
				   ( 
					   '2020_'+ (SELECT FORMAT(GETDATE(),'MM-dd-yy') AS DATE)
					   ,1
					   ,0
					   ,@CurrentDate 
					   ,@CurrentDate 
					   ,'Admin'
					   ,'Admin'
					   ,NEWID()
					)
	-- Insert into board config
	DECLARE @BoardID INT = (SELECT TOP(1) Board.BoardID FROM Board WHERE Board.BoardIsActive = 1 ORDER BY BoardID DESC)

	-- 42 moves/positions
	Declare @loopcounter INT = 0
	DECLARE @Totalrows INT = 6
	DECLARE @TotalCoumns INT = 7
	DECLARE @CurrentRow INT = 0
	DECLARE @CurrentColumn INT = 0

	WHILE @loopcounter < 42
		BEGIN
			IF @loopcounter%7 = 0
				BEGIN
					SET	@CurrentRow +=1
					SET @CurrentColumn = 1
				END
			ELSE
				BEGIN
					SET @CurrentColumn += 1
				END
				
			INSERT INTO [dbo].[BoardConfig]
				(
					[BoardConfigBoardID]
					,[RowID]
					,[ColumnID]
					,[CreatedDate]
					,[ModifiedDate]
					,[CreatedBy]
					,[ModifiedBy]
					,[RowGUID]
				)
			VALUES
				(
					@BoardID
					,@CurrentRow
					,@CurrentColumn
					,@CurrentDate
					,@CurrentDate
					,'Admin'
					,'Admin'
					,NEWID()
				)
			
			SET	@loopcounter +=1
		END

END
