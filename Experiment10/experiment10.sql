
CREATE TABLE payroll (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2) CHECK (salary > 0)
);


INSERT INTO payroll VALUES
(1, 'Sanju', 30000),
(2, 'Riya', 40000),
(3, 'Sidhi', 50000);


START TRANSACTION;

UPDATE payroll
SET salary = 1000
WHERE emp_id = 3;


UPDATE payroll
SET salary = 1000
WHERE emp_id = 3;

ROLLBACK;


SELECT * FROM payroll;


START TRANSACTION;

UPDATE payroll
SET salary = salary + 5000
WHERE emp_id = 1;


SAVEPOINT sp1;

UPDATE payroll
SET salary = salary + 7000
WHERE emp_id = 2;


UPDATE payroll
SET salary = -1000
WHERE emp_id = 3;

ROLLBACK TO sp1;

COMMIT;

SELECT * FROM payroll;
