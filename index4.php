<?php
session_start();
error_reporting(0);
require_once('src/php/facebook.php');
require_once('src/php/conf.php');

echo $_SESSION['logged_in_email'];

?>



<!DOCTYPE html">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>Wrakendus - Login</title>

<link rel='stylesheet' type='text/css' href='stylesheet.css'/>

<script type="text/javascript">
window.fbAsyncInit = function() {
	FB.init({
	appId      : '1440641672840169',
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
			window.location.href = "actions.php?action=fblogin";
		}
	}, {scope: 'email'});
}
</script>

</head>

<body>
<div id="header"><h1>In time</h1></div>
        <div id="loginForm">
            <div id="defaultLogin">
                <form name="input" action="src/php/login.php?action=logIN" method="post">
            	    Kasutajanimi: <input type="text" name="username" value=""><br/>
            	    Parool: <input type="password" name="password" value=""><br/><br/>
                    <input type="submit" id="LogIN" value="Logi sisse!">
				</form>
            </div>
			<div class="facebookLogin">
				<br><button type="button" id="facebook" onclick="FBLogin()">Sisene Facebookiga</button>
			</div>

</body>

</html>
