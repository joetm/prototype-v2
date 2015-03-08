<?php

/*
development only
used to manually create encrypted passwords

usage:
create_password.php?password=<new-password-to-generate>
*/



require_once('../inc/init_app.php');


$salt = Session::CreateToken(5);


if(isset($_GET['password']))
{
	$password = $_GET['password'];
}
else
{
	$password = 'abcde';
}

/*--------------------*/

echo "password_hash (salt): ";
echo "<br />";
echo $salt;
echo "<br /><br />";
echo "password: ";
echo "<br />";
echo htmlspecialchars($password);
echo "<br /><br />";
echo "ecrypted password: ";
echo "<br />";
echo sha1($salt. $password);
