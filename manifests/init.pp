# == Class: transmission
#
# Main class containing parameters and validation logic
#
# == Actions:
#
# * Fails on non-Ubuntu operating systems
# * Validates passed parameters
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
class transmission (
  $blocklist_url         = undef,
  $bind_address_ipv4     = '0.0.0.0',
  $bind_address_ipv6     = '::',
  $dht_enabled           = true,
  $download_dir          = '/var/lib/transmission-daemon/downloads',
  $encryption            = 1,
  $incomplete_dir        = undef,
  $log_file              = undef,
  $manage_ppa            = true,
  $message_level         = 2,
  $peer_port             = 51413,
  $peer_port_random_low  = 49152,
  $peer_port_random_high = 65535,
  $pex_enabled           = true,
  $rpc_base_url          = '/transmission/',
  $rpc_bind_address      = undef,
  $rpc_enable_auth       = true,
  $rpc_password          = undef,
  $rpc_username          = 'transmission',
  $rpc_port              = 9091,
  $rpc_whitelist         = undef,
  $service_ensure        = 'running',
  $service_enable        = true,
  $speed_limit_down      = undef,
  $speed_limit_up        = undef,
  $utp_enabled           = true,
) {

  if $::osfamily != 'Debian' {
    fail "Your osfamily (${::osfamily}) is not supported by this module"
  }

  if $blocklist_url != undef {
    validate_string($blocklist_url)
  }

  if $rpc_bind_address {
    validate_string($rpc_bind_address)
  }

  if $incomplete_dir {
    validate_legacy('Stdlib::Compat::Absolute_Path', 'validate_absolute_path', $incomplete_dir)
  }

  if $log_file {
    validate_legacy('Stdlib::Compat::Absolute_Path', 'validate_absolute_path', $log_file)
  }


  if $rpc_password {
    validate_string($rpc_password)
  }

  if $rpc_whitelist {
    validate_string($rpc_whitelist)
  }

  if $speed_limit_down {
    validate_numeric($speed_limit_down)
  }

  if $speed_limit_up {
    validate_numeric($speed_limit_up)
  }

  validate_legacy('Stdlib::Compat::Absolute_Path', 'validate_absolute_path', $download_dir)

  validate_bool($dht_enabled)
  validate_bool($manage_ppa)
  validate_bool($pex_enabled)
  validate_bool($rpc_enable_auth)
  validate_bool($service_enable)
  validate_bool($utp_enabled)

  validate_numeric($encryption)
  validate_numeric($message_level)
  validate_numeric($peer_port)
  validate_numeric($peer_port_random_high)
  validate_numeric($peer_port_random_low)
  validate_numeric($rpc_port)

  validate_string($bind_address_ipv4)
  validate_string($bind_address_ipv6)
  validate_string($rpc_base_url)
  validate_string($rpc_username)
  validate_string($service_ensure)

  if $rpc_bind_address == undef {
    $rpc_bind = $bind_address_ipv4
  } else {
    $rpc_bind = $rpc_bind_address
  }

  if $service_ensure != 'running' {
    $cron_ensure = absent
  } elsif $blocklist_url != undef {
    $cron_ensure = present
  } else {
    $cron_ensure = absent
  }

  if $rpc_enable_auth == false {
    $remote_command_auth = ''
  } else {
    $remote_command_auth = "-n ${::transmission::rpc_username}:${::transmission::rpc_password}"
  }

  include ::transmission::install
  include ::transmission::config
  include ::transmission::service

}
