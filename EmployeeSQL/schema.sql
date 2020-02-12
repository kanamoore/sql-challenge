-- create departments table
drop table if exists departments cascade;
CREATE TABLE departments (
    dept_no varchar(10) NOT NULL primary key,
    dept_name varchar(30) NOT NULL);

-- create department employee table
-- set combination of emp_no & dept_no as primary key (emp_no has a duplicates value)
drop table if exists dept_emp cascade;
CREATE TABLE dept_emp (
    emp_no int NOT NULL,
	foreign key(emp_no) references employees(emp_no),
    dept_no varchar(4) NOT NULL,
	foreign key(dept_no) references departments(dept_no),
    from_date date NOT NULL,
    to_date date NOT NULL,
	primary key(emp_no,dept_no));

-- create department manager table
drop table if exists dept_manager cascade;
CREATE TABLE dept_manager (
	dept_no varchar(10) NOT NULL,
    foreign key(dept_no) references departments(dept_no),
    emp_no int NOT NULL primary key,
	foreign key(emp_no) references employees(emp_no),
    from_date date NOT NULL,
    to_date date NOT NULL);

-- create employees table
drop table if exists employees cascade;
CREATE TABLE employees (
    emp_no int NOT NULL primary key,
    birth_date date NOT NULL,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    gender varchar(10) NOT NULL,
    hire_date date NOT NULL);
	
-- create salaries table
drop table if exists salaries cascade;
CREATE TABLE salaries (
    emp_no integer NOT NULL primary key,
	foreign key(emp_no) references employees(emp_no),
    salary integer NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL);

-- create titles table
-- set combination of emp_no & from_date as primary key (some emp_no have multiple titles)
drop table if exists titles cascade;
CREATE TABLE titles (
    emp_no int NOT NULL,
	foreign key(emp_no) references employees(emp_no),
    title varchar(100) NOT NULL,
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