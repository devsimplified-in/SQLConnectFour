-- =============================================
-- Author:		One2Nine_Dev
-- Create date: 10/21/2020
-- Description:	Add new players to start a new game
-- =============================================
CREATE PROCEDURE usp_AddNewPlayer 
	@AvitarChar VARCHAR(1)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE	@LastPlayerID INT
	DECLARE @CurrentDate AS DATETIME = GETDATE()
	
		INSERT INTO [dbo].[Player]
				   (
						[FirstName]
					   ,[LastName]
					   ,[UserName]
					   ,[PublicName]
					   ,[AvitarChar]
					   ,[CreatedDate]
					   ,[ModifiedDate]
					   ,[CreatedBy]
					   ,[ModifiedBy]
					   ,[RowGUID]
					)
		 VALUES
			   (
				     'FName_' +  CAST (NEWID() AS VARCHAR(36))
				    ,'LName_' +  CAST (NEWID() AS VARCHAR(36))
				    ,'UsrName_' +  CAST (NEWID() AS VARCHAR(36))
				    ,'PubName_' +  CAST (NEWID() AS VARCHAR(36))
				    ,@AvitarChar 
				    ,@CurrentDate
				    ,@CurrentDate
				    ,'System'
				    ,'System'
				    ,NEWID()
				)
	--	SELECT @LastPlayerID =SCOPE_IDENTITY() 
	SELECT @LastPlayerID = IDENT_CURRENT('Player')


	INSERT INTO [dbo].[PlayerQueue]
			   (
					[PQPlayerID]
					,[CreatedDate]
					,[ModifiedDate]
					,[CreatedBy]
					,[ModifiedBy]
					,[RowGUID]
					,[IsOnline]
				)
		 VALUES
			   (
					@LastPlayerID
					,@CurrentDate
					,@CurrentDate
					,'System'
					,'System'
					,NEWID()
					,1
				)

END