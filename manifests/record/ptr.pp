# == Define bind_dns::record::prt
#
# Wrapper for bind_dns::record to set PTRs
#
define bind_dns::record::ptr (
  $zone,
  $data,
  $ttl = '',
  $host = $name,
  $data_dir = $::bind_dns::server::config::data_dir,
) {

  $alias = "${name},PTR,${zone}"

  bind_dns::record { $alias:
    zone     => $zone,
    host     => $host,
    ttl      => $ttl,
    record   => 'PTR',
    data     => "${data}.",
    data_dir => $data_dir,
  }
}
