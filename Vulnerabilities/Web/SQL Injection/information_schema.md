# MySQL's Information_Schema Table
The Information_Schema table available in MySQL RDBMSs can be used to get data about all of the databases and tables.
## The Tables Table
The tables table of the information_schema database contains all of the tables hosted by the MySQL server.
## Tables.table_schema
This column in the Tables table contains the databases associate with the current record. We can do a distinct search for all databases availabel to us with the following query,
```
MariaDB [security]> select distinct information_schema.tables.table_schema from information_schema.tables;
+--------------------+
| table_schema       |
+--------------------+
| challenges         |
| information_schema |
| mysql              |
| performance_schema |
| security           |
+--------------------+
5 rows in set (0.01 sec)
```
## Tables.table_name
This column in the Tables table contains the table's name of the associated record. We can get all tables for a particular database by using the following query,
```
MariaDB [security]> select distinct table_name from information_schema.tables where table_schema = 'security';
+------------+
| table_name |
+------------+
| emails     |
| referers   |
| uagents    |
| users      |
+------------+
4 rows in set (0.00 sec)
```
## Group_Concat
Group concatenation of records can be achieved using the `GROUP_CONCAT` stored procedure in MySQL,
```
MariaDB [security]> select group_concat(distinct table_name separator ', ') from information_schema.tables where table_schema = 'security';
+--------------------------------------------------+
| group_concat(distinct table_name separator ', ') |
+--------------------------------------------------+
| emails, referers, uagents, users                 |
+--------------------------------------------------+
1 row in set (0.00 sec)

```
This way, we can acheive all records as a single string for simple SQL injection of a given column.
