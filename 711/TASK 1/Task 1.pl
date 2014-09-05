#!/usr/bin/perl

my $repalceStr = "popularity";
my $fileName = "TestSig.txt";

open(INPUT, $fileName);

my @file = <INPUT>;
close(INPUT);

substr($file[10], 2, 10) = $repalceStr;

open(OUTPUT, ">".$fileName);
print OUTPUT @file;