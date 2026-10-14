-- Understand the Data

-- 1st I am printing all tables 

select * from data_dictionary;
select * from dim_business_unit;
select * from dim_date;
select * from dim_delivery;
select * from dim_employee;
select * from dim_location;
select * from dim_programme;
select * from dim_project;
select * from dim_strategic;
select * from fact_project_monthly limit (10);

--These questions help you understand your tables and basic SQL.
-- Q1. How many projects are in the project portfolio?

-- First check the table:
select  * from dim_project;

-- Then Count the Projects 
select count(*) as total_projects from dim_project;

--Q2. How many employees are available in the organization?

-- first check the table:
select * from dim_employee;

-- Then Count the employees 
select count(*) as total_employees from dim_employee;

--Q3. How many business units are there?
-- first check the table:
select * from dim_business_unit;

-- Then Count the  business units 
select count(*) as total_Business_unit from dim_business_unit;

--Q4. How many programmes are there?
select * from dim_programme;

-- Then Count the programmes 
select count(*) as tottal_programmes from dim_programme; 

--Q5. How many different project locations are there?
select * from dim_location;

-- Then Count the locations 
select count(distinct dim_location) as diffrent_location from dim_location;



--Q6. What are the different project statuses?
select * from dim_strategic;

-- Then Distinct the Strategic
select distinct "StrategicTheme"  from dim_strategic;


--  GROUP BY


-- Now start understanding how projects are distributed


-- Q7. How many projects are there in each business unit?
SELECT 
    b."BusinessUnitName",
    COUNT(DISTINCT f."ProjectKey") AS total_projects
FROM fact_project_monthly f
JOIN dim_business_unit b
    ON f."BusinessUnitKey" = b."BusinessUnitKey"
GROUP BY b."BusinessUnitName"
ORDER BY total_projects DESC;

--Q8. How many projects are there in each programme?
SELECT
    p."ProgrammeName",
    COUNT(DISTINCT f."ProjectKey") AS total_projects
FROM fact_project_monthly f
JOIN dim_programme p
    ON f."ProgrammeKey" = p."ProgrammeKey"
GROUP BY p."ProgrammeName"
ORDER BY total_projects DESC;
-- “I use GROUP BY to group the projects by location and COUNT(DISTINCT ProjectKey) to count the unique projects in each location.”


-- Q9. How many projects are there in each location?
SELECT
    l."City",
    COUNT(DISTINCT f."ProjectKey") AS total_projects
FROM fact_project_monthly f
JOIN dim_location l
    ON f."LocationKey" = l."LocationKey"
GROUP BY l."City"
ORDER BY total_projects DESC;
--"I used an INNER JOIN between the fact table and the location dimension using LocationKey. Then I grouped the data by city and used COUNT(DISTINCT ProjectKey) to count each project only once. Finally, I sorted the results in descending

-- Q10. How many projects are associated with each strategic objective?
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'fact_project_monthly'
ORDER BY ordinal_position;


-- FILTERING 

--Q11. Which projects are currently active?
select distinct "ProjectKey"
from fact_project_monthly
where "ProjectStatus" = 'Active';


--Q12. Which projects have been completed?
select distinct "ProjectKey" 
from fact_project_monthly
where "ProjectStatus" = 'Completed';

--Q13. Which projects belong to a particular business unit?
select distinct f."ProjectKey"
from fact_project_monthly f
join dim_Business_Unit b 
	on f."BusinessUnitKey" = b."BusinessUnitKey"
where b."BusinessUnitName" = 'Technology';

-- "I use the WHERE clause to filter projects based on a specific business unit. Since the business unit name is stored in the dimension table, I join it with the fact table using BusinessUnitKey."

--Q14. Which projects are located in a particular location?
select distinct f."ProjectKey"
from fact_project_monthly f
join dim_location b
	on f."LocationKey" = b."LocationKey"
where b."City" = 'Paris';

--"I use the WHERE clause to filter projects based on a particular location. I join the fact table with the location dimension using LocationKey and filter the required city."

--Q15. Which projects have a budget greater than a particular amount?
select distinct "ProjectKey" 
from fact_project_monthly 
where "BaselineBudgetEUR" > 1000000;

-- SORTING

-- Q16. Which projects have the highest budget?



