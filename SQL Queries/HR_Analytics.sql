--drop table EmployeeDetail;
create table EmployeeDetail(EmpID VARCHAR(15),
    Age INTEGER,
    AgeGroup VARCHAR(20),
    Attrition VARCHAR(5),
    BusinessTravel VARCHAR(50),
    DailyRate INTEGER,
    Department VARCHAR(100),
    DistanceFromHome INTEGER,
    Education INTEGER,
    EducationField VARCHAR(100),
    EmployeeCount INTEGER,
    EmployeeNumber INTEGER,
    EnvironmentSatisfaction INTEGER,
    Gender VARCHAR(10),
    HourlyRate INTEGER,
    JobInvolvement INTEGER,
    JobLevel INTEGER,
    JobRole VARCHAR(100),
    JobSatisfaction INTEGER,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INTEGER,
    SalarySlab VARCHAR(20),
    MonthlyRate INTEGER,
    NumCompaniesWorked INTEGER,
    Over18 CHAR(1),
    OverTime VARCHAR(10),
    PercentSalaryHike INTEGER,
    PerformanceRating INTEGER,
    RelationshipSatisfaction INTEGER,
    StandardHours INTEGER,
    StockOptionLevel INTEGER,
    TotalWorkingYears INTEGER,
    TrainingTimesLastYear INTEGER,
    WorkLifeBalance INTEGER,
    YearsAtCompany INTEGER,
    YearsInCurrentRole INTEGER,
    YearsSinceLastPromotion INTEGER,
    YearsWithCurrManager DOUBLE PRECISION,
    salary_lower INTEGER,
    salary_upper DOUBLE PRECISION
);
---csv file shows actual  data sometime if you open your file into excelsheet it shows different datatype to adjust formatting
select * from EmployeeDetail;

copy EmployeeDetail(EmpID, Age, AgeGroup, Attrition, BusinessTravel, DailyRate, Department, DistanceFromHome, Education, EducationField, EmployeeCount, EmployeeNumber, EnvironmentSatisfaction, Gender, HourlyRate, JobInvolvement, JobLevel, JobRole, JobSatisfaction, MaritalStatus, MonthlyIncome, SalarySlab, MonthlyRate, NumCompaniesWorked, Over18, OverTime, PercentSalaryHike, PerformanceRating, RelationshipSatisfaction, StandardHours, StockOptionLevel, TotalWorkingYears, TrainingTimesLastYear, WorkLifeBalance, YearsAtCompany, YearsInCurrentRole, YearsSinceLastPromotion, YearsWithCurrManager, salary_lower, salary_upper)
from 'F:\Project _File\HR_Analytics_Cleaned.csv'
Delimiter ','
CSV  HEADER;

select * from EmployeeDetail;

--1. Attrition by Department
--Identify which departments experience the highest employee attrition(turnover).
select Department,COUNT(*) AS Employees_Left from EmployeeDetail
where Attrition='Yes' group by Department order by Employees_Left DESC;
--2. Average Monthly Income by Job Role
--Compare salary distribution across different job roles.
select  JobRole, round(avg( MonthlyIncome),2) as MonthlyIncome from EmployeeDetail 
group by JobRole Order by MonthlyIncome DESC;
--3. Employee Count by Gender
--Analyze workforce diversity by gender.
select Gender,count(*) as Employee_count  from EmployeeDetail group by Gender Order by Employee_count DESC ;

-- 4. Department-wise Job Satisfaction
--Measure employee satisfaction across departments.
select Department ,Round(avg(JobSatisfaction),2) as Avg_JobSatisfication from  EmployeeDetail 
group by Department Order by Avg_JobSatisfication DESC;

--- 5. Overall Attrition Rate
--- Calculate the percentage of employees who left the organization.
select count(case when Attrition='Yes'  then 1 END )*100 / COUNT(*) AS AttritionPercentage 
from EmployeeDetail ;
 
--6. Attrition by Gender
--Determine whether attrition varies across gender groups.
select Gender, COUNT(*) AS Employees_Left from EmployeeDetail where attrition='Yes' group by Gender;

-- 7.Attrition by Age Group
--Identify age groups with the highest employee turnover.
SELECT
    AgeGroup,
    COUNT(*) AS Employees_Left
FROM EmployeeDetail
WHERE Attrition = 'Yes'
GROUP BY AgeGroup
ORDER BY Employees_Left DESC;

-- 8. Average Income by Department
-- Compare compensation levels across departments.
Select Department ,Round(avg(MonthlyIncome),2) as AvgIncome from EmployeeDetail 
group by Department Order by AvgIncome DESC;

-- 9. Employee Count by Job Role
--Understand workforce distribution across job positions.
select JobRole,count(*) AS Employee_Count from EmployeeDetail group by 
JobRole Order BY Employee_Count DESC;

-- 10. Overtime vs Attrition
--Examine the relationship between overtime(To work extra time ) and employee turnover(Employee movement).
select Overtime, COUNT(*) as EmployeeCount  from  
EmployeeDetail where Attrition='Yes' Group by Overtime Order By EmployeeCount DESC;
--OR
SELECT
    OverTime,
    Attrition,
    COUNT(*) AS Employee_Count
FROM EmployeeDetail
GROUP BY OverTime, Attrition
ORDER BY OverTime, Attrition;

-- 11. Top 10 Highest Paid Employees
-- Identify employees with the highest monthly income.
Select  EmpID,JobRole,
    Department,MonthlyIncome from EmployeeDetail ORDER BY MonthlyIncome DESC LIMIT 10;

---12. Average Years at Company by Department
--Measure employee tenure across departments.
 select Department,Round(avg(YearsAtCompany),2) as Company_Carrier from EmployeeDetail
 group by Department  ORDER BY Company_Carrier DESC;
 
---13. Job Satisfaction by Job Role
--Compare employee satisfaction across job roles.

Select jobrole, ROUND(avg(jobsatisfaction),2)  as SatisfactionScore from EmployeeDetail
group by jobrole ORDER BY SatisfactionScore DESC;
--14.Work-Life Balance by Department
--Evaluate work-life balance across departments.

select Department,Round(avg(WorkLifeBalance),2) as WorkLife
from EmployeeDetail
 group by Department  ORDER BY  WorkLife DESC;

 --15.HR Dashboard KPI Summary
--Generate key performance indicators (KPIs) for the HR dashboard.

SELECT
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Total_Attrition,
    ROUND(AVG(MonthlyIncome), 2) AS Avg_Monthly_Income,
    ROUND(AVG(JobSatisfaction), 2) AS Avg_Job_Satisfaction,
    ROUND(AVG(WorkLifeBalance), 2) AS Avg_WorkLife_Balance
FROM EmployeeDetail;