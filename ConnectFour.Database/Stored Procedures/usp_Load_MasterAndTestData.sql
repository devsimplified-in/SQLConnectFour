-- =============================================
-- Author:		One2Nine_Dev
-- Create date: 10/20/2020,,>
-- Description:	Load Master and test data
-- =============================================
CREATE PROCEDURE [dbo].[usp_Load_MasterAndTestData] 
	@IsTestMode bit = 1
AS
BEGIN

		exec usp_CleanData
		exec usp_CreateBoard
		-- Insert data into Player
END
