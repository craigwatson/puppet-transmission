# Change Log

## 2.2.0

### 2018-01-31 - Feature Release

#### Class: `transmission`
  * Adding new parameter to enable on-complete scripts

## 2.1.0

### 2017-09-01 - Feature Release

#### Class: `transmission`
  * Adding some more parameters into the main class

#### Class: `transmission::params`
  * Creating new class to hold internally-derived parameters
  * Fixing cron syntax bug when using remote command auth

#### Class: `transmission::service`
  * Adding systemd service files for Ubuntu 16.04

## 2.0.0

### 2017-02-28 - Major Version Release

#### Puppet 3 Support Removed
  * This module no longer supports Puppet 3. If you require Puppet 3 functionality, please use version [1.2.1 from the Puppet Forge](https://forge.puppet.com/CraigWatson1987/transmission/readme), or the [puppet3](https://github.com/craigwatson/puppet-transmission/tree/puppet3) branch in Git.

## 1.2.1

### 2017-02-28 - Minor Version Release

#### Puppet 3 Deprecation
  * As of this release, Puppet 3.x functionality is deprecated. The next release (2.0.0) will *not* be compatible with Puppet 3.x.

#### Module-wide: Permissions issues
  * Fixes some permissions issues as reported in [#1](https://github.com/craigwatson/puppet-transmission/issues/1)

## 1.1.4

### 2016-12-30 - Bugfix Release

#### Class: `transmission`
  * Fixing more stdlib deprecation warnings

# 1.1.3

## 2016-12-30

### Class: `transmission`
  * Fixing legacy stdlib deprecation warnings

# 1.1.2

## 2016-02-13 - Bug fix Release

### Class: `transmission::config`
  * Only notify the `replace_transmission_config` resource if the service should be running

### Class: `transmission::install`
  * Only download blocklists if the service should be running

# 1.1.1

### 2016-01-18 - Bug Fix Release

#### Class: `transmission`
  * Blocklist update cron is now absent if the service is stopped

# 1.1.0

### 2016-01-05 - Feature Release

#### Class: `transmission`
  * Two new parameters to control if the Transmission daemon is running or started at boot
  * New parameter to control if the module should add the Transmission PPA repository

### Class: `transmission::install`
  * The Blocklist download `exec` now requires the Service resource, rather than file resources
  * The PPA repository is only added if the main class parameter is set to `true`

### Class: `transmission::service`
  * Using the new parameters from the main `transmission` class to control the `service` resource

## 1.0.0

### 2015-11-30 - First Release
  * The first release to the Forge!
