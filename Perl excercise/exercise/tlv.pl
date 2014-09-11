
my $base_name = "name";
my $base_priority = "priority";
my $totalLength = 0;

#��ȡTLV��T��ֵ
sub get_T_Type{
  my ($name)= @_; 
  
  if ($name eq $base_name) {return 1;}
  elsif ($name eq $base_priority) {return 2;}
  else {& print_error("Invalid name $name, can not get type");}
}

#���ֽ����
sub write_TLV_1{
  my($fp, $type, $value) = @_;
  
  & print_debug("write_TLV_1: $type, 1, $value");
  print $fp pack("n2", $type, 1);
  print $fp pack("c1", $value);;
}

#˫�ֽ����
sub write_TLV_2{
  my($fp, $type, $value) = @_;
  
  & print_debug("write_TLV_2: $type, 2, $value");
  print $fp pack("n2", $type, 2);
  print $fp pack("n1", $value);
}

#4�ֽ����
sub write_TLV_4{
  my($fp, $type, $value) = @_;
  
  & print_debug("write_TLV_4: $type, 4, $value");
  print $fp pack("n2", $type, 4);
  print $fp pack("N1", $value);
}

#�ַ������
sub write_TLV_String{
  my($fp, $type, $length, $value) = @_;
  
  & print_debug("write_TLV_String: $type, $length, $value");
  print $fp pack("n2", $type, $length);
  print $fp pack("a$length", $value);
}

#�ַ������
sub write_TLV_ASCII{
  my($fp, $type, $length, $value) = @_;
  my $tlen = $length/2;

  & print_debug("write_TLV_ASCII: $type, $tlen, $value");
  print $fp pack("n2", $type, $tlen);
  print $fp pack("H$length", $value);
}

sub write_key_uint8{
  my($fp, $key, $value) = @_;
  my $type;
  
  & print_debug("write_key_uint8: $key, $value");
  
  #����key��ȡT��ֵ
  $type = get_T_Type($key);
  
  #���1�ֽ�TLV
  & write_TLV_1($fp, $type, $value);
  
  $totalLength += 5;
}

sub write_key_bool{
  my($fp, $key, $value) = @_;
  my $type;
  my $valueFinal;
  
  & print_debug("write_key_bool: $key, $value");
  
  #����key��ȡT��ֵ
  $type = get_T_Type($key);
  
  #��true��falseת��Ϊ1��0
  if ($value eq "true"){$valueFinal = 1;}
  elsif ($value eq "false"){$valueFinal = 0;}
  else {&print_error("Invalid bool value : $value");}
  
  #���1�ֽ�TLV�������BOOL_T��1���ֽ�
  & write_TLV_1($fp, $type, $valueFinal);
  
  $totalLength += 5;
}

sub write_key_uint16{
  my($fp, $key, $value) = @_;
  my $type;
  
  & print_debug("write_key_uint16: $key, $value");
  
  #����key��ȡT��ֵ
  $type = get_T_Type($key);
  
  #���2�ֽ�TLV
  & write_TLV_2($fp, $type, $value);
  
  $totalLength += 6;
}

sub write_key_uint32{
  my($fp, $key, $value) = @_;
  my $type;
  
  & print_debug("write_key_uint32: $key, $value");
  
  #����key��ȡT��ֵ
  $type = get_T_Type($key);
  
  #���4�ֽ�TLV
  & write_TLV_4($fp, $type, $value);
  
  $totalLength += 8;
}

sub write_key_string{
  my($fp, $key, $value) = @_;
  my $type;
  
  & print_debug("write_key_string: $key, $value");
  
  #����key��ȡT��ֵ
  $type = get_T_Type($key);
  
  #���string
  & write_TLV_String($fp, $type, length($value), $value);
  
  $totalLength += 4;
  $totalLength += length($value);
}

sub write_key_ascii{
  my($fp, $key, $value, $value_len) = @_;
  my $type;
  
  & print_debug("write_key_ascii: $key, $value, $value_len");
  
  #����key��ȡT��ֵ
  $type = get_T_Type($key);
  
  #���string
  & write_TLV_ASCII($fp, $type, $value_len, $value);
  
  $totalLength += 4;
  $totalLength += $value_len / 2;
}

1;