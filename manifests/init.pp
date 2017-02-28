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
  Variant[Undef,String]  $blocklist_url         = undef,
  String                 $bind_address_ipv4     = '0.0.0.0',
  String                 $bind_address_ipv6     = '::',
  Boolean                $dht_enabled           = true,
  String                 $download_dir          = '/var/lib/transmission-daemon/downloads',
  Integer                $encryption            = 1,
  Variant[Undef,String]  $incomplete_dir        = undef,
  Variant[Undef,String]  $log_file              = undef,
  Boolean                $manage_ppa            = true,
  Integer                $message_level         = 2,
  Integer                $peer_port             = 51413,
  Integer                $peer_port_random_low  = 49152,
  Integer                $peer_port_random_high = 65535,
  Boolean                $pex_enabled           = true,
  String                 $rpc_base_url          = '/transmission/',
  Variant[Undef,String]  $rpc_bind_address      = undef,
  Boolean                $rpc_enable_auth       = true,
  String                 $rpc_password          = undef,
  String                 $rpc_username          = 'transmission',
  Integer                $rpc_port              = 9091,
  Variant[Undef,String]  $rpc_whitelist         = undef,
  String                 $service_ensure        = 'running',
  Boolean                $service_enable        = true,
  Variant[Undef,Integer] $speed_limit_down      = undef,
  Variant[Undef,Integer] $speed_limit_up        = undef,
  Boolean                $utp_enabled           = true,
) {

  if $::osfamily != 'Debian' {
    fail "Your osfamily (${::osfamily}) is not supported by this module"
  }

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

  include ::transmission::install
  include ::transmission::config
  include ::transmission::service

}
