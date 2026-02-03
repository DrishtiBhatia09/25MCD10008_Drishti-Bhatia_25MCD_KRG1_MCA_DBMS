


# **DBMS Lab – Experiment 4**  
## **Implementation of Iterative Control Structures using FOR, WHILE, and LOOP in PostgreSQL**

---

## 👨‍🎓 **Student Details**  
**Name:** Drishti Bhatia  
**UID:** 25MCD10008      
**Branch:** MCA (Data Science)    
**Semester:** 2nd  
**Section/Group:** 1/A  
**Subject:** Technical Training-I Lab       
**Date of Performance:** 03/02/2026  

---

## 🎯 **Aim of the Practical**  
To understand and implement iterative control structures in PostgreSQL conceptually, including FOR loops, WHILE loops, and basic LOOP constructs, for repeated execution of database logic.


---

## 💻 **Tools Used**
PostgreSQL

## 📌 **Objective of the Practical**  
-	To understand why iteration is required in database programming
-	To learn the purpose and behavior of FOR, WHILE, and LOOP constructs
-	To understand how repeated data processing is handled in databases
-	To relate loop concepts to real-world batch processing scenarios
-	To strengthen conceptual knowledge of procedural SQL used in enterprise systems

  
## 🛠️ **Theory** 
In real-world database applications, tasks often need to be repeated multiple times. Examples include processing employee records, generating reports, validating data, applying salary increments, and running batch jobs. Standard SQL is declarative and works well for single operations, but repeated logic requires procedural control.
PostgreSQL provides PL/pgSQL, a procedural extension that supports iteration using loop structures. These loops allow SQL statements to execute repeatedly until a specific condition is met.           
Iteration in PostgreSQL is commonly used inside:
-	Stored procedures
-	Functions
-	Anonymous execution blocks                   
Large organizations such as Amazon, SAP, Oracle, and Rippling use loop-based logic for payroll processing, billing cycles, analytics, and automation workflows.

Types of Loops in PostgreSQL

1. FOR Loop (Range-Based)
- 	Executes a fixed number of times
-	Useful when the number of iterations is known in advance
-	Commonly used for counters, testing, and batch execution

2. FOR Loop (Query-Based)
-	Iterates over rows returned by a query
-	Processes one row at a time
-	Frequently used for reporting, audits, and row-wise calculations

3. WHILE Loop
-	Executes repeatedly as long as a condition remains true
-	Suitable for condition-controlled execution
-	Often used in retry logic or threshold-based processing

4. LOOP with EXIT Condition
-	Executes indefinitely until explicitly stopped
-	Provides maximum control over execution flow
-	Used in complex workflows where exit conditions are custom-defined

## 🛠️ **Practical / Experiment Steps**  
Prerequisite Understanding       
Example 1: FOR Loop – Simple Iteration
-	The loop runs a fixed number of times
-	Each iteration represents one execution cycle
-	Useful for understanding basic loop behavior                
Application: Counters, repeated tasks, batch execution

Example 2: FOR Loop with Query (Row-by-Row Processing)
-	The loop processes database records one at a time
-	Each iteration handles a single row
-	Simulates cursor-based processing                         
Application: Employee reports, audits, data verification

Example 3: WHILE Loop – Conditional Iteration
-	The loop runs until a condition becomes false
-	Execution depends entirely on the condition
-	The condition is checked before every iteration                 
Application: Retry mechanisms, validation loops

Example 4: LOOP with EXIT WHEN
-	The loop does not stop automatically
-	An explicit exit condition controls termination
-	Gives flexibility in complex logic                   
Application: Workflow engines, complex decision cycles

Example 5: Salary Increment Using FOR Loop
-	Employee records are processed one by one
-	Salary values are updated iteratively
-	Represents real-world payroll processing                          
Application: Payroll systems, bulk updates

Example 6: Combining LOOP with IF Condition
-	Loop processes each record
-	Conditional logic classifies data during iteration
-	Demonstrates decision-making inside loops                  
Application: Employee grading, alerts, categorization logic

# ⚙️ **Code**


## **Example 1**
```sql
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..5 LOOP
        RAISE NOTICE 'Iteration number: %', i;
    END LOOP;
END $$;

```
<img width="388" height="221" alt="11" src="https://github.com/user-attachments/assets/fe0889a1-7e88-44cb-95b2-d94070831601" />

## **Example 2**

```sql
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

```
<img width="387" height="222" alt="22" src="https://github.com/user-attachments/assets/440c206f-f22a-4191-a3dd-95e3dc12d0d6" />


## **Example 3:**

```sql
DO $$
DECLARE
    counter INT := 1;
BEGIN
    WHILE counter <= 5 LOOP
        RAISE NOTICE 'Counter value: %', counter;
        counter := counter + 1;
    END LOOP;
END $$;


```
<img width="407" height="212" alt="33" src="https://github.com/user-attachments/assets/8e659d7c-8118-4105-9a93-6c5e1886aa5c" />

## **Example 4:**
```sql
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
```
<img width="417" height="207" alt="44" src="https://github.com/user-attachments/assets/77ff309f-dcd1-499a-83b6-ff9a1501e617" />

## **Example 5:**

```sql
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
```

<img width="626" height="212" alt="55" src="https://github.com/user-attachments/assets/e0dccb3e-6d08-491a-b6e8-193508c814d7" />

## **Example 6:**

```sql
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
```
<img width="432" height="213" alt="66" src="https://github.com/user-attachments/assets/83aff98b-03da-4d78-8020-781c033cbc29" />

## 📘 **Learning Outcomes**  
-	Understood the concept of iterative control structures in PostgreSQL
-	Identified appropriate use cases for FOR, WHILE, and LOOP constructs
-	Implemented procedural logic using PL/pgSQL loops
-	Applied loops for row-by-row data processing and conditional execution
-	Gained foundational knowledge required for enterprise-level database applications


