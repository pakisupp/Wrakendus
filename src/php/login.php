<?php

session_start();

switch ( $_GET['action'] ) {

	case "logIN":

		require_once 'conf.php';

		$username = $_POST['username'];
		$password_md5 = md5 ( $_POST['password'] );

		$sqlcmd = 'SELECT * FROM kasutajad WHERE kasutajanimi = "'.$username.'" AND parool = "'.$password_md5.'"';
		$result = mysql_query ( $sqlcmd );
		$row = mysql_fetch_row($result);

		$count = mysql_num_rows ( $result );

		if ( $count == 1 ) {
		
			$_SESSION['logged_in_email'] = $row['email'];

			header ( 'Location: ../../index4.php' );

		} else {

			print "Vale kasutajanimi ja/või parool!";
			print '<p><a href="javascript:history.back(0)">&lt;- Tagasi</a></p>';

		}

	break;

	case "logOUT":

		session_destroy();
			
		header ( 'Location: ../../index.php' );

	break;

	default:
	
		if ( isset ( $_SESSION['username'] ) ) {
			
			header ( 'Location: ../../index.php' );
				
		} else {

			header ( 'Location: ../../index.php' );

		}

}
?>