USE ExtraTestingSystem;

/*
Viết stored procedure (không có parameter) để Remove tất cả thông tin
project đã hoàn thành sau 3 tháng kể từ ngày hiện. In số lượng record đã
remove từ các table liên quan trong khi removing (dùng lệnh print)
*/
DROP VIEW IF EXISTS Get_ProjectsID;
CREATE VIEW Get_ProjectsID AS
	SELECT ProjectID
	FROM `Projects`
	WHERE now() - interval 3 month > ProjectCompletedOn;

DROP VIEW IF EXISTS Get_ModulesID;
CREATE VIEW Get_ModulesID AS
	SELECT ModuleID
	FROM `Project_Modules`
	WHERE ProjectID IN (SELECT ProjectID FROM Get_ProjectsID);

DROP VIEW IF EXISTS Get_WorkDone;
CREATE VIEW Get_WorkDone AS
	SELECT WorkDoneID
	FROM `Work_Done`
	WHERE ModuleID IN (SELECT ModuleID FROM Get_ModulesID);

DROP PROCEDURE IF EXISTS Remove_Information;
DELIMITER $$
	CREATE PROCEDURE Remove_Information()
		BEGIN
			DECLARE count_Project INT;
            DECLARE count_ProjectModule INT;
            DECLARE count_WorkDone INT;
            
			SELECT count(ProjectID) INTO count_Project
			FROM Get_ProjectsID;

            SELECT count(ModuleID) INTO count_ProjectModule
            FROM Get_ModulesID;

            SELECT count(WorkDoneID) INTO count_WorkDone
            FROM Get_WorkDone;
            
            SELECT count_Project, count_ProjectModule, count_WorkDone;
		END $$
DELIMITER ;

/*
Viết stored procedure (có parameter) để in ra các module đang được thực
hiện)
*/
DROP PROCEDURE IF EXISTS Modules_is_Active;
DELIMITER $$
	CREATE PROCEDURE Modules_is_Active()
		BEGIN
			SELECT *
			FROM `Projects_Modules`
			WHERE ProjectModulesCompletedOn IS NULL;
		END $$
DELIMITER ;

/*
Viết hàm (có parameter) trả về thông tin nhân viên đã tham gia làm mặc
dù không ai giao việc cho nhân viên đó (trong bảng Works)
*/
DROP PROCEDURE IF EXISTS Supervisor;
DELIMITER $$
	CREATE PROCEDURE Supervisor()
		BEGIN
			SELECT DISTINCT(e.EmployeeID), e.EmployeeLastName, e.EmployeeFirstName
			FROM `Work_Done` w
			LEFT JOIN `Employee` e ON w.EmployeeID = e.EmployeeID
			WHERE e.SupervisorID IS NULL;
		END $$
DELIMITER ;

/*
Viết hàm trả về thông tin nhân viên đã tham gia làm và
có người giao việc (in thêm thông tin người giao việc)
*/
DROP PROCEDURE IF EXISTS Supervisor;
DELIMITER $$
	CREATE PROCEDURE Supervisor()
		BEGIN
			SELECT DISTINCT(e.EmployeeID), e.EmployeeLastName, e.EmployeeFirstName
			FROM `Work_Done` w
			LEFT JOIN `Employee` e ON w.EmployeeID = e.EmployeeID
			WHERE e.SupervisorID IS NOT NULL;
		END $$
DELIMITER ;



