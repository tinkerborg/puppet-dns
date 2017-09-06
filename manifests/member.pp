# == Class bind_dns::member
#
define bind_dns::member ($domain, $hostname, $ipaddress) {
  bind_dns::record::a { $hostname:
    zone => $domain,
    data => $ipaddress,
    ptr  => true;
  }
}
