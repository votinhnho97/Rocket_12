DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;
USE TestingSystem;

-- Table 1: Department
DROP TABLE IF EXISTS `Department`;
CREATE TABLE `Department` (
	DepartmentID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName		NVARCHAR(50) NOT NULL UNIQUE KEY
);

-- Table 2: Position
DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position` (
	PositionID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName		ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL UNIQUE KEY
);

-- Table 3: Account
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (
	AccountID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email				VARCHAR(50) NOT NULL UNIQUE KEY,
    Username			VARCHAR(50) NOT NULL UNIQUE KEY,
    FullName			NVARCHAR(50) NOT NULL,
    DepartmentID		TINYINT UNSIGNED NOT NULL,
    PositionID			TINYINT UNSIGNED NOT NULL,
    CreateDate			DATETIME DEFAULT NOW(),
	FOREIGN KEY (DepartmentID) REFERENCES `Department` (DepartmentID),
	FOREIGN KEY (PositionID) REFERENCES `Position` (PositionID)
);

-- Table 4: Group
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
	GroupID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName			NVARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID			TINYINT UNSIGNED NOT NULL,
    CreateDate			DATETIME DEFAULT NOW()
);

-- Table 5: GroupAccount
DROP TABLE IF EXISTS `GroupAccount`;
CREATE TABLE `GroupAccount` (
	GroupID				TINYINT UNSIGNED NOT NULL,
    AccountID			TINYINT UNSIGNED NOT NULL,
    JoinDate			DATETIME DEFAULT NOW(),
    PRIMARY KEY (GroupID, AccountID)
);

-- Table 6: TypeQuestion
DROP TABLE IF EXISTS `TypeQuestion`;
CREATE TABLE `TypeQuestion` (
	TypeID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName			ENUM('Essay', 'Multiple-Choice') NOT NULL UNIQUE KEY
);

-- Table 7: CategoryQuestion
DROP TABLE IF EXISTS `CategoryQuestion`;
CREATE TABLE `CategoryQuestion` (
	CategoryID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName		NVARCHAR(50) NOT NULL UNIQUE KEY
);

-- Table 8: Question
DROP TABLE IF EXISTS `Question`;
CREATE TABLE `Question` (
	QuestionID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content				NVARCHAR(200) NOT NULL,
    CategoryID			TINYINT UNSIGNED NOT NULL,
    TypeID				TINYINT UNSIGNED NOT NULL,
    CreatorID			TINYINT UNSIGNED NOT NULL,
    CreateDate			DATETIME DEFAULT NOW(),
	FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion` (CategoryID),
	FOREIGN KEY (TypeID) REFERENCES `TypeQuestion` (TypeID),
	FOREIGN KEY (CreatorID) REFERENCES `Account` (AccountID)
);

-- Table 9: Answer
DROP TABLE IF EXISTS `Answer`;
CREATE TABLE `Answer` (
	AnswerID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content				NVARCHAR(200) NOT NULL,
    QuestionID			TINYINT UNSIGNED NOT NULl,
    isCorrect			BOOLEAN DEFAULT TRUE,
	FOREIGN KEY (QuestionID) REFERENCES `Question` (QuestionID)
);

-- Table 10: Exam
DROP TABLE IF EXISTS `Exam`;
CREATE TABLE `Exam` (
	ExamID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code`				VARCHAR(10) NOT NULL,
    Title				NVARCHAR(50) NOT NULL,
    CategoryID			TINYINT UNSIGNED NOT NULL,
    Duration			TINYINT UNSIGNED NOT NULL,
    CreatorID			TINYINT UNSIGNED NOT NULL,
    CreateDate			DATETIME DEFAULT NOW(),
	FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion` (CategoryID),
	FOREIGN KEY (CreatorID) REFERENCES `Account` (AccountID)
);

-- Table 11: ExamQuestion
DROP TABLE IF EXISTS `ExamQuestion`;
CREATE TABLE `ExamQuestion` (
	ExamID				TINYINT UNSIGNED NOT NULL,
    QuestionID			TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (ExamID, QuestionID),
	FOREIGN KEY (ExamID) REFERENCES `Exam` (ExamID),
	FOREIGN KEY (QuestionID) REFERENCES `Question` (QuestionID)
);

/*
Th??m d??? li???u cho c??c b???ng
*/
-- Th??m d??? li???u cho b???ng `Department`
INSERT INTO `Department` 	
		(DepartmentName) 
VALUES	(N'Marketing'),
		(N'Sale'),
		(N'B???o v???'),
		(N'Nh??n s???'),
		(N'K??? thu???t'),
		(N'T??i ch??nh'),
		(N'Ph?? gi??m ?????c'),
		(N'Gi??m ?????c'),
		(N'Th?? k??'),
		(N'B??n h??ng');
        
-- Th??m d??? li???u cho b???ng `Position`
INSERT INTO `Position`	
		(PositionName) 
VALUES	(N'Dev'),
		(N'Test'),
		(N'Scrum Master'),
		(N'PM');

-- Th??m d??? li???u cho b???ng `Account`
INSERT INTO `Account`
		(Email								, Username			, FullName				, DepartmentID	, PositionID, CreateDate)
VALUE 	('dimprowe@gmail.com'				, 'dimprowe'		,'Nguy???n V??n Chi???n'		,   '5'			,   '1'		,'2020-03-05'),
		('udgerful@gmail.com'				, 'udgerful'		,'????? V??n H??u'			,   '1'			,   '2'		,'2020-03-05'),
		('houstion@gmail.com'				, 'houstion'		,'Ng?? Ng???c C?????ng'		,   '2'			,   '3'		,'2020-03-07'),
		('gisingel@gmail.com'				, 'gisingel'		,'H?? Th??? Lan'			,   '3'			,   '4'		,'2020-03-08'),
		('mbnoseat@gmail.com'				, 'mbnoseat'		,'Nguy???n V??n ??i???p'		,   '4'			,   '4'		,'2020-03-10'),
		('strivaid@gmail.com'				, 'strivaid'		,'Chu Th??? C??c'			,   '6'			,   '3'		,'2020-04-05'),
		('gelignew@gmail.com'				, 'gelignew'		,'H?? Th??? L???c'			,   '7'			,   '2'		,'2020-04-05'),
		('tleyorka@gmail.com'				, 'tleyorka'		,'Nguy???n Th??? Thu C???n'	,   '8'			,   '1'		,'2020-04-07'),
		('breabera@gmail.com'				, 'breabera'		,'Nguy???n V??n Dao'		,   '9'			,   '2'		,'2020-04-07'),
        ('hurancit@gmail.com'				, 'hurancit'		,'H?? Lan Th??? Hoa'		,   '3'			,   '4'		,'2020-03-08'),
		('castardi@gmail.com'				, 'castardi'		,'Nguy???n Huy T?????ng'		,   '4'			,   '4'		,'2020-03-10'),
		('mitanjea@gmail.com'				, 'mitanjea'		,'T??? Th??? C??c Loan'		,   '6'			,   '3'		,'2020-04-05'),
		('igharoph@gmail.com'				, 'igharoph'		,'H?? Th??? L???c L??'		,   '3'			,   '2'		,'2020-04-05'),
		('ghtfudet@gmail.com'				, 'ghtfudet'		,'Nguy???n Th??? Thu'		,   '8'			,   '1'		,'2020-04-07'),
		('onistrev@gmail.com'				, 'onistrev'		,'L?? V??n L???c'			,   '3'			,   '2'		,'2020-04-07'),
		('sushumen@gmail.com'				, 'sushumen'		,'T??? V??n L??n'			,   '10'		,   '1'		,'2020-04-09');

-- Th??m d??? li???u cho b???ng `Group`
INSERT INTO `Group`	
		(GroupName				, CreatorID	, CreateDate	)
VALUE 	(N'Testing System'		, 1			, '2015-03-05'	),
		(N'Developement'		, 2			, '2016-05-07'	),
		(N'VTI Sale 01'			, 3			, '2017-06-01'	),
		(N'VTI Sale 02'			, 4			, '2018-12-05'	),
		(N'VTI Sale 03'			, 5			, '2019-03-06'	),
		(N'VTI Creator'			, 6			, '2019-01-04'	),
		(N'VTI Marketing 01'	, 7			, '2019-11-03'	),
		(N'Management'			, 8			, '2020-10-03'	),
		(N'Chat with love'		, 9			, '2020-09-03'	),
		(N'Vi Ti Ai'			, 10		, '2020-08-02'	);

-- Th??m d??? li???u cho b???ng `GroupAccount`
INSERT INTO `GroupAccount`	
		(GroupID, AccountID	)
VALUE 	(1		, 1			),
		(2		, 2			),
		(3		, 3			),
		(4		, 4			),
		(5		, 5			),
		(6		, 6			),
		(7		, 7			),
		(8		, 8			),
		(9		, 9			),
		(10		, 10		);
        
-- Th??m d??? li???u cho b???ng `TypeQuestion`
INSERT INTO `TypeQuestion`	
		(TypeName)
VALUE	('Essay'),
		('Multiple-Choice');
        
-- Th??m d??? li???u cho b???ng `CategoryQuestion`
INSERT INTO `CategoryQuestion`	
		(CategoryName)
VALUE	('Java'),
		('ASP.NET'),
        ('ADO.NET'),
        ('SQL'),
        ('Postman'),
        ('Ruby'),
        ('Python'),
        ('C++'),
        ('C Sharp'),
        ('PHP');
	
-- Th??m d??? li???u cho b???ng `Question`
INSERT INTO `Question`	
		(Content				, CategoryID, TypeID, CreatorID	)
VALUE	('Th???c m???c v??? Java'		, 1			,	1	, 1			),
		('Th???c m???c v??? ASP.NET'	, 2			,	2	, 2			),
        ('Th???c m???c v??? ADO.NET'	, 3			,	2	, 3			),
        ('Th???c m???c v??? SQL'		, 4			,	1	, 4			),
        ('Th???c m???c v??? Postman'	, 5			,	1	, 5			),
        ('Th???c m???c v??? Ruby'		, 6			,	2	, 6			),
        ('Th???c m???c v??? Python'	, 7			,	1	, 7			),
        ('Th???c m???c v??? C++'		, 8			,	1	, 8			),
        ('Th???c m???c v??? C Sharp'	, 9			,	2	, 9			),
        ('C??u h???i v??? C Sharp'	, 9			,	2	, 9			),
        ('C??u h???i v??? C Sharp'	, 9			,	2	, 9			),
        ('Th???c m???c v??? PHP'		, 10		,	1	, 10		);
        
-- Th??m d??? li???u cho b???ng `Answer`
INSERT INTO `Answer`	
		(Content		, QuestionID, isCorrect	)
VALUE	('Tr??? l???i 01'	, 1			,	FALSE	),
		('Tr??? l???i 02'	, 1			,	TRUE	),
        ('Tr??? l???i 03'	, 1			,	FALSE	),
        ('Tr??? l???i 04'	, 1			,	TRUE	),
        ('Tr??? l???i 05'	, 2			,	TRUE	),
        ('Tr??? l???i 06'	, 3			,	TRUE	),
        ('Tr??? l???i 07'	, 4			,	FALSE	),
        ('Tr??? l???i 08'	, 8			,	FALSE	),
        ('Tr??? l???i 09'	, 9			,	TRUE	),
        ('Tr??? l???i 10'	, 10		,	TRUE	);

-- Th??m d??? li???u cho b???ng `Exam`
INSERT INTO Exam	
		(`Code`			, Title					, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUE	('VTIQ001'		, N'????? thi C#'			,	1			,	60		,   '5'			,'2019-04-05'),
		('VTIQ002'		, N'????? thi PHP'			,	10			,	60		,   '1'			,'2019-04-05'),
		('VTIQ003'		, N'????? thi C++'			,	9			,	120		,   '2'			,'2019-04-07'),
		('VTIQ004'		, N'????? thi Java'		,	6			,	60		,   '3'			,'2020-04-08'),
		('VTIQ005'		, N'????? thi Ruby'		,	5			,	120		,   '4'			,'2020-04-10'),
		('VTIQ006'		, N'????? thi Postman'		,	3			,	60		,   '6'			,'2020-04-05'),
		('VTIQ007'		, N'????? thi SQL'			,	2			,	60		,   '7'			,'2020-04-05'),
		('VTIQ008'		, N'????? thi Python'		,	8			,	60		,   '8'			,'2020-04-07'),
		('VTIQ009'		, N'????? thi ADO.NET'		,	4			,	90		,   '9'			,'2020-04-07'),
		('VTIQ010'		, N'????? thi ASP.NET'		,	7			,	90		,   '10'		,'2020-04-08');

-- Th??m d??? li???u cho b???ng `Exam`
INSERT INTO ExamQuestion	
		(ExamID	, QuestionID)
VALUE	(1		, 2			),
		(2		, 3			),
        (3		, 6			),
        (4		, 8			),
        (5		, 6			),
        (6		, 6			),
        (7		, 1			),
        (8		, 4			),
        (9		, 7			),
		(10		, 9			);