# == Define bind_dns::server:srv
#
# Wrapper for bind_dns::zone to set SRV records
#
define bind_dns::record::srv (
  $zone,
  $service,
  $pri,
  $weight,
  $port,
  $target,
  $proto = 'tcp',
  $ttl = '',
  $data_dir = $::bind_dns::server::config::data_dir,
) {

  $alias = "${service}:${proto}@${target}:${port},${pri},${weight},SRV,${zone}"

  $host = "_${service}._${proto}.${zone}."

  bind_dns::record { $alias:
    zone     => $zone,
    host     => $host,
    ttl      => $ttl,
    record   => 'SRV',
    data     => "${pri}\t${weight}\t${port}\t${target}",
    data_dir => $data_dir,
  }
}
