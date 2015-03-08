<?php

//only execution from within the app
if(!defined('SCRIPT')) die();

function json_header(){
	if(!headers_sent())
	{
		//JSON headers
		//http://www.dzone.com/snippets/php-headers-serve-json
		header('Cache-Control: no-cache, must-revalidate');
		header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
		header('Content-type: application/json');
	}
}