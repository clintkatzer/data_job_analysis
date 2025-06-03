/* Question: What are the highest earning 'Data Analyst' jobs from the sample data?
-Identify the top 10 highest earning Data Analyst roles, with remote flexibility
-Query focuses on job postings with avaliable salary data (remove nulls)
-Highlighting the top-paying opportunities sheds light on employment forecasting
*/
SELECT
    job_id, 
    job_title, 
    job_location, 
    job_schedule_type,
    name AS company_name, 
    salary_year_avg, 
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN 
    company_dim ON
    job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10