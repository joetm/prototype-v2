<?php

die('no uploads (demonstration-only)');


//no caching for this page
header( "Expires: Mon, 20 Dec 1998 01:00:00 GMT" );
header( "Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT" );
header( "Cache-Control: no-cache, must-revalidate" );
header( "Pragma: no-cache" );

//error_reporting(0);
error_reporting(-1);@ini_set('display_errors', 1);

define('SCRIPT', 'UPLOAD');

require_once('../inc/init_app.php');
require_once('../inc/functions.php'); //json_header function



if(empty($_FILES))
{
	if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 400 Bad Request');
	@json_header();
	echo json_encode(array('error' => "No file uploaded."));
	die;
}


$userid = intval(@$_POST['userid']);

if(!$userid) {
	if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 400 Bad Request');
	@json_header();
	echo json_encode(array('error' => 'Invalid userid'));
	die;
}


//check XSRF token header would be checked here...





//thumbnail size configuration
$thumbnailsizes = array(
				'tiny'	=> array('w'=>150,'h'=>150),
				'medium'	=> array('w'=>220,'h'=>220),
				'big'		=> array('w'=>400,'h'=>400)
			);


// The path where the file will be stored
$save_path = _PATH_WEBROOT."/images/things/".$userid;




//helper function to resize the images
function image_resize($imgpath, $save_path, $width, $height, $crop = false)
{
	//get filename
	//$info = pathinfo($imgpath);

	$imagename =  basename($imgpath);

	//get extension
	$tmp = explode(".", $imagename);
	$image_ext = array_pop($tmp);
	$imagename = implode("-", $tmp); //this will also have the effect of replacing any dots in the filename
	unset($tmp);

    $imagename = $imagename . '-' . intval($width) .'x'. intval($height) . '.' . $image_ext; //$info['extension'];

	$target = realpath($save_path) . '/' . $imagename;

	$image = new SimpleImage();
	$image->load($imgpath);

	if($width < $height)
	   $image->resizeToHeight($height);
	else
	   $image->resizeToWidth ($width);

	/*
	if($crop)
	{
		$image->yt_crop($width, $height);
	}
	*/

	$return = $image->save($target);

	//if okay, return the image filename
	if($return)
	{
		$return = $imagename;
	}
	//if not okay, return false
	else
	{
		$return = false;
	}

	//var_dump($return);

	return $return;

}//image_resize




//is this the first upload? -> create user directory
if(!is_dir($save_path))
{
	mkdir($save_path);
	chmod($save_path, 0777);
}

$file_extension = "";

$errors = array();

//codofication of the errors of the $_FILES array
$upload_errors = array(
	0 => "No error, the file uploaded with success",
	1 => "Uploaded file exceeds the upload_max_filesize directive in php.ini",
	2 => "Uploaded file exceeds the MAX_FILE_SIZE directive that was specified in the HTML form",
	3 => "Uploaded file was only partially uploaded",
	4 => "No file was uploaded",
	6 => "Missing temporary folder"
);

//maximum file size
$max_file_size = 6000000;

//allowed file extensions
$extension_whitelist = array("jpg", "jpe", "jpeg", "png", "gif");

// valid characters that are allowed in the upload's filename
$valid_chars = '\.A-Za-z0-9_\s\!\(\)\+\=\{\}\[\]\'\"\,\~\-';

// Check post_max_size (see http://us3.php.net/manual/en/features.file-upload.php#73762)
if(isset($_SERVER['CONTENT_LENGTH']))
{
	$POST_MAX_SIZE = ini_get('post_max_size');
	$unit = strtoupper(substr($POST_MAX_SIZE, -1));
	$multiplier = ($unit == 'M' ? 1048576 : ($unit == 'K' ? 1024 : ($unit == 'G' ? 1073741824 : 1)));
	if ((int)$_SERVER['CONTENT_LENGTH'] > $multiplier * (int)$POST_MAX_SIZE && $POST_MAX_SIZE) {
		if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 500 Internal Server Error');
		//This will trigger an upload_error event
		$errors[] = "POST exceeded maximum allowed size.";
	}
}

$upload = @$_FILES['file'];

//validate the upload
if (!$upload || !isset($upload['name']))
{
	$errors[] = "Upload is not valid.";
}
elseif (isset($upload["error"]) && $upload["error"] != 0)
{
	$errors[] = 'File could not be uploaded.'.
	"Error: ".(isset($upload_errors[$upload["error"]]) ? htmlspecialchars($upload_errors[$upload["error"]], ENT_QUOTES) : "<unknown error>");
}
elseif (!isset($upload["tmp_name"]) || !@is_uploaded_file($upload["tmp_name"]))
{
	$errors[] = "Upload unsuccessful. Problem with tmp directory?";
}

//validate the file size
$file_size = @filesize($upload["tmp_name"]);
if (!$file_size || $file_size > $max_file_size)
{
	$errors[] = "File exceeds the maximum allowed size";
}
if ($file_size <= 0) {
	$errors[] = "File size not valid";
}


//sanitize the file name + remove any invalid characters that were previously allowed in the filename
$file_name = trim(preg_replace('/[^'.$valid_chars.']|\.+$/i', "", $upload['name']));
unset($valid_chars);
if (strlen($file_name) === 0) //strlen($file_name) > $MAX_FILENAME_LENGTH
{
	$errors[] = "Invalid file name";
}
//these chars should not be in the html output
$file_name = str_replace(array("'", "\"", "\\", "/", "(", ")"),	"", $file_name);
$file_name = trim($file_name);

//filename still valid?
if(!$file_name)
{
	$errors[] = 'Error uploading file.';
}

if (!preg_match('/\.(' . implode('|', $extension_whitelist) . ')$/i', $file_name))
{
	$errors[] = "Extension is not allowed.";
}


//check if there are errors
if(!empty($errors))
{
	if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 400 Bad Request');
	@json_header();
	echo json_encode($errors);
	die;
}
//upload has passed all security checks
else
{

	//make sure that this filename is unique
	do
	{
		$file_name = uniqid().'_'.$file_name; //uniqid() to never overwrite a file
	}
	while (file_exists($save_path.'/'.$file_name));

	$new_file = $save_path.'/'.$file_name;

	// Process the file
	if(!is_dir($save_path))
	{
		$errors[] = "Could not save the file.";
	}
	else
	{
		if (!@move_uploaded_file($upload["tmp_name"], $new_file))
		{
			$errors[] = "File could not be saved. (" . htmlspecialchars($new_file) . ")";
		}
	}


	//create the thumbnails

	//image processing functions
	require_once(_PATH_WEBROOT."/inc/classes/SimpleImage.php");

	$thumbs = array();

	$thumbs['tiny'] = image_resize($new_file, $save_path, $thumbnailsizes['tiny']['w'], $thumbnailsizes['tiny']['h']);

	$thumbs['medium'] = image_resize($new_file, $save_path, $thumbnailsizes['medium']['w'], $thumbnailsizes['medium']['h']);

	$thumbs['big'] = image_resize($new_file, $save_path, $thumbnailsizes['big']['w'], $thumbnailsizes['big']['h']);

	if(
		$thumbs['tiny']
		&&
		$thumbs['medium']
		&&
		$thumbs['big']
	)
	{
		//all is okay


		//the original image (full-size)
		$thumbs['orig'] = $file_name;


		//save the thumbnails to the DB

		$mysqli = DB::getInstance();


		$time = time();


		//internal_order = 0 => problem


		$result = $mysqli->query("INSERT INTO `things` (
									`thingid`,
									`internal_order`,
									`is_private`,
									`is_container`,
									`container`,
									`title`,
									`description`,
									`image`,
									`thumb_tiny`,
									`thumb_medium`,
									`thumb_big`,
									`upload_date`
								)
								VALUES
								(
									NULL,
									0,
									0,
									0,
									0,
									NULL,
									NULL,
									'" . $mysqli->real_escape_string('things/'.intval($userid).'/'.$thumbs['orig'])   . "',
									'" . $mysqli->real_escape_string('things/'.intval($userid).'/'.$thumbs['tiny'])   . "',
									'" . $mysqli->real_escape_string('things/'.intval($userid).'/'.$thumbs['medium']) . "',
									'" . $mysqli->real_escape_string('things/'.intval($userid).'/'.$thumbs['big'])    . "',
									" . $time . "
								)
					");

		//link this thing to user

		$thumb_id = mysqli_insert_id($mysqli);

		if($thumb_id)
		{
			$result = $mysqli->query("INSERT INTO `user_things` (
									`userid`,
									`thingid`
								)
								VALUES
								(
									".intval($userid).",
									".intval($thumb_id)."
								)
					");

			//update this user's thing count
			if($result) $mysqli->query("UPDATE users SET `possession_count` = `possession_count` + 1");
		}


		//output
		if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 200 OK');
		@json_header();
		echo json_encode($thumbs);

		exit;
	}
	else
	{
		$errors[] = 'Could not create thumbnails';
	}


	if(!empty($errors))
	{
		//output error messages
		if(!headers_sent()) header($_SERVER["SERVER_PROTOCOL"].' 400 Bad Request');
		@json_header();
		echo json_encode(array('error' => $errors));
		die;
	}

}