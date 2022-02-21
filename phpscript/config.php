<?php

  $servername = "localhost";
  $username = "root";
  $password = "";
  $dbname = "sds011";
  
  $connect = @mysqli_connect($servername, $username, $password, $dbname);

  if (mysqli_connect_errno()) {

    die("<pre><h1>Sorry, we are experiencing a little Downtime!</h1></pre>");

  }

?>