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

  file { '/etc/default/transmission-daemon':
    ensure  => file,
    content => template('transmission/default.erb'),
    require => Package['transmission-daemon'],
    notify  => Service['transmission-daemon'],
  }

  file { '/etc/transmission-daemon':
    ensure  => directory,
    owner   => 'root',
    group   => 'debian-transmission',
    mode    => 'u=rwx,g=rwxs,o=rx',
    require => Package['transmission-cli','transmission-common','transmission-daemon'],
  }

  file { '/etc/transmission-daemon/settings.json.puppet':
    ensure  => file,
    owner   => 'debian-transmission',
    group   => 'debian-transmission',
    mode    => '0600',
    content => template('transmission/settings.json.erb'),
    notify  => Exec['replace_transmission_config'],
  }

  cron { 'transmission_update_blocklist':
    ensure  => $::transmission::cron_ensure,
    command => "/usr/bin/transmission-remote ${transmission::remote_command_auth} --blocklist-update > /dev/null",
    require => Package['transmission-cli','transmission-common','transmission-daemon'],
    user    => 'root',
    minute  => '0',
    hour    => '*',
  }

}
