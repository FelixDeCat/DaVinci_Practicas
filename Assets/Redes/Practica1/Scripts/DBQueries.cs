using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class DBQueries{
    public const string LOG_IN_REQUEST = "SELECT * FROM `usernames` WHERE `username` = '%1' AND `pass` LIKE '%2'";
    public const string CHECK_USERNAME = "SELECT * FROM `usernames` WHERE `username` LIKE '%1'";
    public const string REGISTER_REQUEST = "INSERT INTO `usernames` (`username`, `pass`) VALUES ('%1', '%2')";
}
