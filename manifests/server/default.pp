# == Class: bind_dns::server::default
#
class bind_dns::server::default (

  $default_file          = $bind_dns::server::params::default_file,
  $default_template      = $bind_dns::server::params::default_template,

  $resolvconf            = undef,
  $options               = undef,
  $rootdir               = undef,
  $enable_zone_write     = undef,
  $enable_sdb            = undef,
  $disable_named_dbus    = undef,
  $keytab_file           = undef,
  $disable_zone_checking = undef,

) inherits bind_dns::server::params {

  validate_absolute_path( $default_file )

  if $resolvconf != undef {
    validate_re( $resolvconf, '^(yes|no)$', 'The resolvconf value is not type of a string yes / no.' )
  }

  if $rootdir != undef {
    validate_absolute_path( $rootdir )
  }

  if $enable_zone_write != undef {
    validate_re( $enable_zone_write, '^(yes|no|\s*)$', 'The enable_zone_write value is not type of a string yes / no or empty.' )
  }

  if $enable_sdb != undef {
    validate_re( $enable_sdb, '^(yes|no|1|0|\s*)$', 'The enable_sdb value is not type of a string yes / no / 1 / 0 or empty.' )
  }

  if $keytab_file != undef {
    validate_absolute_path( $keytab_file )
  }

  if $disable_zone_checking != undef {
    validate_re( $disable_zone_checking, '^(yes|no|\s*)$', 'The disable_zone_checking value is not type of a string yes / no or empty.' )
  }

  file { $default_file:
    ensure  => present,
    owner   => $::bind_dns::server::params::owner,
    group   => $::bind_dns::server::params::group,
    mode    => '0644',
    content => template("${module_name}/${default_template}"),
    notify  => Class['bind_dns::server::service'],
    require => Package[$::bind_dns::server::params::necessary_packages]
  }

}
