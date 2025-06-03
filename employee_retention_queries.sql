Select * from KPI;

LOAD DATA INFILE "HRforMySQL.csv" INTO TABLE KPI
FIELDS TERMINATED BY ","
IGNORE 1 LINES;

#1.Avg Attrition Rate for All Departments
Select Department,
Sum(CASE Attrition
When "Yes" THEN 1
ELSE 0
END)/Count(Attrition)*100 as AttritionRate from KPI group by department;

#2.Avg Hourly Rate of Male Research Scientist
Select Gender, JobRole, avg(hourlyrate) as HourlyRate from KPI where Gender in ("Male") and Jobrole in ("Research Scientist") group by Gender,Jobrole;

#3.Attrition Rate VS Monthly Income Stats
SELECT 
    AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100 AS AttritionRate,
    AVG(MonthlyIncome) AS AvgMonthlyIncome,
    MIN(MonthlyIncome) AS MinMonthlyIncome,
    MAX(MonthlyIncome) AS MaxMonthlyIncome
FROM KPI;

#4.Avg Working Years for Each Department
Select Department, Avg(totalWorkingYears) as WorkingYears from KPI group by Department;

#5.DepartmentWise No. of Empoyees
Select Department, Count(*) as Employees from KPI group by Department;

#6.Count of Employees Based on Educational Fields
Select EducationField, Count(*) as Employees from KPI group by EducationField;

#7.Job Role VS Work Life Balance
Select Jobrole, Avg(Worklifebalance) as WorkLifeBalance from KPI group by Jobrole;

#8.Attrition Rate VS Year Since Last Promotion Relation
Select Avg(CASE ATTRITION WHEN "YES" THEN 1 ELSE 0 END)*100 AS AttritionRate, avg(Yearssincelastpromotion) as YSLP from KPI;

#9.Gender Based Percentage of Employee
SELECT Gender, COUNT(*) AS TotalCount, (ROUND((COUNT(*) / (SELECT COUNT(*) FROM KPI)) * 100, 2)) AS Percentage FROM KPI GROUP BY Gender;
    
#10.MonthlyNew Hire VS Attrition Trendline
Select Year(DateofJoining) as Year, Month(DateofJoining) as Month, Count(*) AS MonthlyNewHires, Sum(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions
From KPI group by YEAR(DateofJoining), MONTH(DateofJoining)
ORDER BY 
year, month;
    
#11.Department/Job Role Wise Job Satisfaction
SELECT Department,JobRole, avg(JobSatisfaction) AS avg_job_satisfaction FROM KPI GROUP BY Department, JobRole;
    
