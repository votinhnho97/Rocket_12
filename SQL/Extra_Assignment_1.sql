DROP DATABASE IF EXISTS ExtraTestingSystem;
CREATE DATABASE IF NOT EXISTS ExtraTestingSystem;
USE ExtraTestingSystem;

-- Exercise 1: Design a table
DROP TABLE IF EXISTS `Trainee`;
CREATE TABLE IF NOT EXISTS `Trainee` (
	TraineeID			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Full_Name			NVARCHAR(100) NOT NULL,
    Birth_Date			DATE NOT NULL,
    Gender				ENUM('Male', 'Female', 'Unknown') NOT NULL,
    ET_IQ				TINYINT NOT NULL CHECK(ET_IQ >= 0 AND ET_IQ <= 20),
    ET_Gmath			TINYINT NOT NULL CHECK(ET_Gmath >= 0 AND ET_Gmath <= 20),
    ET_English			TINYINT NOT NULL CHECK(ET_English >= 0 AND ET_English <= 50),
    Training_Class		VARCHAR(50),
    Evaluation_Notes	NVARCHAR(200),
    VTI_Account			NVARCHAR(100) NOT NULL UNIQUE KEY
);

-- Exercise 2: Data Types
DROP TABLE IF EXISTS Exercise2;
CREATE TABLE IF NOT EXISTS Exercise2 (
	`ID`				MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Name`				VARCHAR(200) NOT NULL,
    `Code`				CHAR(5) NOT NULL,
    `ModifiedDate`		DATETIME NOT NULL
);

-- Exercise 3: Data Types (2)
DROP TABLE IF EXISTS Exercise3;
CREATE TABLE IF NOT EXISTS Exercise3 (
	`ID`				MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Name`				VARCHAR(200) NOT NULL,
    `BirthDate`			DATETIME NOT NULL,
    `Gender`			TINYINT UNSIGNED,
    `IsDeletedFlag`		TINYINT NOT NULL
);