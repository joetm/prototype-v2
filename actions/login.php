<?php

die('no login (demonstration-only)');


//for debugging
error_reporting(E_ALL | E_NOTICE | E_STRICT);

define('SCRIPT', 'LOGIN');

require_once('../inc/init_app.php');
require_once('../inc/functions.php');


//authenticate the user, given the credentials

if(Auth::Login())
{
	if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 200 OK');

	@json_header();

	//JSON CSRF protection
	//https://docs.angularjs.org/api/ng/service/$http#json-vulnerability-protection
	//ANGULAR_JSON_PREFIX was NOT ignored, as promised by Angular documentation

	echo json_encode(array(
						'sessionid'		=> Session::GetId(),
						'userid'		=> Auth::getUserid(),
						'securitytoken'	=> Session::GetToken(),
						'nickname'		=> Auth::getNickName(),
						)
					);
}
else
{

	if(!headers_sent())
	{
		//custom error - do not add an ugly 401 error on every page load
		if(isset($_GET['cookie']) && $_GET['cookie'] == '1')
		{
			 header($_SERVER["SERVER_PROTOCOL"].' 200 OK');
		}
		else
		{
			header($_SERVER["SERVER_PROTOCOL"].' 401 Unauthorized');
		}
	}

	@json_header();

	echo json_encode(array("error"  => Auth::getError() ));
}

exit;