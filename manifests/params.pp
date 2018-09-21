# == Class openconnect::params
#
# This class is meant to be called from openconnect
# It sets variables according to platform
#
class openconnect::params {
  case $::osfamily {
    'Debian': {
      $package_name        = 'openconnect'
      $additional_packages = ['vpnc']
      $service_name        = 'openconnect'

      if $::lsbdistcodename == 'xenial' {
        $cafileparam = 'cafile'
      } else {
        $cafileparam = 'CAfile'
      }
    }
    'RedHat': {
      $package_name        = 'openconnect'
      $additional_packages = []
      $service_name        = 'openconnect'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
