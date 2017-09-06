#== Class bind_dns::collector
#
# ?
class bind_dns::collector {
  Dns::Member <<| |>> {
    require => Class['bind_dns::server'],
    notify  => Class['bind_dns::server::service']
  }
}
