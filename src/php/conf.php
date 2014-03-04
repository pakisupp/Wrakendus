<?php

$hostname="localhost";
$username="tarretis_wusr"; 
$password="2viGj613@19"; 
$database="tarretis_wrakendus"; 
$db = mysql_connect($hostname,$username,$password); 
mysql_select_db($database,$db);

/* $connect = mysql_connect("localhost","tarretis_wusr","2viGj613@19","tarretis_wrakendus");

// Kontrollime ühendust

if (mysql_connect_errno($connect)) {

	echo "Failed to connect to MySQL: " . mysqli_connect_error();

} */

?>