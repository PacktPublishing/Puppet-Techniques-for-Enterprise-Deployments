class sectest {
  class { 'os_hardening': }
  class { 'ssh_hardening': }

  class { 'mysql::server': }
  class { 'mysql_hardening':  provider => 'puppetlabs/mysql' }

  class { 'apache': default_mods => false }
  class { 'apache_hardening': provider => 'puppetlabs/apache' }

  class { 'sudo': 
    purge               => false,
    config_file_replace => false,
  }
  sudo::conf { 'admins':
    priority => 10,
    content  => "%admins ALL=(ALL) NOPASSWD: ALL",
  }
}
