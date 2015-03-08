<?php

die('no editing (demonstration-only)');


//simple backend for re-ordering things

define('SCRIPT', 'EDITTHING');


//init the backend
require_once('../inc/init_app.php');
require_once('../inc/functions.php');


//input


$INPUT = json_decode($_REQUEST['formdata']);

$thingid = intval($INPUT->thingid);

if(empty($thingid))
{
	if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 400 Bad Request');
	echo json_encode(array('error' => 'Invalid thing'));
	die;
}


//get DB access
$mysqli = DB::getInstance();


$is_container = intval($INPUT->is_container);

//escape title (the title might be used in html attributes, so quotes need to be escaped)
$title = mysqli_real_escape_string($mysqli,
		htmlspecialchars(
			strip_tags(
				strval(@$INPUT->title)
			),
		ENT_QUOTES
		)
	);
//escape description
$description = mysqli_real_escape_string($mysqli,
		htmlspecialchars(
			strip_tags(
				strval(@$INPUT->description)
			)
		)
	);


$result = $mysqli->query("UPDATE `things`
							SET `title` = '".($title)."',
							`description` = '".($description)."',
							`is_container` = ".($is_container)."
							WHERE `thingid` = ".$thingid."
							LIMIT 1
						 ");


@json_header();

header($_SERVER["SERVER_PROTOCOL"].' 200 OK');

echo json_encode('OK');
