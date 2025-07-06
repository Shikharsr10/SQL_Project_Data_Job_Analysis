/* What are the most optimal skills to learn for remote Data analyst roles
(aka it's in high Demand and a high paying skill)
*/

WITH Skills_demand AS (
    SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(*) As demand_count
FROM job_postings_fact

INNER JOIN skills_job_dim
ON job_postings_fact.job_id=skills_job_dim.job_id

INNER JOIN skills_dim
ON skills_dim.skill_id=skills_job_dim.skill_id

WHERE 
    job_postings_fact.job_title_short='Data Analyst'
    AND job_work_from_home= TRUE
    AND salary_year_avg is NOT NULL

GROUP BY skills_dim.skill_id
)

,

average_salary As (
SELECT
    skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg),0) as Salary

FROM 
    job_postings_fact

INNER JOIN skills_job_dim
ON job_postings_fact.job_id=skills_job_dim.job_id

INNER JOIN skills_dim
ON skills_dim.skill_id=skills_job_dim.skill_id

WHERE
    job_postings_fact.job_title_short='Data Analyst'
    AND salary_year_avg is NOT NULL
    AND job_work_from_home= TRUE

GROUP BY 
    skills_job_dim.skill_id
)

SELECT 
    Skills_demand.skill_id,
    Skills_demand.skills,
    demand_count,
    Salary
FROM
    Skills_demand

INNER JOIN average_salary
ON  skills_demand.skill_id = average_salary.skill_id

ORDER BY demand_count desc, average_salary desc



--rewriting this query concisely

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg)) As average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id= skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY 
    skills_dim.skill_id
HAVING 
    COUNT(skills_job_dim.job_id) > 10
ORDER BY 
    average_salary DESC,
    demand_count DESC
LIMIT 25