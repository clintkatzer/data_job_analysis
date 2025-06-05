/* What are the top skills based on salary?
--Look at the median salary associated with each skill
--Focus on roles with specified salaries
--Why? Indicative of how different skills impact salary level
and helps identify the most financially rewarded skills
*/

SELECT 
    skills,
    percentile_cont(.5) WITHIN GROUP (ORDER BY salary_year_avg) AS median_salary,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN 
    skills_job_dim ON 
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON 
    skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_title_short='Data Analyst'
    AND salary_year_avg IS NOT NULL
    --AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    median_salary DESC

LIMIT 25
