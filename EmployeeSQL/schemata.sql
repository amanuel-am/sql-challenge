--CREATE DEPARTMENTS TABLE---------------------------------

CREATE TABLE departments(
	dept_no VARCHAR(4) PRIMARY KEY,
	dept_name VARCHAR(50)
);

-----------------------------------------------------------
SELECT * FROM departments

-- CREATE EMPLOYEE TABLE-----------------------------------


CREATE TABLE employees(
	emp_no int NOT NULL PRIMARY KEY,
	emp_title_id VARCHAR(10)NOT NULL REFERENCES titles(title_id),
	birth_date DATE NOT NULL,
	first_name VARCHAR(50)NOT NULL,
	last_name VARCHAR(50)NOT NULL,
	sex VARCHAR(1) NOT NULL,
	hire_date DATE NOT NULL
);

-------------------------------------------------------------
SELECT * FROM employees


-- CREATE DEPT_EMP TABLE-------------------------------------


CREATE TABLE dept_emp(
	dept_emp_id SERIAL PRIMARY KEY,
	emp_no int NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-----------------------------------------------------------------
SELECT * FROM dept_emp


-- CREATE DEPT_MANAGER TABLE-------------------------------------

CREATE TABLE dep_manager(
	dept_manager_id SERIAL PRIMARY KEY,
	dept_no VARCHAR(4) NOT NULL,
	emp_no int NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)	
);

-------------------------------------------------------------------
SELECT * FROM dep_manager;


-- CREATE SALARIES TABLE-------------------------------------------

CREATE TABLE salaries(
	salary_id SERIAL PRIMARY KEY,
	emp_no int NOT NULL,
	salary int NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)	
);

-------------------------------------------------------------------
SELECT * FROM dept_emp


-- CREATE TITLES TABLE-------------------------------------------

CREATE TABLE titles(
	title_id VARCHAR(10) NOT NULL PRIMARY KEY,
	title VARCHAR(50) NOT NULL
);

-------------------------------------------------------------------
SELECT * FROM titles



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
