#!/usr/bin/perl
package MyXML;
@EXPORT = qw(check_class_id);

sub check_class_id{
  my ($app_id, $data) = @_;
  my $class_id = $data->{$app_id}->{"cmcc_class_id"};
  
}

sub get_xdr_code{
  my ($app_id, $data) = @_;
  my $xdr_code = "";
  

  return $xdr_code;
}

1;
