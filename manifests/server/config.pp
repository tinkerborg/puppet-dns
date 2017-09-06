# == Class bind_dns::server
#
class bind_dns::server::config (
  $cfg_dir              = $bind_dns::server::params::cfg_dir,
  $cfg_file             = $bind_dns::server::params::cfg_file,
  $data_dir             = $bind_dns::server::params::data_dir,
  $owner                = $bind_dns::server::params::owner,
  $group                = $bind_dns::server::params::group,
  $enable_default_zones = true,
) inherits bind_dns::server::params {

  file { $cfg_dir:
    ensure => directory,
    owner  => $owner,
    group  => $group,
    mode   => '0755',
  }

  file { $data_dir:
    ensure => directory,
    owner  => $owner,
    group  => $group,
    mode   => '0755',
  }

  file { "${cfg_dir}/bind.keys.d/":
    ensure => directory,
    owner  => $owner,
    group  => $group,
    mode   => '0755',
  }

  file { $cfg_file:
    ensure  => present,
    owner   => $owner,
    group   => $group,
    mode    => '0644',
    content => template("${module_name}/named.conf.erb"),
    require => [
      File[$cfg_dir],
      Class['bind_dns::server::install']
    ],
    notify  => Class['bind_dns::server::service'],
  }

  concat { "${cfg_dir}/named.conf.local":
    owner  => $owner,
    group  => $group,
    mode   => '0644',
    notify => Class['bind_dns::server::service']
  }

  concat::fragment{'named.conf.local.header':
    target  => "${cfg_dir}/named.conf.local",
    order   => 1,
    content => "// File managed by Puppet.\n"
  }

  # Configure default zones with a concat so we could add more zones in it
  concat {$bind_dns::server::params::rfc1912_zones_cfg:
    owner          => $owner,
    group          => $group,
    mode           => '0644',
    ensure_newline => true,
    notify         => Class['bind_dns::server::service'],
  }

  concat::fragment {'default-zones.header':
    target => $bind_dns::server::params::rfc1912_zones_cfg,
    order  => '00',
    source => "puppet:///modules/${module_name}/named.conf.default-zones",
  }

  include bind_dns::server::default

}
