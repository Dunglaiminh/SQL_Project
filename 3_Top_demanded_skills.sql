/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

WITH joined_table AS (
    SELECT * 
FROM job_postings_fact 
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
WHERE job_title_short = 'Data Analyst'
) 

SELECT skills,COUNT(*) AS skill_count 
FROM joined_table 
GROUP BY skills 
ORDER BY skill_count DESC LIMIT 5; 

/* Result: 
[
  {
    "skills": "sql",
    "skill_count": "92628"
  },
  {
    "skills": "excel",
    "skill_count": "67031"
  },
  {
    "skills": "python",
    "skill_count": "57326"
  },
  {
    "skills": "tableau",
    "skill_count": "46554"
  },
  {
    "skills": "power bi",
    "skill_count": "39468"
  }
]  
*/ 