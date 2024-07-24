Drop Table if Exists GameMaintenance
Drop Table if Exists Game
Drop Table if Exists Category
Drop Table if Exists Zone
Drop Table if Exists Job
Drop Table if Exists Staff 
Drop Table if Exists StaffType
Drop View if exists MaintenanceHistory

--PART A - Constraints
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

Create Table Game
(
GameCode int identity(1,1) not null constraint pk_Games primary key,
GameName varchar(30) not null,
Tokens tinyint not null ,
ZoneID int not null constraint fk_GamesToZone references Zone(ZoneID),
PurchaseDate smalldatetime not null,
PurchasePrice smallmoney not null,
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

Insert into Game (GameName, Tokens, ZoneID, PurchaseDate,PurchasePrice, CategoryCode)
values
('Pac Man',2,1,'jan 1 2008',10000,1),
('Donkey Kong',2,1,'jan 1 2009',9000,1),
('Space Invaders',1,1,'jan 1 2023',10000,1),
('Galaga',2,1,'jan 1 2023',10000,1),
('Asteroids',2,1,'jan 1 2008',10000,3),
('Mortal Combat',3,2,'jan 1 2008',10000,4),
('Frogger',2,4,'jan 1 2008',10000,4),
('Tetris',2,6,'jan 1 2008',10000,4),
('Pole Position',4,1,'jan 1 2008',10000,2),
('Pong',1,1,'jan 1 2008',10000,3)

Insert into GameMaintenance(MaintenanceID, Gamecode, notes, DateStarted,DateCompleted,JobID,StaffID)
values
(1,1,'clean screen','Jan 1 2020','Jan 2 2020',1,1),
(2,2,'calibrate dial','Jan 2 2020','Jan 3 2020',2,1),
(1,3,'check controls','Jan 4 2020','Jan 5 2020',3,1),
(2,5,'repaint graphics','Aug 1 2023','Aug 2 2023 ',4,1),
(3,6,'clean screen','Aug 6 2023','Aug 7 2023',1,1),
(4,1,'calibrate control wheel','Aug 8 2023','Jan 9 2023',2,1),
(1,1,'check power cord','Oct 10 2023','Oct 11 2023',3,1),
(2,2,'repaint red','Oct 12 2023','Oct 15 2023',4,1),
(1,1,'paint blue','Oct 17 2023','Oct 18 2023',4,1),
(2,4,'check transformer','Oct 22 2023','Oct 23 2023',3,1),
(3,5,'graphic touchups','Oct 24 2023','Oct 25 2023',4,1),
(1,1,'check screen voltage','Oct 27 2023','Oct 28 2023',3,1)

select * from game
select * from job
select * from staff

select * from category


--PART B - Indexes
 

--PART C – Alter Table
--Assuming the tables have data in them already, use the alter table statement to add a new column defined as CategoryDescription varchar(100) that does not allow nulls. Any Categories that do not have a CategoryDescription should default to “None”  
 

--PART D - Queries
--Write the following queries:
--1.	Which games keep needing maintenance? Select the GameCode and GameName for all the games that have more than 4 GameMaintenance records.  
 

--2.	Select all the StaffID’s, Staff full names (as one column) and their StaffType names  
 

--3.	How many Games have been purchased each year? Select the Year and the count. Show the results in descending order by year  
 

--4.	Select the game names that have not had any maintenance started on them in the current calendar year. Do not use a join.  
 

--5  Select the JobID, JobDescription and the count of how many times each job has been performed.  
 
--PART E - DML
--1.	Add $1 to the wage of all the staff whose current wage is less than $15 .  
 
--2.	Delete all the categories  that have no games.  
  
-- 3.	Insert the following record into the Staff table.
--FirstName				LastName				Email								Wage																															StaffTypeID
--Rachel					Racer						RRacer@gmail.com		**The same wage as the current highest wage in the staff table				1
  



 --PART F - Views
--1.	Create a view called MaintenanceHistory that selects all the GameCodes, GameName, MaintenanceID’s, Notes, DateCompleted, and JobDescriptions for ALL games.  
go
 




go
--2.	Using the MaintenanceHistory view select the GameCodes, GameName and how many times maintenance has been performed on each game.   
 

