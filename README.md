# sds011
SDS011 is a project initiated by me. Basically it is a software that monitors air quality using the sds011 sensor.

<p>You may refer to my blogpost for more details <a href="https://pythondatascienceprojectsblog.blogspot.com/2022/02/python-ml-analyzing-air-quality.html">Python ML Analyzing Air Quality Obtained from SDS011 Sensor via VB6/PHP</a> 
<p><b>It consists of the following Programs:</b></p>
<ol> <li>Visual Basic 6(front end) and reads the data coming fom the SDS011 sensor</li> 
     <li> PHP is used for decoding data collected by the front end application and saves the decoded information to MysSql database</li>
     <li>Python is used to analyse the collected data</li>
</ol>
     
<p><b>DISCLAIMER:</b>
<br>This is just a personal project so pls expect the quality of the code(naming convention, coding algorith, etc) are not of commercial quality.
     
<p>Please note that this project is still on-going and below are my current issues as of 02/25/2022:
<ol> <li>Python Program</li>
     <ul>
         <li>command line withn parameters to accept date</li> 
         <li>panda get average per hour</li>
         <li>create the html template</li>
         <li>compute air quality</li>
         <li>plotting should be average per hour</li>
         <li>improve appearance of mplotlib graph(possible to discard this and use bootstrap line graph)</li> 
     </ul>     
     <li>vb realtime monitor</li>
     <ul>
         <li>add form icon</li> 
         <li>To check possible bug when just cleared picture 1, it seems 0 second does start at x = 0</li>
         <li>enlarge fonts further</li>
         <li>compute air quality</li>
         <li>make the blue and red line thinner</li>
     </ul>         
     <li>vb dashboard</li>
     <ul>
         <li>add new selection parameters(still in conceptualization stage)</li> 
         <li>compute the overall air quality based on date selected in selection parameter</li>
         <li>add new button to hide/display the data grid</li>
         <li>compute and update the 24-hour air quality display based on the entered date in selection parameter</li>
         <li>make the blue and red line thinner</li>
     </ul> 
     <li>HTML File</li>
     <ul>
         <li>reshuffle the colors assigned to statistical values</li> 
     </ul>        
</ol>     

<p> As of March 4, 2022 all issues has been resolved but I still consider it in Develomen but uploaded all files. The remaining issue is to make the selection screen work. And also, planning to use online bootstrap instead of using the bootstrap that I have downloaded with AdminLTE dashboard.
