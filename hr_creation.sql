-- -----------------------------------------------------
-- WARNING - Script will overwrite an existing HR 
-- database and tables!
-- -----------------------------------------------------
-- Database hr
-- -----------------------------------------------------
DROP DATABASE IF EXISTS hr;
CREATE DATABASE hr DEFAULT CHARACTER SET utf8;
USE hr;

-- -----------------------------------------------------
-- Table hr.county
-- -----------------------------------------------------
DROP TABLE IF EXISTS county;
CREATE TABLE county (
	county_id INT NOT NULL AUTO_INCREMENT,
	county_name varchar(40) NOT NULL,
	PRIMARY KEY (county_id)

);

-- -----------------------------------------------------
-- Table hr.town
-- -----------------------------------------------------
DROP TABLE IF EXISTS town;
CREATE TABLE town (
  town_id INT NOT NULL AUTO_INCREMENT,
  town_name varchar(60) NOT NULL,
  county_id INT NOT NULL,
  PRIMARY KEY (town_id),
  FOREIGN KEY (county_id) REFERENCES county (county_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table hr.postcode
-- -----------------------------------------------------
DROP TABLE IF EXISTS postcode;
CREATE TABLE postcode (
  postcode varchar(8) NOT NULL,
  town_id INT NOT NULL,
  PRIMARY KEY (postcode),
  FOREIGN KEY (town_id) REFERENCES town (town_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table hr.location
-- -----------------------------------------------------
DROP TABLE IF EXISTS location;
CREATE TABLE location (
  location_id int NOT NULL AUTO_INCREMENT,
  address_1 varchar(255) NOT NULL,
  address_2 varchar(150),
  postcode varchar(8) NOT NULL,
  PRIMARY KEY (location_id),
  FOREIGN KEY (postcode) REFERENCES postcode (postcode)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table hr.department
-- -----------------------------------------------------
DROP TABLE IF EXISTS department;
CREATE TABLE department (
  depart_id int NOT NULL AUTO_INCREMENT,
  depart_name varchar(20) NOT NULL,
  PRIMARY KEY (depart_id)
);

-- -----------------------------------------------------
-- Table hr.department_address_link
-- -----------------------------------------------------
DROP TABLE IF EXISTS department_address_link;
CREATE TABLE department_address_link (
  depart_id int NOT NULL,
  location_id int NOT NULL,
  PRIMARY KEY (depart_id, location_id),
  FOREIGN KEY (depart_id) REFERENCES department (depart_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,
  FOREIGN KEY (location_id) REFERENCES location (location_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table hr.job_role
-- -----------------------------------------------------
DROP TABLE IF EXISTS `job_role`;
CREATE TABLE `job_role` (
	job_title varchar(50) NOT NULL,
    max_salary INT NOT NULL,
    min_salary INT NOT NULL,
    PRIMARY KEY (job_title)
);

-- -----------------------------------------------------
-- Table hr.employee
-- -----------------------------------------------------
DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
    emp_id INT NOT NULL AUTO_INCREMENT,
    emp_first_name varchar(50) NOT NULL,
    emp_last_name varchar(50) NOT NULL,
    depart_id INT NOT NULL,
    location_id INT NOT NULL,
    dob date NOT NULL,
	job_title varchar(50) NOT NULL,
    salary INT NOT NULL,
    phone_number varchar(15) NOT NULL,
    hire_date DATE,
    age INT,
    PRIMARY KEY (emp_id),
    FOREIGN KEY (depart_id) REFERENCES department (depart_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,
    FOREIGN KEY (job_title) REFERENCES `job_role`(job_title)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table hr.employee_manager
-- -----------------------------------------------------
DROP TABLE IF EXISTS employee_manager;
CREATE TABLE employee_manager (
	emp_id INT NOT NULL,
	manager_id INT NOT NULL,
    PRIMARY KEY (emp_id),
	FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (manager_id) REFERENCES employee(emp_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table hr.skill
-- -----------------------------------------------------
DROP TABLE IF EXISTS skill;
CREATE TABLE skill (
    skill_id INT NOT NULL AUTO_INCREMENT,
	skill_name varchar(50) NOT NULL,
    PRIMARY KEY (skill_id)
);

-- -----------------------------------------------------
-- Table hr.skill_rating
-- -----------------------------------------------------
DROP TABLE IF EXISTS skill_rating;
CREATE TABLE skill_rating (
	skill_id INT NOT NULL,
    emp_id INT NOT NULL,
    rating INT,
    PRIMARY KEY (skill_id, emp_id),
    FOREIGN KEY (skill_id) REFERENCES skill(skill_id),
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);

-- -----------------------------------------------------
-- Table hr.manager_speciality
-- -----------------------------------------------------
DROP TABLE IF EXISTS manager_speciality;
CREATE TABLE manager_speciality (
	manager_id INT NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (manager_id, skill_id),
    FOREIGN KEY (skill_id) REFERENCES skill(skill_id),
    FOREIGN KEY (manager_id) REFERENCES employee(emp_id)
);