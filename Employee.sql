-- DATA ENGINEERING

-- create employees table
CREATE TABLE "employees" (
    "emp_no" INT NOT NULL,
    "emp_title_id" VARCHAR(10) NOT NULL,
    "birth_date" DATE   	  NOT NULL,
    "first_name" VARCHAR(30)  NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "sex" VARCHAR(1)   		  NOT NULL,
    "hire_date" DATE   		  NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);
SELECT * FROM employees;

--create departments table
CREATE TABLE "departments" (
    "dept_no" VARCHAR(10)   	NOT NULL,
    "dept_name" VARCHAR(20)     NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);
SELECT * FROM departments;

-- create department no. and employee no. table
CREATE TABLE "dept_emp" (
    "emp_no" INT   			NOT NULL,
    "dept_no" VARCHAR(10)   NOT NULL
);
SELECT * FROM dept_emp;

-- create department manager table
CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "emp_no" INT   	 		NOT NULL
);
SELECT * FROM dept_manager

-- create salary table
CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);
SELECT * FROM salaries;

-- create titles table
CREATE TABLE "titles" (
    "title_id" VARCHAR(20) NOT NULL,
    "title" VARCHAR(20)    NOT NULL
);
SELECT * FROM titles

-- ANALYSIS

--#1 List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

--#2 List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE EXTRACT(YEAR FROM e.hire_date) = 1986;

--#3 List the manager of each department along with their department number, 
-- department name, employee number, last name, and first name.
SELECT DISTINCT e.emp_no, e.last_name, e.first_name, d.dept_no, d.dept_name
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
JOIN departments d ON dm.dept_no = d.dept_no;

--#4 List the department number for each employee along with that employee’s 
-- employee number, last name, first name, and department name.
SELECT DISTINCT de.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no;

--#5 List first name, last name, and sex of each employee whose first name is 
-- Hercules and whose last name begins with the letter B.
SELECT DISTINCT e.first_name, e.last_name, e.sex
FROM employees e
WHERE e.first_name = 'Hercules' AND e.last_name LIKE 'B%';
-- chat GPT helped with the first first name beginning with B

--#6 List each employee in the Sales department, including their employee number, last name, 
-- and first name.
SELECT DISTINCT de.emp_no, e.last_name, e.first_name
FROM departments d
JOIN dept_emp de ON d.dept_no = d.dept_no
JOIN employees e ON de.emp_no = e.emp_no 
WHERE d.dept_name = 'Sales';

--#7 List each employee in the Sales and Development departments, including their employee number, 
-- last name, first name, and department name.
SELECT DISTINCT d.dept_name, de.emp_no, e.last_name, e.first_name
FROM departments d
JOIN dept_emp de ON d.dept_no = d.dept_no
JOIN employees e ON de.emp_no = e.emp_no 
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'

--#8 List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name).
SELECT last_name, COUNT(*) AS num_employees
FROM employees
GROUP BY last_name
ORDER BY num_employees DESC;
