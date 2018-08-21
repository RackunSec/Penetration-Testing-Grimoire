# Local File Inclusion Cheat Sheet
Testing for local file inclusion, LFI, vulnerabilities is pretty straight forward. If the web language interpreter calls for a file locally but shows it externally, often as input to itself, you should attempt to put another file into the input.
### LFI Using PHP Wrapper
This kind of attack attempt, shown below, puts the command into POST data which is interpreterd by the PHP interpreter via the GET data input `php://input` and uses a NULL byte to stop all PHP interpretation of the current page after the input.

`curl -s --data "<?system('ls -la');?>" "http://target.host/web.php?file_path=php://input%00"`
