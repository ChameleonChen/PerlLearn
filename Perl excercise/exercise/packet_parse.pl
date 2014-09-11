#!/usr/bin/perl -w
use Net::TcpDumpLog;
use NetPacket::Ethernet;
use NetPacket::TCP;
use NetPacket::UDP;

my $BOOL_TRUE = 1;
my $BOOL_FALSE = 0;

#获取唯一标识一条流的五元组信息：src_ip, dest_ip, src_port, dest_port, l4_protocol
sub get_stream_key {
  my ($raw_pkt) = @_;
  my ($eth_obj, $ip_obj, $tcp_obj, $udp_obj);
  my $l4_protocol;
  my %stream_key = ();

  #解析当前包;
  $eth_obj = NetPacket::Ethernet->decode($raw_pkt);
  $ip_obj = NetPacket::IP->decode($eth_obj->{data});
  $stream_key{"src_ip"}  = $ip_obj->{src_ip};
  $stream_key{"dest_ip"} = $ip_obj->{dest_ip};
  $stream_key{"proto"} = $ip_obj->{proto};
  $l4_protocol = $ip_obj->{proto};
  if ($l4_protocol eq NetPacket::IP::IP_PROTO_TCP)
  {
    $tcp_obj = NetPacket::TCP->decode($ip_obj->{data});
    $stream_key{"src_port"}  = $tcp_obj->{src_port};
    $stream_key{"dest_port"}  = $tcp_obj->{dest_port};
    $stream_key{"data"} = $tcp_obj->{data};
  }
  elsif ($l4_protocol eq NetPacket::IP::IP_PROTO_UDP)
  {
    $udp_obj = NetPacket::UDP->decode($ip_obj->{data});
    $stream_key{"src_port"}  = $udp_obj->{src_port};
    $stream_key{"dest_port"}  = $udp_obj->{dest_port};
    $stream_key{"data"} = $udp_obj->{data};
  }
  
  return %stream_key;
}

#判断同一条流的两个包是否属于同一方向
sub is_same_direction {
  my ($key1, $key2) = @_;
  my $key1_src_ip = $key1->{"src_ip"};
  my $key1_dest_ip = $key1->{"dest_ip"};
  my $key1_src_port = $key1->{"src_port"};
  my $key1_dest_port = $key1->{"dest_port"};
  my $key2_src_ip = $key2->{"src_ip"};
  my $key2_dest_ip = $key2->{"dest_ip"};
  my $key2_src_port = $key2->{"src_port"};
  my $key2_dest_port = $key2->{"dest_port"};
    
  #两个包的会话方向相同
  if (($key1_src_ip eq $key2_src_ip) && ($key1_dest_ip eq $key2_dest_ip) && 
      ($key1_src_port eq $key2_src_port) && ($key1_dest_port eq $key2_dest_port))
  {
    return $BOOL_TRUE;
  }
  
  return $BOOL_FALSE;
}

#判断两个包是否属于同一条流
sub is_same_stream {
  my ($key1, $key2) = @_;
  my $key1_src_ip = $key1->{"src_ip"};
  my $key1_dest_ip = $key1->{"dest_ip"};
  my $key1_src_port = $key1->{"src_port"};
  my $key1_dest_port = $key1->{"dest_port"};
  my $key2_src_ip = $key2->{"src_ip"};
  my $key2_dest_ip = $key2->{"dest_ip"};
  my $key2_src_port = $key2->{"src_port"};
  my $key2_dest_port = $key2->{"dest_port"};
  
  #比较四层协议
  if ($key1->{"proto"} ne $key2->{"proto"}){return $BOOL_FALSE;}
  
  if (!exists($key1->{"src_port"}) || !exists($key1->{"dest_port"}) ||
      !exists($key2->{"src_port"}) || !exists($key2->{"dest_port"}))
  {
    return $BOOL_FALSE;
  }
  
  #两个包的会话方向相同
  if (($key1_src_ip eq $key2_src_ip) && ($key1_dest_ip eq $key2_dest_ip) && 
      ($key1_src_port eq $key2_src_port) && ($key1_dest_port eq $key2_dest_port))
  {
    return $BOOL_TRUE;
  }
  
  #两个包的会话方向相反
  if (($key1_src_ip eq $key2_dest_ip) && ($key1_dest_ip eq $key2_src_ip) && 
      ($key1_src_port eq $key2_dest_port) && ($key1_dest_port eq $key2_src_port))
  {
    return $BOOL_TRUE;
  } 
  
  return $BOOL_FALSE;
}

sub print_session_key {
  my ($fp, $stream_key) = @_;
  my $src_ip = $stream_key->{"src_ip"};
  my $dest_ip = $stream_key->{"dest_ip"};
  my $src_port = $stream_key->{"src_port"};
  my $dest_port = $stream_key->{"dest_port"};
  my $proto = $stream_key->{"proto"};

  print "$src_ip:$src_port->$dest_ip:$dest_port($proto)\n";
  print $fp "$src_ip:$src_port->$dest_ip:$dest_port($proto)\n";
}

#输出十六进制串
sub print_data_hex {
    my ($fp, $str) = @_;
    my $i = 0;
    my @arr = split //, $str;
    
    for my $c (@arr)
    {
        printf $fp ("%02x ", ord($c));
        $i++;
        if (0 == ($i % 16)){print $fp "\n";}
    }
    print $fp "\n";
}

#解析pcap包，提取如下信息：源目的地址，源目端口，四层协议，负载数据
sub parse_pcap_stream {
  my ($pcap_file) = @_;
  my %stream_key_req = ();
  my %stream_key_res = ();
  my %current_key = ();
  my %stream_info = ();
  my $stream_key_req_ref = \%stream_key_req;
  my $stream_key_res_ref = \%stream_key_res;
  my $current_key_ref = \%current_key;
  my $stream_info_ref = \%stream_info;
  
  #读取pcap文件

  
  #获取第一个包的五元组

 
  #基于流拼装请求和回应方向的数据
  foreach my $index (@indexes_array)
  {
    #判断当前包是请求还是回应方向
  }
  
  return $stream_info_ref;
}

1;