#!C:/xampp/perl/bin/perl.exe
use CGI qw(:standard);
use strict;
use warnings;

# Load CGI and get current time
my $cgi = CGI->new();
my $current_time = localtime();

# Example user login check (In real applications, use session management)
my $webmaster_logged_in = param('user') eq 'webmaster' ? 1 : 0;

# Generate a greeting based on the time of access
my $greeting;
my $hour = (localtime)[2];  # Get the current hour (0-23)

if ($hour >= 5 && $hour < 12) {
    $greeting = "Good morning!";
} elsif ($hour >= 12 && $hour < 17) {
    $greeting = "Good afternoon!";
} elsif ($hour >= 17 && $hour < 21) {
    $greeting = "Good evening!";
} else {
    $greeting = "Good night!";
}

# Output the HTML header
print $cgi->header('text/html');

# Start the HTML output
print <<HTML;
<html>
    <head>
        <title>Greeting Page</title>
    </head>
    <body>
        <center>
            <h2>$greeting</h2>
            <p>Access Time: $current_time</p>
HTML

# Check if the webmaster is logged in
if ($webmaster_logged_in) {
    print "<p>Welcome back, Webmaster!</p>";
} else {
    print "<p>You are not logged in as Webmaster.</p>";
}

# End the HTML output
print <<HTML;
        </center>
    </body>
</html>
HTML
