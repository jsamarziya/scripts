#!/usr/bin/perl -pn

# $fmt = "%Y-%m-%dT%H:%M:%S+$ms ";
$fmt = "[%H:%M:%S] ";

use Time::HiRes (gettimeofday); 
use POSIX qw(strftime);
$|=1;
while(<>) {
    ($s,$ms) = gettimeofday();
    print strftime "$fmt$_", gmtime($s);
}