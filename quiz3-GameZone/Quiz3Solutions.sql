/*
 * The SQL script for Quiz 3 : Game Zone!
 * Term: DMIT1508 - Database Fundamentals - 2023/2024 Spring Term (1233) (E01)
 * Date: Aug 8, 2024
 *
 * Student: Youfang Yao
 * Student ID: 200582794
 */
 
DROP PROCEDURE IF EXISTS AddGame
DROP PROCEDURE IF EXISTS ChangeZone
DROP PROCEDURE IF EXISTS HighMaintenenaceGames
DROP PROCEDURE IF EXISTS AddGameMaintenance
Go

-- 1.(4.5 marks) Write a stored procedure called AddGame that will have parameters of 
-- GameName, Tokens, ZoneID, PurchaseDate, PurchasePrice, and CategoryCode 
-- Add a new record to the Game table.
-- Provide an appropriate error message if the PurchaseDate provided is after todays date. 
-- Select the database generated(identity) GameCode if the insert was successful. 
CREATE PROCEDURE AddGame (@GameName VARCHAR(30) = NULL,
						  @Tokens TINYINT = NULL, 
						  @ZoneID INT = NULL, 
						  @PurchaseDate SMALLDATETIME = NULL, 
						  @PurchasePrice SMALLMONEY = NULL,
						  @CategoryCode INT = NULL)
AS
BEGIN
	/* Check parameters for stored procedure */
	IF @GameName IS NULL OR @GameName = ''
		BEGIN
			RaisError('You must provide a game name!', 16, 1)
		END
	ELSE IF @Tokens IS NULL
		BEGIN
			RaisError('You must provide a tokens value!', 16, 1)
		END
	ELSE IF @ZoneID IS NULL
		BEGIN
			RaisError('You must provide a Zone ID!', 16, 1)
		END
	ELSE IF @PurchaseDate IS NULL
		BEGIN
			RaisError('You must provide the purchase data!', 16, 1)
		END
	ELSE IF @PurchasePrice IS NULL
		BEGIN
			RaisError('You must provide the purchase price!', 16, 1)
		END
	ELSE IF @CategoryCode IS NULL
		BEGIN
			RaisError('You must provide the game category code!', 16, 1)
		END
	ELSE
		BEGIN
			DECLARE @Error INT
			DECLARE @RowCount INT
			DECLARE @Identity INT

			/* Check the @PurchaseDate is valid or not */
			IF @PurchaseDate > GetDate()
				BEGIN
					RaisError('The purchase date is invalid!', 16, 2)
				END
			ELSE IF NOT EXISTS (SELECT * FROM Zone WHERE Zone.ZoneID = @ZoneID)
				BEGIN
					RaisError('The ZoneID: %d does not exist', 16, 3, @ZoneID)
				END
			ELSE IF NOT EXISTS (SELECT * FROM Category WHERE Category.CategoryCode = @CategoryCode)
				BEGIN
					RaisError('The CategoryCode: %d does not exist', 16, 4, @CategoryCode)
				END
			ELSE
				BEGIN
					/* Insert the new type description to tablt StaffType */
					INSERT INTO Game
						(GameName, Tokens, ZoneID, PurchaseDate, PurchasePrice, CategoryCode) 
					VALUES 
						(@GameName, @Tokens, @ZoneID, @PurchaseDate, @PurchasePrice, @CategoryCode)
					SELECT @Error = @@ERROR, @RowCount=@@ROWCOUNT, @Identity = @@IDENTITY
					IF @Error <> 0
						BEGIN
							RaisError('Insert a new record into table Game failed!', 16, 5)
						END
					ELSE IF @RowCount = 0
						BEGIN
							RaisError('You did not insert any record into table Game!', 16, 6)
						END
					ELSE
						/* Select the type id of new record */
						BEGIN
							SELECT @Identity AS 'New Game Code'
						END
				END
		END
END
RETURN
GO
-- Test
-- EXEC AddGame 'Pong2', 2, 1, 'jan 1 2022', 10000, 3
-- GO


-- 2.(4 marks) Write a stored procedure called ChangeZone that will update the ZoneName and Description of one zone. 
CREATE PROCEDURE ChangeZone(@ZoneID INT = NULL,
							@ZoneName VARCHAR(30) = NULL,
							@Description VARCHAR(80) = NULL)
AS
BEGIN
	DECLARE @Error INT
	DECLARE @RowCount INT

	/* Check parameters for stored procedure */
	IF @ZoneID IS NULL 
		BEGIN
			RaisError('You must provide the Zone ID value!', 16, 1)
		END
	ELSE IF @ZoneName IS NULL 
		BEGIN
			RaisError('You must provide the Zone Name!', 16, 2)
		END
	ELSE IF @Description IS NULL 
		BEGIN
			RaisError('You must provide the Zone description!', 16, 3)
		END
	ELSE
		BEGIN
			/* Raise an error if the Zone ID does not exists */
			IF NOT EXISTS (SELECT * FROM Zone WHERE Zone.ZoneID = @ZoneID)
				BEGIN
					RaisError('The Zone ID: %d does not exists!', 16, 4, @ZoneID)
				END
			/* Otherwise, update this record */
			ELSE
				BEGIN
					UPDATE Zone
						SET Zone.ZoneName = @ZoneName, Zone.Description = @Description
					WHERE Zone.ZoneID = @ZoneID
					SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT
					IF @Error <> 0
						BEGIN
							RaisError('Update records in table Zone failed!', 16, 5)
						END
					ELSE IF @RowCount = 0
						BEGIN
							RaisError('You did not update any record in table Zone!', 16, 6)
						END
				END
		END
END
RETURN
Go
-- Test
-- EXEC ChangeZone 100, 'aaaa', 'bbb'
-- GO


-- 3.(3 marks) Write a stored procedure called HighMaintenenaceGames that returns the GameName of all the games 
-- whose total number of maintenance days is over a value that was passed to the stored procedure as a parameter. 
CREATE PROCEDURE HighMaintenenaceGames(@NumberOfDays INT = NULL)
AS
BEGIN
	DECLARE @Error INT
	DECLARE @RowCount INT

	/* Check parameters for stored procedure */
	IF @NumberOfDays IS NULL 
		BEGIN
			RaisError('You must provide the days number of maintenance!', 16, 1)
		END
	ELSE
		BEGIN
			SELECT Game.GameName
			FROM Game
				LEFT JOIN GameMainTenance
				ON Game.GameCode = GameMainTenance.GameCode
				GROUP BY Game.GameCode, Game.GameName
				HAVING SUM(DATEDIFF(DAY, GameMainTenance.DateStarted, GameMainTenance.DateCompleted)) > @NumberOfDays
		END
END
RETURN
GO
-- Test
-- EXEC HighMaintenenaceGames 3
-- GO


-- 4.(8.5 marks) Write a stored procedure using a transaction called AddGameMaintenance 
-- that accepts all the parameters required to add a new GameMaintenance record. 
-- As new maintenance is performed on a game, the expected lifespan of the game is reduced.
-- The LIfeID attribute contains a value between 1 and 3. 3 indicates there is lots of life left in the game 
-- and it should last a long time and 1 represents that the game is getting old and needs to be replaced soon. 
-- The LifeID attribute value IS NOT provided by user and is evaluated each time a GameMaintenance record is added. 
-- The following chart defines how the LiveID value is calculated.
CREATE PROCEDURE AddGameMaintenance(@MaintenanceID INT = NULL,
								    @GameCode INT = NULL,
									@Notes VARCHAR(100) = NULL,
									@DateStarted SMALLDATETIME = NULL,
									@DateCompleted SMALLDATETIME = NULL,
									@JobID INT = NULL,
									@StaffID INT = NULL)
AS
BEGIN
	/* Check parameters for stored procedure */
	IF @MaintenanceID IS NULL
		BEGIN
			RaisError('You must provide a MaintenanceID value!', 16, 1)
		END
	ELSE IF @GameCode IS NULL
		BEGIN
			RaisError('You must provide a GameCode value!', 16, 2)
		END
	ELSE IF @Notes IS NULL
		BEGIN
			RaisError('You must provide a note!', 16, 3)
		END
	ELSE IF @DateStarted IS NULL
		BEGIN
			RaisError('You must provide the DateStarted value!', 16, 4)
		END
	ELSE IF @DateCompleted IS NULL
		BEGIN
			RaisError('You must provide the DateCompleted value!', 16, 5)
		END
	ELSE IF @JobID IS NULL
		BEGIN
			RaisError('You must provide a JobID value!', 16, 6)
		END
	ELSE IF @StaffID IS NULL
		BEGIN
			RaisError('You must provide a StaffID value!', 16, 7)
		END
	ELSE
		BEGIN
			DECLARE @Error INT
			DECLARE @RowCount INT
			DECLARE @MaintenanceCount INT
			DECLARE @NewLifeID INT

			/* Check related records exist or not */
			IF NOT EXISTS (SELECT * FROM Game WHERE Game.GameCode = @GameCode)
				BEGIN
					RaisError('The Game Code: %d does not exist!', 16, 8, @GameCode)
				END
			ELSE IF NOT EXISTS (SELECT * FROM Job WHERE Job.JobID = @JobID)
				BEGIN
					RaisError('The Job ID: %d does not exist!', 16, 9, @JobID)
				END
			ELSE IF NOT EXISTS (SELECT * FROM Staff WHERE Staff.StaffID = @StaffID)
				BEGIN
					RaisError('The Staff ID: %d does not exist!', 16, 10, @StaffID)
				END
			ELSE
				/* Use transaction to update multi-table */
				BEGIN
					BEGIN TRANSACTION
					/* Insert new record to table GameMaintenance*/
					INSERT INTO GameMaintenance
						(MaintenanceID, GameCode, Notes, DateStarted, DateCompleted, JobID, StaffID)
					VALUES
						(@MaintenanceID, @GameCode, @Notes, @DateStarted, @DateCompleted, @JobID, @StaffID)
					SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT
					IF @Error <> 0
						BEGIN
							ROLLBACK TRANSACTION
							RaisError('Insert this new record to table GameMaintenance failed!', 16, 11)
						END
					ELSE IF @RowCount = 0
						BEGIN
							ROLLBACK TRANSACTION
							RaisError('You did not insert any new record to table GameMaintenance!', 16, 12)
						END
					/* Then, update the relevant record table Game */
					ELSE
						BEGIN
							SELECT @MaintenanceCount = COUNT(*) FROM GameMaintenance WHERE GameMaintenance.GameCode = @GameCode
							IF @MaintenanceCount >= 1 AND @MaintenanceCount <= 5
								BEGIN
									SET @NewLifeID = 3
								END
							ELSE IF @MaintenanceCount >= 6 AND @MaintenanceCount <= 10
								BEGIN
									SET @NewLifeID = 2
								END
							ELSE
								BEGIN
									SET @NewLifeID = 1
								END
							UPDATE Game
								SET Game.LifeID = @NewLifeID
							WHERE Game.GameCode = @GameCode
							SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT
							IF @Error <> 0
								BEGIN
									ROLLBACK TRANSACTION
									RaisError('Update this record in table Game failed!', 16, 13)
								END
							ELSE IF @RowCount = 0
								BEGIN
									ROLLBACK TRANSACTION
									RaisError('You did not update any new record to table Game!', 16, 14)
								END
							/* Successfully! */
							COMMIT TRANSACTION
						END
				END
		END
END
RETURN
GO
-- Test
-- EXEC AddGameMaintenance 2, 6, 'clean screen', 'Aug 6 2024', 'Aug 7 2024', 1, 1
-- EXEC AddGameMaintenance 3, 6, 'clean screen', 'Aug 6 2024', 'Aug 7 2024', 1, 1
-- EXEC AddGameMaintenance 4, 6, 'clean screen', 'Aug 6 2024', 'Aug 7 2024', 1, 1
-- EXEC AddGameMaintenance 5, 6, 'clean screen', 'Aug 6 2024', 'Aug 7 2024', 1, 1
-- EXEC AddGameMaintenance 6, 6, 'clean screen', 'Aug 6 2024', 'Aug 7 2024', 1, 1
-- GO