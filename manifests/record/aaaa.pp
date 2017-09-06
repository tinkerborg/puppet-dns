# == Define: bind_dns::record::aaaa
#
# Wrapper of bind_dns::record to set AAAA records
#
define bind_dns::record::aaaa (
  $zone,
  $data,
  $ttl = '',
  $host = $name,
  $data_dir = $::bind_dns::server::config::data_dir,
) {

  $alias = "${name},AAAA,${zone}"

  bind_dns::record { $alias:
    zone     => $zone,
    host     => $host,
    ttl      => $ttl,
    record   => 'AAAA',
    data     => $data,
    data_dir => $data_dir,
  }
}
