# HTTP Verbs
There are many methods, or "*verbs*," that you can use when making an HTTP request to a web application service. Depending the server configuration, different responses might lead to gleaning more information about the service, server, or web application that you are testing. In fact, some of the methods, when not configured properly, allow an attacker to alter or upload files on/to the HTTP server, CONNECT to the server and use it as a proxy, and more.

## Testing for Allowed HTTP Methods
We can do a simple to the web service using Netcat to potentially view the allowed HTTP services like so,

```
root@kali:~# nc (TARGET IP ADDRESS) (TARGET PORT)
OPTIONS / HTTP/1.1
```

## Altering an HTTP Request
To alter your request, simply use the [Burp Suite](https://portswigger.net/burp), or a similar tool, and change the top line as,

`GET /index.php HTTP/1.1`

into something like so,

`OPTIONS /index.php HTTP/1.1`

Often this type of request will prompt an HTTP response that will contain errors and possibly will leak server-specific information.

## All 8 HTTP Methods
Below is an entire list of all methods provided by the HTTP RFC.
* HEAD
* GET
* POST
* PUT
* DELETE
* TRACE
* OPTIONS
* CONNECT
