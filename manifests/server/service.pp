# == Class bind_dns::server::service
#
class bind_dns::server::service (
  $service = $bind_dns::server::params::service
) inherits bind_dns::server::params {

  service { $service:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['bind_dns::server::config']
  }

}
