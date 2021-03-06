<?php

session_start();

require_once('src/php/conf.php');

// Kui kasutaja on juba sisse logitud, suuname ta edasi

if (isset($_SESSION['logged_in_email'])) {

	header ( 'Location: index_in.php' );

}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
		<title>Wrakendus - Login</title>
		<link rel='stylesheet' type='text/css' href='stylesheet.css'/>
		<!-- Algus - Facebook'i ühendus ja sisselogimise nupp -->
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

			function FBLogin(){
				FB.login(function(response){
					if(response.authResponse){
						window.location.href = "src/php/login.php?action=FB_logIN";
					}
				}, {scope: 'email'});
			}
		</script>
		<!-- Lõpp - Facebook'i ühendus ja sisselogimise nupp -->
	</head>
	<body>
		<div id="header"><h1>In time</h1></div>
	        <div id="tekstiala">
	            <div id="defaultLogin">
	                <form name="input" action="src/php/login.php?action=logIN" method="post">
	            	    <p>Kasutajanimi: <input type="text" name="username"/></p>
	            	    <p>Parool: <input type="password" name="password"/></p>
	                    <p><input type="submit" id="LogIN" value="Logi sisse!"/></p>
					</form>
	            </div>
				<div class="facebookLogin">
					<button type="button" id="facebook" onclick="FBLogin()">Sisene Facebookiga</button>
				</div>
			</div>
	</body>
</html>
