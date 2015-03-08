<?php

die('no ordering (demonstration-only)');

//simple backend for re-ordering things

define('SCRIPT', 'REORDER');


//init the backend
require_once('../inc/init_app.php');
require_once('../inc/functions.php');


//input


//var_dump($_REQUEST);
//die;


$userid = (isset($_REQUEST['userid']) ? intval($_REQUEST['userid']) : false);
if(!$userid)
{
	if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 400 Bad Request');
	@json_header();
	echo json_encode(array("error"  => 'Invalid user id.' ));
	die;
}

if(!isset($_REQUEST['things']) || !$_REQUEST['things'])
{
	if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 400 Bad Request');
	@json_header();
	echo json_encode(array("error"  => 'No things to re-order.' ));
	die;
}


$things = json_decode($_REQUEST['things']);


//get DB access
$mysqli = DB::getInstance();


//$sql_string = '';
foreach($things as $key => $value)
{
	$id = str_replace("thing_", "", $key);

	//single row updates in a loop are not a good idea
	//but transactions for mysqli are currently not documented:
	//http://php.net/manual/de/mysqli.begin-transaction.php
	$result = $mysqli->query("UPDATE `things`
							SET `internal_order` = ".intval($value)."
							WHERE `thingid` = ".intval($id)."
							LIMIT 1
						");
}
//$sql_string = rtrim($sql_string, ',');


@json_header();

if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 200 OK');

exit( json_encode('OK') );
