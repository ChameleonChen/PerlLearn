#!usr/bin/perl
use Spreadsheet::XLSX;
use Text::Iconv;

#列索引为0表示分类，1表示软件名，3表示应用名称
my $Index_Type = 0;
my $Index_Software = 1;
my $Index_App = 2;
my $type_name = "";
my $software_name = "";
my @type_array = ();
my $type_array_ref = \@type_array;
my @software_array = ();
my $software_array_ref = \@software_array;
my $type_num = 0;
my $software_num = 0;

sub write_appgroup_file{
  my ($fp, $appgroup) = @_;
  
}

sub finalize_software{
  my @new_software_array_name = ();
  
  & print_debug("Process a new Software, finalize previous Software first");
  
  #保存当前分类的当前软件

  
  #清零操作

}
  
sub finalize_type{
  my ($appgroup_array) = @_;

  & print_debug("Process a new Type, finalize previous Type first");

  
  #保存当前分类的当前软件

  
  #保存当前分类的软件列表

  
  #清零操作

}

sub parse_excel_cell{
  my ($sheet, $row, $col, $appgroup_array) = @_;
  my $app_Name = "";  
  
  my $cell = $sheet -> {Cells} [$row] [$col];
  if ($cell && $col <= $Index_App && $row >= 1)
  {
    printf("( %s , %s ) => %s\n", $row, $col, $cell -> {Val});
    if ($col == $Index_Type)
    {
      if ($type_name ne "") {& finalize_type($appgroup_array);}
      
      #设置type内容
      $type_name = $cell -> {Val};
      & print_debug("type_name : $type_name");
    }
    elsif($col == $Index_Software)
    {
      if ($software_name ne "") {& finalize_software();}

      #设置software内容
      $software_name = $cell -> {Val};
      & print_debug("software_name : $software_name");
    }
    elsif($col == $Index_App)
    {
      #设置app内容
      $app_Name = $cell -> {Val};
      print_debug("app_Name : $app_Name");
      
      #保存当前软件的当前应用
    }
  }
}

sub parse_excel_file{
  my ($excel_name) = @_;
  my @appgroup_array = ();
  my $appgroup_array_ref = \@appgroup_array;
  my $converter = Text::Iconv -> new("utf-8", "gb2312");
  my $excel = Spreadsheet::XLSX -> new($excel_name, $converter);
  
  foreach my $sheet (@{$excel -> {Worksheet}})
  {
    printf("Sheet: %s\n", $sheet->{Name});
        
    if ($sheet->{Name} ne "V7") {next;}
    
    $sheet-> {MaxRow} ||= $sheet-> {MinRow};
    foreach my $row ($sheet -> {MinRow} .. $sheet -> {MaxRow}) 
    {
      $sheet -> {MaxCol} ||= $sheet -> {MinCol};
      foreach my $col ($sheet -> {MinCol} ..  $sheet -> {MaxCol}) 
      {
        & parse_excel_cell($sheet, $row, $col, $appgroup_array_ref);
      } 
    }
    
    & finalize_type($appgroup_array_ref);
  }
  
  return $appgroup_array_ref;
}

1;


