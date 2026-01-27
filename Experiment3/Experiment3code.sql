CREATE TABLE schema_violations (
    id SERIAL PRIMARY KEY,
    schema_name VARCHAR(50),
    violation_count INT
);

INSERT INTO schema_violations (schema_name, violation_count) VALUES
('sales', 0),
('finance', 2),
('hr', 5),
('inventory', 9),
('audit', 15);

--Step1
SELECT schema_name,violation_count,
    CASE
        WHEN violation_count = 0 THEN 'No Violation'
        WHEN violation_count BETWEEN 1 AND 3 THEN 'Minor Violation'
        WHEN violation_count BETWEEN 4 AND 7 THEN 'Moderate Violation'
        ELSE 'Critical Violation'
    END AS violation_status
FROM schema_violations;

--Step2
ALTER TABLE schema_violations
ADD COLUMN approval_status VARCHAR(20);

UPDATE schema_violations
SET approval_status =
    CASE
        WHEN violation_count = 0 THEN 'Approved'
        WHEN violation_count BETWEEN 1 AND 5 THEN 'Needs Review'
        ELSE 'Rejected'
    END;

Select * from schema_violations;

--Step3
DO $$
DECLARE
    v_count INT := 6;
BEGIN
    IF v_count = 0 THEN
        RAISE NOTICE 'No violations found.';
    ELSIF v_count BETWEEN 1 AND 5 THEN
        RAISE NOTICE 'Minor issues detected. Review required.';
    ELSE
        RAISE NOTICE 'Critical violations! Immediate action needed.';
    END IF;
END $$;

--Step4
CREATE TABLE student (
    student_name VARCHAR(50),
    marks INT
);

INSERT INTO student VALUES
('Amit', 92),
('Riya', 78),
('Neha', 65),
('Rahul', 48),
('Karan', 33);

SELECT student_name,marks,
    CASE
        WHEN marks >= 90 THEN 'A'
        WHEN marks >= 75 THEN 'B'
        WHEN marks >= 60 THEN 'C'
        WHEN marks >= 40 THEN 'D'
        ELSE 'Fail'
    END AS grade
FROM student;

--Step5
SELECT
    schema_name,
    violation_count
FROM schema_violations
ORDER BY
    CASE
        WHEN violation_count = 0 THEN 1
        WHEN violation_count BETWEEN 1 AND 3 THEN 2
        WHEN violation_count BETWEEN 4 AND 7 THEN 3
        ELSE 4
    END,
    violation_count DESC ;

