class transmission::params {

  $rpc_url = regsubst($::transmission::rpc_url,'/$','')

  if $::transmission::home_dir != undef {
    $home_dir = $::transmission::home_dir
  } else {
    if versioncmp($facts['os']['release']['full'],'16.04') >= 0 {
      $home_dir = '/var/lib/transmission-daemon'
    } else {
      $home_dir = '/home/debian-transmission'
    }
  }

  if $::transmission::download_root != undef {
    $download_root = $::transmission::download_root
  } else {
    $download_root = $home_dir
  }

  $download_dirs = unique([
    "${download_root}/${::transmission::download_dir}",
    "${download_root}/${::transmission::incomplete_dir}",
    "${download_root}/${::transmission::watch_dir}"
  ])

  if versioncmp($facts['os']['release']['full'],'16.04') >= 0 {
    $use_systemd = true
    $stop_cmd    = '/bin/systemctl stop transmission-daemon'
    $start_cmd   = '/bin/systemctl start transmission-daemon'
  } else {
    $use_systemd = false
    $stop_cmd    = '/usr/sbin/service transmission-daemon stop'
    $start_cmd   = '/usr/sbin/service transmission-daemon start'
  }

  if $::transmission::rpc_bind_address != '0.0.0.0' {
    $rpc_bind = $::transmission::rpc_bind_address
  } else {
    $rpc_bind = $::transmission::bind_address_ipv4
  }

  if $::transmission::service_ensure != 'running' {
    $cron_ensure = absent
  } elsif $::transmission::blocklist_url != 'http://www.example.com/blocklist' {
    $cron_ensure = present
  } else {
    $cron_ensure = absent
  }

  if $::transmission::rpc_authentication_required == true {
    $remote_command = "/usr/bin/transmission-remote http://localhost:${::transmission::rpc_port}${rpc_url} -n ${::transmission::rpc_username}:${::transmission::rpc_password}"
  } else {
    $remote_command = "/usr/bin/transmission-remote http://localhost:${::transmission::rpc_port}${rpc_url}"
  }

}
