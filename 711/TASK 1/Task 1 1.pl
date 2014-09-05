
my $fileName = "TestSig.txt";
my $sigStr = "perference";
my $replaceStr = "popularity";

open(INPUT, $fileName);
my @file = <INPUT>;
close(INPUT);

print length(@file);

for (my $i = 0; $i < length(@file); $i++) {
	if ($file[$i] =~ /perference/) {
		substr($file[$i], 2, 10) = "popularity";
		print $file[$i];
	}
}

open(OUTPUT, ">".$fileName);
print OUTPUT @file;