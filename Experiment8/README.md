
# **DBMS Lab – Experiment 8**  

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
To apply the concept of Stored Procedures in database operations in order to perform tasks like insertion,
updating, deletion, and retrieval of data efficiently, securely, and in a reusable manner within the database system.



## 💻 **Tools Used**
PostgreSQL

## 📌 **Objective of the Practical**  
Apply stored procedure concepts for database operations

## 🛠️ **Theory** 
A Stored Procedure is a precompiled collection of SQL statements stored in the database that can be executed whenever required. It is used to perform operations like INSERT, UPDATE, DELETE, and SELECT in a structured and reusable way.
Stored procedures help in improving performance, security, and code reusability in database systems.
Key Features:
1.	Precompiled Code
Stored procedures are compiled once and stored, which makes execution faster compared to normal SQL queries. 
2.	Reusability
The same procedure can be called multiple times without rewriting the code. 
3.	Security
Users can be given permission to execute procedures without direct access to database tables. 
4.	Reduced Network Traffic
Instead of sending multiple SQL queries, a single procedure call performs multiple operations. 
5.	Modularity
Complex database logic can be divided into smaller procedures, making it easier to manage.



## 🛠️ **Practical / Experiment Steps**  
```sql

CREATE TABLE employee_ (
    emp_id INT  PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    salary NUMERIC(10,2) NOT NULL,
    department VARCHAR(50)
);

INSERT INTO employee_ (emp_id,emp_name, salary, department) VALUES
(1,'Alice', 50000, 'HR'),
(2,'Bob', 60000, 'IT'),
(3,'Charlie', 55000, 'Finance');

CREATE OR REPLACE PROCEDURE UPDATA_SALARY_PROC(IN P_EMP_ID INT,INOUT P_SALARY NUMERIC(20,3),OUT
STATUS VARCHAR(20))
    AS
	$$
	DECLARE
	CURR_SAL NUMERIC(20,3);
	BEGIN

           SELECT SALARY+P_SALARY INTO CURR_SAL FROM EMPLOYEE_ WHERE         EMP_ID=P_EMP_ID;
	IF NOT FOUND THEN
	RAISE EXCEPTION 'EMPLOYEE NOT FOUND';
	END IF;
	--CURR_SAL:=CURR_SALARY+P_SALARY;
	
	UPDATE EMPLOYEE_
	SET SALARY=CURR_SAL
	WHERE EMP_ID=P_EMP_ID;

	P_SALARY:=CURR_SAL;
	STATUS:='SUCCESS';

	EXCEPTION 
	WHEN OTHERS THEN
	IF SQLERRM LIKE '%EMPLOYEE NOT FOUND%' THEN 
	STATUS:='EMPLOYEE NOT FOUND';
	END IF;
	END
	$$ LANGUAGE PLPGSQL;

	DO
	$$
		DECLARE
		EMP_ID INT:=1;
		STATUS VARCHAR(20);
		SALARY NUMERIC(20,3):=500;
		BEGIN
		CALL UPDATA_SALARY_PROC(EMP_ID,SALARY,STATUS);
		RAISE NOTICE 'YOUR STATUS IS % ',STATUS;
		END;
	$$
```

<img width="656" height="191" alt="image" src="https://github.com/user-attachments/assets/0bdb0ac7-a380-43f5-9edf-28065512603d" />
        
```sql
DO

              $$
		DECLARE
		EMP_ID INT:=99;
		STATUS VARCHAR(20);
		SALARY NUMERIC(20,3):=500;
		BEGIN
		CALL UPDATA_SALARY_PROC(EMP_ID,SALARY,STATUS);
		RAISE NOTICE 'YOUR STATUS IS % ',STATUS;
		END;
	$$	
  ```


<img width="663" height="215" alt="image" src="https://github.com/user-attachments/assets/58d9f17b-5c57-4e49-a798-4ed403f01c17" />

 ```sql

SELECT * FROM EMPLOYEE_;
```
<img width="1056" height="219" alt="image" src="https://github.com/user-attachments/assets/15fb0eba-df76-4315-b70d-be3c082092f8" />

## 📘 **Learning Outcomes**  
-	Understood the concept and importance of stored procedures in database systems. 
-	Learned how to create and execute stored procedures for CRUD operations. 
-	Gained knowledge about improving database performance and security using procedures. 
-	Developed skills to write reusable and modular SQL code for real-world applications.

