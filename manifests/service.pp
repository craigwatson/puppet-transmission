# == Class: transmission::service
#
# Manages the transmission-daemon service and configuration replacement
#
# == Actions:
#
# None
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
class transmission::service {

  service { 'transmission-daemon':
    ensure => $::transmission::service_ensure,
    enable => $::transmission::service_enable,
  }

  exec { 'replace_transmission_config':
    command     => '/usr/sbin/service transmission-daemon stop && cp -a /etc/transmission-daemon/settings.json.puppet /etc/transmission-daemon/settings.json && /usr/sbin/service transmission-daemon start',
    refreshonly => true,
  }

}
