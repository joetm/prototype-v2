<?php

//for debugging
error_reporting(E_ALL | E_NOTICE | E_STRICT);

define('SCRIPT', 'LOGIN');

require_once('../inc/init_app.php');


Auth::Logout();

if(!headers_sent())
{
	header('Location: ../');
}
