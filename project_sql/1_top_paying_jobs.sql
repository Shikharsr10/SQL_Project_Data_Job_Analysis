/* What are the top paying jobs for data analyst?
-Identify top 10 jobs that are available remotely.
-Focuses on Job Postings with specified salaries (remove nulls)
*/

SELECT
    job_id,
    name as Company_name,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
    
FROM 
    job_postings_fact
LEFT JOIN company_dim ON
job_postings_fact.company_id=company_dim.company_id

WHERE
    job_title_short='Data Analyst' AND
    job_location='Anywhere' AND
    salary_year_avg IS NOT NULL
    
ORDER BY salary_year_avg DESC
LIMIT 10