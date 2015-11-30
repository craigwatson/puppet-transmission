class transmission::service {

  service { 'transmission-daemon':
    ensure => running,
    enable => true,
  }

  exec { 'replace_transmission_config':
    command     => '/usr/sbin/service transmission-daemon stop && cp -a /etc/transmission-daemon/settings.json.puppet /etc/transmission-daemon/settings.json && /usr/sbin/service transmission-daemon start',
    refreshonly => true,
  }

}
