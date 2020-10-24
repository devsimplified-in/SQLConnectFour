-- =============================================
-- Author:		One2Nine_Dev
-- Create date: 10/24/2020
-- Description:	Print FinalState of Board
-- =============================================
CREATE PROCEDURE [dbo].[usp_PrintBoardState] 
	@GamePlayer1_ID INT,
	@GamePlayer2_ID INT
AS
BEGIN
	SET NOCOUNT ON;
	-- Print 6X6 matrix

SELECT  *
FROM
		(
			select	gbs.BSgameid, 
					case	when gbs.occupiedbyGamePlayerID = @GamePlayer1_ID
							then 'P1'
							else 'P2' 
					end As Player, 
					CAST(bc.rowid as VARCHAR(10)) rowid,
					CAST(bc.columnid as VARCHAR(10)) columnid
			from	gameboardstate gbs
					inner join BoardConfig  bc
					on gbs.bsBoardConfigID = bc.BoardConfigID
		)OBJ
		PIVOT(
				MAX(Player)
				FOR columnid IN
					(
						[1],[2],[3],[4],[5],[6],[7]
					)
		)AS Ptable



	declare @rowId INT = 1

--	select gbs.BSgameid, 
--case when gbs.occupiedbyGamePlayerID = 1
--	then 'P1'
--	else 'P2' end As Player, bc.rowid, bc.columnid from gameboardstate gbs
--inner join BoardConfig  bc
--on gbs.bsBoardConfigID = bc.BoardConfigID
	--while @rowid <=6
	--	BEGIN
	--		SELECT STUFF
	--		(
	--			(select ', ' + CASE when OccupiedByGamePlayerID = @GamePlayer1_ID
	--									then 'P1'
	--									else 'P2'
	--									end
				
	--			from GameBoardState as gbs
	--			where gbs.BSBoardConfigID = BC.BoardConfigID
	--			and BC.RowID = @rowid
	--			for xml path('')),1,1,'') AS AAA
	--			from BoardConfig bc
	--	END
	--	set @rowid +=1
END
