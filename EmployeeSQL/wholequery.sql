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
select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;


/*List the following details of each employee: 
employee number, last name, first name, gender, and salary.*/
double check done
select employees.emp_no, last_name, first_name, gender, salary from employees
left join salaries
on employees.emp_no = salaries.emp_no
order by salary DESC;

--List employees who were hired in 1986.
double check done
select emp_no, last_name, first_name, hire_date from employees
where hire_date between '1986/1/1' and '1986/12/31'
order by emp_no;

/*List the manager of each department with the following information: 
department number, department name, the manager's employee number, last name, first name, 
and start and end employment dates.*/
double check done
select departments.dept_no, dept_name, employees.emp_no, last_name, first_name,
	   dept_emp.from_date, dept_emp.to_date
from employees
inner join dept_emp
on employees.emp_no = dept_emp.emp_no
inner join dept_manager
on dept_emp.emp_no = dept_manager.emp_no
inner join departments
on departments.dept_no = dept_manager.dept_no;

/*List the department of each employee with the following information: 
employee number, last name, first name, and department name.*/
select dept_emp.emp_no, last_name, first_name, dept_name from dept_emp
inner join departments
on departments.dept_no = dept_emp.dept_no
inner join employees
on employees.emp_no = dept_emp.emp_no
order by dept_name;

-- List all employees whose first name is "Hercules" and last names begin with "B."
select * from employees
where first_name = 'Hercules' and last_name like 'B%';

/* List all employees in the Sales department, including their employee number, last name,
first name, and department name */
select employees.emp_no, last_name, first_name, dept_name from employees
inner join dept_emp
on dept_emp.emp_no = employees.emp_no
inner join departments
on dept_emp.dept_no = departments.dept_no
where dept_name = 'Sales'
order by emp_no;

/*List all employees in the Sales and Development departments, 
including their employee number, last name, first name, and department name.*/
select employees.emp_no, last_name, first_name, dept_name from employees
inner join dept_emp
on dept_emp.emp_no = employees.emp_no
inner join departments
on dept_emp.dept_no = departments.dept_no
where dept_name = 'Sales' or dept_name = 'Development'
order by dept_name;

/*In descending order, list the frequency count of employee last names, 
i.e., how many employees share each last name.*/
select last_name, count(last_name) as last_name_count from employees
group by last_name
order by last_name_count desc;
