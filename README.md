# SQL Challenge - Employee Database Query

## Background
In this challenge, I designed the tables to hold data in the CSVs, import the CSVs into a SQL database, and answer questions about the data.

#### Data Modeling
Sketched out an ERD of the tables using http://www.quickdatabasediagrams.com

![alt text](https://raw.githubusercontent.com/kanamoore/sql-challenge/master/EmployeeSQL/ERD%20Image.svg)

Click an image to get the full size table.

#### Data Engineering

Created tables specifying data types and added data from csv files.
For SQL code, please see here https://github.com/kanamoore/sql-challenge/blob/master/EmployeeSQL/schema.sql

## Using postgreSQL database with Python

1. Imported the SQL database into Pandas. 

```sql
engine = create_engine(f'postgresql+psycopg2://{username}:{pw}@localhost/sql_homework')
conn = engine.connect()
```   

Reference: [SQLAlchemy documentation](https://docs.sqlalchemy.org/en/latest/core/engines.html#postgresql)

2. Created a histogram to visualize the most common salary ranges for employees.

![alt text](https://github.com/kanamoore/sql-challenge/blob/master/EmployeeSQL/Salary%20Ranges%20for%20Employees.PNG)


3. Created a bar chart of average salary by title.

![alt text](https://github.com/kanamoore/sql-challenge/blob/master/EmployeeSQL/Average%20Salary%20by%20TItle.PNG)
