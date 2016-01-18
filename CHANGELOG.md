# Change Log

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
