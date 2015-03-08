<?php

/*
* Database Class
* used throughout the backend to access the instance of the database
*/
class DB extends mysqli
{
    private $connected = false;
    private static $connection = false;

	/*-----------
	* Constructor
	*/
	private function __construct()
    {
		//Michael Berkowski (2012): connect to database server in class that extends mysqli.
		//URL: http://stackoverflow.com/a/13435529/426266
		parent::__construct("localhost", "mdb_user", "BxGswAav6enSTFJP", "minimalism", 3306);

		self::$connection = $this;

		if (self::$connection->connect_errno){
			die("Failed to connect to MySQL: (" . self::$connection->connect_errno . ") " . self::$connection->connect_error);
		}
		else
		{
			$this->connected = true;
		}

		//some helpful db config
		@self::$connection->set_charset("utf8");
		//@mysqli_query(self::$connection, "SET `wait_timeout` = 86400");
		//@mysqli_query(self::$connection, "SET `interactive_timeout` = 86400");

		return;
    }

	/*----------
	* Destructor
	*/
    public function __destruct()
    {
        $this->Disconnect();
    }

	/*----------
	* Disconnect
	*/
	public function Disconnect()
	{
		if($this->connected)
		{
			mysqli_close(self::$connection);

			self::$connection = false;
			$this->connected = false;
		}
	}

	/*---------------------
	* Get Database Instance
	*/
	public static function getInstance()
	{
		if (!self::$connection)
		{
			self::$connection = new DB;
		}

		return self::$connection;
	}

	/*-------------
	* Is Connected?
	*/
	public function is_connected(){
		if (self::$connection){
			return true;
		}
		else {
			return false;
		}
	}

}