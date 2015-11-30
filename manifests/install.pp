class transmission::install {

  apt::ppa { 'ppa:transmissionbt/ppa': }

  package { ['transmission-cli','transmission-common','transmission-daemon']:
    ensure  => present,
    require => Apt::Ppa['ppa:transmissionbt/ppa']
  }

  if $::transmission::blocklist_url {
    exec { 'download_blocklists':
      command => "/usr/bin/transmission-remote$ {::transmission::remote_command_auth} --blocklist-update > /dev/null",
      creates => '/var/lib/transmission-daemon/info/blocklists/blocklist.bin',
      require => Package['transmission-cli','transmission-common','transmission-daemon'],
    }
  }

}
