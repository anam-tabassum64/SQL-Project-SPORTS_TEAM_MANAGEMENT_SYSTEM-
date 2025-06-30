----------------------- CREATE DATABASE ---------------------

CREATE DATABASE SportsTeamManagement;
USE SportsTeamManagement;
--------------------------------------------------------------


------------------------ CREATE TABLES -----------------------------
CREATE TABLE Team (
  Team_Id INT PRIMARY KEY,
  Team_Name VARCHAR(50),
  Team_Level VARCHAR(20)
);
CREATE TABLE Coach (
  Coach_Id INT PRIMARY KEY,
  First_Name VARCHAR(30),
  Last_Name VARCHAR(30),
  Specialty VARCHAR(30),
  Years_Experience INT,
  Team_Id INT,
  FOREIGN KEY (Team_Id) REFERENCES Team(Team_Id)
);
CREATE TABLE Player (
  Player_Id INT PRIMARY KEY,
  First_Name VARCHAR(30),
  Last_Name VARCHAR(30),
  Position VARCHAR(30),
  Date_Joined DATE,
  Team_Id INT,
  FOREIGN KEY (Team_Id) REFERENCES Team(Team_Id)
);
CREATE TABLE Venue (
  Venue_Id INT PRIMARY KEY,
  Venue_Name VARCHAR(50),
  City VARCHAR(30),
  State VARCHAR(30)
);
CREATE TABLE Matches (
  Match_Id INT PRIMARY KEY,
  Match_Date DATE,
  Opponent_Team VARCHAR(50),
  Venue_Id INT,
  Result VARCHAR(10),
  FOREIGN KEY (Venue_Id) REFERENCES Venue(Venue_Id)
);
CREATE TABLE Performance (
  Performance_Id INT PRIMARY KEY,
  Match_Id INT,
  Player_Id INT,
  Goals INT,
  Assists INT,
  Rating DECIMAL(3,1),
  FOREIGN KEY (Match_Id) REFERENCES Matches(Match_Id),
  FOREIGN KEY (Player_Id) REFERENCES Player(Player_Id)
);
CREATE TABLE Training_Session (
  Training_Id INT PRIMARY KEY,
  Training_Name VARCHAR(50),
  Training_Date DATE,
  Duration_Minutes INT
);
CREATE TABLE Player_Training (
  Player_Id INT,
  Training_Id INT,
  PRIMARY KEY (Player_Id, Training_Id),
  FOREIGN KEY (Player_Id) REFERENCES Player(Player_Id),
  FOREIGN KEY (Training_Id) REFERENCES Training_Session(Training_Id)
);
CREATE TABLE Leave_Record (
  Leave_Id INT PRIMARY KEY,
  Player_Id INT,
  Leave_Date DATE,
  Reason VARCHAR(100),
  FOREIGN KEY (Player_Id) REFERENCES Player(Player_Id)
);
-------------------------------------------------------------------------------

----------------------------- INSERTING DATA -----------------------------

-- Teams
INSERT INTO Team VALUES (1, 'Dragons', 'Senior');
INSERT INTO Team VALUES (2, 'Tigers', 'U-19');
INSERT INTO Team VALUES (3, 'Eagles', 'Junior');
INSERT INTO Team VALUES (4, 'Sharks', 'Senior');

-- Coaches
INSERT INTO Coach VALUES (101, 'John', 'Doe', 'Attack', 10, 1);
INSERT INTO Coach VALUES (102, 'Emily', 'Smith', 'Defense', 8, 2);
INSERT INTO Coach VALUES (103, 'Robert', 'Brown', 'Goalkeeping', 12, 3);
INSERT INTO Coach VALUES (104, 'Laura', 'Wilson', 'Strategy', 9, 4);

-- Players
INSERT INTO Player VALUES (201, 'Michael', 'Jordan', 'Forward', '2010-06-15', 1);
INSERT INTO Player VALUES (202, 'Scottie', 'Pippen', 'Guard', '2011-07-20', 1);
INSERT INTO Player VALUES (203, 'Dennis', 'Rodman', 'Forward', '2012-08-25', 1);
INSERT INTO Player VALUES (204, 'Kobe', 'Bryant', 'Guard', '2015-05-05', 2);
INSERT INTO Player VALUES (205, 'Shaquille', 'O\'Neal', 'Center', '2016-09-10', 2);
INSERT INTO Player VALUES (206, 'LeBron', 'James', 'Forward', '2017-09-01', 3);
INSERT INTO Player VALUES (207, 'Dwyane', 'Wade', 'Guard', '2018-01-15', 3);
INSERT INTO Player VALUES (208, 'Chris', 'Bosh', 'Forward-Center', '2019-03-22', 4);
INSERT INTO Player VALUES (209, 'Tim', 'Duncan', 'Forward-Center', '2014-04-11', 4);
INSERT INTO Player VALUES (210, 'Tony', 'Parker', 'Guard', '2013-07-30', 4);

-- Venues
INSERT INTO Venue VALUES (301, 'Madison Square Garden', 'New York', 'NY');
INSERT INTO Venue VALUES (302, 'Staples Center', 'Los Angeles', 'CA');
INSERT INTO Venue VALUES (303, 'United Center', 'Chicago', 'IL');
INSERT INTO Venue VALUES (304, 'TD Garden', 'Boston', 'MA');

-- Matches
INSERT INTO Matches VALUES (401, '2024-01-15', 'Wolves', 301, 'Win');
INSERT INTO Matches VALUES (402, '2024-01-22', 'Bulls', 302, 'Loss');
INSERT INTO Matches VALUES (403, '2024-02-05', 'Knights', 303, 'Draw');
INSERT INTO Matches VALUES (404, '2024-02-12', 'Raptors', 304, 'Win');

-- Performance
INSERT INTO Performance VALUES (501, 401, 201, 3, 2, 9.5);
INSERT INTO Performance VALUES (502, 401, 202, 1, 3, 8.7);
INSERT INTO Performance VALUES (503, 402, 204, 0, 1, 7.8);
INSERT INTO Performance VALUES (504, 403, 206, 2, 0, 8.2);
INSERT INTO Performance VALUES (505, 404, 209, 1, 1, 8.9);

-- Training Sessions
INSERT INTO Training_Session VALUES (601, 'Strength Training', '2024-01-10', 120);
INSERT INTO Training_Session VALUES (602, 'Tactical Drills', '2024-01-17', 90);
INSERT INTO Training_Session VALUES (603, 'Endurance Training', '2024-01-24', 110);

-- Player Training (which players attended which training)
INSERT INTO Player_Training VALUES (201, 601);
INSERT INTO Player_Training VALUES (202, 601);
INSERT INTO Player_Training VALUES (203, 602);
INSERT INTO Player_Training VALUES (204, 602);
INSERT INTO Player_Training VALUES (205, 603);
INSERT INTO Player_Training VALUES (206, 603);
INSERT INTO Player_Training VALUES (207, 601);
INSERT INTO Player_Training VALUES (208, 602);
INSERT INTO Player_Training VALUES (209, 603);
INSERT INTO Player_Training VALUES (210, 603);

-- Leave Records
INSERT INTO Leave_Record VALUES (701, 201, '2024-01-05', 'Injury');
INSERT INTO Leave_Record VALUES (702, 205, '2024-01-10', 'Personal');
INSERT INTO Leave_Record VALUES (703, 209, '2024-02-01', 'Family Emergency');
INSERT INTO Leave_Record VALUES (704, 207, '2024-02-15', 'Rest');
------------------------------------------------------------------------------

SELECT * FROM Player;
SELECT * FROM Matches WHERE Result = 'Win';
SELECT * FROM Performance WHERE Rating > 8.5;

-- List players and their teams:
SELECT p.First_Name, p.Last_Name, t.Team_Name
FROM Player p
JOIN Team t ON p.Team_Id = t.Team_Id;

-- Players with average rating above 8:
SELECT p.First_Name, p.Last_Name, AVG(per.Rating) as Avg_Rating
FROM Player p
JOIN Performance per ON p.Player_Id = per.Player_Id
GROUP BY p.Player_Id
HAVING AVG(per.Rating) > 8;

-- Matches played in a specific venue:
SELECT m.Match_Date, m.Opponent_Team, v.Venue_Name
FROM Matches m
JOIN Venue v ON m.Venue_Id = v.Venue_Id
WHERE v.City = 'New York';

----------------------------------- CREATE VIEWS ------------------------------------

-- Player performance summary view:
CREATE VIEW Player_Stats AS
SELECT
  p.Player_Id,
  CONCAT(p.First_Name, ' ', p.Last_Name) AS Player_Name,
  t.Team_Name,
  IFNULL(SUM(per.Goals), 0) AS Total_Goals,
  IFNULL(SUM(per.Assists), 0) AS Total_Assists,
  IFNULL(ROUND(AVG(per.Rating), 2), 0) AS Avg_Rating
FROM Player p
JOIN Team t ON p.Team_Id = t.Team_Id
LEFT JOIN Performance per ON p.Player_Id = per.Player_Id
GROUP BY p.Player_Id;

SELECT * FROM Player_Stats;
----------------------------------------------------------------------

-------------------------------- STORED PROCEDURES AND FUNCTIONS -----------------------------------------

--  Procedure to get players by team ID:
DELIMITER $$
CREATE PROCEDURE GetPlayersByTeam(IN team_id INT)
BEGIN
  SELECT Player_Id, First_Name, Last_Name, Position
  FROM Player
  WHERE Team_Id = team_id;
END $$
DELIMITER ;

CALL GetPlayersByTeam(1);
------------------------------------------------------------------

---------------------------- TRANSACTION -----------------------------

-- adding a player and registering training in one transaction:
START TRANSACTION;
INSERT INTO Player VALUES (211, 'New', 'Player', 'Guard', '2025-01-01', 1);
INSERT INTO Player_Training VALUES (211, 601);
COMMIT;
---------------------------------------------------------------------------


--  Writing More Queries --
-- 1. Find players who have scored more than 2 goals in any match
SELECT p.First_Name, p.Last_Name, per.Goals, m.Match_Date
FROM Performance per
JOIN Player p ON per.Player_Id = p.Player_Id
JOIN Matches m ON per.Match_Id = m.Match_Id
WHERE per.Goals > 2;

-- 2. List all training sessions attended by a particular player (e.g., Player_Id = 201)
SELECT ts.Training_Name, ts.Training_Date, ts.Duration_Minutes
FROM Player_Training pt
JOIN Training_Session ts ON pt.Training_Id = ts.Training_Id
WHERE pt.Player_Id = 201;

-- 3. Count of players per team
SELECT t.Team_Name, COUNT(p.Player_Id) AS NumberOfPlayers
FROM Team t
LEFT JOIN Player p ON t.Team_Id = p.Team_Id
GROUP BY t.Team_Name;

-- 4. Players on leave on a given date (e.g., '2024-01-10')
SELECT p.First_Name, p.Last_Name, lr.Leave_Date, lr.Reason
FROM Leave_Record lr
JOIN Player p ON lr.Player_Id = p.Player_Id
WHERE lr.Leave_Date = '2024-01-10';


----------------------------- CREATING TRIGGERS -----------------------

-- Prevent inserting Performance with negative Goals or Assists
DELIMITER $$
CREATE TRIGGER CheckPerformance BEFORE INSERT ON Performance
FOR EACH ROW
BEGIN
  IF NEW.Goals < 0 OR NEW.Assists < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Goals and Assists cannot be negative';
  END IF;
END $$
DELIMITER ;

-- Update Player Last Updated timestamp (you can add a column for this)
ALTER TABLE Player ADD COLUMN Last_Updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- TRIGGER
DELIMITER $$
CREATE TRIGGER UpdatePlayerTimestamp BEFORE UPDATE ON Player
FOR EACH ROW
BEGIN
  SET NEW.Last_Updated = CURRENT_TIMESTAMP;
END $$
DELIMITER ;
-- -- -- ---------------------------------------------------------------------







