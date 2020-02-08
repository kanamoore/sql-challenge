-- Verify if data is successfully imported
select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;

/*List the following details of each employee: 
employee number, last name, first name, gender, and salary.*/
select employees.emp_no, last_name, first_name, gender, salary from employees
left join salaries
on employees.emp_no = salaries.emp_no
order by salary DESC;

--List employees who were hired in 1986.
select employees.emp_no, last_name, first_name, from_date from employees
left join salaries
on employees.emp_no = salaries.emp_no
where from_date between '1986/1/1' and '1986/12/31'
order by emp_no;

/*List the manager of each department with the following information: 
department number, department name, the manager's employee number, last name, first name, 
and start and end employment dates.*/

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
