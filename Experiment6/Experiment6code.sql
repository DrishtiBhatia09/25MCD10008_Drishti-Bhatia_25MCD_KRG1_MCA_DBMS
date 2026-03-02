--create table
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    salary NUMERIC(10,2),
    status VARCHAR(20),      -- Active / Inactive
    dept_id INT
);

CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100)
);

-- Insert Departments
INSERT INTO departments (dept_name)
VALUES
('HR'),
('IT'),
('Finance'),
('Marketing');

-- Insert Employees
INSERT INTO employees (emp_name, salary, status, dept_id)
VALUES
('Amit Sharma', 50000, 'Active', 2),
('Neha Verma', 60000, 'Active', 3),
('Rahul Singh', 45000, 'Inactive', 1),
('Priya Mehta', 70000, 'Active', 2),
('Karan Malhotra', 55000, 'Inactive', 4);

--step1
CREATE VIEW active_employees AS
SELECT emp_id, emp_name, salary, dept_id
FROM employees
WHERE status = 'Active';

SELECT * FROM active_employees;

--step2
CREATE VIEW employee_department_view AS
SELECT 
    e.emp_id,
    e.emp_name,
    e.salary,
    e.status,
    d.dept_name
FROM employees e
JOIN departments d 
ON e.dept_id = d.dept_id;

SELECT * FROM employee_department_view;

--step3
CREATE VIEW department_summary AS
SELECT 
    d.dept_name,
    COUNT(e.emp_id) AS total_employees,
    COUNT(CASE WHEN e.status = 'Active' THEN 1 END) AS active_employees,
    AVG(e.salary) AS avg_salary,
    SUM(e.salary) AS total_salary_expense
FROM departments d
LEFT JOIN employees e 
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

SELECT * FROM department_summary;
