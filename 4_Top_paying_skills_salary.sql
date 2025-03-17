/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

WITH joined_table AS (
    SELECT * 
FROM job_postings_fact 
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
) 

SELECT skills, ROUND(AVG(salary_year_avg),0) AS average_salary, 
    CASE
        WHEN ROUND(AVG(salary_year_avg),0) > 120000 THEN 'High'
        WHEN ROUND(AVG(salary_year_avg),0) > 80000 THEN 'Medium'
        ELSE 'Low'
END AS salary_level
FROM joined_table
WHERE salary_year_avg IS NOT NULL 
GROUP BY skills 
ORDER BY average_salary DESC; 
