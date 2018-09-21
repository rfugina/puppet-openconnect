# == Class openconnect::service
#
# This class is meant to be called from openconnect
# It ensure the service is running
#
class openconnect::service {
  include openconnect::params

  if $openconnect::ensure == 'absent' {
    $ensure = 'stopped'
    $enable = false
  } else {
    $ensure = 'running'
    $enable = true
  }

  # Disable `hasrestart` because otherwise upstart won't pick up
  # option/argument changes to the init file.
  if $::service_provider == 'upstart' {
    service { $openconnect::params::service_name:
      ensure     => $ensure,
      enable     => $enable,
      hasstatus  => true,
      hasrestart => false,
    }
  } else {
    service { $openconnect::params::service_name:
      ensure     => $ensure,
      enable     => $enable,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}
