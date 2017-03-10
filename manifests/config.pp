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

  # == Defaults

  File {
    owner   => 'debian-transmission',
    group   => 'debian-transmission',
    require => Package[$::transmission::params::packages],
  }

  # == Transmission config

  file { '/etc/transmission-daemon':
    ensure => directory,
    mode   => '0770',
  }

  if $::transmission::params::service_ensure == 'running' {
    File['/etc/transmission-daemon/settings.json.puppet'] {
      notify => Exec['replace_transmission_config'],
    }
  }

  file { '/etc/transmission-daemon/settings.json.puppet':
    ensure  => file,
    mode    => '0600',
    content => template('transmission/settings.json.erb'),
    require => File['/etc/transmission-daemon'],
  }

  # == Transmission Home

  file { $::trasmission::params::home_dir:
    ensure => directory,
    mode   => '0770',
  }

  file { "${::trasmission::params::home_dir}/.config":
    ensure  => directory,
    require => File[$::trasmission::params::home_dir],
    mode    => '0770',
  }

  file { "${::trasmission::params::home_dir}/.config/transmission-daemon":
    ensure  => directory,
    mode    => '0770',
    require => File["${::trasmission::params::home_dir}/.config"],
  }

  file { "${::trasmission::params::home_dir}/.config/transmission-daemon/settings.json":
    ensure  => link,
    target  => '/etc/transmission-daemon/settings.json',
    require => File["${::trasmission::params::home_dir}/.config/transmission-daemon"],
  }

  # == Blocklist update cron

  cron { 'transmission_update_blocklist':
    ensure  => $::transmission::params::cron_ensure,
    command => "/usr/bin/transmission-remote ${::transmission::params::remote_command_auth} --blocklist-update > /dev/null",
    require => Package['transmission-cli','transmission-common','transmission-daemon'],
    user    => 'root',
    minute  => '0',
    hour    => '*',
  }

}
