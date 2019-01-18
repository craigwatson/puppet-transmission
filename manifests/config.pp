# == Class: transmission::config
#
# This class handles the main configuration files for the module
#
# == Actions:
#
# * Deploys configuration files and cron
#
# === Authors:
#
# Craig Watson <craig@cwatson.org>
#
# === Copyright:
#
# Copyright (C) Craig Watson
# Published under the Apache License v2.0
#
class transmission::config {

  # == Transmission config

  file { '/etc/transmission-daemon':
    ensure  => 'directory',
    owner   => $::transmission::owner,
    group   => $::transmission::group,
    mode    => '0770',
    require => Package['transmission-daemon'],
  }

  file { '/etc/transmission-daemon/settings.json.puppet':
    ensure  => 'file',
    owner   => $::transmission::owner,
    group   => $::transmission::group,
    mode    => '0600',
    content => template('transmission/settings.json.erb'),
    require => File['/etc/transmission-daemon'],
  }

  # == Transmission Home

  file { $::transmission::params::home_dir:
    ensure  => 'directory',
    owner   => $::transmission::owner,
    group   => $::transmission::group,
    mode    => '0770',
    require => Package['transmission-daemon'],
  }

  if $::transmission::params::download_root != $::transmission::params::home_dir {
    file { $::transmission::params::download_root:
      ensure  => 'directory',
      owner   => $::transmission::owner,
      group   => $::transmission::group,
      mode    => '0770',
      require => Package['transmission-daemon'],
    }
  }

  file { $::transmission::params::download_dirs:
    ensure  => 'directory',
    owner   => $::transmission::owner,
    group   => $::transmission::group,
    mode    => '0770',
    require => File[$::transmission::params::download_root]
  }

  file { "${::transmission::params::home_dir}/settings.json":
    ensure  => 'link',
    target  => '/etc/transmission-daemon/settings.json',
    require => File[$::transmission::params::home_dir],
  }

  # == Blocklist update cron


  cron { 'transmission_update_blocklist':
    ensure  => $::transmission::params::cron_ensure,
    command => "${::transmission::params::remote_command} --blocklist-update > /dev/null",
    require => Package['transmission-cli','transmission-common','transmission-daemon'],
    user    => 'root',
    minute  => '0',
    hour    => '*',
  }

}
