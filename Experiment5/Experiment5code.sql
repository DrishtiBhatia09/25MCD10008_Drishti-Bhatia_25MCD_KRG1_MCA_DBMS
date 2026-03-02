--create table
CREATE TABLE employeee (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    salary NUMERIC(10,2),
    experience INT,
    performance_rating NUMERIC(3,1)
);

--insert sample data
INSERT INTO employeee (emp_name, salary, experience, performance_rating)
VALUES
('Amit Sharma', 30000, 2, 3.5),
('Neha Verma', 45000, 5, 4.2),
('Rahul Singh', 60000, 8, 4.8),
('Priya Mehta', 35000, 3, 2.9),
('Karan Malhotra', 70000, 10, 4.5);

--step1
DO $$
DECLARE
    emp_record RECORD;
    emp_cursor CURSOR FOR 
        SELECT emp_id, emp_name, salary FROM employeee;
BEGIN
    OPEN emp_cursor;

    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN NOT FOUND;

        RAISE NOTICE 'ID: %, Name: %, Salary: %',
            emp_record.emp_id,
            emp_record.emp_name,
            emp_record.salary;
    END LOOP;

    CLOSE emp_cursor;
END $$;

--step2
DO $$
DECLARE
    emp_record RECORD;
    ratio NUMERIC;
    emp_cursor CURSOR FOR 
        SELECT emp_id, salary, experience, performance_rating 
        FROM employeee
        FOR UPDATE;
BEGIN
    OPEN emp_cursor;

    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN NOT FOUND;

        ratio := emp_record.experience * emp_record.performance_rating;

        IF ratio > 20 THEN
            UPDATE employeee 
            SET salary = salary * 1.20
            WHERE CURRENT OF emp_cursor;

        ELSIF ratio BETWEEN 10 AND 20 THEN
            UPDATE employeee 
            SET salary = salary * 1.10
            WHERE CURRENT OF emp_cursor;

        ELSE
            UPDATE employeee 
            SET salary = salary * 1.05
            WHERE CURRENT OF emp_cursor;
        END IF;

    END LOOP;

    CLOSE emp_cursor;
END $$;

--view updated table
select * from employeee;

--step3
DO $$
DECLARE
    emp_record RECORD;
    emp_cursor CURSOR FOR 
        SELECT emp_id, emp_name FROM employeee;
    row_count INT := 0;
BEGIN
    OPEN emp_cursor;

    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN NOT FOUND;

        row_count := row_count + 1;

        RAISE NOTICE 'Processing Employee: % - %',
            emp_record.emp_id,
            emp_record.emp_name;
    END LOOP;

    IF row_count = 0 THEN
        RAISE NOTICE 'No employees found.';
    ELSE
        RAISE NOTICE 'Total Employees Processed: %', row_count;
    END IF;

    CLOSE emp_cursor;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error: %', SQLERRM;
        IF emp_cursor IS NOT NULL THEN
            CLOSE emp_cursor;
        END IF;
END $$;
