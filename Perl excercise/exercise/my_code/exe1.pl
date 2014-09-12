#!/usr/bin/perl
use strict;

main();

sub main() {
	&fun();
	return;
}

sub fun() {
	my $argc = @ARGV;
	my $argv1;
	my $argv2;
	
	if ($argc == 1) {
		$argv1 = $ARGV[0];
		
		if (-e $argv1) {
			if ((-d $argv1) || (($argv1 =~ /.*\.txt$/) && (-f $argv1)) || (($argv1 =~ /.*\.xml$/) && (-f $argv1))) {
				&one_arg_fuc();
			}
			else {
				&error("is not a txt , xml file, dir");
			}
		} 
		else {
			&error("the file or directory is not exsit");
		}
	}
	elsif ($argc == 2) {
		$argv1 = $ARGV[0];
		$argv2 = $ARGV[1];
		
		if (($argv1 =~ /.*\.txt$/) && (-f $argv1)) {
			if ((-d $argv2) || (($argv2 =~ /.*\.pcap$/) && (-e $argv2))) {
				&two_argv_func();
			}
			else {
				&error("second argv is not a pcap file or directory, or exsit\n");
			}
		}
		else {
			&error("first argv is not a txt file, or exsit\n");
		}
		
	}
	else {
		&error("the argument counts is illegal\n");
	}
	
	return;
}

sub one_arg_fuc() {
	print $ARGV[0]."\n"."HelloPerl"."\n";
	return;
}

sub two_argv_func() {
	print $ARGV[0]."\n".$ARGV[1]."\n"."HelloPerl"."\n";
	return;
}

sub error() {
	my ($errStr) = @_;
	print $errStr;
	return;
}