<?php

session_start();

require_once('src/php/conf.php');

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
		<script type="text/javascript">
			window.fbAsyncInit = function() {
				FB.init({
				appId      : <?php echo APP_ID; ?>,
				status     : true, 
				cookie     : true, 
				xfbml      : true  
				});
			};
			
			(function(d){
				var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
				if (d.getElementById(id)) {return;}
				js = d.createElement('script'); js.id = id; js.async = true;
				js.src = "//connect.facebook.net/en_US/all.js";
				ref.parentNode.insertBefore(js, ref);
			}(document));

			function FBLogout(){
				FB.logout(function(response) {
					window.location.href = "src/php/login.php?action=logOUT";
				});
			}
		</script>
	</head>
	<body>
  
	<div id="header"><h1>In time</h1></div>
	
	<div id="tekstiala">
		
		<h2>Tere, <?php echo $_SESSION['name']; ?></h2>
		<?php if ($_SESSION['user_login_type'] == "facebook") { ?>
			<h6><a href="#" onClick="FBLogout();">Logi välja</a></h6>
		<?php } else { ?>
			<h6><a href="src/php/login.php?action=logOUT">Logi välja</a></h6>
		<?php } ?>
		
		<div id="tutvustus">
			<h4> In Time on õpipäevik, mida võib kasutada igaüks, kes soovib saada ülevaadet oma ajakulust erinevatele tegevustele.</h4>
		</div>
		
		<div id="autorid">
			<h6>Wrakendus: Aivo, Helen, Leelo</h6>
		</div>
	</div>
	
    </body>
</html>
