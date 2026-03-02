
# **DBMS Lab – Experiment 5**  

## 👨‍🎓 **Student Details**  
**Name:** Drishti Bhatia  
**UID:** 25MCD10008      
**Branch:** MCA (Data Science)    
**Semester:** 2nd  
**Section/Group:** 1/A  
**Subject:** Technical Training-I Lab       
**Date of Performance:** 27/02/2026  

---

## 🎯 **Aim of the Practical**  
To gain hands-on experience in creating and using cursors for row-by-row processing in a database, enabling sequential access and manipulation of query results for complex business logic. (Company Tags: Infosys, Wipro, TCS, Capgemini)

---

## 💻 **Tools Used**
PostgreSQL

## 📌 **Objective of the Practical**  
-	Sequential Data Access: To understand how to fetch rows one by one from a result set using cursor mechanisms.
-	Row-Level Manipulation: To perform specific operations or calculations on individual records that require conditional procedural logic.
-	Resource Management: To learn the lifecycle of a cursor: Declaring, Opening, Fetching, and importantly, Closing and Deallocating to manage system memory.
-	Exception Handling: To handle cursor-related errors and performance considerations during large-scale data iteration.

  
## 🛠️ **Theory** 
While SQL is generally set-oriented, certain tasks require a procedural approach where we process one row at a time. This is where Cursors are used:
1.	Cursor Types: Cursors can be Implicit (managed by the system) or Explicit (defined by the developer). They can also be Forward-Only (moving only toward the end) or Scrollable (moving back and forth).
2.	The Lifecycle: * DECLARE: Defines the SQL query for the cursor.
o	OPEN: Executes the query and establishes the result set.
o	FETCH: Retrieves a specific row into variables for processing.
o	CLOSE: Releases the current result set.
o	DEALLOCATE: Removes the cursor definition from memory.
3.	Use Case: Cursors are ideal for generating row-specific reports, updating balances based on complex historical data, or migrating data where each record needs individual validation.

## 🛠️ **Practical / Experiment Steps**  

Step 1: Implementing a Simple Forward-Only Cursor                                
Creating a cursor to loop through an Employee table and print individual records.

## **Step 1**
```sql
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

'SELECT * FROM active_employees;

```
<img width="570" height="204" alt="Screenshot 2026-03-02 203818" src="https://github.com/user-attachments/assets/116ddf61-d1d5-4504-956b-0fab0390ca5d" />


## **Step 2**
Step 2: Complex Row-by-Row Manipulation                          
Using a cursor to update salaries based on a dynamic "Experience-to-Performance" ratio logic.


```sql
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
```
<img width="570" height="204" alt="Screenshot 2026-03-02 203818" src="https://github.com/user-attachments/assets/b8684a7e-4899-4060-a5b5-b8955a370fe4" />



## **Step 3**

Step 3: Exception and Status Handling                  
Ensuring the cursor handles empty result sets or termination signals gracefully.



```sql
--step3
DO $$
DECLARE
    emp_record RECORD;
    emp_cursor CURSOR FOR 
        SELECT emp_id, emp_name FROM employee;
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
```
<img width="469" height="209" alt="Screenshot 2026-03-02 204436" src="https://github.com/user-attachments/assets/03a9ff47-efd2-411b-a991-7f7713d0597e" />


## 📘 **Learning Outcomes**  

- Cursor Implementation: Students will be able to design, implement, and manage cursors to solve row-wise processing problems.
- Lifecycle Mastery: Students will demonstrate the correct syntax for declaring, opening, fetching, and closing cursors.
- Error Prevention: Students will understand how to properly handle row-by-row processing exceptions and prevent memory leaks via deallocation.
- Analytical Thinking: Students will be able to apply cursor-based logic to solve real-world scenarios like multi-level payroll adjustments or data migrations
