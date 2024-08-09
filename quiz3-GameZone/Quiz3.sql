--Student Name: 
DROP PROC IF EXISTS ADDGAME
DROP PROC IF EXISTS CHANGEZONE
DROP PROC IF EXISTS HIGHMAINTENANCEGAMES
DROP PROC IF EXISTS ADDGAMEMAINTENANCE

--Complete all answers on this file

Drop Table if Exists GameMaintenance
Drop Table if Exists Game
Drop Table if Exists Lives
Drop Table if Exists Category
Drop Table if Exists Zone
Drop Table if Exists Job
Drop Table if Exists Staff 
Drop Table if Exists StaffType
 


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
Description varchar(80) not null
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
StaffID int not null constraint fk_GameMaintenanceToStaff references Staff(StaffID) ,
constraint pk_GameMaintenance primary key(MaintenanceID, GameCode)
)

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

Insert into Zone (ZoneName, Description)
Values
('80''s Zone', 'Games from the 80''s'),
('90''s Zone', 'Games from the 90''s'),
('70''s Zone','Games from the 70''s' ),
('Little Gamers Zone','Kids games'),
('Teen Zone','Games for Teens'),
('Whatever','Games for Everyone!')

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
('Pong',1,1,'jan 1 2008',10000,1,3)

Insert into GameMaintenance(MaintenanceID, Gamecode, notes, DateStarted,DateCompleted,JobID,StaffID)
values
(1,1,'clean screen','Jan 1 2020','Jan 2 2020',1,1),
(2,1,'check screen voltage','Oct 27 2023','Oct 28 2023',3,1),
(3,1,'paint blue','Oct 17 2023','Oct 18 2023',4,1),
(4,1,'check power cord','Oct 10 2023','Oct 11 2023',3,1),
(5,1,'calibrate control wheel','Aug 8 2023','Aug 10 2023',2,1),
(1,2,'repaint red','Oct 12 2023','Oct 15 2023',4,1),
(2,2,'calibrate dial','Jan 2 2020','Jan 3 2020',2,1),
(1,3,'check controls','Jan 4 2020','Jan 5 2020',3,1),
(1,4,'check transformer','Oct 22 2023','Oct 23 2023',3,1),
(1,5,'graphic touchups','Oct 24 2023','Oct 25 2023',4,1),
(2,5,'repaint graphics','Aug 1 2023','Aug 2 2023 ',4,1),
(1,6,'clean screen','Aug 6 2023','Aug 7 2023',1,1)




Select * from  GameMaintenance
Select * from  Game
Select * from  Category
Select * from  Zone
Select * from  Job
Select * from  Staff 
Select * from  StaffType

go
--4.5 marks) Write a stored procedure called AddGame that will have parameters of GameName, Tokens, ZoneID, PurchaseDate, PurchasePrice, and CategoryCode. Add a new record to the Game table. Provide an appropriate error message if the PurchaseDate provided is after todays date. Select the database generated(identity) GameCode if the insert was successful. 


go
--2.	(4 marks) Write a stored procedure called ChangeZone that will update the ZoneName and Description of one zone. 




go
--3.	(3 marks) Write a stored procedure called HighMaintenanceGames that returns the GameName of all the games whose total number of maintenance days is over a value that was passed to the stored procedure as a parameter. 





go
--4.	(8.5 marks) Write a stored procedure called AddGameMaintenance that accepts all the parameters required to add a new GameMaintenance record. As new maintenance is performed on a game, the expected lifespan of the game is reduced. The LifeID attribute contains a value between 1 and 3. 3 indicates there is lots of life left in the game and it should last a long time and 1 represents that the game is getting old and needs to be replaced soon. The LifeID attribute value IS NOT provided by user and is evaluated each time a GameMaintenance record is added. The following chart defines how the LifeID value is calculated.

--MaintanceCount	LifeID
--1-5								3
--6-10							2
--More than 10			1

--Perform the following tasks:
--1.	If the maintenance record is not for an existing Game give an error message.
--2.	If the Game is an existing Game, add a record to the GameMaintenance table.
--3.	Adjust the lives attribute for that game according to the number of maintenance jobs that have been performed on that game.











