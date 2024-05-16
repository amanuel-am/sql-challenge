
-- Q1-----------------------------------------------------------------

SELECT employees.emp_no, 
employees.last_name,
employees.first_name,
employees.sex,
salaries.salary
FROM employees
LEFT JOIN salaries
ON employees.emp_no = salaries.emp_no
ORDER BY emp_no;


--Q2--------------------------------------------------------------------

SELECT first_name,last_name,hire_date FROM employees
where DATE_PART('year',hire_date) = 1986
ORDER BY hire_date ASC;

--Q3--------------------------------------------------------------------

SELECT dep_manager.dept_no, 
departments.dept_name,
dep_manager.emp_no,
employees.first_name,
employees.last_name
FROM dep_manager
JOIN departments 
ON 	dep_manager.dept_no = departments.dept_no
JOIN employees 
ON dep_manager.emp_no = employees.emp_no;


--Q4-------------------------------------------------------------------

SELECT d.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
JOIN employees e
ON de.emp_no = e.emp_no
ORDER BY d.dept_no ASC;


--Q5---------------------------------------------------------------------

SELECT first_name, last_name, sex 
FROM employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%%'
ORDER BY last_name ASC;


--Q6-------------------------------------------------------------------

SELECT e.emp_no, e.last_name, e.first_name, t.dept_name 
FROM employees e
JOIN
(SELECT d.dept_no, d.dept_name, de.emp_no  FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales') t
ON e.emp_no = t.emp_no
ORDER BY e.emp_no ASC;

--Q7-----------------------------------------------------------------

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name 
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales' or d.dept_name = 'Development'
ORDER BY e.emp_no ASC;

--------------------------------------------------------------------
SELECT DISTINCT dept_name
FROM departments;

--Q8----------------------------------------------------------------

SELECT last_name, COUNT(emp_no) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;
