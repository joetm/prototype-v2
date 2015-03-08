<?php

//report all errors
@error_reporting(-1);

if(!defined('DIRECTORY_SEPARATOR')) define('DIRECTORY_SEPARATOR', '/');
//shorter alias
define('DIR_SEP', DIRECTORY_SEPARATOR);

define('_PATH_WEBROOT', realpath(dirname(__FILE__).DIR_SEP.'..'));
define('_PATH_INC', realpath(dirname(__FILE__).DIR_SEP.'../inc'));


//JSON CSRF protection
//https://docs.angularjs.org/api/ng/service/$http#json-vulnerability-protection
if(!defined('PHP_EOL')) { define('PHP_EOL', "\n"); }
define('ANGULAR_JSON_PREFIX', ")]}'," . PHP_EOL);


if (!defined('PHP_EOL')) define('PHP_EOL', (DIRECTORY_SEPARATOR == '/') ? "\n" : "\r\n");

define("TIME_NOW", time());


function headers($str)
{
	if(!headers_sent())
	{
		@header($str);
	}
}



/*
* Class Autoloading Helper Function
*/
function pathsetup($className)
{
	$directory = _PATH_INC . DIR_SEP . 'classes' . DIR_SEP;
	$fileNameFormat = '%s.class.php';

	$path = $directory.sprintf($fileNameFormat, $className);
	//die($path);
	if(file_exists($path))
	{
		require_once $path;
		return;
	}
}
/**
* Class Autoloading
*/
if( function_exists('spl_autoload_register') )
{
	function autoLoader($className){
		pathsetup($className);
	}
	spl_autoload_register('autoLoader');
}
else
{
	function __autoload($className)
	{
		pathsetup($className);
	}
}