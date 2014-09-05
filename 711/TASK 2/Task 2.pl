#!/usr/bin/perl
use YAML::Syck;

$data = LoadFile("TestSig.yaml");
%sigFile = %$data;
%name = $sigFile{'name'};
print %name;
$en = $name{'en'};
print $en;
