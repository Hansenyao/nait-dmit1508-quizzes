# Quiz3 - Game Zone!

Game Zone is a bringing back the old school, with some new twists of course! The supplied ERD shows the database design that is currently in use to its operations.

The file “Quiz3.sql” contains statements to create the tables and insert test data. You must answer all the questions on the “Quiz3.sql” file. When finished, submit the file to Moodle.

Raise a user friendly error if:
- Required parameters were not passed to the procedure (2 marks max deduction)
- A DML statement fails (2 marks max deduction)
- Records to be updated or deleted do not exist (2 marks max deduction)

Use transactions only where needed and do not add additional validation beyond what has been asked for. 

1. (4.5 marks) Write a stored procedure called AddGame that will have parameters of 
GameName, Tokens, ZoneID, PurchaseDate, PurchasePrice, and CategoryCode 
- Add a new record to the Game table.
- Provide an appropriate error message if the PurchaseDate provided is after todays date. 
- Select the database generated(identity) GameCode if the insert was successful. 

2. (4 marks) Write a stored procedure called ChangeZone that will update the ZoneName and Description of one zone. 

3. (3 marks) Write a stored procedure called HighMaintenenaceGames that returns the GameName of all the games whose total number of maintenance days is over a value that was passed to the stored procedure as a parameter. 

4. (8.5 marks) Write a stored procedure using a transaction called AddGameMaintenance that accepts all the parameters required to add a new GameMaintenance record. As new maintenance is performed on a game, the expected lifespan of the game is reduced. The LIfeID attribute contains a value between 1 and 3. 3 indicates there is lots of life left in the game and it should last a long time and 1 represents that the game is getting old and needs to be replaced soon. The LifeID attribute value IS NOT provided by user and is evaluated each time a GameMaintenance record is added. The following chart defines how the LiveID value is calculated.

| Maintance Count	| LifeID |
| ---               | ---    |
| 1-5	            |  3     |
| 6-10	            |  2     |
| More than 10	    |  1     |

Perform the following tasks:
1. If the maintenance record is not for an existing Game give an error message.
2. If the Game is an existing Game, add a record to the GameMaintenance table.
3. Adjust the LifeID attribute for that game according to the number of maintenance jobs that have been performed on that game.

# ERD

<img src="./img/ERD.png">

