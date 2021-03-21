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
Thêm dữ liệu cho các bảng
*/
-- Thêm dữ liệu cho bảng `Department`
INSERT INTO `Department` 	
		(DepartmentName) 
VALUES	(N'Marketing'),
		(N'Sale'),
		(N'Bảo vệ'),
		(N'Nhân sự'),
		(N'Kỹ thuật'),
		(N'Tài chính'),
		(N'Phó giám đốc'),
		(N'Giám đốc'),
		(N'Thư ký'),
		(N'Bán hàng');
        
-- Thêm dữ liệu cho bảng `Position`
INSERT INTO `Position`	
		(PositionName) 
VALUES	(N'Dev'),
		(N'Test'),
		(N'Scrum Master'),
		(N'PM');

-- Thêm dữ liệu cho bảng `Account`
INSERT INTO `Account`
		(Email								, Username			, FullName				, DepartmentID	, PositionID, CreateDate)
VALUE 	('dimprowe@gmail.com'				, 'dimprowe'		,'Nguyễn Văn Chiến'		,   '5'			,   '1'		,'2020-03-05'),
		('udgerful@gmail.com'				, 'udgerful'		,'Đỗ Văn Hưu'			,   '1'			,   '2'		,'2020-03-05'),
		('houstion@gmail.com'				, 'houstion'		,'Ngô Ngọc Cường'		,   '2'			,   '3'		,'2020-03-07'),
		('gisingel@gmail.com'				, 'gisingel'		,'Hà Thị Lan'			,   '3'			,   '4'		,'2020-03-08'),
		('mbnoseat@gmail.com'				, 'mbnoseat'		,'Nguyễn Văn Điệp'		,   '4'			,   '4'		,'2020-03-10'),
		('strivaid@gmail.com'				, 'strivaid'		,'Chu Thị Cúc'			,   '6'			,   '3'		,'2020-04-05'),
		('gelignew@gmail.com'				, 'gelignew'		,'Hà Thị Lộc'			,   '7'			,   '2'		,'2020-04-05'),
		('tleyorka@gmail.com'				, 'tleyorka'		,'Nguyễn Thị Thu Cẩn'	,   '8'			,   '1'		,'2020-04-07'),
		('breabera@gmail.com'				, 'breabera'		,'Nguyễn Văn Dao'		,   '9'			,   '2'		,'2020-04-07'),
        ('hurancit@gmail.com'				, 'hurancit'		,'Hà Lan Thị Hoa'		,   '3'			,   '4'		,'2020-03-08'),
		('castardi@gmail.com'				, 'castardi'		,'Nguyễn Huy Tưởng'		,   '4'			,   '4'		,'2020-03-10'),
		('mitanjea@gmail.com'				, 'mitanjea'		,'Tạ Thị Cúc Loan'		,   '6'			,   '3'		,'2020-04-05'),
		('igharoph@gmail.com'				, 'igharoph'		,'Hà Thị Lộc Lá'		,   '3'			,   '2'		,'2020-04-05'),
		('ghtfudet@gmail.com'				, 'ghtfudet'		,'Nguyễn Thị Thu'		,   '8'			,   '1'		,'2020-04-07'),
		('onistrev@gmail.com'				, 'onistrev'		,'Lã Văn Lộc'			,   '3'			,   '2'		,'2020-04-07'),
		('sushumen@gmail.com'				, 'sushumen'		,'Tạ Văn Lân'			,   '10'		,   '1'		,'2020-04-09');

-- Thêm dữ liệu cho bảng `Group`
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

-- Thêm dữ liệu cho bảng `GroupAccount`
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
        
-- Thêm dữ liệu cho bảng `TypeQuestion`
INSERT INTO `TypeQuestion`	
		(TypeName)
VALUE	('Essay'),
		('Multiple-Choice');
        
-- Thêm dữ liệu cho bảng `CategoryQuestion`
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
	
-- Thêm dữ liệu cho bảng `Question`
INSERT INTO `Question`	
		(Content				, CategoryID, TypeID, CreatorID	)
VALUE	('Thắc mắc về Java'		, 1			,	1	, 1			),
		('Thắc mắc về ASP.NET'	, 2			,	2	, 2			),
        ('Thắc mắc về ADO.NET'	, 3			,	2	, 3			),
        ('Thắc mắc về SQL'		, 4			,	1	, 4			),
        ('Thắc mắc về Postman'	, 5			,	1	, 5			),
        ('Thắc mắc về Ruby'		, 6			,	2	, 6			),
        ('Thắc mắc về Python'	, 7			,	1	, 7			),
        ('Thắc mắc về C++'		, 8			,	1	, 8			),
        ('Thắc mắc về C Sharp'	, 9			,	2	, 9			),
        ('Câu hỏi về C Sharp'	, 9			,	2	, 9			),
        ('Câu hỏi về C Sharp'	, 9			,	2	, 9			),
        ('Thắc mắc về PHP'		, 10		,	1	, 10		);
        
-- Thêm dữ liệu cho bảng `Answer`
INSERT INTO `Answer`	
		(Content		, QuestionID, isCorrect	)
VALUE	('Trả lời 01'	, 1			,	FALSE	),
		('Trả lời 02'	, 1			,	TRUE	),
        ('Trả lời 03'	, 1			,	FALSE	),
        ('Trả lời 04'	, 1			,	TRUE	),
        ('Trả lời 05'	, 2			,	TRUE	),
        ('Trả lời 06'	, 3			,	TRUE	),
        ('Trả lời 07'	, 4			,	FALSE	),
        ('Trả lời 08'	, 8			,	FALSE	),
        ('Trả lời 09'	, 9			,	TRUE	),
        ('Trả lời 10'	, 10		,	TRUE	);

-- Thêm dữ liệu cho bảng `Exam`
INSERT INTO Exam	
		(`Code`			, Title					, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUE	('VTIQ001'		, N'Đề thi C#'			,	1			,	60		,   '5'			,'2019-04-05'),
		('VTIQ002'		, N'Đề thi PHP'			,	10			,	60		,   '1'			,'2019-04-05'),
		('VTIQ003'		, N'Đề thi C++'			,	9			,	120		,   '2'			,'2019-04-07'),
		('VTIQ004'		, N'Đề thi Java'		,	6			,	60		,   '3'			,'2020-04-08'),
		('VTIQ005'		, N'Đề thi Ruby'		,	5			,	120		,   '4'			,'2020-04-10'),
		('VTIQ006'		, N'Đề thi Postman'		,	3			,	60		,   '6'			,'2020-04-05'),
		('VTIQ007'		, N'Đề thi SQL'			,	2			,	60		,   '7'			,'2020-04-05'),
		('VTIQ008'		, N'Đề thi Python'		,	8			,	60		,   '8'			,'2020-04-07'),
		('VTIQ009'		, N'Đề thi ADO.NET'		,	4			,	90		,   '9'			,'2020-04-07'),
		('VTIQ010'		, N'Đề thi ASP.NET'		,	7			,	90		,   '10'		,'2020-04-08');

-- Thêm dữ liệu cho bảng `Exam`
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