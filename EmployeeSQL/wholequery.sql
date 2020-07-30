-- create departments table
drop table if exists departments cascade;
CREATE TABLE departments (
    dept_no varchar NOT NULL primary key,
    dept_name varchar NOT NULL);

-- create department employee table
-- set combination of emp_no & dept_no as primary key (emp_no has a duplicates value)
drop table if exists dept_emp cascade;
CREATE TABLE dept_emp (
    emp_no int NOT NULL,
    dept_no varchar NOT NULL,
	foreign key(dept_no) references departments(dept_no),
    from_date date NOT NULL,
    to_date date NOT NULL,
	primary key(emp_no,dept_no));	

-- create department manager table
drop table if exists dept_manager cascade;
CREATE TABLE dept_manager (
	dept_no varchar NOT NULL,
    emp_no int NOT NULL primary key,
	foreign key(dept_no) references departments(dept_no),
    from_date date NOT NULL,
    to_date date NOT NULL);

-- create employees table
drop table if exists employees cascade;
CREATE TABLE employees (
    emp_no int NOT NULL primary key,
    birth_date date NOT NULL,
    first_name varchar NOT NULL,
    last_name varchar NOT NULL,
    gender varchar NOT NULL,
    hire_date date NOT NULL);
	
-- create salaries table
drop table if exists salaries cascade;
CREATE TABLE salaries (
    emp_no integer NOT NULL primary key,
    salary integer NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL);

-- create titles table
-- set combination of emp_no & from_date as primary key (some emp_no has multiple start dates)
drop table if exists titles cascade;
CREATE TABLE titles (
    emp_no int NOT NULL,
    title varchar NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL,
	primary key(emp_no,from_date));
	
-- import departments data to table
copy departments from 'C:\SQL\departments.csv'
with (format csv, header);

-- import department employee data to table
copy dept_emp from 'C:\SQL\dept_emp.csv'
with (format csv, header);

-- import department manager data to table
copy dept_manager from 'C:\SQL\dept_manager.csv'
with (format csv, header);

-- import employees data to table
copy employees from 'C:\SQL\employees.csv'
with (format csv, header);

-- import salaries data to table
copy salaries from 'C:\SQL\salaries.csv'
with (format csv, header);

-- import titles to table
copy titles from 'C:\SQL\titles.csv'
with (format csv, header);

-- Verify if data is successfully imported
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;


/*List the following details of each employee: 
employee number, last name, first name, gender, and salary.*/
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary FROM employees AS e
LEFT JOIN salaries AS s
ON e.emp_no = s.emp_no
ORDER BY salary DESC;

--List employees who were hired in 1986.
SELECT emp_no, last_name, first_name, hire_date FROM employees
WHERE hire_date BETWEEN '1986/1/1' AND '1986/12/31'
ORDER BY emp_no;

/*List the manager of each department with the following information: 
department number, department name, the manager's employee number, last name, first name, 
and start and end employment dates.*/
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name,
	   de.FROM_date, de.to_date
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no
INNER JOIN dept_manager AS dm
ON de.emp_no = dm.emp_no
INNER JOIN departments AS d
ON d.dept_no = dm.dept_no;

/*List the department of each employee with the following information: 
employee number, last name, first name, and department name.*/
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name FROM dept_emp AS de
INNER JOIN departments AS d
ON d.dept_no = de.dept_no
INNER JOIN employees AS e
ON e.emp_no = de.emp_no
ORDER BY dept_name;

-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

/* List all employees in the Sales department, including their employee number, last name,
first name, and department name */
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name FROM employees AS e
INNER JOIN dept_emp AS de
ON de.emp_no = e.emp_no
INNER JOIN departments AS d
ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales'
ORDER BY emp_no;

/*List all employees in the Sales and Development departments, 
including their employee number, last name, first name, and department name.*/
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name FROM employees AS e
INNER JOIN dept_emp AS de
ON de.emp_no = e.emp_no
INNER JOIN departments AS d
ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales' or dept_name = 'Development'
ORDER BY dept_name;

/*In descending order, list the frequency count of employee last names, 
i.e., how many employees share each last name.*/
SELECT last_name, COUNT(last_name) AS last_name_count FROM employees
GROUP BY last_name
ORDER BY last_name_count DESC;



