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
  String                 $download_dir          = 'downloads',
  Variant[Undef,Integer] $download_queue_size   = undef,
  Integer                $encryption            = 1,
  Variant[Undef,String]  $incomplete_dir        = undef,
  Variant[Undef,String]  $log_file              = undef,
  Boolean                $manage_ppa            = true,
  Integer                $message_level         = 2,
  Integer                $peer_port             = 51413,
  Integer                $peer_port_random_low  = 49152,
  Integer                $peer_port_random_high = 65535,
  Boolean                $pex_enabled           = true,
  Variant[Undef,Integer] $ratio_limit           = undef,
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

  include ::transmission::params
  include ::transmission::install
  include ::transmission::config
  include ::transmission::service

}
