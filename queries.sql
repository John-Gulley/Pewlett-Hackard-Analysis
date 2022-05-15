SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


select first_name,last_name,title
from employees as e
left join titles as t on e.emp_no = t.emp_no;


-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;


-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;


-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
	retirement_info.last_name,
    department_employee.to_date
FROM retirement_info
left JOIN department_employee
ON retirement_info.emp_no = department_employee.emp_no;


SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN department_employee as de
ON ri.emp_no = de.emp_no;


-- Joining retirement_info and dept_emp tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;


SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN department_employee as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');


-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN department_employee as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;


-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN department_employee as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;


-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
into emp_by_dept
FROM current_emp as ce
LEFT JOIN department_employee as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;


SELECT e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN department_employee as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');


SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN department_employee AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);


(((Unable to add the into text before from in sql. Ask about this)))
SELECT re.emp_no,
    re.first_name,
	re.last_name,
	de.emp_no,
	de.dept_no,
	d.dept_no,
	d.dept_name
FROM retirement_info as re
left JOIN department_employee as de
ON (re.emp_no = de.emp_no)
INNER JOIN departments as d
ON (d.dept_no = de.dept_no)
Where (dept_name = 'Sales')
order by re.emp_no;


SELECT re.emp_no,
    re.first_name,
	re.last_name,
	de.emp_no,
	de.dept_no,
	d.dept_no,
	d.dept_name
FROM retirement_info as re
left JOIN department_employee as de
ON (re.emp_no = de.emp_no)
INNER JOIN departments as d
ON (d.dept_no = de.dept_no)
Where dept_name in ('Sales','Development')
order by re.emp_no;



Test query no_1 -
SELECT distinct e.emp_no,
	e.first_name,
	e.last_name, 
	e.birth_date,
	t.title,
	t.from_date,
	t.to_date
	into retirement_titles
from employees as e
	inner join titles as t
	on (e.emp_no = t.emp_no)
where (birth_date between '1952-01-01' and '1955-12-31')
order by emp_no;


no_1.A -
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	to_date,
	title

INTO retire_ready
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;


no_1.B -
select count (emp_no), title
into retiring_titles
from retire_ready
group by title
order by count desc


Test query no_2 -
