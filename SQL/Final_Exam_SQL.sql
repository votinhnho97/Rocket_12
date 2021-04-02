DROP DATABASE IF EXISTS ThucTap;
CREATE DATABASE ThucTap;
USE ThucTap;

DROP TABLE IF EXISTS `Country`;
CREATE TABLE IF NOT EXISTS `Country` (
	country_id			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	country_name		VARCHAR(100) NOT NULL
);

INSERT INTO `Country` 
		(country_name)
VALUES 
		('Việt Nam'),
		('Hàn Quốc'),
		('Mỹ');

DROP TABLE IF EXISTS `Location`;
CREATE TABLE IF NOT EXISTS `Location` (
	location_id			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	street_address		VARCHAR(100) NOT NULL,
	postal_code			INT NOT NULL,
	country_id			INT UNSIGNED NOT NULL,
	FOREIGN KEY (country_id) REFERENCES `Country`(country_id)
);

INSERT INTO `Location` 
		(street_address		, postal_code		, country_id		)
VALUES 
		('Ha Noi'			, 1000				, 1					),
		('Danwon-gu'		, 2000				, 2					),
        ('Phu Tho'			, 1000				, 1					),
		('Texas'			, 5000				, 3					);

DROP TABLE IF EXISTS `Employee`;
CREATE TABLE IF NOT EXISTS `Employee` (
	employee_id			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	full_name			VARCHAR(100) NOT NULL,
	email				VARCHAR(50) NOT NULL,
	location_id			INT UNSIGNED,
	FOREIGN KEY (location_id) REFERENCES `Location`(location_id)
);

INSERT INTO `Employee` 
		(full_name		, email				, location_id		)
VALUES 
		('Nguyễn Văn A'	, 'a@gmail.com'		, 1					),
		('Nguyễn Văn B'	, 'b@gmail.com'		, 3					),
		('Nguyễn Văn C'	, 'c@gmail.com'		, 2					),
        ('Nguyễn Văn E'	, 'nn03@gmail.com'	, 4					),
		('Nguyễn Văn D'	, 'test@gmail.com'	, 1					);
/*
	QUERY
*/

/*
2. Viết lệnh để
	a) Lấy tất cả các nhân viên thuộc Việt nam
	b) Lấy ra tên quốc gia của employee có email là "nn03@gmail.com"
	c) Thống kê mỗi country, mỗi location có bao nhiêu employee đang làm việc.
*/
-- 2.a
SELECT *
FROM `Employee`
WHERE location_id IN (SELECT location_id FROM `Location` WHERE country_id = (SELECT country_id FROM `Country` WHERE country_name = 'Việt Nam'));

-- 2.b
SELECT c.country_name
FROM Employee e
JOIN Location l ON e.location_id = l.location_id
JOIN Country c ON c.country_id = l.country_id
WHERE e.email = 'nn03@gmail.com';

-- 2.c
SELECT c.country_name, l.location_id, l.street_address, count(e.employee_id) AS Slg
FROM `Country` c
LEFT JOIN `Location` l ON c.country_id = l.country_id
LEFT JOIN `Employee` e ON l.location_id = e.location_id
WHERE e.location_id IS NOT NULL
GROUP BY c.country_id, l.location_id
ORDER BY c.country_id;

/*
3. Tạo trigger cho table Employee chỉ cho phép insert mỗi quốc gia có tối đa 10 employee
*/
DROP TRIGGER IF EXISTS check_before_insert_employee;
DELIMITER $$
	CREATE TRIGGER check_before_insert_employee
		BEFORE INSERT ON `Employee`
		FOR EACH ROW
		BEGIN
			DECLARE get_country_id INT;
            DECLARE count_employee INT;
			
            SELECT country_id INTO get_country_id FROM `Location` WHERE NEW.location_id = location_id;

			SELECT count(1) INTO count_employee
			FROM `Employee`
			WHERE location_id IN (SELECT location_id FROM `Location` WHERE country_id = get_country_id);
			
			IF count_employee >= 10 THEN
				SIGNAL SQLSTATE '12345'
				SET MESSAGE_TEXT = 'Mỗi quốc gia chỉ cho phép 10 employee.';
			END IF;
		END $$
DELIMITER ;
-- Test trigger
INSERT INTO `Employee` 
		(full_name		, email					, location_id		)
VALUES 
		('Nguyễn Văn E'	, 'sss@gmail.com'		, 1					);

/*
4. Hãy cấu hình table sao cho khi xóa 1 location nào đó thì tất cả employee ở location đó sẽ có location_id = null
*/
DROP TRIGGER IF EXISTS check_before_delete_location;
DELIMITER $$
	CREATE TRIGGER check_before_delete_location
		BEFORE DELETE ON `Location`
		FOR EACH ROW
		BEGIN
			UPDATE `Employee`
			SET
				location_id = NULL
			WHERE location_id = OLD.location_id;
		END $$
DELIMITER ;
-- Test trigger
DELETE FROM `Location` WHERE location_id = 3;





