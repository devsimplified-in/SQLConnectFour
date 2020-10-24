-- =============================================
-- Author:		One2Nine_Dev
-- Create date: 10/21/2020
-- Description:	Start a new game
-- =============================================
CREATE PROCEDURE [dbo].[usp_StartNewGame] 
	
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE	@OnlinePlayers INT = 0
	SELECT	@OnlinePlayers =  COUNT(*) FROM PlayerQueue
			WHERE PlayerQueue.IsOnline = 1
	DECLARE @GameID INT
	DECLARE @retVal INT = 0
	DECLARE @Winner varchar(20)
	
-- Add a new game	
	INSERT INTO [dbo].[Game]
			   (
				   [GameName]
				   ,[GameIsActive]
				   ,[GameState]
				   ,[GameStartTime]
				   ,[CreatedDate]
				   ,[ModifiedDate]
				   ,[CreatedBy]
				   ,[ModifiedBy]
				   ,[RowGUID]
				)
		 VALUES
			   (
				   
				   'Game' + CAST (NEWID() AS VARCHAR(36))
				   ,1
				   ,'In-Session'
				   ,GETDATE()
				   ,GETDATE()
				   ,GETDATE()
				   ,'System'
				   ,'System'
				   ,NEWID()
				)

	SET @GameID =	SCOPE_IDENTITY()
	-- Add Players
	WHILE @OnlinePlayers < 2
		BEGIN
			DECLARE @AvitarChar AS VARCHAR(1)
			SELECT @AvitarChar = case when @OnlinePlayers%2=0 then 'Y' else 'X' end
			EXEC usp_AddNewPlayer @AvitarChar = @AvitarChar
			SET @OnlinePlayers +=1
		END

	declare @PlayerSet TABLE
	(
		PlayerID INT
	)
	INSERT INTO @PlayerSet
		SELECT	TOP(2) PlayerQueue.PQPlayerID
		FROM	PlayerQueue
		WHERE	PlayerQueue.IsOnline = 1

	INSERT INTO [dbo].[GamePlayer]
	(
		[GPGameID]
		,[GPPlayerID]
		,[CreatedDate]
		,[ModifiedDate]
		,[CreatedBy]
		,[ModifiedBy]
		,[RowGUID]
	)
	SELECT
			@GameID
			,PlayerID
			,GETDATE()
			,GETDATE()
			,'System'
			,'System'
			,NEWID()
	FROM	@PlayerSet

	--UPDATE	PlayerQueue
	--SET		IsOnline = 0
	--WHERE	PQPlayerID IN
	--		(
	--			SELECT  PlayerID 
	--			FROM	@PlayerSet
	--		)

	DECLARE @BoardConfigID TABLE
	(
		BoardConfigID INT
	)
	INSERT INTO @BoardConfigID 
	SELECT		BoardConfig.BoardConfigID
	FROM		BoardConfig 
	INNER JOIN	Board
	ON			BoardConfig.BoardConfigBoardID = Board.BoardID
	WHERE		Board.BoardIsActive = 1
	ORDER BY	BoardConfigBoardID DESC
	
	-- Initialize a new game
	INSERT INTO [dbo].[GameBoardState]
			(
				[BSBoardConfigID]
				,[BSGameID]
				,[CreatedDate]
				,[ModifiedDate]
				,[CreatedBy]
				,[ModifiedBy]
				,[RowGUID]
			)
	SELECT 
			BoardConfigID
			,@GameID
			,GETDATE()
			,GETDATE()
			,'Systeem'
			,'System'
			,NEWID()
	FROM	@BoardConfigID
	DECLARE @Player1 INT
	DECLARE @Player2 INT
	DECLARE @CurrentPlayerID INT
	SET @CurrentPlayerID = (SELECT TOP(1) PlayerID from @PlayerSet)
	IF @CurrentPlayerID%2=0
		BEGIN
			SET @Player1 = @CurrentPlayerID
			SET @Player2 =	(SELECT	PlayerID 
							FROM	@PlayerSet
							WHERE	PlayerID <> @CurrentPlayerID)
		END
	ELSE
		BEGIN
			SET @Player2 =	@CurrentPlayerID
			SET @Player1 =	(SELECT	PlayerID 
							FROM	@PlayerSet
							WHERE	PlayerID <> @CurrentPlayerID)
		END
	
	Declare @NumMoves INT = 1
	Declare @GamePlayerID INT
	Declare @GamePlayer1_ID INT
	Declare @GamePlayer2_ID INT

	SET		@GamePlayer1_ID =	(
											SELECT	GamePlayerID FROM GamePlayer
											WHERE	GamePlayer.GPGameID = @GameID
													AND GamePlayer.GPPlayerID = @Player1
								)


	SET		@GamePlayer2_ID =	(
											SELECT	GamePlayerID FROM GamePlayer
											WHERE	GamePlayer.GPGameID = @GameID
													AND GamePlayer.GPPlayerID = @Player2
								)

	WHILE @NumMoves <=21
		BEGIN
				EXEC @retVal= dbo.usp_ExecuteMove @Player1, @GameID,@NumMoves
				IF @retVal>=4
					BEGIN	
						SET @Winner = cast(@Player1	AS nvarchar)
						BREAK	
					END	
				EXEC @retVal= dbo.usp_ExecuteMove @Player2, @GameID,@NumMoves
				IF @retVal>=4
					BEGIN	
					SET @Winner = cast(@Player2	AS nvarchar)
						BREAK	
					END	
				SET @NumMoves +=1
		END
	IF @retVal	>=4
		BEGIN
			PRINT 'Result: Win, Player::' +@Winner
		END
	ELSE
		BEGIN
			PRINT 'Result: Draw'
		END
	PRINT 'Board State is: '
	exec usp_PrintBoardState @GamePlayer1_ID, @GamePlayer2_ID
END


