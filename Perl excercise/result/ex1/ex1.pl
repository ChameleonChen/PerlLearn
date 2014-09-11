#!/usr/bin/perl
use warnings;
use strict;

#base info
my $base_name = "name";
my $base_name_cn = "cn";
my $base_name_en = "en";
my $base_enable = "enable";
my $base_priority = "priority";

#detect info signature
my $detect_signature = "signature";
my $detect_pattern = "pattern";
my $detect_sig_ac = "ac";


sub open_log_file {
  my $log_file = $0;
  
  $log_file =~ s/\.pl/\.log/; 
  open (fp_log_file, "> $log_file");
}

sub close_log_file {
  close(fp_log_file);
}

sub print_error {
  my ($error_string) = @_;
  
  print "###Error###: $error_string\n";
  print fp_log_file "Error: $error_string\n";
  exit(1);
}

sub print_debug {
  my ($debug_string) = @_;
  
  print fp_log_file "$debug_string\n";
}

sub print_info {
  my ($debug_string) = @_;
  
  print "$debug_string\n";
  print fp_log_file "$debug_string\n";
}

sub parse_txt_file{
  my ($file_name) = @_;
  
  & print_info("parse txt file: $file_name");
}

sub parse_pcap_file{
  my ($file_name) = @_;
  
  & print_info("parse pcap file: $file_name");
}

sub parse_xml_file{
  my ($file_name) = @_;
  
  & print_info("parse xml file: $file_name");
}

sub parse_xlsx_file{
  my ($file_name) = @_;
  
  & print_info("parse xlsx file: $file_name");
}

sub read_all_file{
  my ($source_dir) = @_;
  
  & print_info("read dir: $source_dir");
}

sub usage{
  print "Usage:\n";
  print "  - perl $0 xxx.txt\n";
  print "  - perl $0 xxx.pcap\n";
  print "  - perl $0 xxx.xml\n";  
  print "  - perl $0 xxx.xlsx\n";
  print "  - perl $0 dir\n";
  exit(1);
}

#主程序

& open_log_file();

if ($#ARGV == 0)
{
  if (!(-e $ARGV[0])) {& print_error("$ARGV[0] is not exist");}
  if (-f $ARGV[0])
  {
    if ($ARGV[0] =~ /\.txt$/) {& parse_txt_file($ARGV[0]);}
    elsif ($ARGV[0] =~ /\.pcap$/) {& parse_pcap_file($ARGV[0]);}
    elsif ($ARGV[0] =~ /\.xml$/) {& parse_xml_file($ARGV[0]);}
    elsif ($ARGV[0] =~ /\.xlsx$/) {&parse_xlsx_file($ARGV[0]);}
    else {& usage();}
  }
  else {& read_all_file($ARGV[0]);}
}
else {& usage();}

& print_info("Hello Perl");

& close_log_file();

