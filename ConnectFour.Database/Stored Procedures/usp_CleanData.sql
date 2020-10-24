-- =============================================
-- Author:		One2Nine_Dev
-- Create date: 10/20/2020
-- Description:	Clean Master and test data
-- =============================================
CREATE PROCEDURE [dbo].[usp_CleanData] 
AS
BEGIN
	DELETE GameBoardState
	DBCC CHECKIDENT(GameBoardState, RESEED,0)

	DELETE GamePlayer
	DBCC CHECKIDENT(GamePlayer, RESEED,0)

	DELETE [dbo].[BoardConfig]
	DBCC CHECKIDENT([BoardConfig], RESEED,0)
	
	DELETE [dbo].[Board]
	DBCC CHECKIDENT(Board, RESEED,0)
	
	DELETE PlayerQueue
	DBCC CHECKIDENT(PlayerQueue, RESEED,0)
	
	
	DELETE Player
	DBCC CHECKIDENT(Player, RESEED,0)
	
	DELETE Game
	DBCC CHECKIDENT(Game, RESEED,0)
END
