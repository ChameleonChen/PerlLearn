#!usr/bin/perl

sub check_tab {
	my ($file_name) = @_;
  my $line;
  my $num = 0;

  open(fp_txt_file, "< $file_name") || die "can not open file: $file_name";
  while (<fp_txt_file>)
  {
    $num++;
    if ($_ =~ /\t/g) {exit($num);}
  }
}

sub usage{
  print "Usage:\n";
  print "  - perl $0 xxx.txt\n";
  exit(1);
}

#参数合法性检查
if ((0 != $#ARGV) || ($ARGV[0] !~ /\.txt$/)) 
{
	& usage();
}

& check_tab($ARGV[0]);

