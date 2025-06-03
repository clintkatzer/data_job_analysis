/* What are the most in demand skills for the top potential earning positions?
-- Include those positions without skills listed to include highest earning potentials
that may not document skills but still add substance to the query
-- Continue from previous query focusing on remote Data Analyst positions
*/

WITH top_paying_jobs AS (
    SELECT
        job_id, 
        job_title,
        name AS company_name,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN 
        company_dim ON
        job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
)

SELECT DISTINCT
    top_paying_jobs.*,
    skills_dim.skills
FROM 
    top_paying_jobs
FULL JOIN 
    skills_job_dim ON 
    top_paying_jobs.job_id = skills_job_dim.job_id
FULL JOIN 
    skills_dim ON 
    skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    top_paying_jobs.job_id IS NOT NULL
ORDER BY
    salary_year_avg DESC

/*
--Python to more easily identify top earning jobs by skills. Uses common job_id,
job_title, company_name, and returning each skill as a column as 
"top_earning_data_analyst_skills"
import pandas as pd

# Load the data
df = pd.read_csv("C:/Users/Username/Downloads/top_earning_data_analyst_skills.csv")

# Add a skill number per job_id group to later pivot (1, 2, 3, ...)
df['skill_num'] = df.groupby('job_id').cumcount() + 1

# Pivot so skills become columns: skill_1, skill_2, etc.
df_pivoted = df.pivot(index=['job_id', 'job_title', 'company_name', 'salary_year_avg'],
                      columns='skill_num',
                      values='skills')

# Rename columns to have 'skill_' prefix
df_pivoted.columns = [f'skill_{i}' for i in df_pivoted.columns]

# Reset index to flatten the DataFrame
df_pivoted = df_pivoted.reset_index()

# Optional: Save the result
df_pivoted.to_csv("C:/Users/Username/Downloads/top_earning_data_analyst_skills2.csv", index=False)

# Show result
print(df_pivoted.head())
*/
