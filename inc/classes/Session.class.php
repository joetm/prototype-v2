<?php

/**
//Session class
//used only for string processing
//see Auth.class.php for session authentification
**/

class Session
{
    private static $_securitytoken;
    private static $_sessionid;

    /*---------------------
    * Create Security Token
    */
    public static function CreateToken($length = 12)
    {
        $length = intval($length);
        if(!$length) $length = 12;

        $allowedchars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!!!@@@###^^^___---";

        $token = null;

        for ($i=0, $x = strlen($allowedchars)-1; $i < $length; $i++) $token .= $allowedchars[rand(0, $x)];

        return $token;
    }

    /*------------------
    * Set Security Token
    */
    public static function SetToken($token)
    {
        self::$_securitytoken = $token;
    }

    /*---------
    * Get Security Token
    */
    public static function GetToken()
    {
        return self::$_securitytoken;
    }

    /*---------
    * Get Session ID
    */
    public static function GetId()
    {
        return self::$_sessionid;
    }

    /*---------
    * Get Session ID
    */
    public static function SetId($id)
    {
        self::$_sessionid = $id;
    }

    /*---------
    * Fetch IP Address of current visitor
    */
    public static function FetchIP()
    {
        return $_SERVER['REMOTE_ADDR'];
    }

}//Session class