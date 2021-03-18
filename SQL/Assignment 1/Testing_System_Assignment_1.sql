DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;
USE TestingSystem;

DROP TABLE IF EXISTS `Department`;
CREATE TABLE `Department` (
	DepartmentID 		INT AUTO_INCREMENT,
    DepartmentName		VARCHAR(50)
);

DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position` (
	PositionID			INT AUTO_INCREMENT,
    PositionName		ENUM('Dev', 'Test', 'Scrum Master', 'PM')
);

DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (
	AccountID			INT AUTO_INCREMENT,
    Email				VARCHAR(50),
    Username			VARCHAR(50),
    FullName			VARCHAR(50),
    DepartmentID		INT,
    PositionID			INT,
    CreateDate			DATE
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
	GroupID				INT AUTO_INCREMENT,
    GroupName			VARCHAR(50),
    CreatorID			INT,
    CreateDate			DATE
);

DROP TABLE IF EXISTS `GroupAccount`;
CREATE TABLE `GroupAccount` (
	GroupID				INT,
    AccountID			INT,
    JoinDate			DATE
);

DROP TABLE IF EXISTS `TypeQuestion`;
CREATE TABLE `TypeQuestion` (
	TypeID				INT AUTO_INCREMENT,
    TypeName			ENUM('Essay', 'Multiple-Choice')
);

DROP TABLE IF EXISTS `CategoryQuestion`;
CREATE TABLE `CategoryQuestion` (
	CategoryQuestion	INT AUTO_INCREMENT,
    CategoryName		VARCHAR(50)
);

DROP TABLE IF EXISTS `Question`;
CREATE TABLE `Question` (
	QuestionID			INT AUTO_INCREMENT,
    Content				VARCHAR(200),
    CategoryID			INT,
    TypeID				INT,
    CreatorID			INT,
    CreateDate			DATE
);

DROP TABLE IF EXISTS `Answer`;
CREATE TABLE `Answer` (
	AnswerID			INT AUTO_INCREMENT,
    Content				VARCHAR(200),
    QuestionID			INT,
    isCorrect			BOOLEAN
);

DROP TABLE IF EXISTS `Exam`;
CREATE TABLE `Exam` (
	ExamID				INT AUTO_INCREMENT,
    `Code`				VARCHAR(200),
    Title				VARCHAR(50),
    CategoryID			INT,
    Duration			DATETIME,
    CreatorID			INT,
    CreateDate			DATE
);

DROP TABLE IF EXISTS `ExamQuestion`;
CREATE TABLE `ExamQuestion` (
	ExamID				INT,
    QuestionID			INT
);