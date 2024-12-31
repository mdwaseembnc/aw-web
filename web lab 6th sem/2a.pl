#!/xampp/perl/bin/perl.exe
# Load CGI standard routines
use CGI qw(:standard);

# Take input from the form and store in local variable
my $cmd = param('name');

# Define various greeting messages
my @greet = ("Hello", "Hai", "Nice meeting you", "Have a nice day");

# Choose a message based on a random index
my $index = int(rand(scalar(@greet)));

# Output the HTML with the greeting
print "Content-type: text/html\n\n";
print <<HTML;
<html>
    <center>
        <h2>$cmd, $greet[$index]</h2>
    </center>
</html>
HTML