class transmission::params {

  if $::transmission::rpc_bind_address != undef {
    $rpc_bind = $::transmission::rpc_bind_address
  } else {
    $rpc_bind = $::transmission::bind_address_ipv4
  }

  if $::transmission::service_ensure != 'running' {
    $cron_ensure = absent
  } elsif $::transmission::blocklist_url != undef {
    $cron_ensure = present
  } else {
    $cron_ensure = absent
  }

  if $::transmission::rpc_enable_auth == true {
    $remote_command_auth = "-n ${::transmission::rpc_username}:${::transmission::rpc_password}"
  } else {
    $remote_command_auth = ''
  }

}
