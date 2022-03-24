-- ------------------------------------------------------------------------------------------------
-- Database hr
-- ------------------------------------------------------------------------------------------------
USE hr;

-- -------------------------------------------------------------------------------------------------
-- Views
-- -------------------------------------------------------------------------------------------------
/* Create a view for employee addresses to reduce boilerplate code when retrieving employee 
address information.*/
CREATE OR REPLACE VIEW view_employee_address AS
SELECT employee.*, location.address_1, location.address_2, town.town_name, county.county_name,
location.postcode
FROM employee
INNER JOIN location
ON employee.location_id = location.location_id
INNER JOIN postcode
ON location.postcode = postcode.postcode
INNER JOIN town
ON postcode.town_id = town.town_id
INNER JOIN county
ON town.county_id = county.county_id;

-- -------------------------------------------------------------------------------------------------
-- Functions
-- -------------------------------------------------------------------------------------------------
/* Function to capitalise the first letter of a 100 letter word and lower case the remaining
letters. */
DROP FUNCTION IF EXISTS CapitaliseFirstLetter;
/* Tells MySQL to treat the following code as a single statment by changing the default delimiter
from ; to $$, this allows the use of ; inside functions. */
DELIMITER $$ 
CREATE FUNCTION CapitaliseFirstLetter(word varchar(100)) RETURNS VARCHAR(100)
READS SQL DATA # Disable warning for binary logging by trusting the function is only reading data
BEGIN
	/* Returns the concatination of the capitalised first letter and the lower case following
    letters. */
	RETURN CONCAT(UPPER(LEFT(word,1)), LOWER(SUBSTRING(word,2)));
END $$
DELIMITER ;

-- -------------------------------------------------------------------------------------------------
-- Query 1 - What percentage of the employees have a rating in "Communication" and are rated above
-- 5?
-- -------------------------------------------------------------------------------------------------
SELECT
(
	SELECT count(*) # return the number of skills from the query below
	FROM skill_rating
    INNER JOIN skill
    ON skill.skill_id = skill_rating.skill_id
	WHERE skill.skill_name = "Communication"
    AND skill_rating.rating > 5
) / (
	SELECT count(*) from employee # return total number of employees
) * 100; # (employyes have a rating over 5 / total employees ) * 100 for percentage

-- -------------------------------------------------------------------------------------------------
-- Query 2 - What is the difference in length of service years between the shortest and longest
-- serving employee?
-- -------------------------------------------------------------------------------------------------
/* Find the difference betwen the min and mix hire date timestamps. */
SELECT TIMESTAMPDIFF(
YEAR, # return the result as year
(
	SELECT MIN(hire_date) # find the shortest serving employee
    FROM employee
), 
(
	SELECT MAX(hire_date) # find the longest serving employee
    FROM employee
));

-- -------------------------------------------------------------------------------------------------
-- Query 3 - What is the average salary of each department ordered highest to lowest?
-- -------------------------------------------------------------------------------------------------
SELECT depart_name, AVG(salary) 
FROM department
INNER JOIN employee
ON employee.depart_id = department.depart_id
GROUP BY department.depart_id # group by deparment for aggregate functions
ORDER BY AVG(salary) DESC; # order result highest to lowest

-- -------------------------------------------------------------------------------------------------
-- Query 4 - Which employees live in "Berkshire"?
-- -------------------------------------------------------------------------------------------------
SELECT emp_first_name, emp_last_name
FROM view_employee_address # querying against view
WHERE county_name = "Berkshire";

-- -------------------------------------------------------------------------------------------------
-- Query 5 - Update the age field of all employees from their DOB.
-- -------------------------------------------------------------------------------------------------
SET SQL_SAFE_UPDATES = 0; # WARNING disabling safe-updates to update (without primary key WHERE).
UPDATE employee
/* Get the todays current date, calculate the difference between it and the employee's dob, convert the
result to years (rather than days) and cast the DATE type to an unsigned integer. */  
SET age = (CAST(DATE_FORMAT(FROM_DAYS(DATEDIFF(CURDATE(), dob)), '%Y') AS UNSIGNED));
SET SQL_SAFE_UPDATES = 1; # Re-enabling safe-updates to prevent accidential mass updates.
SELECT * from employee; # Show ouptut.

-- -------------------------------------------------------------------------------------------------
-- Query 6 - What county is the postcode prefix "IP" from?
-- -------------------------------------------------------------------------------------------------
SELECT county_name 
FROM postcode
INNER JOIN town
ON postcode.town_id = town.town_id
INNER JOIN county
ON town.county_id = county.county_id
WHERE postcode LIKE 'IP%' # starts with the postcode IP
LIMIT 1; # only show 1 result

-- -------------------------------------------------------------------------------------------------
-- Query 7 - Delete the county of "Suffolk" and all address from the county.
-- -------------------------------------------------------------------------------------------------
/* Delete cascades are enabled in table creation for locations. Child tables with correspoding rows
 are deleted from the location table e.g. postcodes. When Suffolk is deleted the associated towns 
 and postcodes are also removed in cascade. */ 
SET SQL_SAFE_UPDATES = 0; # WARNING disabling safe-updates to delete (without primary key WHERE).
DELETE FROM county
WHERE county_name = "Suffolk";
SET SQL_SAFE_UPDATES = 1; # Re-enabling safe-updates to prevent accidential mass updates.
SELECT * from town;

-- -------------------------------------------------------------------------------------------------
-- Query 8 - Delete the skill id 1.
-- -------------------------------------------------------------------------------------------------
/* ---- WARNING EXPECTED ERROR!----
  Cascading deletes are not enabled for the skill tables. Deleting from the skill table will error
  as MySQL prevents deleting a parent row where the child tables reference the deleted primary key.
  To prevent the error, the child rows which reference the primary key should be deleted first and 
  then delete the parent rows. */
DELETE from skill
WHERE skill_id = 1;

/* Correct running script */
DELETE FROM skill_rating # delete child references
WHERE skill_id = 1;
DELETE FROM manager_speciality # delete child references
WHERE skill_id = 1;
DELETE FROM skill # delete parent
WHERE skill_id = 1;

-- -------------------------------------------------------------------------------------------------
-- Query 9 - Update first letter of the first and last name to be capitalised in the employee
-- table.
-- -------------------------------------------------------------------------------------------------
SET SQL_SAFE_UPDATES = 0; # WARNING disabling safe-updates to delete (without primary key WHERE).
UPDATE employee
SET emp_first_name = CapitaliseFirstLetter(emp_first_name); # Update first name using function result
UPDATE employee
SET emp_last_name = CapitaliseFirstLetter(emp_last_name); # Update last name using function result
SET SQL_SAFE_UPDATES = 1; # Re-enabling safe-updates to prevent accidential mass updates.

-- -------------------------------------------------------------------------------------------------
-- Query 10 - Employees now have an email address. Add a new column for email address and 
-- autopopulate it with "[first_name].[lastname]@hr.com".
-- -------------------------------------------------------------------------------------------------
ALTER TABLE employee
ADD email VARCHAR(320); # add email column with a theoretical maximum length
SET SQL_SAFE_UPDATES = 0; # WARNING disabling safe-updates to update (without primary key WHERE)
UPDATE employee
SET email = CONCAT(LOWER(emp_first_name), ".", LOWER(emp_last_name), "@hr.com");
SET SQL_SAFE_UPDATES = 1; # re-enabling safe-updates to prevent accidential mass updates
SELECT * from employee; # show ouptut