/* Database Employees * /
/ * 1. Get empid, firstname, lastname, country, region, city of all employees from USA. * /
/ * 2. Get the number of employees for each specialty. * /
/ * 3. Count the number of people for each name. * /
/ * 4. Get the most common name. * /
/ * 5. Get the least common name. * /
/ * 6. Get the top 5 cities where the most workers are. * /
/ * 7. Get the top 5 cities, which have the most unique specialties. * /
/ * 8. Issue mailing addresses for emailing to all employees who started working on 1/01/2012. * /
/ * 9. Issue statistics in what year how many employees were employed. * /
/ * 10. Issue statistics in which year how many workers in which countries were employed. * /
/ * 11. Refresh the Employees table by adding data from the History table to the EndDate column. * /
/ * 12. Issue statistics on how many employees in which year they left. * /
/ * 13. Issue the number of employees who have worked less than a year. */

--1. Get empid, firstname, lastname, country, region, city of all employees from USA. * /
SELECT FirstName,LastName,CountryRegionName,City FROM Employees WHERE (CountryRegionName ='United States')

-------------------------------------------------------------------------------------------

--2. Get the number of employees for each specialty.

SELECT JobTitle, COUNT(*) AS NumberOfEmployees
FROM Employees
GROUP BY JobTitle;

-------------------------------------------------------------------------------------------

--3. Count the number of people for each name.

SELECT FirstName, COUNT(*) AS NumberOfEmployees
FROM Employees
GROUP BY FirstName;

-------------------------------------------------------------------------------------------
--4. Get the most common name.

SELECT TOP 1  FirstName, COUNT(FirstName) AS NumberOfEmployees
FROM Employees
GROUP BY FirstName
ORDER BY NumberOfEmployees DESC;

-------------------------------------------------------------------------------------------
--5. Get the least common name.

SELECT TOP 1 With TIES FirstName, COUNT(FirstName) AS NumberOfEmployees
FROM Employees
GROUP BY FirstName
ORDER BY NumberOfEmployees ASC

-------------------------------------------------------------------------------------------

-- 6. Get the top 5 cities where the most workers are.

Select Top 5 With TIES City,Count(*) AS Count_Empl From Employees
Group by City
ORder by Count_Empl DESC

-------------------------------------------------------------------------------------------

--7. Get the top 5 cities, which have the most unique specialties.

SELECT TOP 5 WITH TIES City, COUNT(DISTINCT JobTitle) AS Count_JobTitle
FROM Employees
GROUP BY City
ORDER BY Count_JobTitle DESC;

-------------------------------------------------------------------------------------------

--8. Issue mailing addresses for emailing to all employees who started working on 1/01/2012.
SELECT FirstName,StartDate From Employees
Where (StartDate between '01-01-2012' and GETDATE())

-------------------------------------------------------------------------------------------

--9. Issue statistics in what year how many employees were employed.
SELECT StartDate,COUNT(FirstName) 
From Employees
GROUP BY StartDate 

-------------------------------------------------------------------------------------------

--10. Issue statistics in which year how many workers in which countries were employed.
SELECT City,StartDate,COUNT(*) AS worker_count
From Employees
GROUP BY City,StartDate

-------------------------------------------------------------------------------------------

--11. Refresh the Employees table by adding data from the History table to the EndDate column.
UPDATE Employees
SET EndDate = History.EndDate,StartDate=History.StartDate
FROM Employees, History
Where (Employees.BusinessEntityID = History.BusinessEntityID)


-------------------------------------------------------------------------------------------

---12. Issue statistics on how many employees in which year they left. * /

Select EndDate, COUNT(*) as worker_count from Employees
Group by EndDate


-------------------------------------------------------------------------------------------

-- 13. Issue the number of employees who have worked less than a year. */
Select COUNT(*) as worker_count 
from Employees
Where (DATEDIFF(year,EndDate,StartDate) < 1)