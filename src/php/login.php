<?php

session_start();

switch ( $_GET['action'] ) {

	case "logIN":

		require_once 'conf.php';

		$username = $_POST['username'];
		$password_md5 = md5 ( $_POST['password'] );
		
		// Kontrollime andmebaasist, kas sisestatud andmetega kasutaja ekisteerib
		$query = 'SELECT * FROM kasutajad WHERE kasutajanimi = "'.$username.'" AND parool = "'.$password_md5.'"';
		$result = $mysqli->query($query);
		
		if ( $result->num_rows == 1 ) {
		
			// Leiame sisestatud andmetega kasutaja kohta veel andmeid ja salvestame need sessiooni
			$query = 'SELECT * FROM kasutajad WHERE kasutajanimi = "'.$username.'" AND parool = "'.$password_md5.'"';
			$result = $mysqli->query($query);
			$row = $result->fetch_row();
			
			$_SESSION['logged_in_email'] = $row[5];
			$_SESSION['name'] = $row[6];
				
			header ( 'Location: ../../index.php' );

		} else {

			print "Vale kasutajanimi ja/v√µi parool!";
			print '<p><a href="javascript:history.back(0)">&lt;- Tagasi</a></p>';

		}

	break;

	case "FB_logIN":

		require_once 'conf.php';
		require_once 'facebook.php';
		
		// Loome ¸henduse Facebookiga
		$appid 		= APP_ID;
		$appsecret  = APP_SECRET;
		$facebook   = new Facebook(array(
			'appId' => $appid,
			'secret' => $appsecret,
			'cookie' => TRUE,
		));
	
		$fbuser = $facebook->getUser();
	
		if ($fbuser) {
		
			try {
		    
		    	$user_profile = $facebook->api('/me');
		
			} catch (Exception $e) {
			
				echo $e->getMessage();
				exit();
			
			}
			
			// Kontrollime, kas sisseloginud kasutaja andmed on salvestatud andmebaasi. Kui ei, salvestame need	
			$query = 'SELECT * FROM kasutajad WHERE email = "'.$user_profile["email"].'"';
			$result = $mysqli->query($query);
		
			if($result->num_rows < 1) {
		
				$query = 'INSERT INTO kasutajad SET kasutajanimi="'.$user_profile["username"].'", nimi="'.$user_profile["name"].'", email="'.$user_profile["email"].'", fb_id="'.$fbuser.'", sugu="'.$user_profile["gender"].'", registreerunud=now(), viimane_sisselogimine=now()';
				$results = $mysqli->query($query);
		
			}
		
			$_SESSION['logged_in_email'] = $user_profile["email"];
			$_SESSION['name'] = $user_profile["name"];
				
		}
		
		header ( 'Location: ../../index.php' );

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