# puppet-transmission

[![Build Status](https://secure.travis-ci.org/craigwatson/puppet-transmission.png?branch=master)](http://travis-ci.org/craigwatson/puppet-transmission)
[![Puppet Forge](http://img.shields.io/puppetforge/v/CraigWatson1987/transmission.svg)](https://forge.puppetlabs.com/CraigWatson1987/transmission)

#### Table of Contents

1. [Overview - What is the puppet-transmission module?](#overview)
1. [Module Description - What does the module do?](#module-description)
1. [Setup - The basics of getting started with puppet-transmission](#setup)
    * [What puppet-transmission affects](#what-puppet-transmission-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with puppet-transmission](#beginning-with-puppet-transmission)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Overview

This Puppet module installs and configures the `transmission` daemon - the headless component of the Transmission BitTorrent client.

## Module Description

  * Adds the Transmission PPA from `ppa:transmissionbt/ppa`
  * Installs `transmission-cli`,`transmission-common` and `transmission-daemon` packages
  * Downloads and periodically updates blocklists if configured
  * Configures the configuration file for Transmission at `/etc/transmission-daemon/settings.json`
  * Enables and starts the `transmission-daemon` daemon/service

## Setup

### Beginning With puppet-transmission

To accept default class parameters (correct in most situations):

    include transmission

## Usage Example

To specify an RPC user/password, set a custom port number for RPC and peer connections and enable mandatory encryption for peer connections:

    class { 'transmission':
      rpc_username => 'rpcuser',
      rpc_password => 'somecomplexpasswordgoeshere',
      rpc_port     => 8080,
      peer_port    => 54612,
      encryption   => 2,
    }

## Reference

### Transmission Configuration Parameters

  * For detailed explanations of the parameters used to configure the `transmission` daemon, see here: https://trac.transmissionbt.com/wiki/EditConfigFiles
  * If any configuration options are not managed by the module, please submit a pull request!

### Classes

#### `transmission::config`

  * Places the daemon configuration and service defaults files
  * Configures the blocklist update cron, if enabled

#### `transmission::install`

  * Adds the Transmission Apt PPA to the system
  * Installs the packages necessary to run the headless daemon

#### `transmission::service`

  * Ensures the `transmission-daemon` service is running
  * Copies the temporary daemon settings file on-change by stopping and starting the daemon

## Limitations

* The module does _not_ manage or install the `transmission-gtk` package for the client's GUI

### Supported Operating Systems

* Ubuntu (tested on 14.04 LTS)

## Development

* Copyright (C) Craig Watson - <craig@cwatson.org>
* Distributed under the terms of the Apache License v2.0 - see LICENSE file for details.
* Further contributions and testing reports are extremely welcome - please submit a pull request or issue on [GitHub](https://github.com/craigwatson/puppet-transmission)
