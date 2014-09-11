#!/usr/bin/perl

#base info
my $base_name_en = "en";

#detect info signature
my $detect_pattern = "pattern";
my $detect_sig_ac = "ac";

my $ac_count = 0;

#check value bool
sub check_value_bool{
  my($key, $value) = @_;
 
}

#check value number
sub check_value_number{
  my($key, $value) = @_;

}


sub check_name_space{
  my ($item, $value) = @_;
  
}

#get rule name
sub check_rule_name{
  my ($data) = @_;
  my ($key, $value);
  my $name_en = ""; 
  
  #根据Key再进一步获取rule name en
  
  return $name_en;
}

#ac pattern
sub check_ac_pattern{
  my ($value) = @_;
  my $pattern_len;
  
  #检查ac pattern的长度是否过短
  $pattern_len = length($value);
  if ($pattern_len <= 5)
  {
    & print_info("ac pattern is too short, ac pattern: \"$value\"");
  } 
}

#ac pattern list
sub check_ac_pattern_list{
  my ($data) = @_;
  my $pattern_number;
  
  if (0 gt $#$data) {& print_error("Invalid pattern count");}
  
  #遍历数组
}

#ac
sub check_detect_sig_ac{
  my ($data) = @_;
}

#signature item
sub check_detect_signature_item{
  my ($item_number, $data) = @_;
  my ($key, $value);
  
  & print_debug("check_detect_signature_item start, item No $item_number");
      

  & print_debug("check_detect_signature_item end, item No: $item_number");
}

#signature
sub check_detect_signature{
  my ($signature_number, $data) = @_;
  my $item_number = 0;
  $ac_count = 0;

  & print_debug("check_detect_signature start, Signature NO $signature_number");
  
  #遍历数组
  
  & print_debug("check_detect_signature end, Signature NO $signature_number");
}

#signature为一个数组，元素为hash:
sub check_detect_signature_list{
  my ($data) = @_;
  my ($key, $value);
  my $signature_number = 0;
  
  & print_debug("check_detect_signature_list start");
  
  #遍历数组
  
  & print_debug("check_detect_signature_list end");
}

1;
