--Student Name: Youfang Yao
--Student ID: 200582794


--Complete all answers on this file

Drop Table if Exists GameMaintenance
Drop Table if Exists Game
Drop Table if Exists Lives
Drop Table if Exists Category
Drop Table if Exists Zone
Drop Table if Exists Job
Drop Table if Exists Staff 
Drop Table if Exists StaffType
Drop Table if Exists TokenChanges 

Drop Trigger if exists TR1
Drop Trigger if exists TR2
Drop Trigger if exists TR3
Drop Trigger if exists TR4
Drop Trigger if exists TR5
Drop Trigger if exists TR6

Create Table StaffType
(
StaffTypeID int identity(1,1) not null constraint pk_StaffType primary key,
StaffTypeName varchar(30) not null,
)

Create Table Staff
(
StaffID int identity(1,1) not null constraint pk_Staff primary key,
FirstName varchar(30) not null,
LastName varchar(30) not null,
Email varchar(50) not null,
Wage smallmoney not null,
StaffTypeId int not null constraint fk_StaffTOStaffType references StaffType(StaffTypeID) 
)



Create Table Job
(
JobID int identity(1,1) not null constraint pk_Job primary key,
JobDescription varchar(30) not null
)

Create Table Zone
(
ZoneID int identity(1,1) not null constraint pk_Zone primary key,
ZoneName varchar(30) not null,
Description varchar(80) not null,
GameCount tinyint not null
)

Create Table Category
(
CategoryCode int identity(1,1) not null constraint pk_Category primary key,
CategoryName varchar(30) not null
)

Create Table Lives
(
LifeID TinyInt not null constraint pk_Lives primary key,
Description varchar(40)
)

Create Table Game
(
GameCode int identity(1,1) not null constraint pk_Games primary key,
GameName varchar(30) not null,
Tokens tinyint not null ,
ZoneID int not null constraint fk_GamesToZone references Zone(ZoneID),
PurchaseDate smalldatetime not null,
PurchasePrice smallmoney not null,
LifeID tinyint not null constraint df_LifeID default 3 constraint fk_GameToLives references Lives(LifeID),
CategoryCode int not null constraint fk_GamesToCategory references Category(CategoryCode)
)

Create Table GameMaintenance
(
MaintenanceID int not null,
GameCode int not null constraint fk_GameMaintenanceToGame references Game(GameCode),
Notes varchar(100) not null,
DateStarted smalldatetime not null,
DateCompleted smalldatetime not null ,
JobID int not null constraint fk_GameMaintenanceToJob references Job(JobID),
StaffID int not null constraint fk_GameMaintenanceToStaff references Staff(StaffID) 
)

Create Table TokenChanges
(
ChangeID int not null identity(1,1) constraint pk_TokenChanges primary key,
GameCode int not null,
ChangeDateTime smalldatetime not null constraint df_ChangeDateTime default getdate(),
OldTokenValue tinyint not null,
NewTokenValue tinyint not null
)
go

Insert into StaffType (StaffTypeName)
values
('Cleaner'),
('Calibrator'),
('Electrical'),
('Sales')

 
INSERT INTO Staff(FirstName, LastName, Email, Wage, StaffTypeId)
VALUES 
('Beyoncé', 'Knowles', 'beyonce@email.com', 16, 1),
('Michael', 'Jackson', 'mj@email.com', 15, 2),
('Adele', 'Adkins', 'adele@email.com', 33, 3),
('Elvis', 'Presley', 'elvis@email.com', 34, 4),
('Freddie', 'Mercury', 'freddie@email.com', 22, 1),
('Whitney', 'Houston', 'whitney@email.com', 12, 2),
('Bob', 'Marley', 'bob@email.com', 14, 3),
('Mariah', 'Carey', 'mariah@email.com', 22, 4),
('John', 'Lennon', 'john@email.com', 32, 1),
('Aretha', 'Franklin', 'aretha@email.com', 22, 2)

Insert into Job (JobDescription)
values
('Screen Cleaner'),
('Control Calibration'),
('Electrical Checkup'),
('Cabinet Painting'),
('Leveling')

Insert into Zone (ZoneName, Description,GameCount)
Values
('80''s Zone', 'Games from the 80''s',7),
('90''s Zone', 'Games from the 90''s',1),
('70''s Zone','Games from the 70''s',0),
('Little Gamers Zone','Kids games',1),
('Teen Zone','Games for Teens',0),
('Whatever','Games for Everyone!',1)

Insert into Category(CategoryName)
values
('Joystick'),
('Wheel'),
('Mouse'),
('Buttons'),
('Virtual')

 
Insert into Lives(LifeID,Description)
values
(1, 'Replace soon'),
(2, 'A few years remaining'),
(3, 'New')


Insert into Game (GameName, Tokens, ZoneID, PurchaseDate,PurchasePrice, LifeID, CategoryCode)
values
('Pac Man',2,1,'jan 1 2008',10000,2,1),
('Donkey Kong',2,1,'jan 1 2009',9000,2,1),
('Space Invaders',1,1,'jan 1 2023',10000,1,1),
('Galaga',2,1,'jan 1 2023',10000,1,1),
('Asteroids',2,1,'jan 1 2008',10000,1,3),
('Mortal Combat',3,2,'jan 1 2008',10000,3,4),
('Frogger',2,4,'jan 1 2008',10000,3,4),
('Tetris',2,6,'jan 1 2008',10000,2,4),
('Pole Position',4,1,'jan 1 2008',10000,3,2),
('Pong',1,1,'jan 20 1972',10000,1,3)

Insert into GameMaintenance(MaintenanceID, Gamecode, notes, DateStarted,DateCompleted,JobID,StaffID)
values
(1,1,'clean screen','Jan 1 2020','Jan 2 2020',1,1),
(2,2,'calibrate dial','Jan 2 2020','Jan 3 2020',2,1),
(1,3,'check controls','Jan 4 2020','Jan 5 2020',3,1),
(2,5,'repaint graphics','Aug 1 2023','Aug 2 2023 ',4,1),
(3,6,'clean screen','Aug 6 2023','Aug 7 2023',1,1),
(4,1,'calibrate control wheel','Aug 8 2023','Aug 10 2023',2,1),
(1,1,'check power cord','Oct 10 2023','Oct 11 2023',3,1),
(2,2,'repaint red','Oct 12 2023','Oct 15 2023',4,1),
(1,1,'paint blue','Oct 17 2023','Oct 18 2023',4,1),
(2,4,'check transformer','Oct 22 2023','Oct 23 2023',3,1),
(3,5,'graphic touchups','Oct 24 2023','Oct 25 2023',4,1),
(1,1,'check screen voltage','Oct 27 2023','Oct 28 2023',3,1)

Select * from  GameMaintenance
Select * from  Game
Select * from  Category
Select * from  Zone
Select * from  Job
Select * from  Staff 
Select * from  StaffType
Select * from  GameMaintenance
go


/* Drop triggers if exist */
DROP TRIGGER IF EXISTS TR1
DROP TRIGGER IF EXISTS TR2
DROP TRIGGER IF EXISTS TR3
DROP TRIGGER IF EXISTS TR4
GO

--1.	(2.5 marks) Game Maintenance records are VERY important to Game Zone.  
-- Do not allow any of the GameMaintenance records to be deleted. 
-- Create a trigger called TR1 that prevents the deletion of any GameMaintenances records. 
CREATE TRIGGER TR1
ON GameMaintenance
FOR Delete
AS
BEGIN
	IF @@ROWCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION
			RaisError('You cannot delete any records in table GameMaintenance.', 16, 1)
			
		END
END
RETURN
go
--Test
--DELETE FROM GameMaintenance
--WHERE GameMaintenance.MaintenanceID = 1
--GO
 

--2.	(3.5 marks) Games that have been purchased more than 20 years ago are not allowed to have any more maintenance on them. 
-- Create a trigger called TR2 that will prevent the addition of new GameMaintenance records for any games that were purchased more than 20 years ago.
CREATE TRIGGER TR2
ON GameMaintenance
FOR Insert
AS
BEGIN
	IF @@ROWCOUNT > 0
		BEGIN
			IF EXISTS (SELECT * FROM inserted 
						INNER JOIN Game
						ON inserted.GameCode = Game.GameCode
						WHERE DATEDIFF(yy, Game.PurchaseDate, GETDATE()) > 20)
				BEGIN
					ROLLBACK TRANSACTION
					RaisError('You cannot add any maintenace records which were purchased 20 years ago.', 16, 1)
				END
		END
END
RETURN
go
--Test
--INSERT INTO GameMaintenance
--	(MaintenanceID, Gamecode, notes, DateStarted,DateCompleted,JobID,StaffID)
--VALUES
--	(1, 10,'check screen voltage','Oct 27 2023','Oct 28 2023',3,1)
--GO
 

--3.	(3 marks) Create a trigger called TR3 on the Game table that will execute when new games are added. 
-- When games are added, adjust the GameCount in the zone table to reflect the current number of games in that zone. 
-- Assume that only one game will be inserted at a time. 
CREATE TRIGGER TR3
ON Game
FOR Insert
AS
BEGIN
	IF @@ROWCOUNT > 0
		BEGIN
			DECLARE @ZoneID INT
			SELECT @ZoneID = inserted.ZoneID FROM inserted
			UPDATE Zone
				SET Zone.GameCount = Zone.GameCount + 1
			WHERE Zone.ZoneID = @ZoneID
			IF @@ERROR <> 0
				BEGIN
					ROLLBACK TRANSACTION
					RaisError('Update table Zone failed.', 16, 1)
				END
		END
END
RETURN
go
--Test
--INSERT INTO Game
--	(GameName, Tokens, ZoneID, PurchaseDate,PurchasePrice, LifeID, CategoryCode)
--VALUES
--	('Pong-a',1,1,'jan 20 1972',10000,1,3)
--GO


--4.	(3.5 marks) The amount of tokens required to play a game changes over time. 
-- Create a trigger called TR4 on the Game table that records changes to the number of tokens. 
-- Record any changes in the TokenChanges table. The TokenChanges table has been included in the Quiz4.sql file.
CREATE TRIGGER TR4
ON Game
FOR UPDATE
AS
BEGIN
	IF @@ROWCOUNT > 0 AND UPDATE(Tokens)
		BEGIN
			INSERT INTO TokenChanges
				(GameCode, OldTokenValue, NewTokenValue)
			SELECT deleted.GameCode, deleted.Tokens, inserted.Tokens
				FROM deleted
				INNER JOIN inserted
				ON deleted.GameCode = inserted.GameCode
			IF @@ERROR <> 0
				BEGIN
					ROLLBACK TRANSACTION
					RaisError('Insert new log record into table TokenChanges failed.', 16, 1)
				END
		END
END
RETURN
go
--Test
--UPDATE Game
--	SET Game.Tokens = Game.Tokens + 1
--WHERE Game.Tokens = 1
--GO
 

--5.	(0.5 mark): Put your name at the top of the “Quiz4.sql” file in the place indicated.
