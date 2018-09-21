# == Class openconnect::service
#
# This class is meant to be called from openconnect
# It ensure the service is running
#
class openconnect::service {
  include openconnect::params

  if $openconnect::ensure == 'absent' {
    $ensure = 'stopped'
  } else {
    $ensure = 'running'
  }

  # Disable `hasrestart` because otherwise upstart won't pick up
  # option/argument changes to the init file.
  if $::service_provider == 'upstart' {
    service { $openconnect::params::service_name:
      ensure     => $ensure,
      enable     => true,
      hasstatus  => true,
      hasrestart => false,
    }
  } else {
    service { $openconnect::params::service_name:
      ensure     => $ensure,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}
