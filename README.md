# SQL Challenge - Employee Database Query

## Background

In this challenge, I designed the tables to hold data in the CSVs, import the CSVs into a SQL database, and answered questions about the data.

#### Data Modeling

Sketched out an ERD of the tables using http://www.quickdatabasediagrams.com

![alt text](https://raw.githubusercontent.com/kanamoore/sql-challenge/master/EmployeeSQL/ERD%20Image.svg)

Click an image to get the full size table.

#### Data Engineering

Created tables specifying data types and added data from csv files.
For SQL code, please see here https://github.com/kanamoore/sql-challenge/blob/master/EmployeeSQL/schema.sql

#### Data Analysis

1. List the following details of each employee: employee number, last name, first name, gender, and salary.

```
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary FROM employees AS e
LEFT JOIN salaries AS s
ON e.emp_no = s.emp_no
ORDER BY salary DESC;
```

2. List employees who were hired in 1986.

```
SELECT emp_no, last_name, first_name, hire_date FROM employees
WHERE hire_date BETWEEN '1986/1/1' AND '1986/12/31'
ORDER BY emp_no;

```

3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

```
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name,
	   de.FROM_date, de.to_date
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no
INNER JOIN dept_manager AS dm
ON de.emp_no = dm.emp_no
INNER JOIN departments AS d
ON d.dept_no = dm.dept_no;
```

4. List the department of each employee with the following information: employee number, last name, first name, and department name.

```
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name FROM dept_emp AS de
INNER JOIN departments AS d
ON d.dept_no = de.dept_no
INNER JOIN employees AS e
ON e.emp_no = de.emp_no
ORDER BY dept_name;
```

5. List all employees whose first name is "Hercules" and last names begin with "B."

```
SELECT * FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';
```

6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

```
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name FROM employees AS e
INNER JOIN dept_emp AS de
ON de.emp_no = e.emp_no
INNER JOIN departments AS d
ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales'
ORDER BY emp_no;
```

7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

```
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name FROM employees AS e
INNER JOIN dept_emp AS de
ON de.emp_no = e.emp_no
INNER JOIN departments AS d
ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales' or dept_name = 'Development'
ORDER BY dept_name;

```

8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

```
SELECT last_name, COUNT(last_name) AS last_name_count FROM employees
GROUP BY last_name
ORDER BY last_name_count DESC;

```

## Using postgreSQL database with Python

For the entire code, please reference Jupyter notebook: https://github.com/kanamoore/sql-challenge/blob/master/EmployeeSQL/sql_analysis.ipynb

1. Imported the SQL database into Pandas.

```sql
engine = create_engine(f'postgresql+psycopg2://{username}:{pw}@localhost/sql_homework')
conn = engine.connect()
```

Reference: [SQLAlchemy documentation](https://docs.sqlalchemy.org/en/latest/core/engines.html#postgresql)

2. Created a histogram to visualize the most common salary ranges for employees using Matplotlib .

![alt text](https://github.com/kanamoore/sql-challenge/blob/master/EmployeeSQL/Salary%20Ranges%20for%20Employees.PNG)

3. Created a bar chart of average salary by title using Matplotlib.

![alt text](https://github.com/kanamoore/sql-challenge/blob/master/EmployeeSQL/Average%20Salary%20by%20TItle.PNG)

\*\* Original data needs to be corrected.
