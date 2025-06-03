/*
What are the most requested, most in-demand skills for data analyst postings in the
dataset?
-- Identify the top 5 in-demand skills for a data analyst postings
-- Why? Retrieves the top 5 skills with highest demand in job market,
providing insights into the most valuable skills for job seekers
*/





SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
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
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5











/* WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skill_jobs
    INNER JOIN 
        job_postings_fact AS job_post ON
        job_post.job_id = skill_jobs.job_id
    WHERE
        job_work_from_home =TRUE AND
        job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

SELECT
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN 
    skills_dim AS skills ON
    skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5
*/
