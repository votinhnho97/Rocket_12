USE TestingSystem;

-- Exercise 1
-- Q1: tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS Account_in_Department;
DELIMITER $$
	CREATE PROCEDURE Account_in_Department (IN in_dep_name VARCHAR(100))
		BEGIN
			SELECT *
			FROM `Account`
			WHERE DepartmentID = (SELECT DepartmentID FROM `Department` WHERE DepartmentName = in_dep_name);
		END$$
DELIMITER ;

-- Q2: tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS Statistic_Accounts_in_Group;
DELIMITER $$
	CREATE PROCEDURE Statistic_Accounts_in_Group ()
		BEGIN
			SELECT GroupID, count(1) AS Num_of_Acc
			FROM `GroupAccount`
			GROUP BY GroupID
			ORDER BY GroupID;
		END$$
DELIMITER ;

-- Q3: tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DROP PROCEDURE IF EXISTS Statistic_Question_by_Type;
DELIMITER $$
	CREATE PROCEDURE Statistic_Question_by_Type ()
		BEGIN
			SELECT TypeID, count(1) AS Num_of_Question
			FROM `Question`
			WHERE month(CreateDate) = month(now())
			GROUP BY TypeID
			ORDER BY TypeID;
		END$$
DELIMITER ;

-- Q4: tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS Kind_of_TypeQuestion;
DELIMITER $$
	CREATE PROCEDURE Kind_of_TypeQuestion (OUT out_TypeID INT)
		BEGIN
			SELECT TypeID INTO out_TypeID
			FROM `Question`
			GROUP BY TypeID
			HAVING count(1) = (SELECT max(Num_of_Question) FROM (SELECT count(1) AS Num_of_Question FROM `Question` GROUP BY TypeID) a);
		END$$
DELIMITER ;

-- Q5: Sử dụng store ở q4 để tìm ra tên của type question 
DROP PROCEDURE IF EXISTS Name_of_TypeQuestion;
DELIMITER $$
	CREATE PROCEDURE Name_of_TypeQuestion ()
		BEGIN
			SET @out_TypeID = NULL;
			CALL Kind_of_TypeQuestion(@out_TypeID);
			SELECT TypeName
			FROM `TypeQuestion`
			WHERE TypeID = @out_TypeID;
		END$$
DELIMITER ;

-- Q6: Cho phép người dùng nhập vào 1 chuỗi và trả về `group` có tên chứa chuỗi hoặc trả về `username` chứa chuỗi
-- K biết làm 
/*
DROP PROCEDURE IF EXISTS Find_by_Str;
DELIMITER $$
	CREATE PROCEDURE Find_by_Str (IN in_str VARCHAR(100))
		BEGIN
			SELECT IF(1=1, (SELECT GroupName FROM `Group` WHERE GroupName LIKE concat('%', 'vti', '%')) ,'false');
			SELECT IF(EXISTS(SELECT GroupName FROM `Group` WHERE GroupName LIKE concat('%', in_str, '%')), SELECT GroupName FROM `Group` WHERE GroupName LIKE concat('%', in_str, '%'), SELECT UserName FROM `Account` WHERE UserName LIKE concat('%', in_str, '%'))
				
		END$$
DELIMITER ;
*/
-- Q7: Store cho phép người dùng nhập vào thông tin FullName, Email và trong store
-- tự động gán
-- UserName = Email bỏ @... đi
-- PositionID có default là Developer
-- DepartmentID sẽ được cho vào phòng chờ
DROP PROCEDURE IF EXISTS Add_User;
DELIMITER $$
	CREATE PROCEDURE Add_User (IN in_FullName VARCHAR(100), IN in_Email VARCHAR(100))
		BEGIN
			
		END $$
DELIMITER ;


-- Q8: viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice để thống kê câu hỏi loại nào có content dài nhất
DROP PROCEDURE IF EXISTS Long_Content;
DELIMITER $$
	CREATE PROCEDURE Long_Content (IN in_type_name ENUM('Essay', 'Multiple-Choice'))
		BEGIN
			SELECT *
			FROM `Question`
			WHERE TypeID = (SELECT TypeID FROM `TypeQuestion` WHERE TypeName = 'Essay')
			AND character_length(Content) = (SELECT max(character_length(content)) FROM `Question`);
		END$$
DELIMITER ;

-- Q9: store cho phép người dùng xóa dựa vào ID
DROP PROCEDURE IF EXISTS Delete_Exam;
DELIMITER $$
	CREATE PROCEDURE Delete_Exam (IN in_ID INT)
		BEGIN
			DELETE 
			FROM `Exam`
			WHERE ExamID = in_ID;
		END$$
DELIMITER ;

-- Q10: tìm ra exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9)
-- Không biết sử dụng Store ở Q9 để xóa!!!
DROP PROCEDURE IF EXISTS Delete_Exam_3year_ago;
DELIMITER $$
	CREATE PROCEDURE Delete_Exam_3year_ago ()
		BEGIN
			DELETE
			FROM `Exam`
			WHERE ExamID IN (SELECT ExamID FROM `Exam` WHERE CreateDate < now() - interval 3 year);
		END$$
DELIMITER ;

-- Q11: xóa phòng ban bằng cách người dùng nhập tên phòng bạn và các account thuộc phòng ban đó sẽ chuyển về phòng bạn mặc định là phòng ban chờ việc
DROP PROCEDURE IF EXISTS Delete_Department;
DELIMITER $$
	CREATE PROCEDURE Delete_Department (IN in_dep_name VARCHAR(100))
		BEGIN
			UPDATE `Account`
			SET DepartmentID = 0
			WHERE DepartmentID = (SELECT DepartmentID FROM `Department` WHERE DepartmentName = in_dep_name);
			
			DELETE
			FROM `Department`
			WHERE DepartmentName = in_dep_name;
		END$$
DELIMITER ;

-- Q12: store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nayquestion
DROP PROCEDURE IF EXISTS Num_Question_created_in_2021;
DELIMITER $$
	CREATE PROCEDURE Num_Question_created_in_2021 ()
		BEGIN
			SELECT month(CreateDate) AS Thang, count(1) AS So_cau_hoi
			FROM `Question`
			WHERE year(CreateDate) = year(now())
			GROUP BY Thang
			ORDER BY Thang ASC;
		END$$
DELIMITER ;

-- Q13: store để in ra mỗi tháng có bn câu hỏi đc tạo trong 6 tháng gần đây nhất
DROP PROCEDURE IF EXISTS Question_last_created;
DELIMITER $$
	CREATE PROCEDURE Question_last_created ()
		BEGIN
			SELECT *
			FROM `Question`
			WHERE month(CreateDate) < now() - interval 6 month;
		END$$
DELIMITER ;