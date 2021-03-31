USE ExtraTestingSystem;

/*
Project_Modules.ProjectModulesDate < Projects.ProjectStartDate,
Project_Modules.ProjectModulesCompletedOn > Projects.ProjectCompletedOn
*/
DROP TRIGGER IF EXISTS check_date;
DELIMITER $$
	CREATE TRIGGER check_date
		BEFORE INSERT ON `Project_Modules`
        FOR EACH ROW
		BEGIN
			DECLARE get_ProjectStartDate DATETIME;
			DECLARE get_ProjectCompletedOn DATETIME;
			SELECT ProjectStartDate, ProjectCompletedOn INTO get_ProjectStartDate, get_ProjectCompletedOn
			FROM `Projects`
			WHERE NEW.ProjectID = ProjectID;
			
			IF NEW.ProjectModulesDate < get_ProjectStartDate OR (NEW.ProjectModulesCompletedOn > get_ProjectCompletedOn AND get_ProjectCompletedOn IS NOT NULL) THEN
				SIGNAL SQLSTATE '12345'
				SET MESSAGE_TEXT = 'Kiểm tra lại thời gian bắt đầu / hoàn thành ProjectModules và Projects';
			END IF;
		END $$
DELIMITER ;

INSERT INTO `Project_Modules` (ProjectID, ProjectModulesDate, ProjectModulesCompletedOn, ProjectModulesDescription)
VALUES (4, '2019-02-01 00:00:00', '2020-07-24 23:35:45', 'Test')