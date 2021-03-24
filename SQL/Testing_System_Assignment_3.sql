USE TestingSystem;

-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
DROP VIEW IF EXISTS Staff_in_Sale;
CREATE VIEW Staff_in_Sale AS
	SELECT a.AccountID, a.Email, a.Username, a.FullName, a.DepartmentID, d.DepartmentName, a.PositionID, a.CreateDate
	FROM `Account` a
	JOIN `Department` d ON a.DepartmentID = d.DepartmentID;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
DROP VIEW IF EXISTS Staff_join_multi_Group;
CREATE VIEW Staff_join_multi_Group AS
	SELECT ga.AccountID, GROUP_CONCAT(g.GroupID) AS 'Group_ID', GROUP_CONCAT(g.GroupName)
    FROM `GroupAccount` ga
    LEFT JOIN `Group` g ON ga.GroupID = g.GroupID
    GROUP BY ga.AccountID;

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
DROP VIEW IF EXISTS Long_content_Question;
CREATE VIEW Long_content_Question AS
	SELECT *, character_length(Content)
    FROM Question
    WHERE character_length(Content) > 300;

DELETE
FROM Long_content_Question;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
DROP VIEW IF EXISTS Department_has_a_lot_of_Employee;
CREATE VIEW Department_has_a_lot_of_Employee AS
	SELECT d.DepartmentName, count(a.DepartmentID) as Num_of_Employee
	FROM `Department` d
	JOIN `Account` a ON d.DepartmentID = a.DepartmentID
	GROUP BY d.DepartmentName
	HAVING Num_of_Employee >= 2
	ORDER BY Num_of_Employee DESC;
    
-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
DROP VIEW IF EXISTS Question_create_by_Nguyen;
CREATE VIEW Question_create_by_Nguyen AS 
SELECT q.QuestionID, q.CategoryID, q.TypeID, q.CreatorID, q.CreateDate, q.Content, a.Username, a.FullName
FROM `Question` q
JOIN `Account` a ON q.CreatorID = a.AccountID
WHERE a.FullName LIKE 'Nguyễn%'