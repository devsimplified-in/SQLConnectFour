
-- =============================================
-- Author:		One2Nine_Dev
-- Create date: 10/21/2020
-- Description:	Execute player's move 
-- =============================================
CREATE PROCEDURE [dbo].[usp_ExecuteMove]
	@PlayerID INT,
	@GameID INT,
	@MoveNumber INT,
	@Result INT =0 OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	Declare @GamePlayerID INT
	SELECT	@GamePlayerID = GamePlayerID 
	FROM	GamePlayer
	WHERE	GamePlayer.GPGameID = @GameID
	AND		GamePlayer.GPPlayerID = @PlayerID

	
	-- Select a random position from boardconfig and
	-- Assign the random position to current player.


	-- Check if it was a winning move, terminate if so and return the status = WIN, DRAW
	--exec usp_Check_WinningMove @GamePlayerID


	DECLARE @GameBoardStateID INT
	DECLARE @BoardID INT
	DECLARE @BoardConfigID INT
	SET	@GameBoardStateID =		(
									select TOP(1)	GameBoardStateID
									FROM	GameBoardState
									WHERE	BSGameID = @GameID
									AND OccupiedByGamePlayerID IS NULL
									ORDER BY NEWID()
								)

	SELECT @BoardConfigID = BSBoardConfigID FROM GameBoardState WHERE GameBoardStateID = @GameBoardStateID
	set @BoardID = (SELECT BoardConfigBoardID FROM BoardConfig WHERE BoardConfigID = @BoardConfigID)

	UPDATE	GameBoardState
	SET		OccupiedByGamePlayerID =	(
											SELECT	GamePlayerID FROM GamePlayer
											WHERE	GamePlayer.GPGameID = @GameID
													AND GamePlayer.GPPlayerID = @PlayerID
										)
	WHERE GameBoardState.GameBoardStateID = @GameBoardStateID

	IF @MoveNumber >3
		BEGIN
			DECLARE @rowID INT
			DECLARE @columnID INT
			DECLARE @rowID_CurMove INT
			DECLARE @columnID_CurMove INT
			DECLARE @tempRefCellRowID INT
			DECLARE @tempRefCellColID INT
			DECLARE @SniffFirstOccupiedCell BIT = 1
			DECLARE @SniffAdjacentCell BIT = 1
			DECLARE @tempBoardConfigID INT
			DECLARE @adjacentCellCount INT = 1

			SELECT @rowID=RowID, @columnID = ColumnID FROM dbo.BoardConfig WHERE BoardConfigID = @BoardConfigID	
			SET	@tempRefCellRowID = @rowID
		
			set @rowID_CurMove = @rowID
			set @columnID_CurMove = @columnID

			-- Horizontal check
			WHILE (@SniffFirstOccupiedCell=1)
				BEGIN
					IF(@columnID >=2)
						BEGIN
							SET @tempRefCellColID = @columnID -1
							SET @tempBoardConfigID = (
														SELECT BoardConfigID FROM dbo.BoardConfig
														WHERE BoardConfigBoardID = @BoardID
														AND RowID = @tempRefCellRowID
														AND ColumnID = @tempRefCellColID 
	 												 )
							IF EXISTS(
										SELECT	1 
										FROM	GameBoardState
										WHERE	BSBoardConfigID = @tempBoardConfigID
										AND		OccupiedByGamePlayerID = @GamePlayerID
									 )
								BEGIN
										SET @columnID = @tempRefCellColID
										SET @SniffFirstOccupiedCell=1
								END
							ELSE
								BEGIN
										-- SET @columnID = @tempRefCellColID
										SET @SniffFirstOccupiedCell=0
								END
						END
					ELSE
						BEGIN
							SET @SniffFirstOccupiedCell = 0
						END
					END
			WHILE (@SniffAdjacentCell =1 AND @adjacentCellCount <4)
				BEGIN
						SET @tempBoardConfigID = (
														SELECT BoardConfigID FROM dbo.BoardConfig
														WHERE BoardConfigBoardID = @BoardID
														AND RowID = @rowID	
														AND ColumnID = @columnID 
	 												 )
						IF EXISTS(
										SELECT	1 
										FROM	GameBoardState
										WHERE	BSBoardConfigID = @tempBoardConfigID
										AND		OccupiedByGamePlayerID = @GamePlayerID
									 )
								BEGIN
										SET @columnID += 1
										SET @adjacentCellCount+=1
								END
							ELSE
								BEGIN
										-- SET @columnID = @tempRefCellColID
										SET @SniffAdjacentCell=0
								END
					END

			-- Vertical Check
			SET @SniffFirstOccupiedCell=1
			SET @rowID = @rowID_CurMove
			SET @columnID = @columnID_CurMove	
			SET @SniffAdjacentCell =1 
			IF @adjacentCellCount <4
				BEGIN
					SET @adjacentCellCount =1
				END
			ELSE
				BEGIN
					SET @SniffAdjacentCell = 0
				END
			WHILE (@SniffFirstOccupiedCell=1 AND @adjacentCellCount<4)
				BEGIN
					IF(@rowID >=2)
						BEGIN
							SET @tempRefCellColID = @columnID
							set @tempRefCellRowID = @rowID -1
							SET @tempBoardConfigID = (
														SELECT BoardConfigID FROM dbo.BoardConfig
														WHERE BoardConfigBoardID = @BoardID
														AND RowID = @tempRefCellRowID
														AND ColumnID = @tempRefCellColID 
	 												 )
							IF EXISTS(
										SELECT	1 
										FROM	GameBoardState
										WHERE	BSBoardConfigID = @tempBoardConfigID
										AND		OccupiedByGamePlayerID = @GamePlayerID
									 )
								BEGIN
										SET @columnID = @tempRefCellColID
										SET @rowID = @tempRefCellRowID	
										SET @SniffFirstOccupiedCell=1
								END
							ELSE
								BEGIN
										SET @SniffFirstOccupiedCell=0
								END
						END
					ELSE
						BEGIN
							SET @SniffFirstOccupiedCell = 0
						END
					END
			WHILE (@SniffAdjacentCell =1 AND @adjacentCellCount <4 AND @rowID<=5 AND @columnID<=6)
				BEGIN
					SET @rowID +=1
					SET @tempBoardConfigID = (
												SELECT BoardConfigID FROM dbo.BoardConfig
												WHERE BoardConfigBoardID = @BoardID
												AND RowID = @rowID	
												AND ColumnID = @columnID 
	 											)
					IF EXISTS(
								SELECT	1 
								FROM	GameBoardState
								WHERE	BSBoardConfigID = @tempBoardConfigID
								AND		OccupiedByGamePlayerID = @GamePlayerID
								)
						BEGIN
								SET @rowID += 1
								SET @adjacentCellCount+=1
						END
					ELSE
						BEGIN
								-- SET @columnID = @tempRefCellColID
								SET @SniffAdjacentCell=0
						END
				END

			-- Diagonal check

			SET @SniffFirstOccupiedCell=1
			SET @rowID = @rowID_CurMove
			SET @columnID = @columnID_CurMove	
			SET @SniffAdjacentCell =1 
			IF @adjacentCellCount <4
				BEGIN
					SET @adjacentCellCount =1
				END
			ELSE
				BEGIN
					SET @SniffAdjacentCell = 0
				END
			WHILE (@SniffFirstOccupiedCell=1 AND @adjacentCellCount<4)
				BEGIN
					IF(@rowID >=2 AND @columnID >=2)
						BEGIN
							SET @tempRefCellColID = @columnID -1
							set @tempRefCellRowID = @rowID -1
							SET @tempBoardConfigID = (
														SELECT BoardConfigID FROM dbo.BoardConfig
														WHERE BoardConfigBoardID = @BoardID
														AND RowID = @tempRefCellRowID
														AND ColumnID = @tempRefCellColID 
	 												 )
							IF EXISTS(
										SELECT	1 
										FROM	GameBoardState
										WHERE	BSBoardConfigID = @tempBoardConfigID
										AND		OccupiedByGamePlayerID = @GamePlayerID
									 )
								BEGIN
										SET @columnID = @tempRefCellColID
										SET @rowID = @tempRefCellRowID	
										SET @SniffFirstOccupiedCell=1
								END
							ELSE
								BEGIN
										SET @SniffFirstOccupiedCell=0
								END
						END
					ELSE
						BEGIN
							SET @SniffFirstOccupiedCell = 0
						END
					END
			WHILE (@SniffAdjacentCell =1 AND @adjacentCellCount <4 AND @rowID<=5 AND @columnID<=6)
				BEGIN
					SET @rowID +=1
					SET @columnID +=1
					SET @tempBoardConfigID = (
												SELECT BoardConfigID FROM dbo.BoardConfig
												WHERE BoardConfigBoardID = @BoardID
												AND RowID = @rowID	
												AND ColumnID = @columnID 
	 											)
					IF EXISTS(
								SELECT	1 
								FROM	GameBoardState
								WHERE	BSBoardConfigID = @tempBoardConfigID
								AND		OccupiedByGamePlayerID = @GamePlayerID
								)
						BEGIN
								SET @columnID += 1
								SET @rowID += 1
								SET @adjacentCellCount+=1
						END
					ELSE
						BEGIN
								SET @SniffAdjacentCell=0
						END
				END
				END
END
