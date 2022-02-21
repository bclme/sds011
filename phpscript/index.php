<?php
   include('config.php');   

    error_reporting(0);
    
$file_handle = fopen('c:\wamp64\www\sds011\45.txt', 'r');
$binarydata = fread($file_handle, filesize('c:\wamp64\www\sds011\45.txt'));
fclose($file_handle);




   // $binarydata = "ªÀ/À-9«"; 
    $data = unpack('H2header/H2commander/vpm25/vpm10/Sid/H2checksum/H2tail', $binarydata);
    
    //echo sprintf("PM2.5: %dµg/m³\nPM10:  %dµg/m³\n", $data['pm25']/10, $data['pm10']/10); 
    //echo "<br>";
    //echo sprintf("PM2.5: %dg/m PM10:  %dg/m\n", $data['pm25']/10, $data['pm10']/10); 
    //echo "<br>";

$myfile = fopen('c:\wamp64\www\sds011\47.txt', 'w');
$txt = $data['pm25']/10 . "|" . $data['pm10']/10;
fwrite($myfile, $txt);
fclose($myfile);  
If (unlink('c:\wamp64\www\sds011\45.txt')) {
  // file was successfully deleted
} else {
  // there was a problem deleting the file
}  
$pm25 = $data['pm25']/10;
$pm10 = $data['pm10']/10;
if ($pm25 <> '0') {
$query = "INSERT INTO sds011 
  (guid, pm25, pm10)
  VALUES (now(), '$pm25', '$pm10')";

mysqli_query($connect, $query);
}
?>