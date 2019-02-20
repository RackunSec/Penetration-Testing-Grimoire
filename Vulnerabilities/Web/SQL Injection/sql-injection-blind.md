# Blind SQL Injection Attacks
These types of attacks rely on other methods of gathering information about the service and the data it holds. For instance, if the error reporting is diabled, we can try to analyze true and false statements with the `sleep()` MySQL function like so,
```
https://127.0.0.1/comment.php?id=1337-IF(MID(@@version,1,1) = '5', sleep(5), 0)
```
If `@@version`'s first byte is in fact the number `5`, then the service will take (at least) 5 seconds to complete and send the HTTP response. If we switch this to,
```
https://127.0.0.1/comment.php?id=1337-IF(MID(@@version,1,1) = '4', sleep(5), 0)
```
And the first byte of `@@version` is still `5`, then the HTTP response will be returned immediately. We can do this in a brute force manner until we can figure out the MySQL version and eventually perform queries, but this takes a considerable amount of time.
