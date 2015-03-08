<?php

//the prototype was changed to only use static data
//that way I do not have to run the database
//(the script below works fine)

/*
Simple backend for viewing user profiles
Outputs data used on the user profile (user details and things)
*/


define('SCRIPT', 'PROFILE');


//init the backend
require_once('../inc/init_app.php');
require_once('../inc/functions.php');


//input
$userid = (isset($_REQUEST['userid']) ? $_REQUEST['userid'] : false);

if(!$userid)
{
	if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 400 Bad Request');
	@json_header();
	echo json_encode(array('error' => 'Invalid user id.'));
	die;
}


//get DB access
$mysqli = DB::getInstance();


//query user details
$user = false;
$result = $mysqli->query("SELECT u.userid, u.first_name, u.last_name, u.nick_name,
				u.birthdate, u.possession_count AS `count`, u.about_me, u.join_date,
				ua.file_name AS `avatar`
			FROM `users` as `u`
				LEFT JOIN `user_avatars` AS `ua` ON (ua.userid = u.userid)
			WHERE u.userid = ".intval($userid)."
			LIMIT 1");
if($result)
{
	$user = mysqli_fetch_assoc($result);

	//readable join date
	$user['join_date'] = date('d-m-Y', $user['join_date']);

	//avatar available?
	$user['avatar'] = ($user['avatar'] ? $user['avatar'] : 'avatars/noavatar.jpg');
}
@mysqli_free_result($result);

if(!$user)
{
	if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 404 Not Found');
	@json_header();
	echo json_encode(array('error' => 'User not found.'));
	die;
}


//query possessions (things) of this user
$things = array();
$result = $mysqli->query("SELECT ut.thingid,
						t.internal_order, t.is_container, t.container,
						t.title, t.description,
						t.thumb_tiny, t.thumb_medium, t.thumb_big
						FROM `things` AS t, user_things AS ut
							WHERE ut.userid = ".intval($userid)."
							AND ut.thingid = t.thingid
						ORDER BY t.internal_order ASC
						");
if($result)
{
	while($thing = mysqli_fetch_assoc($result)){
		$things[] = $thing;
	}
}
@mysqli_free_result($result);

$user['things'] = $things;


//output

@json_header();

echo json_encode($user);

$mysqli->Disconnect();