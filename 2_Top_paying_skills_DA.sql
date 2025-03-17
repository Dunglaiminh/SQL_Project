/*
Question: What skills are required for the top-paying Data-Analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/ 


WITH top_DA_jobs AS (
    SELECT 
    job_id,job_title,ROUND(salary_year_avg,0) AS year_salary
FROM job_postings_fact 
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC LIMIT 10
) 

SELECT top_DA_jobs.job_title, ROUND(AVG(top_DA_jobs.year_salary)) AS average_year_salary, skills_dim.skills
FROM top_DA_jobs
INNER JOIN skills_job_dim ON top_DA_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
GROUP BY top_DA_jobs.job_title, skills_dim.skills 
ORDER BY AVG(top_DA_jobs.year_salary) DESC
LIMIT 10; 