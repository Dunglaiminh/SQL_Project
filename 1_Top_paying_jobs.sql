/*
Question: What are the top-paying data-related jobs?
- Identify the top 5 highest-paying data roles that are available 
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/ 


SELECT 
    job_title_short,
    ROUND(AVG(salary_year_avg), 0) AS year_salary
FROM job_postings_fact 
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short 
ORDER BY year_salary DESC 
LIMIT 10;

/* Result 
[
  {
    "job_title_short": "Senior Data Scientist",
    "year_salary": "154050"
  },
  {
    "job_title_short": "Senior Data Engineer",
    "year_salary": "145867"
  },
  {
    "job_title_short": "Data Scientist",
    "year_salary": "135929"
  },
  {
    "job_title_short": "Data Engineer",
    "year_salary": "130267"
  },
  {
    "job_title_short": "Machine Learning Engineer",
    "year_salary": "126786"
  },
  {
    "job_title_short": "Senior Data Analyst",
    "year_salary": "114104"
  },
  {
    "job_title_short": "Software Engineer",
    "year_salary": "112778"
  },
  {
    "job_title_short": "Cloud Engineer",
    "year_salary": "111268"
  },
  {
    "job_title_short": "Data Analyst",
    "year_salary": "93876"
  },
  {
    "job_title_short": "Business Analyst",
    "year_salary": "91071"
  }
]
*/ 