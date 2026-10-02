SELECT * FROM hr_workforce;

--Q1. Which departments have the largest share of the company's workforce?
SELECT
    department,
    COUNT(*) AS employee_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS employee_percentage
FROM hr_workforce
GROUP BY department
ORDER BY employee_count DESC;


--Q2. How does the salary range vary across different departments?
SELECT
    department,
    COUNT(*) AS employee_count,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_salary,
    MIN(monthly_income) AS min_monthly_salary,
    MAX(monthly_income) AS max_monthly_salary
FROM hr_workforce
GROUP BY department
ORDER BY avg_monthly_salary DESC;


--Q3. Which employees earn more than the company's average monthly salary?
SELECT
    employee_id,
    department,
    job_role,
    job_level,
    monthly_income
FROM hr_workforce
WHERE monthly_income > (
    SELECT AVG(monthly_income)
    FROM hr_workforce
)
ORDER BY monthly_income DESC;


--Q4. Which employees have spent a long time at the company without receiving a recent promotion?
SELECT
    employee_id,
    department,
    job_role,
    years_at_company,
    years_since_last_promotion
FROM hr_workforce
WHERE years_at_company >= 5
  AND years_since_last_promotion >= 5
ORDER BY years_since_last_promotion DESC;


--Q5. Which employees have been working with the same manager for a long period of time?
SELECT
    employee_id,
    department,
    job_role,
    years_at_company,
    years_with_current_manager
FROM hr_workforce
WHERE years_with_current_manager >= 8
ORDER BY years_with_current_manager DESC;


--Q6. How does overtime relate to job satisfaction among employees?
SELECT
    overtime,
    job_satisfaction,
    COUNT(*) AS employee_count,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_salary
FROM hr_workforce
GROUP BY overtime, job_satisfaction
ORDER BY overtime, job_satisfaction;


--Q7. How many early-tenure employees are working overtime, and how does their attrition compare?
SELECT
    overtime,
    attrition,
    COUNT(*) AS employee_count,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_salary
FROM hr_workforce
WHERE years_at_company <= 2
GROUP BY overtime, attrition
ORDER BY overtime, attrition;


--Q8. How many high-performing employees have left the company, and what is their average salary?
SELECT
    attrition,
    COUNT(*) AS employee_count,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_salary
FROM hr_workforce
WHERE performance_rating >= 4
GROUP BY attrition
ORDER BY attrition;


--Q9. What is the overall workforce profile of each department in terms of headcount, salary, and employee tenure?
SELECT
    department,
    COUNT(*) AS employee_count,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_salary,
    ROUND(AVG(years_at_company), 2) AS avg_years_at_company,
    ROUND(AVG(years_since_last_promotion), 2) AS avg_years_since_promotion
FROM hr_workforce
GROUP BY department
ORDER BY employee_count DESC;


--Q10. How many employees meet multiple HR conditions related to tenure, overtime, satisfaction, and performance?
SELECT
    department,
    COUNT(*) AS employee_count
FROM hr_workforce
WHERE years_at_company <= 3
  AND overtime = 'Yes'
  AND job_satisfaction <= 2
  AND performance_rating >= 3
GROUP BY department
ORDER BY employee_count DESC;