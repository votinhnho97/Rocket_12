USE TestingSystem;

-- Question 1: Lấy ra tất cả các phòng ban
SELECT DepartmentName
FROM Department;

-- Question 2: Lấy ra id của phòng ban `Sale`
SELECT DepartmentID
FROM Department
WHERE DepartmentName = 'Sale';

-- Question 3: Lấy ra thông tin account có fullname dài nhất
SELECT *
FROM `Account`
ORDER BY length(FullName) DESC
LIMIT 1;

-- Question 4: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT * 
FROM `Group`
WHERE CreateDate < '2019-12-20';

-- Question 5: Lấy ra ID của question có >= 4 câu trả lời
SELECT QuestionID
FROM Answer
GROUP BY QuestionID
HAVING count(QuestionID) >= 4;

-- Question 6: Lấy ra 5 group được tạo gần đây nhất
SELECT *
FROM `Group`
ORDER BY CreateDate DESC
LIMIT 5;

-- Question 8: Xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE
FROM Exam
WHERE CreateDate < '2019-12-20';

-- Question 9: Update thông tin của account có id = 5 thành "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE `Account`
SET	FullName	= 'Nguyễn Bá Lộc',
	Email		= 'loc.nguyenba@vti.com.vn'
WHERE AccountID = 5;

-- Question 10: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT a.AccountID, a.Email, a.Username, a.Fullname, d.DepartmentID, d.DepartmentName
FROM `Account` a
INNER JOIN `Department` d ON a.DepartmentID = d.DepartmentID;

-- Question 11: Viết lệnh để lấy ra tất cả các developer
SELECT a.AccountID, a.Email, a.Username, a.Fullname, a.DepartmentID, p.PositionID, p.PositionName
FROM `Account` a
INNER JOIN `Position` p ON a.PositionID = p.PositionID
WHERE p.PositionName = 'Dev';

-- Question 12: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT `Department`.DepartmentName, count(`Account`.DepartmentID) as So_luong_NV
FROM `Department`
JOIN `Account`
ON `Department`.DepartmentID = `Account`.DepartmentID
GROUP BY `Department`.DepartmentName
HAVING count(*) > 3;

-- Question 13: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT eq.QuestionID, count(1) AS Num_of_use
FROM `ExamQuestion` eq
GROUP BY eq.QuestionID
ORDER BY Num_of_use DESC
LIMIT 1;

-- Question 14: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT CategoryQuestion.CategoryName, count(*) AS Num_of_Questions
FROM CategoryQuestion
JOIN Question
ON CategoryQuestion.CategoryID = Question.CategoryID
GROUP BY CategoryQuestion.CategoryID;

-- Question 15: Lấy ra Question có nhiều câu trả lời nhất
SELECT Question.QuestionID, count(*) AS Num_of_Answer
FROM Question
INNER JOIN Answer
ON Question.QuestionID = Answer.QuestionID
GROUP BY Answer.QuestionID
LIMIT 1;

-- Question 16: Tìm chức vụ có ít người nhất
SELECT `Position`.PositionID, `Position`.PositionName, count(`Account`.AccountID) AS Counter
FROM `Position`
INNER JOIN `Account`
ON `Position`.PositionID = `Account`.PositionID
GROUP BY `Position`.PositionID
ORDER BY Counter ASC
LIMIT 1;

-- Question 17: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM


-- Question 18: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …



-- Question 19: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT tq.TypeName, count(1) AS Num_of_question
FROM `Question` q
INNER JOIN `TypeQuestion` tq ON q.TypeID = tq.TypeID
GROUP BY q.TypeID;
