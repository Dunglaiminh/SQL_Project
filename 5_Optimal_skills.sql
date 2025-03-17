/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/

WITH joined_table AS (
    SELECT * 
FROM job_postings_fact 
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
WHERE job_title_short = 'Data Analyst'
) 

SELECT skills, COUNT(*) AS skill_count, ROUND(AVG(salary_year_avg),0) AS average_salary
FROM joined_table
WHERE salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY skill_count DESC, average_salary DESC
LIMIT 25; 