# Getting to Know Databases
We can use many tools to make connections to the Oracle RDBMS if uncovered during the penetration test.
## Terms
Below if a list of key terms to become familiar with before executing a penetration test for a client who employs databases.
* Schema - The username and password used to bind to the RDBMS for a session.
* RDBMS - Relational Database Management System - The actual service that serves the database files: MySQL, Oracle SQL, PostGRESQL, SQLite3, etc.
* Table - the file of data
* Database - a directory of files (tables, synonyms, views, etc)
* Materialized View - a section of a file (table) or concatenation of multiple files (tables) as if it were a single file (table).
* SQL - structured query language - the language used to query the database.
* Query - INSERT, UPDATE, DELETE, SELECT, DROP, CREATE and GRANT are a few queries that we make to databases.
* Store Procedures - Special, customized queries or functions made for the particular RDBMS or DBA.
## SQL Client Tools
There are many tools we can use to make connections to RDMS, including GUI and CLI tools. Below is a list of tools to explore when presented with an RDMS during a penetration test.
### SQL Developer
[Oracle SQL Developer](https://www.oracle.com/database/technologies/appdev/sqldeveloper-landing.html) is a free, integrated development environment that simplifies the development and management of Oracle Database in both traditional and Cloud deployments. SQL Developer offers complete end-to-end development of your PL/SQL applications, a worksheet for running queries and scripts, a DBA console for managing the database, a reports interface, a complete data modeling solution, and a migration platform for moving your 3rd party databases to Oracle. 
### DBeaver
[DBeaver](https://dbeaver.io/) is a free multi-platform database tool for developers, database administrators, analysts and all people who need to work with databases. Supports all popular databases: MySQL, PostgreSQL, SQLite, Oracle, DB2, SQL Server, Sybase, MS Access, Teradata, Firebird, Apache Hive, Phoenix, Presto, etc.
