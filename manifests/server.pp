# == Class bind_dns::server
#
class bind_dns::server (
  $service = $bind_dns::server::params::service,

  $necessary_packages = $bind_dns::server::params::necessary_packages,
  $ensure_packages    = $bind_dns::server::params::ensure_packages,

  $cfg_dir  = $bind_dns::server::params::cfg_dir,
  $cfg_file = $bind_dns::server::params::cfg_file,
  $data_dir = $bind_dns::server::params::data_dir,
  $owner    = $bind_dns::server::params::owner,
  $group    = $bind_dns::server::params::group,

  $enable_default_zones = true,
) inherits bind_dns::server::params {
  class { 'bind_dns::server::install':
    necessary_packages => $necessary_packages,
    ensure_packages    => $ensure_packages,
  } -> class { 'bind_dns::server::config':
    cfg_dir              => $cfg_dir,
    cfg_file             => $cfg_file,
    data_dir             => $data_dir,
    owner                => $owner,
    group                => $group,
    enable_default_zones => $enable_default_zones,
  } ~> class { 'bind_dns::server::service':
    service => $service,
  }
}
