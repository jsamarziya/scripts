#!/usr/bin/perl

# fixes filenames so that they're legal Windows filenames.
# Converts the following illegal characters: 
#
# \ / : * ? " < > |

use File::Basename;

sub repl {
    my $string = shift;
    my $pat = shift;
    my $repl = "%" . sprintf("%X", ord($pat));
    $string =~ s/\Q$pat/$repl/g;
    return $string;
}

sub convert {
    my $file = shift;
    $file = repl($file, '\\');
    $file = repl($file, '/');
    $file = repl($file, ':');
    $file = repl($file, '*');
    $file = repl($file, '?');
    $file = repl($file, '"');
    $file = repl($file, '<');
    $file = repl($file, '>');
    $file = repl($file, '|');
    return $file;
}

foreach $file (@ARGV) {
    my $dir = dirname($file);
    my $filename = basename($file);
    my $legalfilename = convert($filename);
    my $legalfile = "$dir/$legalfilename";
    if ($legalfilename eq $filename) {
        next;
    }
    if (-e $legalfile) {
	warn("Can't rename $file to $legalfile: file exists\n");
    } else {
	print "Renaming $file to $legalfile\n";
	rename $file, $legalfile or warn("Unable to rename $file: $!\n");
    }
}
