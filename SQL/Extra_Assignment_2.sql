/*
	INSERT data
*/
USE ExtraTestingSystem;
INSERT INTO `Trainee` 
	(Full_Name		, Birth_Date	, Gender, ET_IQ	, ET_Gmath	, ET_English, Training_Class, Evaluation_Notes	, VTI_Account		)
VALUES 
	('Nguyễn Văn A'	, '1999-01-20'	, 'male', 10	, 15		, 45		, 'Rocket 12'	, 'Đánh giá 1'		, 'a.nguyenvan'		),
	('Nguyễn Bân'	, '1996-09-16'	, 'male', 8		, 8			, 30		, 'Rocket 12'	, 'Đánh giá 2'		, 'ban.nguyen'		),
	('Nguyễn Văn B'	, '1995-02-20'	, 'male', 15	, 10		, 20		, 'Rocket 12'	, 'Đánh giá 3'		, 'b.nguyenvan'		),
	('Nguyễn Văn C'	, '1997-01-24'	, 'male', 12	, 13		, 40		, 'Rocket 12'	, 'Đánh giá 4'		, 'c.nguyenvan'		),
	('Nguyễn Văn D'	, '1998-04-28'	, 'male', 19	, 18		, 10		, 'Rocket 12'	, 'Đánh giá 5'		, 'd.nguyenvan'		),
	('Nguyễn Văn E'	, '1999-03-15'	, 'male', 9		, 20		, 15		, 'Rocket 12'	, 'Đánh giá 6'		, 'e.nguyenvan'		),
	('Nguyễn Văn F'	, '1994-06-13'	, 'male', 3		, 15		, 19		, 'Rocket 12'	, 'Đánh giá 7'		, 'f.nguyenvan'		),
	('Nguyễn Văn G'	, '1993-01-12'	, 'male', 17	, 18		, 20		, 'Rocket 12'	, 'Đánh giá 8'		, 'g.nguyenvan'		),
	('Nguyễn Văn H'	, '1992-07-07'	, 'male', 20	, 5			, 40		, 'Rocket 12'	, 'Đánh giá 9'		, 'h.nguyenvan'		),
	('Nguyễn Văn I'	, '2000-01-06'	, 'male', 10	, 10		, 15		, 'Rocket 12'	, 'Đánh giá 10'		, 'i.nguyenvan'		),
	('Nguyễn Văn K'	, '2001-08-05'	, 'male', 15	, 9			, 45		, 'Rocket 12'	, 'Đánh giá 11'		, 'k.nguyenvan'		);
	
/*
	Exercise 1
*/
-- Question 2: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào, nhóm chúng thành các tháng sinh khác nhau
SELECT GROUP_CONCAT(Full_Name) AS 'Fullname', Birth_Date, MONTH(Birth_Date) AS 'Month'
FROM	`Trainee`
WHERE	(ET_IQ + ET_Gmath) >= 20 AND ET_IQ >= 8 AND ET_Gmath >= 8 AND ET_English >= 18
GROUP BY MONTH(Birth_Date);

-- Question 3: Viết lệnh để lấy ra thực tập sinh có tên dài nhất, lấy ra các thông tin sau: tên, tuổi, các thông tin cơ bản (như đã được định nghĩa trong table)
SELECT *
FROM	`Trainee`
ORDER BY LENGTH(Full_Name) DESC
LIMIT 1;

-- Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là những người đã vượt qua bài test đầu vào và thỏa mãn số điểm như sau: ET_IQ + ET_Gmath>=20; ET_IQ>=8; ET_Gmath>=8; ET_English>=18
SELECT *
FROM	`Trainee`
WHERE	(ET_IQ + ET_Gmath) >= 20 AND ET_IQ >= 8 AND ET_Gmath >= 8 AND ET_English >= 18;

-- Question 5: Xóa thực tập sinh có TraineeID = 3
DELETE
FROM	`Trainee`
WHERE	TraineeID = 3;
	
-- Question 6: Thực tập sinh có TraineeID = 5 được chuyển sang lớp "2". Hãy cập nhật thông tin vào database
UPDATE `Trainee`
SET	Training_Class = 'Rocket 2'
WHERE	TraineeID = 5;

/*
	Exercise 2
*/
-- Tạo bảng
DROP TABLE IF EXISTS `Department`;
CREATE TABLE `Department` (
	`Department_Number`		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`Department_Name`		VARCHAR(100) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS `Employee_Table`;
CREATE TABLE IF NOT EXISTS `Employee_Table` (
	`Employee_Number`		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`Employee_Name`			VARCHAR(100) NOT NULL,
	`Department_Number`		INT UNSIGNED NOT NULL
	-- FOREIGN KEY (`Department_Number`) REFERENCES `Department` (`Department_Number`)
);

DROP TABLE IF EXISTS `Employee_Skill_Table`;
CREATE TABLE `Employee_Skill_Table` (
	`Employee_Number`		INT UNSIGNED NOT NULL,
	`Skill_Code`			VARCHAR(10) NOT NULL,
	`Date_Registered`		DATE NOT NULL
	-- FOREIGN KEY (`Employee_Number`) REFERENCES `Employee_Table` (`Employee_Number`)
);

-- Query
INSERT INTO `Department` 
	(`Department_Name`)
VALUES
	('Marketing'	),
	('Sale'			),
	('Bảo vệ'		),
	('Nhân sự'		),
	('Kỹ thuật'		),
	('Tài chính'	),
	('Phó giám đốc'	),
	('Giám đốc'		),
	('Thư ký'		),
	('Bán hàng'		);

INSERT INTO `Employee_Table`
	(`Employee_Name`, `Department_Number`	)
VALUES
	('Nguyễn Văn A'	, 7						),
	('Nguyễn Văn B'	, 6						),
	('Nguyễn Văn C'	, 5						),
	('Nguyễn Thị D'	, 9						),
	('Nguyễn Văn E'	, 1						),
	('Nguyễn Thị F'	, 10					),
	('Nguyễn Văn G'	, 3						),
	('Nguyễn Văn H'	, 4						),
	('Nguyễn Văn I'	, 2						),
	('Nguyễn Thị K'	, 9						),
	('Nguyễn Thị M'	, 10					),
	('Nguyễn Văn Ni', 1						),
    ('Nguyễn Văn Gi', 3						),
	('Nguyễn Văn Ho', 4						),
	('Nguyễn Văn Ii', 2						),
	('Nguyễn Thị Ki', 9						),
	('Nguyễn Thị My', 10					),
	('Nguyễn Văn No', 8						),
	('Nguyễn Văn O'	, 4						),
	('Nguyễn Văn P'	, 2						),
	('Nguyễn Thị Q'	, 9						);

INSERT INTO `Employee_Skill_Table`
	(`Employee_Number`	, `Skill_Code`	, `Date_Registered`	)
VALUES
	(1					, 'Java'		, '2019-03-20'		),
	(8					, 'Java'		, '2019-05-05'		),
	(3					, 'C#'			, '2019-07-13'		),
	(7					, 'Python'		, '2019-09-20'		),
	(2					, 'C'			, '2019-11-20'		),
	(1					, 'PHP'			, '2019-12-10'		),
	(6					, 'JS'			, '2019-03-20'		),
	(4					, 'Ruby'		, '2019-03-20'		),
	(5					, 'C++'			, '2019-01-15'		),
	(11					, 'PHP'			, '2019-03-17'		),
	(9					, 'Java'		, '2019-03-09'		),
	(10					, 'Java'		, '2019-03-20'		);

-- Question 3: Viết lệnh để lấy ra danh sách nhân viên (name) có skill Java
SELECT et.`Employee_Name`, est.`Skill_Code`
FROM `Employee_Table` et
JOIN `Employee_Skill_Table` est ON et.`Employee_Number` = est.`Employee_Number`
WHERE est.`Skill_Code` = 'Java';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
-- Cách 1
SELECT et.Department_Number, count(et.Department_Number) AS Num_of_Staff 
FROM `Employee_Table` et
GROUP BY et.Department_Number
HAVING Num_of_Staff > 3;
-- Cách 2
SELECT d.Department_Number, d.Department_Name, count(*) AS Num_of_Staff
FROM `Department` d
JOIN `Employee_Table` et ON d.Department_Number = et.Department_Number
GROUP BY d.Department_Number
HAVING count(*) > 3
ORDER BY d.Department_Number;

-- Question 5: Viết lệnh để lấy ra danh sách nhân viên của mỗi văn phòng ban.
SELECT d.Department_Number, d.Department_Name, GROUP_CONCAT(et.Employee_Name) AS Staff
FROM `Employee_Table` et
LEFT JOIN `Department` d ON et.Department_Number = d.Department_Number 
GROUP BY d.Department_Number 
ORDER BY d.Department_Number;

-- Question 6: Viết lệnh để lấy ra danh sách nhân viên có > 1 skills
SELECT et.Employee_Number, GROUP_CONCAT(est.Skill_Code) AS Skills
FROM `Employee_Table` et
JOIN `Employee_Skill_Table` est ON et.Employee_Number = est.Employee_Number 
GROUP BY et.Employee_Number
HAVING count(est.Skill_Code) > 1
ORDER BY et.Employee_Number