# == Class: transmission::install
#
# Installs packages
#
# == Actions:
#
# * Conditionally adds the Transmission Apt PPA to the system
# * Installs packages
# * Optionally downloads blacklists
#
# === Authors:
#
# Craig Watson <craig@cwatson.org>
#
# === Copyright:
#
# Copyright (C) 2014 Craig Watson
# Published under the Apache License v2.0
#
class transmission::install {

  if $::transmission::manage_ppa {
    apt::ppa { 'ppa:transmissionbt/ppa': }

    Package[$::transmission::params::packages] {
      require => Apt::Ppa['ppa:transmissionbt/ppa']
    }

  }

  package { $::transmission::params::packages:
    ensure  => present,
  }

  if $::transmission::blocklist_url != undef and $::transmission::service_ensure != 'running' {
    exec { 'transmission_download_blocklists':
      command => "/usr/bin/transmission-remote${::transmission::params::remote_command_auth} --blocklist-update > /dev/null",
      creates => "${::transmission::params::home_dir}/blocklists/blocklist.bin",
      require => Service['transmission-daemon'],
    }
  }

}
