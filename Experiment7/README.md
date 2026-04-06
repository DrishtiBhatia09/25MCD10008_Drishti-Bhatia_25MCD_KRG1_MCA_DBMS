
# **DBMS Lab – Experiment 7**  

## 👨‍🎓 **Student Details**  
**Name:** Drishti Bhatia  
**UID:** 25MCD10008      
**Branch:** MCA (Data Science)    
**Semester:** 2nd  
**Section/Group:** 1/A  
**Subject:** Technical Training-I Lab       
**Date of Performance:** 31/03/2026  

---

## 🎯 **Aim of the Practical**  
Implementation of joins in PostgreSQL (inner join, left join, right join, self join and cross join)


## 💻 **Tools Used**
PostgreSQL

## 📌 **Objective of the Practical**  
Apply joins to a real-world database schema (e.g., Students, Courses, Enrollments, Departments)

## 🛠️ **Theory** 
Joins in SQL are used to combine data from two or more tables based on a common column. They are an essential feature of relational databases that allow users to retrieve related data stored in different tables in a single query.
There are different types of joins used in SQL:
1. INNER JOIN:
INNER JOIN returns only those records that have matching values in both tables. If there is no match, the rows are not included in the result.
2. LEFT JOIN (LEFT OUTER JOIN):
LEFT JOIN returns all records from the left table and the matching records from the right table. If there is no match, NULL values are returned for the right table columns.
3. RIGHT JOIN (RIGHT OUTER JOIN):
RIGHT JOIN returns all records from the right table and the matching records from the left table. If there is no match, NULL values are returned for the left table columns.
4. FULL JOIN (FULL OUTER JOIN):
FULL JOIN returns all records from both tables. It includes matching rows as well as non-matching rows from both sides, filling NULL where no match exists.
5. CROSS JOIN:
CROSS JOIN returns all possible combinations of rows from both tables. It is also known as the Cartesian product.
6. SELF JOIN:
SELF JOIN is used to join a table with itself. It is useful when comparing rows within the same table.
Joins help in reducing data redundancy, improving data retrieval efficiency, and performing complex queries by combining related information from multiple tables.



## 🛠️ **Practical / Experiment Steps**  
```sql
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
```

## **Step 1**
1: Write queries to list students with their enrolled courses (INNER JOIN).
```sql
SELECT s.student_id, s.student_name, c.course_name
FROM studentt s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;
```
<img width="647" height="248" alt="image" src="https://github.com/user-attachments/assets/7b1215a6-dd7a-4f80-b4c5-6fe8dca10e04" />

## **Step 2**
2: Find students not enrolled in any course (LEFT JOIN).                     
```sql
SELECT s.student_id, s.student_name
FROM studentt s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;
```
<img width="470" height="116" alt="image" src="https://github.com/user-attachments/assets/aa19e6d4-adfb-41be-8628-08ebcc8d30f4" />


## **Step 3**
3: Display all courses with or without enrolled students (RIGHT JOIN).

```sql

SELECT s.student_name, c.course_name
FROM enrollments e
RIGHT JOIN courses c ON e.course_id = c.course_id
LEFT JOIN studentt s ON e.student_id = s.student_id;
```
<img width="479" height="214" alt="image" src="https://github.com/user-attachments/assets/4e24a3cb-b338-4470-846a-3e50734b6106" />

## **Step 4**
4: Show students with department info using SELF JOIN or multiple joins
```sql
SELECT s.student_id, s.student_name, d.dept_name
FROM studentt s
INNER JOIN departmentss d ON s.dept_id = d.dept_id;

```
<img width="696" height="271" alt="image" src="https://github.com/user-attachments/assets/481990fc-c9cf-4b3b-bdf8-42822b66ea0a" />

## **Step 5**
4: Display all possible student-course combinations (CROSS JOIN). (Oracle, SAP, IBM, Microsoft)
```sql

SELECT` s.student_name, c.course_name
FROM studentt s
CROSS JOIN courses c;
```
<img width="422" height="676" alt="image" src="https://github.com/user-attachments/assets/9c6ad289-1570-4ed0-962c-69b089042cfa" />


## 📘 **Learning Outcomes**  
-	Understood the concept of joins in SQL and their importance in relational databases. 
-	Applied different types of joins such as INNER JOIN, LEFT JOIN, RIGHT JOIN, and CROSS JOIN in queries. 
-	Analyzed how data from multiple tables can be combined using common attributes. 
-	Implemented SQL queries to retrieve meaningful and structured data from related tables. 

