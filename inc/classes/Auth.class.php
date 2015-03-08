<?php

/*
* Authentification
*/
class Auth {

	//contants allow to change the variables later on
	const NICKNAME	= 'nick_name';
	const SESSION 	= 'session';
	const COOKIE_NAME = 'm';
	const CSRFTOKEN_NAME = 'csrftoken';

	//user stays logged in for 1 month
	const SESSION_TIME = 2629743;

	//easily get the nick_name of the current user, without DB access
	private static $nick_name;

	//easily get the userid of the current user, without DB access
	private static $userid;

	//default: not logged in
	private static $authenticated = false;

	//auth errors
	private static $error = null;


	/*-----
	* Login
	*/
	public static function Login()
	{
		/***database connect***/
		$mysqli = DB::getInstance();


		//get json payload from angular
		//Mike Brant on stackoverflow
		//http://stackoverflow.com/a/15485690/426266
		if(empty($_POST['email']) && empty($_POST['password']))
		{
			$postdata = file_get_contents("php://input");
			$request = json_decode($postdata);
				$_POST['email'] = (isset($request->email) ? $request->email : false);
				$_POST['password'] = (isset($request->password) ? $request->password : false);
			unset($postdata, $request);
		}


		self::$error = null;

		self::$nick_name = null;
		self::$authenticated = false;


		//if a POST request to log the user in was received
		if(isset($_POST['email']) && $_POST['email'])
		{

		    $_POST['email'] = trim($_POST['email']);

			if(empty($_POST['email']))
			{
                self::$error = 'AuthClass Error (Auth.class.php)::The email was left blank.';
                return;
			}
			elseif(false === strpos($_POST['email'], '@')) //this email can't be valid
			{
                self::$error = 'AuthClass Error (Auth.class.php)::Email is not valid.';
                return;
			}

			if(empty($_POST['password']))
			{
                self::$error = 'AuthClass Error (Auth.class.php)::The password was left blank.';
				//self::$username = $_POST['username'];
                return;
			}

			$uresult = $mysqli->query("SELECT *
									FROM `users`
									WHERE `email` = '".$mysqli->real_escape_string($_POST['email'])."'
									LIMIT 1
								");
			$user = false;
			if($uresult)
			{
				$user = mysqli_fetch_assoc($uresult);
			}
			@mysqli_free_result($uresult);


			if(!$user)
			{
				self::$error = "AuthClass Error (Auth.class.php)::Invalid login.";
                return;
			}
			else
			{
				//check validity of login
				if ($_POST['email'] == $user['email']
					&& sha1($user['password_hash'].$_POST['password']) == $user['password'])
				{
					//we found a valid login
					self::$authenticated = true;

					self::$userid	= $user['userid'];
					self::$nick_name= $user[self::NICKNAME];
				}
				else
				{
					self::$error = "AuthClass Error (Auth.class.php)::Invalid user details.";
	                return;
				}


				if (self::$authenticated == true)
				{
					//generate new session id
					$session = sha1(uniqid(rand(), true));

					//set session id
					Session::SetId($session);

					//generate security token
					Session::SetToken(Session::CreateToken());

					//write session info to database
					$mysqli->query("INSERT INTO `user_sessions` (
						`session_id`,
						`userid`,
						`nick_name`,
						`securitytoken`,
						`IP`,
						`user_agent`,
						`session_date`
					) VALUES (
						'".$mysqli->real_escape_string($session)."',
						'".$mysqli->real_escape_string(self::$userid)."',
						'".$mysqli->real_escape_string(self::$nick_name)."',
						'".$mysqli->real_escape_string(Session::GetToken())."',
						'".$mysqli->real_escape_string(Session::FetchIP())."',
						'".$mysqli->real_escape_string($_SERVER['HTTP_USER_AGENT'])."',
						'".time()."'
					)
					");

					/***remember user***/
					setcookie(self::COOKIE_NAME,
							'userid=' . urlencode(self::$userid).'&'.
							self::SESSION  . '=' . urlencode($session),
							(time() + self::SESSION_TIME),
							'/');

					//Set security token as XSRF-TOKEN cookie for angular
					setcookie(self::CSRFTOKEN_NAME,
							Session::GetToken(),
							(time() + self::SESSION_TIME),
							'/');


					self::$authenticated = true;

					self::$error = null;
				}
			}
		}
		//else: use cookie authentification
		elseif(isset($_COOKIE[self::COOKIE_NAME]))
		{
			$cookie = array();
			parse_str($_COOKIE[self::COOKIE_NAME], $cookie);

			//session cleanup - delete sessions that are expired because of the time limit
			$mysqli->query("DELETE FROM `user_sessions`
								WHERE `userid` = '".$mysqli->real_escape_string($cookie['userid'])."'
								AND `session_date` < ".(time() - self::SESSION_TIME)."
							");//"


			/*
			var_dump($cookie[self::SESSION],$cookie['userid'],Session::FetchIP(),$_SERVER['HTTP_USER_AGENT']);
			die;
			//the IP will look like "::1" on windows localhost
			*/

			$sql = "SELECT
						s.session_id AS `sessionid`,
						s.userid,
						s.nick_name,
						s.securitytoken
					FROM `user_sessions` AS `s`
					WHERE s.userid = '".$mysqli->real_escape_string($cookie['userid'])."'
					AND s.session_id = '".$mysqli->real_escape_string($cookie[self::SESSION])."'
					AND s.user_agent = '".$mysqli->real_escape_string($_SERVER['HTTP_USER_AGENT'])."'
					AND s.IP = '".$mysqli->real_escape_string(Session::FetchIP())."'
					AND s.session_date > ".$mysqli->real_escape_string(time() - self::SESSION_TIME)."
				";
			//die($sql);
			$cookie_query_result = $mysqli->query($sql);
			unset($sql);

			$session = false;
			if($cookie_query_result)
			{
				$session = mysqli_fetch_assoc($cookie_query_result);
			}
			@mysqli_free_result($cookie_query_result);


			if(!$session)
			{
				//delete cookies
				setcookie(self::COOKIE_NAME,	"", time() - 3600, '/');
				setcookie(self::CSRFTOKEN_NAME,	"", time() - 3600, '/');

				//session cleanup
				$mysqli->query("DELETE FROM `user_sessions`
								WHERE `userid` = " . intval($cookie['userid']) . "
								AND `session_date` < " . intval(time() - self::SESSION_TIME) . "
								AND s.user_agent = '".$mysqli->real_escape_string($_SERVER['HTTP_USER_AGENT'])."'
								AND s.IP = '".$mysqli->real_escape_string(Session::FetchIP())."'
								");//"

				self::$error = 'AuthClass Error (Auth.class.php)::Session has expired.';
				self::$authenticated = false;

                return;
            }
            else
            {
				self::$userid = $session['userid'];
				self::$nick_name = $session[self::NICKNAME];

				//set the session ID
				Session::SetId($session['sessionid']);

				//set the security token
				Session::SetToken($session['securitytoken']);

				self::$authenticated = true;

				self::$error = null;
			}
		}
		else
		{
			self::$authenticated = false;

			self::$error = 'AuthClass Error (Auth.class.php)::No cookie, no credentials';
		}

		return self::$authenticated;

	} //Login


	/*----------------------
	* Authentification Check
	*/
	public static function isAuthenticated()
	{
		return self::$authenticated;
	}

	/*--------------------------
	* Get Authentification Error
	*/
	public static function getError()
    {
        return self::$error;
    }

	/*------------
	* Get Username
	*/
    public static function getNickName()
    {
        return self::$nick_name;
    }

	/*------------
	* Get Userid
	*/
    public static function getUserid()
    {
        return self::$userid;
    }

	/*------
	* Logout
	*/
	public static function Logout()
    {
		/***database connect***/
		$mysqli = DB::getInstance();

		self::$authenticated = false;

		if(isset($_COOKIE[self::COOKIE_NAME]))
		{
			$cookie = array();
			parse_str($_COOKIE[self::COOKIE_NAME], $cookie);

			//session cleanup
			mysqli_query($mysqli, "DELETE FROM `user_sessions`
									WHERE `userid` = '".$mysqli->real_escape_string($cookie['userid'])."'
									AND `session_id`  = '".$mysqli->real_escape_string($cookie[self::SESSION])."'
								  ");

			//delete the cookie
			setcookie(self::COOKIE_NAME,	"", time() - 3600, '/');
		}

		//delete the cookie
		setcookie(self::CSRFTOKEN_NAME,	"", time() - 3600, '/');
	}

} //Auth class
