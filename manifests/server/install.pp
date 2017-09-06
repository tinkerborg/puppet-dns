# == Class bind_dns::server
#
class bind_dns::server::install (
  $necessary_packages = $bind_dns::server::params::necessary_packages,
  $ensure_packages    = $bind_dns::server::params::ensure_packages,
) inherits bind_dns::server::params {

  package { $necessary_packages :
    ensure => $ensure_packages,
  }

}
