/* What are the skills required for top 10 paying jobs for data analyst?
-Identify top 10 jobs that are available remotely.
-Focuses on Job Postings with specified salaries (remove nulls)
*/
WITH top_paying_jobs AS
(
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
        
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
)

SELECT 
    top_paying_jobs.*,
    skills
    
FROM top_paying_jobs

INNER JOIN skills_job_dim AS skills
ON top_paying_jobs.job_id=skills.job_id

INNER JOIN skills_dim AS skill_name
ON skills.skill_id=skill_name.skill_id

ORDER BY salary_year_avg DESC


/* Top-Paying Data Analyst Roles (2023)  Skills Breakdown & Insights
Most In-Demand Skills:- 
SQL  8: Essential for querying and managing structured data in databases.
Python  7: Versatile language for data analysis, automation, and scripting.
Tableau  6: Popular tool for creating interactive dashboards and visualizations.
R  4: Statistical computing language favored in research and analytics.
Excel  3: Still widely used for quick analysis and spreadsheet modeling.
Pandas  3: Python library for efficient data manipulation and analysis.
Snowflake  3: Cloud-based data warehousing platform used for big data workloads.
Azure  2: Microsoft s cloud service, often used for hosting data pipelines.
Bitbucket  2: Git-based repository tool for code collaboration.
Go  2: Compiled programming language, used in backend data systems.
 --Key Insights:- SQL + Python + Tableau appear together frequently, forming the core skill set.
 --Data analysis is deeply tied to both programming and visualization skills.
 --Familiarity with cloud platforms and modern tools (e.g., Snowflake, Bitbucket) gives analysts an edge */
