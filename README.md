# SQL Challenge - Employee Database Query

## Background
In this challenge, you will design the tables to hold data in the CSVs, import the CSVs into a SQL database, and answer questions about the data.

#### Data Modeling
Created an ERD of the tables using http://www.quickdatabasediagrams.com

![alt text](https://raw.githubusercontent.com/kanamoore/sql-challenge/master/EmployeeSQL/ERD%20Image.svg)

Click an image to get the full size table.

#### Data Engineering

* Use the information you have to create a table schema for each of the six CSV files. Remember to specify data types, primary keys, foreign keys, and other constraints.

* Import each CSV file into the corresponding SQL table.

#### Data Analysis

Once you have a complete database, do the following:

1. List the following details of each employee: employee number, last name, first name, gender, and salary.
```sql
select e.emp_no, e.last_name, e.first_name, e.gender, s.salary from employees as e
left join salaries as s
on e.emp_no = s.emp_no
order by salary DESC;
```
2. List employees who were hired in 1986.
```sql
select emp_no, last_name, first_name, hire_date from employees
where hire_date between '1986/1/1' and '1986/12/31'
order by emp_no;
```
3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
```sql
select d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name,
	   de.from_date, de.to_date
from employees as e
inner join dept_emp as de
on e.emp_no = de.emp_no
inner join dept_manager as dm
on de.emp_no = dm.emp_no
inner join departments as d
on d.dept_no = dm.dept_no;
```
4. List the department of each employee with the following information: employee number, last name, first name, and department name.
```sql
select de.emp_no, e.last_name, e.first_name, d.dept_name from dept_emp as de
inner join departments as d
on d.dept_no = de.dept_no
inner join employees as e
on e.emp_no = de.emp_no
order by dept_name;
```
5. List all employees whose first name is "Hercules" and last names begin with "B."
```sql
select * from employees
where first_name = 'Hercules' and last_name like 'B%';
```
6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
```sql
select e.emp_no, e.last_name, e.first_name, d.dept_name from employees as e
inner join dept_emp as de
on de.emp_no = e.emp_no
inner join departments as d
on de.dept_no = d.dept_no
where dept_name = 'Sales'
order by emp_no;
```
7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
```sql
select e.emp_no, e.last_name, e.first_name, d.dept_name from employees as e
inner join dept_emp as de
on de.emp_no = e.emp_no
inner join departments as d
on de.dept_no = d.dept_no
where dept_name = 'Sales' or dept_name = 'Development'
order by dept_name;
```

8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
```sql
select last_name, count(last_name) as last_name_count from employees
group by last_name
order by last_name_count desc;
```
## Bonus (Optional)

As you examine the data, you are overcome with a creeping suspicion that the dataset is fake. You surmise that your boss handed you spurious data in order to test the data engineering skills of a new employee. To confirm your hunch, you decide to take the following steps to generate a visualization of the data, with which you will confront your boss:

1. Import the SQL database into Pandas. (Yes, you could read the CSVs directly in Pandas, but you are, after all, trying to prove your technical mettle.) This step may require some research. Feel free to use the code below to get started. Be sure to make any necessary modifications for your username, password, host, port, and database name:

   ```sql
   from sqlalchemy import create_engine
   engine = create_engine('postgresql://localhost:5432/<your_db_name>')
   connection = engine.connect()
   ```

* Consult [SQLAlchemy documentation](https://docs.sqlalchemy.org/en/latest/core/engines.html#postgresql) for more information.

* If using a password, do not upload your password to your GitHub repository. See [https://www.youtube.com/watch?v=2uaTPmNvH0I](https://www.youtube.com/watch?v=2uaTPmNvH0I) and [https://martin-thoma.com/configuration-files-in-python/](https://martin-thoma.com/configuration-files-in-python/) for more information.

2. Create a histogram to visualize the most common salary ranges for employees.

3. Create a bar chart of average salary by title.

