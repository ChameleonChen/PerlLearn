#!/usr/bin/perl
use YAML::Syck;
#use Data::Dumper;

#my $yaml = LoadFile("TestSig.yaml");
#DumpFile("my.yaml", $yaml);

#my %fileHash = %$yaml;
#print %fileHash;

#print $fileHash{popularity};

my $data = LoadFile("TestSig.yaml");




=pod
my %hash = ( hehe => 'hehe', haha => 'haha');
print Dumper(\%hash);
print $hash{hehe};
=cut