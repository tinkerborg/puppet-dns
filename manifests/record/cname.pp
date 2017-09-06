# == Define bind_dns::record::dname
#
# Wrapper for bind_dns::record to set a CNAME
#
define bind_dns::record::cname (
  $zone,
  $data,
  $ttl = '',
  $host = $name,
  $data_dir = $::bind_dns::server::config::data_dir,
) {

  $alias = "${name},CNAME,${zone}"

  $qualified_data = $data ? {
    '@'     => $data,
    /\.$/   => $data,
    default => "${data}."
  }

  bind_dns::record { $alias:
    zone     => $zone,
    host     => $host,
    ttl      => $ttl,
    record   => 'CNAME',
    data     => $qualified_data,
    data_dir => $data_dir,
  }
}
