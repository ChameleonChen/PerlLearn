#!/usr/bin/perl

use strict;
use YAML::Syck;
use Data::Dumper;

main();

sub main() {
	&parse();
}

sub parse() {
	my $txtFileName;
	my $txtFile;
	
	$txtFile = $ARGV[0];
	if (!-f $txtFile) {
		&error("txt file is not exsit\n");
		return;
	}
	
	$txtFileName = &get_file_name($txtFile);
	
	if ($txtFileName =~ /\s/) {
		&error("the file name can not has blank character\n");
		return;
	}
	
	my %yamlHash = &load_and_compile_to_yaml($txtFile);
	
	&check_txt(%yamlHash);
	return;
}

sub check_txt() {
	my (%yamlHash) = @_;
	
	if ($yamlHash{"enable"} ne "true" && $yamlHash{"enable"} ne "false") {
		&error("check_txt: enable must be true or false\n");
	}
	
	if ($yamlHash{"priority"} =~ /\D/) {
		&error("check_txt: priorty must be number\n");
	}
}

sub get_file_name() {
	my ($file, $suffix) = @_;
	my $fileName;
	
	my @fileTmp = split(/\//, $file);
	if ($fileTmp[@fileTmp - 1] =~ /(?=\.txt$)/) {
		$fileName = $&;
	}
	else {
		&error("can not get the file name\n");
		return;
	}
	
	return $fileName;
}

sub load_and_compile_to_yaml() {
	my ($file) = @_;
	my $yamlFile;	#要保存的yaml后缀文件
	
	my $fileP = LoadFile($file);
	if ($file =~ /.*(?=\.txt)/) {
		$yamlFile = $&.".yaml";
	}
	else {
		error("load_and_compile_to_yaml: there is no txt file\n");
	}
	
	open(OP, ">>".$yamlFile);
	print OP Dumper($fileP);
	
	return %$fileP;
}

sub error() {
	my ($str) = @_;
	print "txt_parse: ".$str."\n";
	exit;
}