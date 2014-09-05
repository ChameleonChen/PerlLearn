#!/usr/bin/perl

my $fileName = "TestSig.txt";

# 将文件读入数组
open(INPUT, $fileName);
my @file = <INPUT>;
close(INPUT);

# 对数组的每一行进行匹配替换
=pod
for (my $i = 0; $i < @file; $i++) {
	if ($file[$i] =~ s/perference/popularity/) {
		print $file[$i];
	}
}
=cut

# 将整个文件当成一个变量进行匹配替换
$fileData = join("", @file, "");
print $fileData;
$fileData =~ s/perference/popularity/;

# 将数组写入文件
open(OUTPUT, ">".$fileName);
#print OUTPUT @file;
print OUTPUT $fileData;
close(OUTPUT);