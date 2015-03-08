<?php

die('no sign-ups (demonstration-only)');


//only for development
error_reporting(E_ALL | E_NOTICE | E_STRICT);
//error_reporting(0);

define('SCRIPT', 'SIGNUP');

require_once('../inc/init_app.php');
require_once('../inc/functions.php');



//create user account, given the credentials



//get json payload from angular
//Mike Brant on stackoverflow
//http://stackoverflow.com/a/15485690/426266
$postdata = file_get_contents("php://input");
$request = json_decode($postdata);
if($request)
{
	$_POST['email']		= trim(@$request->email);
	$_POST['firstname']	= trim(@$request->firstname);
	$_POST['lastname']	= trim(@$request->lastname);
	$_POST['nickname']	= trim(@$request->nickname);
	$_POST['password']	= @$request->password;
	$_POST['retypepassword'] = @$request->retypepassword;
}
unset($postdata, $request);


//required field check
if(empty($_POST['email']) || empty($_POST['nickname']) || empty($_POST['password']) || empty($_POST['retypepassword']))
{
	if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 500 Internal Server Error');
	@json_header();

	echo json_encode(array('error' => 'Missing required fields'));
	die;
}


//password match check
if($_POST['retypepassword'] !== $_POST['password'])
{
	if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 401 Unauthorized');
	@json_header();

	echo json_encode(array('error' => 'Password mismatch'));
	die;
}



//check for invalid user name characters

function NotIsValid($str) {
    return (1 === preg_match('~[\<\>\"\'\0]+~', $str));
}
function invalid_chars_error($field)
{
	if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 400 Bad Request');
	@json_header();

	echo json_encode(array('error' => 'Invalid characters in ' . $field . ' detected.'));
	die;
}

if(NotIsValid($email = $_POST['email']))
{
	invalid_chars_error('email');
}
if(NotIsValid($nickname = $_POST['nickname']))
{
	invalid_chars_error('nickname');
}
if(NotIsValid($firstname = $_POST['firstname']))
{
	invalid_chars_error('first name');
}
if(NotIsValid($lastname = $_POST['lastname']))
{
	invalid_chars_error('last name');
}





/***database connect***/
$mysqli = DB::getInstance();


//check if a user with this e-mail address already exists
$result = $mysqli->query("SELECT `userid`
    FROM `users`
    WHERE `email` = '".$mysqli->real_escape_string($email)."'
    LIMIT 1");
if($result)
{
	$user = mysqli_fetch_assoc($result);
    if($user && isset($user['userid']) && $user['userid'])
    {
    	if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"]." 422 Unprocessable Entity");
		@json_header();
    	echo json_encode(array('error' => 'User already exists.'));
		die;
    }
}
@mysqli_free_result($result);


//okay - add new user to database


	//write user details

		//generate security token
		$password_salt = Session::CreateToken(5);

		//encrypt the password
		$password = sha1($password_salt . @$_POST['password']);

		$mysqli->query("INSERT INTO `users` (
			`userid`,
			`user_group`,
			`nick_name`,
			`first_name`,
			`last_name`,
			`email`,
			`password_hash`,
			`password`,
			`possession_count`,
			`join_date`
		) VALUES (
			NULL,
			'1',
			'".$mysqli->real_escape_string($nickname)."',
			'".$mysqli->real_escape_string($firstname)."',
			'".$mysqli->real_escape_string($lastname)."',
			'".$mysqli->real_escape_string($email)."',
			'".$mysqli->real_escape_string($password_salt)."',
			'".$mysqli->real_escape_string($password)."',
			'0',
			'".time()."'
		)
		");


	//get the id of this user
	$userid = mysqli_insert_id($mysqli);

	if(!$userid)
	{
		//there was an error to create the account
		if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 500 Internal Server Error');
		@json_header();
		echo json_encode(array('error' => 'Could not write to DB.'));
		die;
	}


	//Note:
	//The Auth class operates on the same $_POST variables as this script.
	//It can therefore be called to create the session and cookie,
	//just like when the user submits the login form
	//This will however add 1 unnecessary DB query to fetch the user details from the database again

	if(Auth::Login())
	{
		//signup success

		if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 200 OK');
		@json_header();

		//ANGULAR_JSON_PREFIX <-- did not work
		echo  json_encode(array(
							"sessionid"		=> Session::GetId(),
							"userid"		=> Auth::getUserid(),
							"securitytoken"	=> Session::GetToken(),
							"nickname"		=> Auth::getNickName(),
							)
						);
		exit;
	}
	else
	{

		if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 401 Unauthorized');
		@json_header();

		echo json_encode(array("error"  => Auth::getError() ));
		die;
	}

