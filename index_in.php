<?php

session_start();

require_once('src/php/conf.php');

// Kui kasutaja on sattunud antud lehele sisse-logimata, suuname ta tagasi avalehele

if (!$_SESSION['logged_in_email']) {

	header ( 'Location: index.php' );

}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
		<title>Wrakendus - Login</title>
		<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
	</head>
	<body>
		<div id="header"><h1>In time</h1></div>
		<div id="tekstiala">
			<h2>Tere, <?php echo $_SESSION['name']; ?></h2>
			<h6><a href="src/php/login.php?action=logOUT">Logi välja</a></h6>
			<div id="tutvustus">
				<h4> In Time on õpipäevik, mida võib kasutada igaüks, kes soovib saada ülevaadet oma ajakulust erinevatele tegevustele.</h4>
			</div>
			<div id="autorid">
			<h6>Wrakendus: Aivo, Helen, Leelo</h6>
			</div>
		</div>
    </body>
</html>
