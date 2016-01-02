# == Class: transmission::install
#
# Installs packages
#
# == Actions:
#
# * Adds the Transmission Apt PPA to the system
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

  apt::ppa { 'ppa:transmissionbt/ppa': }

  package { ['transmission-cli','transmission-common','transmission-daemon']:
    ensure  => present,
    require => Apt::Ppa['ppa:transmissionbt/ppa']
  }

  if $::transmission::blocklist_url {
    exec { 'download_blocklists':
      command => "/usr/bin/transmission-remote ${::transmission::remote_command_auth} --blocklist-update > /dev/null",
      creates => '/var/lib/transmission-daemon/info/blocklists/blocklist.bin',
      require => Service['transmission'],
    }
  }

}
