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
  String                 $service_ensure                 = 'running',
  Boolean                $service_enable                 = true,
  Boolean                $manage_ppa                     = true,
  Variant[Undef,String]  $download_root                  = '/var/lib/transmission-daemon',
  Variant[Undef,String]  $log_file                       = undef,


  Integer                $alt_speed_down                 = 50,
  Boolean                $alt_speed_enabled              = false,
  Integer                $alt_speed_up                   = 50,
  Integer                $alt_speed_time_begin           = 540,
  Integer                $alt_speed_time_day             = 127,
  Boolean                $alt_speed_time_enabled         = false,
  Integer                $alt_speed_time_end             = 1020,
  String                 $bind_address_ipv4              = '0.0.0.0',
  String                 $bind_address_ipv6              = '::',
  Boolean                $blocklist_enabled              = false,
  String                 $blocklist_url                  = 'http://www.example.com/blocklist',
  Integer                $cache_size_mb                  = 4,
  Boolean                $dht_enabled                    = true,
  String                 $download_dir                   = 'Downloads',
  Boolean                $download_queue_enabled         = true,
  Integer                $download_queue_size            = 5,
  Integer                $encryption                     = 1,
  String                 $incomplete_dir                 = 'Downloads',
  Boolean                $incomplete_dir_enabled         = false,
  Integer                $idle_seeding_limit             = 30,
  Boolean                $idle_seeding_limit_enabled     = false,
  Boolean                $lazy_bitfield_enabled          = true,
  Boolean                $lpd_enabled                    = false,
  Integer                $message_level                  = 2,
  String                 $peer_congestion_algorithm      = '',
  Integer                $peer_id_ttl_hours              = 6,
  Integer                $peer_limit_global              = 200,            # 240
  Integer                $peer_limit_per_torrent         = 50,             # 60
  Integer                $peer_port                      = 51413,
  Integer                $peer_port_random_high          = 65535,
  Integer                $peer_port_random_low           = 49152,          # 1024
  Boolean                $peer_port_random_on_start      = false,
  String                 $peer_socket_tos                = 'default',
  Boolean                $pex_enabled                    = true,
  Boolean                $port_forwarding_enabled        = true,
  Integer                $preallocation                  = 1,
  Boolean                $prefetch_enabled               = true,
  Boolean                $queue_stalled_enabled          = true,
  Integer                $queue_stalled_minutes          = 30,
  Integer                $ratio_limit                    = 2,              # 2.0
  Boolean                $ratio_limit_enabled            = false,
  Boolean                $rename_partial_files           = true,
  Boolean                $rpc_authentication_required    = false,
  String                 $rpc_url                        = '/transmission/',
  String                 $rpc_bind_address               = '0.0.0.0',
  Boolean                $rpc_enabled                    = true,
  String                 $rpc_host_whitelist             = '',
  Boolean                $rpc_host_whitelist_enabled     = true,
  String                 $rpc_password                   = 'transmission',
  Integer                $rpc_port                       = 9091,
  String                 $rpc_username                   = 'transmission', # ''
  String                 $rpc_whitelist                  = '127.0.0.1',
  Boolean                $rpc_whitelist_enabled          = true,
  Boolean                $scrape_paused_torrents_enabled = true,
  Boolean                $script_torrent_done_enabled    = false,
  String                 $script_torrent_done_filename   = '',
  Boolean                $start_added_torrents           = true,
  Integer                $speed_limit_down               = 100,
  Boolean                $speed_limit_down_enabled       = false,
  Integer                $speed_limit_up                 = 100,
  Boolean                $speed_limit_up_enabled         = false,
  Boolean                $seed_queue_enabled             = false,
  Integer                $seed_queue_size                = 10,
  Boolean                $trash_original_torrent_files   = false,
  Integer                $umask                          = 18,
  Integer                $upload_slots_per_torrent       = 14,
  Boolean                $utp_enabled                    = true,
  String                 $watch_dir                      = 'watched',
  Boolean                $watch_dir_enabled              = false,
) {

  if $facts['os']['family'] != 'Debian' {
    fail "Your osfamily (${facts[os][family]}) is not supported by this module"
  }

  include ::transmission::params
  include ::transmission::install
  include ::transmission::config
  include ::transmission::service

}
