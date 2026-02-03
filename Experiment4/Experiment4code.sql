--Example1
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..5 LOOP
        RAISE NOTICE 'Iteration number: %', i;
    END LOOP;
END $$;

--Example2
CREATE TABLE employee1 (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT
);

INSERT INTO employee1 (emp_name, department, salary) VALUES
('Aarav', 'HR', 45000),
('Diya', 'Finance', 60000),
('Kabir', 'IT', 75000),
('Meera', 'IT', 52000),
('Rohan', 'Marketing', 40000);

DO $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN SELECT emp_id, emp_name FROM employee1 LOOP
        RAISE NOTICE 'Employee ID: %, Name: %', rec.emp_id, rec.emp_name;
    END LOOP;
END $$;

--Example3
DO $$
DECLARE
    counter INT := 1;
BEGIN
    WHILE counter <= 5 LOOP
        RAISE NOTICE 'Counter value: %', counter;
        counter := counter + 1;
    END LOOP;
END $$;

--Example4
DO $$
DECLARE
    num INT := 1;
BEGIN
    LOOP
        RAISE NOTICE 'Number: %', num;
        num := num + 1;

        EXIT WHEN num > 5;
    END LOOP;
END $$;

--Example5
DO $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN SELECT emp_id FROM employee1 LOOP
        UPDATE employee1
        SET salary = salary + 1000
        WHERE emp_id = rec.emp_id;
    END LOOP;
END $$;

select * from employee1;

--Example6
DO $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN SELECT emp_name, salary FROM employee1 LOOP
        IF rec.salary >= 60000 THEN
            RAISE NOTICE '% is a High Salary Employee', rec.emp_name;
        ELSE
            RAISE NOTICE '% is a Regular Salary Employee', rec.emp_name;
        END IF;
    END LOOP;
END $$;
