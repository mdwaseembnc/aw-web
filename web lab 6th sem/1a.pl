#!C:/xampp/perl/bin/perl.exe
#this is a here-document
print<<here;
Content-type:text/html\n\n
<html>
<center>
 <table border=1>
 <tr>
 <th>ENV_VARIABLES</th><th>Value</th>
 </tr>
here
#end of here document
#display values in a table
foreach $i(sort keys %ENV)
{
print "<tr><td>$i</td><td>$ENV{$i}</td></tr>";
}
print<<here
 </table>
 </center>
</html>
here
