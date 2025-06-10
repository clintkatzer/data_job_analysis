/* What are the most optimal skills to learn? 
(high demand and high-paying skill)
--Identify skills in high demand and associated with 
high median salaries for Data Analyst roles
-- Concentrates on remote positions with specified salaries
-- Why? Targets skills that offer job security (high demand) and 
financial benefits (high salaries),
 --Why? Offering strategic insights for career development in data analysis
--Optimal: High Demand AND High Paying
*/

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    percentile_cont(.5) WITHIN GROUP (ORDER BY salary_year_avg) AS median_salary,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN 
    skills_job_dim ON
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON
    skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING  
    COUNT(skills_job_dim.job_id)>10
ORDER BY
    median_salary DESC,
    demand_count DESC
LIMIT 25;
