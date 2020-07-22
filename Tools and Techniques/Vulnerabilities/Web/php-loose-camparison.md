# PHP Loose Comparisons
PHP can use the loose comparison operator, `==` or a strict comparison operator, `===`.

Comparing *string* to *string*:
```
TRUE: “0e12345” == “0e54321”
TRUE: “0e12345” <= “1”
TRUE: “0e12345” == “0”
TRUE: “0xF” == “15”
```
Comparing a *String* to a *Number*:
```
TRUE: “0000” == int(0)
TRUE: “0e12” == int(0)
TRUE: “1abc” == int(1)
TRUE: “0abc” == int(0)
TRUE: “abc” == int(0)
```
## Example
Say that we have the following code that checks the user's authorization token,
```
<php
  $token = "0e124656823434657657655654324342";
  if(isset($_COOKIE['token']) && $_COOKIE['token'] == $token) {
    // access to privilege area
  }
  else {
    // login require
  }
?>
```
So, if we set our `token` cookie, using [Cookie Quick Manager](https://addons.mozilla.org/en-US/firefox/addon/cookie-quick-manager/) to `0`, this will be TRUE as shown below,(and as described above)
```
$COOKIE[‘token’] == $token (‘0e124656823434657657655654324342’ == ‘0’) will return TRUE
$COOKIE[‘token’] != $token (‘0e124656823434657657655654324342’ != ‘0’) will return FALSE
```

## Reference
https://hydrasky.com/network-security/php-string-comparison-vulnerabilities/
