<?php

//prototype demonstration with only static data.
//(the code below works with the database on localhost)

/*
Simple backend for listing user profiles
Outputs a list of users in JSON format
*/


define('SCRIPT', 'LIST');

//init the backend
require_once('../inc/init_app.php');
require_once('../inc/functions.php');

//uncomment to test the list page's error message
/*
	if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 404 Not Found');
	@json_header();
	echo json_encode(array('error' => 'No users found.'));
	die;
*/

//get DB access
$mysqli = DB::getInstance();

//query users
$users = false;

//the results would have to be paginated in the final app
$result = $mysqli->query("SELECT u.userid, u.first_name, u.last_name, u.nick_name,
							u.possession_count AS count,
							u.join_date,
							ua.file_name AS avatar
						FROM users as u
							LEFT JOIN user_avatars AS ua ON (ua.userid = u.userid)
							ORDER BY userid ASC
							LIMIT 30
						");
if($result)
{
	$users = array();
	while($user = mysqli_fetch_assoc($result))
	{
		//readable join_date
		$user['join_date'] = date('d-m-Y', $user['join_date']);

		//avatar available?
		$user['avatar'] = ($user['avatar'] ? $user['avatar'] : 'avatars/noavatar.jpg');


		//db query for things
		$things = array();
		$result2 = $mysqli->query("SELECT ut.thingid,
						t.internal_order, t.is_container, t.container,
						t.title, t.description,
						t.thumb_tiny, t.thumb_medium, t.thumb_big
						FROM `things` AS t, user_things AS ut
							WHERE ut.userid = ".intval($user['userid'])."
							AND ut.thingid = t.thingid
						ORDER BY thingid DESC
						");
		if($result2)
		{
			while($thing = mysqli_fetch_assoc($result2)){
				$things[] = $thing;
			}
		}
		@mysqli_free_result($result2);

		$user['things'] = $things;
		unset($things);

		$users[] = $user;
	}
}
@mysqli_free_result($result);


//empty users array or false
if(!$users)
{
	if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 500 Internal Server Error');
	@json_header();
	echo json_encode(array('error' => 'Could not get users.'));
	die;
}

//output

@json_header();

echo json_encode($users);

$mysqli->Disconnect();