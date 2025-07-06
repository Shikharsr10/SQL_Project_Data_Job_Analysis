--TOP 10 Job skills for Remote Data Analyst

SELECT
skill.skills,
COUNT(*) As demand_count
FROM job_postings_fact

INNER JOIN skills_job_dim as job_skill
ON job_postings_fact.job_id=job_skill.job_id

INNER JOIN skills_dim as skill
ON skill.skill_id=job_skill.skill_id
WHERE job_postings_fact.job_title_short='Data Analyst'
AND job_work_from_home= TRUE
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 10
