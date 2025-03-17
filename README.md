# Overview 

Welcome to my data analysis project, where I apply my SQL expertise to uncover valuable insights into the data job market. This project showcases my ability to use *Structured Query Language (SQL)* to manipulate data, extract key information, and derive meaningful conclusions.  

Using SQL in **VS Code**, I have explored five essential questions related to data jobs. Additionally, I leveraged my Python skills to create visualizations that enhance understanding and provide a clearer perspective on the data. 

*DISCLAIMER* 
- The main data is sourced from [Luke Barousse's SQL Course](https://www.lukebarousse.com/sql) 
- Due to the limited availability of data in Vietnam, my analysis will primarily focus on the job market in the United States.
- The findings are based on available data and may not reflect real-time market conditions. 


# Questions 

This project aims at answering the following questions:  

1. What are the top-paying data analyst jobs?
2. What skills are required for top-paying Data Analyst jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn? 

# Tools I Used  
To explore the data analyst job market, I utilized several essential tools:  

- **SQL** – The core of my analysis, enabling me to query the database and extract valuable insights.  
- **PostgreSQL** – My database management system of choice, well-suited for handling job posting data.  
- **Visual Studio Code** – My primary workspace for managing databases and executing SQL queries.  
- **Git & GitHub** – Crucial for version control, sharing SQL scripts, and tracking project progress collaboratively.

# The project 

Here's a deep insight into my project 

## 1. What are the top-paying data analyst jobs? 

SQL file: [1_Top_paying_jobs.sql](1_Top_paying_jobs.sql) 

### Steps  
To identify the highest-paying data analyst jobs, I performed the following steps:  

1. **Filter Data**  
- Selected only job postings where salary data is available (`salary_year_avg IS NOT NULL`).  

2. **Calculate & Group Salaries**  
- Used `AVG(salary_year_avg)` to find the average yearly salary for each job title.  
- Applied `ROUND` function to remove decimals for clarity.  
- Grouped results by `job_title_short` to aggregate salaries.  

3. **Sort & Limit Results**  
- Ordered salaries in descending order (`ORDER BY year_salary DESC`).  
- Used `LIMIT 10` to display the top 10 highest-paying job titles.  


```sql
SELECT 
    job_title_short,
    ROUND(AVG(salary_year_avg), 0) AS year_salary
FROM job_postings_fact 
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short 
ORDER BY year_salary DESC 
LIMIT 10;
```

### Data Visualization 

With the help of ChatGPT, I managed to construct the table as follow: 

| Job Title                    | Yearly Salary (USD) |
|------------------------------|---------------------|
| Senior Data Scientist        | 154,050            |
| Senior Data Engineer         | 145,867            |
| Data Scientist               | 135,929            |
| Data Engineer                | 130,267            |
| Machine Learning Engineer    | 126,786            |
| Senior Data Analyst          | 114,104            |
| Software Engineer            | 112,778            |
| Cloud Engineer               | 111,268            |
| Data Analyst                 | 93,876             |
| Business Analyst             | 91,071             |



With the use of Python, here's how I visualized the data. 

![1_Top_paying_jobs.png](Python_visualization\Images\1_Top_paying_jobs.png)

To see the full python code: visit [1_Top_paying_jobs.ipynb](Python_visualization\1_Top_paying_jobs.ipynb)

### Insight 

**1. Senior roles get paid the most**

Senior Data Scientist ($154K) and Senior Data Engineer ($146K) have the highest salaries.
Senior roles earn ~30-40% more than regular positions.

**2. High demand for Data Science & Engineering**  

5 of the top 6 jobs are related to Data Science, Data Engineering, and Machine Learning.
These fields are in high demand, making them some of the best-paying tech careers.

**3. Business & Data Analysts earn the moderately**

Business Analysts ($91K) and Data Analysts ($94K) are the lowest-paid on the list.
These roles are still important but pay less compared to engineering and data science jobs.


## 2. What skills are required for top-paying Data Analyst jobs? 

This questions aims at figuring out: For the top 10 highest-paid 'Data Analyst' jobs, what skills are required for these roles? 

SQL file: [2_Top_paying_skills_DA.sql](2_Top_paying_skills_DA.sql) 

### Steps 

### **Step 1: Identify the Top 10 Highest-Paying Data Analyst Jobs**  

- Filter the `job_title_short` column to include only 'Data Analyst' roles.  
- Remove all `NULL` values from the `salary_year_avg` column to ensure accurate salary analysis.  
- Sort the results in descending order based on annual salary.  
- Select the top 10 highest-paying Data Analyst jobs.  
- Store these results in a **Common Table Expression (CTE)** named `top_DA_jobs` for further analysis.  

---

### **Step 2: Link the Top 10 Jobs with Relevant Skills**  

- **Use INNER JOIN** to connect the `top_DA_jobs` CTE with the `skills_job_dim` table on `job_id`. This step associates each job with the corresponding skill IDs.  
- **Perform another INNER JOIN** with the `skills_dim` table on `skill_id`. This step retrieves the actual skill names.  

---

### **Step 3: Analyze Salary Trends by Skill**  

- Group the data by job title and skill to calculate the average annual salary for each skill.  
- Order the results by average salary in descending order** to highlight the highest-paying skills.  
- Limit the output to 10 rows to focus on the most valuable skills for high-paying Data Analyst roles.

```sql
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
```

### Data Visualization 

| Job Title                          | Average Yearly Salary | Skills  |
|-------------------------------------|-----------------------|---------|
| Data Base Administrator            | $400,000             | SVN     |
| Data Base Administrator            | $400,000             | Git     |
| Data Base Administrator            | $400,000             | Linux   |
| Data Base Administrator            | $400,000             | Kafka   |
| Data Base Administrator            | $400,000             | Oracle  |
| Director of Safety Data Analysis   | $375,000             | MATLAB  |
| Director of Safety Data Analysis   | $375,000             | Excel   |
| Director of Safety Data Analysis   | $375,000             | Airflow |
| Director of Safety Data Analysis   | $375,000             | Power BI|
| Director of Safety Data Analysis   | $375,000             | Python  |


### Insight 

The data highlights version control (SVN, Git), system administration (Linux), and data infrastructure (Kafka, Oracle) as highly valued skills in the Data Analyst field. 

Additionally, Excel, Power BI, and Python are essential for data analysis, visualization, and automation, making them equally important for high-paying roles. 

## 3. What skills are most in demand for Data Analysts? 

SQL file: [3_Top_demanded_skills.sql](3_Top_demanded_skills.sql) 

### Steps 

To find the top five in-demand skills for Data Analysts, I performed the following steps: 

### Steps to Identify the Top 5 Most Common Skills for Data Analysts  

**1. Creating a CTE**  
- Perform an INNER JOIN from `job_postings_fact` with `skills_job_dim` on the `job_id` column to connect job postings with their associated skill IDs.  
- Perform another INNER JOIN with `skills_dim` on the `skill_id` column to retrieve the actual skill names.  
- Use a WHERE clause to filter only Data Analyst job postings.  
- Store the results in a Common Table Expression (CTE) named `joined_table`.  

**2. Identify and Count the Most Common Skills** 
- Select the `skills` column from `joined_table`.  
- Use the `COUNT(*)` function to count the number of times each skill appears.  
- Group the results by `skills` to ensure each skill is counted separately.  

**3. Rank and Select the Top 5 Skills**  
- Order the results by `skill_count` in descending order, ensuring the most frequently mentioned skills appear at the top.  
- Use `LIMIT` to display only the top 5 most common skills for Data Analyst job postings. 

```sql 
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
```

### Data Visualization 

With the help of ChatGPT, I managed to construct the table as follow: 

| Skills   | Skill Count |
|----------|------------|
| SQL      | 92,628     |
| Excel    | 67,031     |
| Python   | 57,326     |
| Tableau  | 46,554     |
| Power BI | 39,468     |

With the use of Python, here's how I visualized the data. 

![3_Top_demanded_skills.png](Python_visualization\Images\3_Top_demanded_skills.png)

To see the full python code: visit [3_Top_demanded_skills.ipynb](3_Top_demanded_skills.sql) 

### Insight 

**1. SQL is the Most In-Demand Skill**

With 92,628 job postings, SQL is a fundamental requirement for Data Analysts, highlighting its importance in data querying and management. 

**2. Excel Remains Essential** 

Despite the rise of advanced tools, 67,031 job postings still require Excel, proving that spreadsheet proficiency is crucial for data analysis and reporting. 

**3.Python is a Key Programming Skill** 

With 57,326 mentions, Python is highly valued for automation, data manipulation, and machine learning applications in analytics. 

**4.Visualization Tools Matter** 

Tableau (46,554) and Power BI (39,468) are widely sought after, emphasizing the need for strong data storytelling and dashboarding skills. 

## 4. Which skills are associated with higher salaries? 

SQL file: [4_Top_paying_skills.sql](4_Top_paying_skills.sql) 

### Steps 

To find what skills are in-demand for highly-paid jobs, I conducted the following steps 

*Note: This is different from the second questions `Top_paying_skills_DA`. This part will widen the scope of research (not only Data Analyst) and classify level of salary.* 

**1. Create a joined table**

- Select all columns from the `job_postings_fact` table, which contains job details and salaries.  
- Perform an **INNER JOIN** with `skills_job_dim` on `job_id` to connect job postings with their skill IDs.  
- Perform another **INNER JOIN** with `skills_dim` on `skill_id` to retrieve the actual skill names.  
- Store the results in a **Common Table Expression (CTE)** named `joined_table`.  

**2. Calculate the Average Salary for Each Skill**  
- Select the `skills` column from `joined_table`.  
- Use `ROUND(AVG(salary_year_avg),0)` to calculate the average annual salary for each skill.  
- Filter out job postings where `salary_year_avg` is NULL to ensure accurate calculations.  
- Group the results by `skills` to get a distinct salary value for each skill.  

**3. Categorize Salary Levels**  
- Use a **CASE** statement to classify salaries into three categories: High, Medium, and Low  

**4. Order and Display the Results**  
- Sort the results by `average_salary` in descending order, ensuring the highest-paying skills appear at the top.  
- Display the skill name, its average salary, and its salary level category.  

```sql 
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
``` 

### Data Visualization 

| skills          |   average_salary | salary_level   |
|:----------------|-----------------:|:---------------|
| debian          |           196500 | High           |
| ringcentral     |           182500 | High           |
| mongo           |           170715 | High           |
| lua             |           170500 | High           |
| dplyr           |           160667 | High           |
| haskell         |           155758 | High           |
| asp.net core    |           155000 | High           |
| node            |           154408 | High           |
| cassandra       |           154124 | High           |
| solidity        |           153640 | High           |
| watson          |           152844 | High           |
| codecommit      |           152289 | High           |
| rshiny          |           151611 | High           |
| hugging face    |           148648 | High           |
| neo4j           |           147708 | High           |
| gatsby          |           147500 | High           |
| scala           |           145120 | High           |
| mlr             |           145000 | High           |
| kafka           |           144754 | High           |
| pytorch         |           144470 | High           |
| couchdb         |           144167 | High           |
| mxnet           |           143695 | High           |
| theano          |           143404 | High           |
| shell           |           143370 | High           |
| golang          |           143139 | High           |
| airflow         |           142386 | High           |
| tensorflow      |           142370 | High           |
| spark           |           141734 | High           |
| heroku          |           141667 | High           |
| redshift        |           140792 | High           |
| airtable        |           140615 | High           |
| ruby on rails   |           140130 | High           |
| scikit-learn    |           139603 | High           |
| dynamodb        |           139548 | High           |
| rust            |           139349 | High           |
| clojure         |           139342 | High           |
| redis           |           139213 | High           |
| atlassian       |           138651 | High           |
| hadoop          |           138574 | High           |
| snowflake       |           137960 | High           |
| kubernetes      |           137949 | High           |
| pandas          |           137518 | High           |
| openstack       |           137455 | High           |
| nosql           |           137039 | High           |
| numpy           |           136809 | High           |
| fastapi         |           136574 | High           |
| aws             |           136481 | High           |
| java            |           136210 | High           |
| keras           |           136026 | High           |
| c               |           135987 | High           |
| splunk          |           135746 | High           |
| next.js         |           135663 | High           |
| kotlin          |           135639 | High           |
| seaborn         |           135501 | High           |
| mysql           |           135432 | High           |
| pyspark         |           135011 | High           |
| perl            |           134374 | High           |
| jupyter         |           133829 | High           |
| c++             |           133733 | High           |
| bigquery        |           133649 | High           |
| no-sql          |           133556 | High           |
| terraform       |           133161 | High           |
| fastify         |           133000 | High           |
| elasticsearch   |           132742 | High           |
| asana           |           132697 | High           |
| matplotlib      |           132508 | High           |
| python          |           132440 | High           |
| arch            |           132376 | High           |
| datarobot       |           132211 | High           |
| typescript      |           132149 | High           |
| docker          |           132040 | High           |
| flask           |           131959 | High           |
| couchbase       |           131959 | High           |
| objective-c     |           131825 | High           |
| gcp             |           131738 | High           |
| go              |           131689 | High           |
| plotly          |           131610 | High           |
| databricks      |           131525 | High           |
| aurora          |           131308 | High           |
| mongodb         |           131207 | High           |
| express         |           131088 | High           |
| ruby            |           130712 | High           |
| azure           |           130433 | High           |
| gitlab          |           130257 | High           |
| gdpr            |           130194 | High           |
| vue             |           129863 | High           |
| nltk            |           129738 | High           |
| svn             |           129287 | High           |
| tidyverse       |           129103 | High           |
| looker          |           129006 | High           |
| jenkins         |           128872 | High           |
| graphql         |           128659 | High           |
| linux           |           128614 | High           |
| django          |           128528 | High           |
| zoom            |           128427 | High           |
| julia           |           128319 | High           |
| git             |           128316 | High           |
| ibm cloud       |           127753 | High           |
| ubuntu          |           127649 | High           |
| r               |           127115 | High           |
| angular.js      |           127050 | High           |
| opencv          |           127034 | High           |
| notion          |           127007 | High           |
| ggplot2         |           126630 | High           |
| unity           |           126608 | High           |
| postgresql      |           126401 | High           |
| bitbucket       |           126316 | High           |
| chef            |           126314 | High           |
| twilio          |           126210 | High           |
| node.js         |           126156 | High           |
| centos          |           125953 | High           |
| angular         |           125600 | High           |
| suse            |           125000 | High           |
| ansible         |           124991 | High           |
| sqlite          |           124976 | High           |
| sql             |           124935 | High           |
| github          |           124816 | High           |
| vmware          |           124486 | High           |
| jira            |           124154 | High           |
| php             |           123898 | High           |
| bash            |           123893 | High           |
| react           |           123799 | High           |
| confluence      |           123223 | High           |
| phoenix         |           122996 | High           |
| puppet          |           122649 | High           |
| c#              |           122307 | High           |
| unix            |           122118 | High           |
| matlab          |           122048 | High           |
| erlang          |           121583 | High           |
| redhat          |           121467 | High           |
| xamarin         |           121250 | High           |
| unify           |           120251 | High           |
| flow            |           120211 | High           |
| slack           |           120118 | High           |
| swift           |           119972 | Medium         |
| selenium        |           119914 | Medium         |
| db2             |           119824 | Medium         |
| microstrategy   |           119563 | Medium         |
| spring          |           119397 | Medium         |
| mariadb         |           119354 | Medium         |
| groovy          |           119251 | Medium         |
| cordova         |           117921 | Medium         |
| powershell      |           116803 | Medium         |
| tableau         |           116796 | Medium         |
| oracle          |           115125 | Medium         |
| qlik            |           115040 | Medium         |
| javascript      |           114837 | Medium         |
| electron        |           114678 | Medium         |
| jquery          |           114645 | Medium         |
| react.js        |           114450 | Medium         |
| css             |           113897 | Medium         |
| assembly        |           113119 | Medium         |
| alteryx         |           112907 | Medium         |
| sas             |           112788 | Medium         |
| unreal          |           112667 | Medium         |
| sql server      |           112487 | Medium         |
| t-sql           |           112403 | Medium         |
| ssis            |           112265 | Medium         |
| elixir          |           112073 | Medium         |
| yarn            |           111963 | Medium         |
| pulumi          |           111772 | Medium         |
| terminal        |           111582 | Medium         |
| asp.net         |           110963 | Medium         |
| fortran         |           110083 | Medium         |
| qt              |           110000 | Medium         |
| windows         |           109718 | Medium         |
| html            |           109678 | Medium         |
| sass            |           109585 | Medium         |
| dax             |           109408 | Medium         |
| firebase        |           109095 | Medium         |
| sap             |           108103 | Medium         |
| power bi        |           106738 | Medium         |
| cobol           |           106497 | Medium         |
| macos           |           105771 | Medium         |
| dart            |           105373 | Medium         |
| drupal          |           105234 | Medium         |
| chainer         |           105000 | Medium         |
| clickup         |           105000 | Medium         |
| vue.js          |           104958 | Medium         |
| lisp            |           104124 | Medium         |
| visio           |           103749 | Medium         |
| ssrs            |           103189 | Medium         |
| spss            |           102627 | Medium         |
| vba             |           101846 | Medium         |
| cognos          |           101469 | Medium         |
| wrike           |           101250 | Medium         |
| wire            |           100704 | Medium         |
| crystal         |            99942 | Medium         |
| excel           |            99751 | Medium         |
| powerpoint      |            99160 | Medium         |
| word            |            99012 | Medium         |
| sharepoint      |            98611 | Medium         |
| visual basic    |            98511 | Medium         |
| delphi          |            98496 | Medium         |
| symphony        |            98400 | Medium         |
| workfront       |            97841 | Medium         |
| npm             |            97030 | Medium         |
| homebrew        |            96773 | Medium         |
| svelte          |            94575 | Medium         |
| sheets          |            94455 | Medium         |
| spreadsheet     |            93746 | Medium         |
| microsoft teams |            93559 | Medium         |
| outlook         |            93220 | Medium         |
| colocation      |            92943 | Medium         |
| trello          |            92643 | Medium         |
| ms access       |            92341 | Medium         |
| pascal          |            92000 | Medium         |
| apl             |            90000 | Medium         |
| kali            |            89100 | Medium         |
| webex           |            88750 | Medium         |
| flutter         |            87702 | Medium         |
| vb.net          |            87226 | Medium         |
| planner         |            83420 | Medium         |
| laravel         |            82200 | Medium         |
| smartsheet      |            81049 | Medium         |
| firestore       |            80019 | Medium         |
| monday.com      |            77880 | Low            |
| blazor          |            74733 | Low            |
| digitalocean    |            65000 | Low            |

### Insight 

**1. Big Data Manipulation skills are valuable**

Professionals in manipulating big datasets using technologies like PySpark and Couchbase, along with machine learning tools such as DataRobot and Jupyter, are in high demand.

**2. Python libraries are esseential**

Additionally, proficiency in Python libraries like Pandas and NumPy further enhances an analyst’s ability to manipulate and analyze data efficiently, making these skills essential for top-paying roles. 


## 5. What are the most optimal skills to learn? 

SQL file: [5_Optimal_skills.sql](5_Optimal_skills.sql) 

### Steps 

To determine the most valuable skills to learn, I first needed to identify which skills offer the highest salaries and which are in the highest demand. Both of these factors were addressed in Questions 3 and 4. 

1. **Join Tables**  
- Merged `job_postings_fact` with `skills_job_dim` to link job postings with their required skills.  
- Further joined `skills_dim` to retrieve skill names.  
- Filtered the data to include only **Data Analyst** job postings.  

2. **Count Skill Frequency & Calculate Salaries**  
- Counted how often each skill appeared in job postings (`COUNT(*) AS skill_count`).  
- Calculated the **average salary** for jobs requiring each skill (`AVG(salary_year_avg)`).  
- Rounded the average salary for clarity.  

3. **Filter & Rank Skills**  
- Removed job postings with missing salary data (`WHERE salary_year_avg IS NOT NULL`).  
- Sorted skills **first by demand** (highest count) and **then by salary** (highest average).  
- Displayed the **top 25 most in-demand skills** (`LIMIT 25`).

```sql 
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
``` 

### Data Visualization 


With the help of ChatGPT, I managed to construct the table as follow:  

| #  | Skill       | Demand (Job Count) | Average Salary ($) |
|----|------------|-------------------|--------------------|
| 1  | SQL        | 3,083             | 96,435            |
| 2  | Excel      | 2,143             | 86,419            |
| 3  | Python     | 1,840             | 101,512           |
| 4  | Tableau    | 1,659             | 97,978            |
| 5  | R          | 1,073             | 98,708            |
| 6  | Power BI   | 1,044             | 92,324            |
| 7  | SAS        | 1,000             | 93,707            |
| 8  | Word       | 527               | 82,941            |
| 9  | PowerPoint | 524               | 88,316            |
| 10 | SQL Server | 336               | 96,191            |
| 11 | Oracle     | 332               | 100,964           |
| 12 | Azure      | 319               | 105,400           |
| 13 | AWS        | 291               | 106,440           |
| 14 | Go         | 288               | 97,267            |
| 15 | Flow       | 271               | 98,020            |
| 16 | Looker     | 260               | 103,855           |
| 17 | Snowflake  | 241               | 111,578           |
| 18 | SPSS       | 212               | 85,293            |
| 19 | Spark      | 187               | 113,002           |
| 20 | VBA        | 185               | 93,845            |
| 21 | SAP        | 183               | 92,446            |
| 22 | Outlook    | 180               | 80,680            |
| 23 | SharePoint | 174               | 89,027            |
| 24 | Sheets     | 155               | 84,130            |
| 25 | JavaScript | 153               | 91,805            |


With the use of Python, here's how I visualized the data. 

![5_Optimal_skills.png](Python_visualization\Images\5_Optimal_skills.png) 

### Insight 

#### **Top Skills by Demand**  
- **SQL (3,083 postings, $96,435 avg. salary)** → The most in-demand skill, essential for querying databases.  
- **Excel (2,143 postings, $86,419 avg. salary)** → Still highly relevant in data analysis workflows.  
- **Python (1,840 postings, $101,512 avg. salary)** → A versatile skill with strong salary potential.  
- **Tableau (1,659 postings, $97,978 avg. salary)** → A top data visualization tool used widely.  
- **R (1,073 postings, $98,708 avg. salary)** → Common in statistical analysis and data science.  

#### **Top Skills by Salary**  
- **Spark ($113,002, 187 postings)** → A powerful tool for big data processing.  
- **Snowflake ($111,578, 241 postings)** → A cloud data warehouse skill with high earning potential.  
- **AWS ($106,440, 291 postings)** → Cloud computing is in high demand and pays well.  
- **Azure ($105,400, 319 postings)** → Similar to AWS, strong for cloud-based data roles.  
- **Looker ($103,855, 260 postings)** → BI tool growing in importance.  

#### **Best Skills to Learn (Balance of Demand & Salary)**  
1. **Python** – Strong demand & salary, used in automation, ML, and analytics.  
2. **SQL** – The most essential skill for data analysts, in high demand.  
3. **Tableau** – Critical for data visualization, pays well.  
4. **Azure/AWS** – Cloud skills significantly boost salary potential.  
5. **Snowflake/Spark** – High-paying, future-proof skills in big data & cloud.  

# Thank you for reading 



