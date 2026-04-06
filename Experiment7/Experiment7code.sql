-- STUDENTS TABLE
CREATE TABLE studentt (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    dept_id INT
);

-- COURSES TABLE
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50)
);

-- ENROLLMENTS TABLE (relation table)
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id)
);

-- DEPARTMENTS TABLE
CREATE TABLE departmentss (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- STUDENTS
INSERT INTO studentt VALUES
(101, 'Aman', 1),
(102, 'Riya', 2),
(103, 'Rahul', 3),
(104, 'Sneha', 4),
(105, 'Arjun', 1);   

-- COURSES
INSERT INTO courses VALUES
(201, 'Database'),
(202, 'Cloud'),
(203, 'AI'),
(204, 'Networking');

-- ENROLLMENTS
INSERT INTO enrollments VALUES
(101, 201),
(101, 202),
(102, 203),
(103, 201),
(104, 204);

-- DEPARTMENTS
INSERT INTO departmentss VALUES
(1, 'Oracle'),
(2, 'SAP'),
(3, 'IBM'),
(4, 'Microsoft');

--query1
SELECT s.student_id, s.student_name, c.course_name
FROM studentt s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;

--query2
SELECT s.student_id, s.student_name
FROM studentt s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

--query3
SELECT s.student_name, c.course_name
FROM enrollments e
RIGHT JOIN courses c ON e.course_id = c.course_id
Rig JOIN studentt s ON e.student_id = s.student_id;
