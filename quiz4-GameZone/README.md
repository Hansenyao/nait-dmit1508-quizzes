# Quiz 3 - Game Zone

Game Zone is a bringing back the old school, with some new twists of course! The supplied ERD shows the database design that is currently in use to support its operations.
The file “Quiz4.sql” contains statements to create the tables and insert test data. You must answer all the questions on the “Quiz4.sql” file. When finished, submit the file according to your instructor’s instructions.

1. (2.5 marks) Game Maintenance records are VERY important to Game Zone.  Do not allow any of the GameMaintenance records to be deleted. Create a trigger called TR1 that prevents the deletion of any GameMaintenance records. 

2. (3.5 marks) Games that have been purchased more than 20 years ago are not allowed to have any more maintenance on them. Create a trigger called TR2 that will prevent the addition of new GameMaintenance records for any games that were purchased more than 20 years ago.

3. (3 marks) Create a trigger called TR3 on the Game table that will execute when new games are added. When games are added, adjust the GameCount in the zone table to reflect the current number of games in that zone. Assume that only one game will be inserted at a time.

4. (3.5 marks) The amount of tokens required to play a game changes over time. Create a trigger called TR4 on the Game table that records changes to the number of tokens. Record any changes in the TokenChanges table. The TokenChanges table has been included in the Quiz4.sql file.

5. (0.5 mark): Put your name at the top of the “Quiz4.sql” file in the place indicated.


# ERD
<img src="./img/ERD.png">
