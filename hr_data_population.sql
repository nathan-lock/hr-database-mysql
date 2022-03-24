-- -----------------------------------------------------
-- Database hr
-- -----------------------------------------------------
USE hr;

-- -----------------------------------------------------
-- Table hr.county
-- -----------------------------------------------------
/* Shorthand mulit insert syntax to reduce repeating 
boiler plate code. Always specifiying field name for
self documeneting quieries. */
INSERT INTO 
	county (county_name) 
VALUES 
	("Berkshire"),
	("Devon"),
	("East Sussex"),
	("Essex"),
	("Lancashire"),
	("Norfolk"),
	("South Gloucestershire"),
	("Suffolk"),
	("Tyne & Wear"),
	("Wiltshire");

-- -----------------------------------------------------
-- Table hr.town
-- -----------------------------------------------------
INSERT INTO 
	town (town_name, county_id)
VALUES 
	("Reading", 1),
	("Windsor", 1),
	("Exeter", 2),
	("Kings Bridge", 2),
	("Rye", 3),
    ("Braintree", 4),
    ("Colchester", 4),
    ("Norwich", 6),
    ("Ipswich", 8);

-- -----------------------------------------------------
-- Table hr.postcode
-- -----------------------------------------------------
INSERT INTO postcode (
	postcode, town_id
) VALUES 
	("IP1 1AZ", 1),
	("IP4 6SN", 9),
	("RG1 1AF", 1),
	("RG14 2AF", 1),
	("CO1 3BC", 7),
	("SL3 9BS", 2),
	("TN31 7AB", 5),
	("TQ7 1AA", 4),
	("TQ4 1AA", 4);

-- -----------------------------------------------------
-- Table hr.location
-- -----------------------------------------------------
INSERT INTO 
	location (address_1, address_2, postcode)
VALUES 
	("14 Ascott close", "", "IP1 1AZ"),
	("20 Abbey Road", "", "IP4 6SN"),
	("8 Brewer Street", "", "RG1 1AF"),
	("4 Canning Place", "", "TQ4 1AA"),
	("1 Charlotte Street", "Block 2", "TN31 7AB"),
	("2 Cumberland Street", "", "SL3 9BS"),
	("45 Cumberland Street", "", "SL3 9BS"),
	("45 Edward Street", "", "CO1 3BC");

-- -----------------------------------------------------
-- Table hr.department
-- -----------------------------------------------------
INSERT INTO 
	department (depart_name)
VALUES 
	("Human Rescources"),
	("Sales"),
	("Accounts"),
	("Marketing"),
	("Security");

-- -----------------------------------------------------
-- Table hr.department_address_link
-- -----------------------------------------------------
INSERT INTO 
	department_address_link (depart_id, location_id) 
VALUES 
	(1, 5),
	(2, 4),
	(3, 3),
	(4, 2),
	(5, 1);

-- -----------------------------------------------------
-- Table hr.job_role
-- -----------------------------------------------------
INSERT INTO 
	job_role (job_title, min_salary, max_salary) 
VALUES 
	("Head of Operations", 700000, 100000),
	("Junior Executive", 18000, 25000),
	("Executive", 26000, 30000),
	("Senior Executive", 31000, 40000),
	("Manager", 40000, 50000),
	("Graphic Designer", 15000, 25000),
	("Director", 70000, 100000);

-- -----------------------------------------------------
-- Table hr.employee
-- -----------------------------------------------------
INSERT INTO
	employee (emp_first_name, emp_last_name, dob, depart_id, location_id, job_title, salary, phone_number, hire_date)
VALUES
	("John", "Smith", "1987-04-07", 2, 3, "Head of Operations", 750000, "078958747288", "2021-01-20"),
	("Philip", "Huband", "2000-5-30", 4, 4, "Executive", 28000, "078958747555", "2019-11-20"),
	("Ella", "Fisher", "1968-7-15", 1, 6, "Executive", 28000, "078958744855", "2018-04-30"),
	("Max", "Fisher", "1968-7-15", 3, 6, "Manager", 45000, "0789587447895", "2019-08-5"),
	("Tom", "Jackson", "1998-4-1", 5, 5, "Senior Executive", 26000, "07854632514", "2021-04-12"),
	("Jasmine", "Smith", "1988-4-1", 5, 3, "Senior Executive", 29000, "07854632514", "2015-06-22"),
	("Emily", "walker", "1999-6-29", 2, 2, "Graphic Designer", 36000, "07854632514", "2020-08-21"),
	("Jonah", "watson", "1989-7-3", 4, 8, "Director", 900000, "07458965235", "2005-01-1");

-- -----------------------------------------------------
-- Table hr.employee_manager
-- -----------------------------------------------------
INSERT INTO
	employee_manager (emp_id, manager_id)
VALUES
	(1, 8),
	(2, 5),
	(3, 6),
	(4, 1),
	(5, 1),
	(6, 1),
	(7, 4);
    
-- -----------------------------------------------------
-- Table hr.skill
-- -----------------------------------------------------
INSERT INTO
	skill (skill_name)
VALUES
	("Communication"),
	("Time Management"),
	("Critical Thinking"),
	("Creativity"),
	("Teamwork");
    
-- -----------------------------------------------------
-- Table hr.skill_rating
-- -----------------------------------------------------
INSERT INTO
	skill_rating (emp_id, skill_id, rating)
VALUES
	(1, 1, 7),
	(1, 2, 4),
	(1, 3, 5),
	(2, 4, 5),
	(2, 5, 1),
	(2, 2, 10),
	(3, 1, 8),
	(3, 2, 9),
	(3, 4, 7),
	(4, 5, 6),
	(4, 1, 6),
	(4, 2, 8),
	(5, 3, 8),
	(5, 4, 1),
	(5, 5, 6),
	(6, 1, 7),
	(6, 2, 4),
	(6, 3, 5);
    
-- -----------------------------------------------------
-- Table hr.manager_speciality
-- -----------------------------------------------------
INSERT INTO
	manager_speciality (manager_id, skill_id)
VALUES
	(4, 1),
	(1, 5),
	(5, 2),
	(6, 3),
	(6, 4);