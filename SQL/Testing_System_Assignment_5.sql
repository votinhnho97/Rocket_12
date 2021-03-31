USE TestingSystem;
/*
Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo
trước 1 năm trước
*/
DROP TRIGGER IF EXISTS Q1;
DELIMITER $$
	CREATE TRIGGER Q1
		BEFORE INSERT ON `Group`
		FOR EACH ROW
			BEGIN
				IF NEW.`CreateDate` < now() - interval 1 year THEN
					SIGNAL SQLSTATE '12345'
					SET MESSAGE_TEXT='Không được nhập vào nhóm đã tạo cách đây 1 năm.';
				END IF;
			END $$
DELIMITER ;

/*
Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào
department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
"Sale" cannot add more user"
*/
DROP TRIGGER IF EXISTS Q2;
DELIMITER $$
	CREATE TRIGGER Q2
		BEFORE INSERT ON `Account`
		FOR EACH ROW
			BEGIN
				DECLARE dep_name VARCHAR(100);
				SELECT DepartmentName INTO dep_name
				FROM `Department` WHERE DepartmentID = NEW.`DepartmentID`;
				IF dep_name = 'Sale' THEN
					SIGNAL SQLSTATE '12345'
					SET MESSAGE_TEXT='Department "Sale" cannot add more user.';
				END IF;
			END $$
DELIMITER ;

/*
Question 3: Cấu hình 1 group có nhiều nhất là 5 user
*/
DROP TRIGGER IF EXISTS Q3;
DELIMITER $$
	CREATE TRIGGER Q3
		BEFORE INSERT ON `GroupAccount`
		FOR EACH ROW
		BEGIN
			DECLARE count_Acc INT;
			SELECT Num_of_Acc INTO count_Acc
			FROM (SELECT GroupID, count(1) AS Num_of_Acc FROM `GroupAccount` GROUP BY GroupID) a
			WHERE NEW.GroupID = a.GroupID;
			IF count_Acc >= 5 THEN
				SIGNAL SQLSTATE '12345'
				SET MESSAGE_TEXT='1 group chỉ có tối đa 5 user.';
			END IF;
		END $$
DELIMITER ;

/*
Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question
*/
DROP TRIGGER IF EXISTS Q4;
DELIMITER $$
	CREATE TRIGGER Q4
		BEFORE INSERT ON `ExamQuestion`
		FOR EACH ROW
		BEGIN
			DECLARE count_Question INT;
			SELECT Num_of_Question INTO count_Question
			FROM (SELECT ExamID, count(1) AS Num_of_Question FROM `ExamQuestion` GROUP BY ExamID) a
			WHERE NEW.ExamID = a.ExamID;
			IF count_Question > 10 THEN
				SIGNAL SQLSTATE '12345'
				SET MESSAGE_TEXT='1 đề thi chỉ có 10 câu hỏi.';
			END IF;
		END $$
DELIMITER ;

/*
Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là
admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông
tin liên quan tới user đó
*/
DROP TRIGGER IF EXISTS Q5;
DELIMITER $$
	CREATE TRIGGER Q5
		BEFORE DELETE ON `Account`
		FOR EACH ROW
        BEGIN
			IF OLD.`UserName` = 'admin@gmail.com' THEN
				SIGNAL SQLSTATE '12345'
				SET MESSAGE_TEXT='Không thể xóa tài khoản "admin@gmail.com".';
			END IF;
		END $$
DELIMITER ;

/*
Question 6: Không sử dụng cấu hình default cho field DepartmentID của table
Account, hãy tạo trigger cho phép người dùng khi tạo account không điền
vào departmentID thì sẽ được phân vào phòng ban "waiting Department"
*/
DROP TRIGGER IF EXISTS Q6;
DELIMITER $$
	CREATE TRIGGER Q6
		BEFORE INSERT ON `Account`
		FOR EACH ROW
        BEGIN
			IF NEW.`DepartmentID` IS NULL THEN
				SET NEW.`DepartmentID` = 0;
			END IF;
		END $$
DELIMITER ;

/*
Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi
question, trong đó có tối đa 2 đáp án đúng.
*/


/*
Question 8: Viết trigger sửa lại dữ liệu cho đúng:
Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định
Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database
*/
-- Thêm 1 trường Gender vào bảng `Account`
DROP TRIGGER IF EXISTS Q8;
DELIMITER $$
	CREATE TRIGGER Q8
		BEFORE INSERT ON `Account`
		FOR EACH ROW
        BEGIN
			IF NEW.`Gender` IN ('Nam', 'Nữ', 'Chưa xác định') THEN
				IF NEW.`Gender` = 'Nam' THEN
					SET NEW.`Gender` = 'M';
				ELSEIF NEW.`Gender` = 'Nữ' THEN
					SET NEW.`Gender` = 'F';
				ELSE
					SET NEW.`Gender` = 'U';
				END IF;
			END IF;
		END $$
DELIMITER ;

/*
Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
*/
DROP TRIGGER IF EXISTS Q9;
DELIMITER $$
	CREATE TRIGGER Q9
		BEFORE DELETE ON `Exam`
		FOR EACH ROW
        BEGIN
			DECLARE get_CreateDate DATETIME;
			SELECT CreateDate INTO get_CreateDate FROM `Exam` WHERE ExamID = OLD.ExamID;
			IF get_CreateDate < now() - interval 2 day THEN
				SIGNAL SQLSTATE '12345'
				SET MESSAGE_TEXT='Không thể xóa bài thi mới tạo cách đây 2 ngày.';
			END IF;
		END $$
DELIMITER ;
/*
Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các
question khi question đó chưa nằm trong exam nào
*/
DROP TRIGGER IF EXISTS Q10_1;
DELIMITER $$
	CREATE TRIGGER Q10_1
		BEFORE UPDATE ON `Question`
		FOR EACH ROW
		BEGIN
			DECLARE question_is_used INT;
			SELECT count(QuestionID) INTO question_is_used FROM `ExamQuestion` WHERE QuestionID = NEW.QuestionID;
			IF question_is_used != 0 THEN
				SIGNAL SQLSTATE '12345'
				SET MESSAGE_TEXT='Không thể xóa câu hỏi đã sử dụng trong đề thi.';
			END IF;
		END $$
DELIMITER ;
DROP TRIGGER IF EXISTS Q10_2;
DELIMITER $$
	CREATE TRIGGER Q10_2
		BEFORE DELETE ON `Question`
		FOR EACH ROW
		BEGIN
			DECLARE question_is_used INT;
			SELECT count(QuestionID) INTO question_is_used FROM `ExamQuestion` WHERE QuestionID = OLD.QuestionID;
			IF question_is_used != 0 THEN
				SIGNAL SQLSTATE '12345'
				SET MESSAGE_TEXT='Không thể xóa câu hỏi đã sử dụng trong đề thi.';
			END IF;
		END $$
DELIMITER ;

/*
Question 12: Lấy ra thông tin exam trong đó:
Duration <= 30 thì sẽ đổi thành giá trị "Short time"
30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
Duration > 60 thì sẽ đổi thành giá trị "Long time"
*/
-- CASE WHEN
SELECT *,
		CASE 
			WHEN Duration <= 30 THEN 'Short time'
			WHEN Duration > 30 AND Duration <= 60 THEN 'Medium time'
			ELSE 'Long time'
		END AS Duration_text
FROM `Exam`;

/*
Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
là the_number_user_amount và mang giá trị được quy định như sau:
Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher
*/
-- CASE WHEN
SELECT GroupID, 
	CASE
		WHEN count(1) <= 5 THEN 'Few'
		WHEN count(1) > 5 AND count(1) <= 20 THEN 'Normal'
		ELSE 'Higher'
	END AS the_number_user_amount
FROM `GroupAccount`
GROUP BY GroupID;

/*
Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào
không có user thì sẽ thay đổi giá trị 0 thành "Không có User"
*/
-- CASE WHEN
SELECT d.DepartmentID, d.DepartmentName, 
	CASE
		WHEN count(1) = 0 THEN 'Không có User'
		ELSE count(1)
	END AS the_number_user_amount
FROM `Department` d
LEFT JOIN `Account` a ON a.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentID;