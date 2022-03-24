-- ------------------------------------------------------------------------------------------------
-- Database hr
-- ------------------------------------------------------------------------------------------------
USE hr;

-- -------------------------------------------------------------------------------------------------
-- Query 1 - List the salary bands for each job title.
-- -------------------------------------------------------------------------------------------------
SELECT *FROM job_role;

-- ------------------------------------------------------------------------------------------------
-- Query 2 - Find the employee phone number of an employee named "Philip Huband".
-- ------------------------------------------------------------------------------------------------
SELECT phone_number
FROM employee 
WHERE emp_first_name = "Philip"
AND emp_last_name = "Huband";

-- ------------------------------------------------------------------------------------------------
-- Query 3 - Find the employees whos salary is over £30,000.
-- -------------------------------------------------------------------------------------------------
SELECT emp_first_name, emp_last_name
FROM employee
WHERE salary > 30000;

-- ------------------------------------------------------------------------------------------------
-- Query 4 - Find the number of departments in the company.
-- ------------------------------------------------------------------------------------------------
SELECT COUNT(depart_id)
FROM department;

-- ------------------------------------------------------------------------------------------------
-- Query 5 - What is the "Communication" skill score for "John Smith"?
-- ------------------------------------------------------------------------------------------------
/* The inner join collates the information from the different locaiton tables ON the supplied key.
Inner join merges matching rows from both tables.*/
SELECT rating
FROM employee
INNER JOIN skill_rating
ON employee.emp_id = skill_rating.emp_id
INNER JOIN skill
ON skill.skill_id = skill_rating.skill_id
WHERE emp_first_name = "John"
AND emp_last_name = "Smith"
AND skill_name = "Communication";

-- -------------------------------------------------------------------------------------------------
-- Query 6 - What is the full addres of "Jasmin Smith"?
-- -------------------------------------------------------------------------------------------------
SELECT location.address_1, location.address_2, town.town_name, county.county_name, location.postcode
FROM employee
INNER JOIN location
ON employee.location_id = location.location_id
INNER JOIN postcode
ON location.postcode = postcode.postcode
INNER JOIN town
ON postcode.town_id = town.town_id
INNER JOIN county
ON town.county_id = county.county_id
WHERE emp_first_name = "Jasmine"
AND emp_last_name = "Smith";

-- -------------------------------------------------------------------------------------------------
-- Query 7 - What department is "Tom Jackson" in?
-- -------------------------------------------------------------------------------------------------
SELECT depart_name
FROM employee
INNER JOIN department 
ON employee.depart_id = department.depart_id
WHERE emp_first_name = "Tom"
AND emp_last_name = "Jackson";

-- -------------------------------------------------------------------------------------------------
-- Query 8 - Who does "John Smith" manage? 
-- -------------------------------------------------------------------------------------------------
SELECT emp.emp_first_name, emp.emp_last_name
FROM employee emp
INNER JOIN employee_manager link
ON emp.emp_id = link.emp_id 
INNER JOIN employee man
ON man.emp_id = link.manager_id
WHERE man.emp_first_name = "John"
AND man.emp_last_name = "Smith";

-- -------------------------------------------------------------------------------------------------
-- Query 9 - List the address where each employee works.
-- -------------------------------------------------------------------------------------------------
SELECT emp_first_name, emp_last_name, location.address_1, location.address_2, town.town_name, 
county.county_name, location.postcode
FROM employee
INNER JOIN department_address_link
ON employee.depart_id = department_address_link.depart_id
INNER JOIN location
ON department_address_link.location_id = location.location_id
INNER JOIN postcode
ON location.postcode = postcode.postcode
INNER JOIN town
ON postcode.town_id = town.town_id
INNER JOIN county
ON town.county_id = county.county_id;

-- -------------------------------------------------------------------------------------------------
-- Query 10 - List the managers and their speciality.
-- -------------------------------------------------------------------------------------------------
SELECT emp_first_name, emp_last_name, skill_name 
FROM employee
INNER JOIN manager_speciality
ON employee.emp_id = manager_speciality.manager_id
INNER JOIN skill
ON skill.skill_id = manager_speciality.skill_id;