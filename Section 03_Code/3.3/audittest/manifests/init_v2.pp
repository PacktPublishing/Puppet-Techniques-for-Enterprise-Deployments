class audittest {
  user { 'testuser':
    ensure => present,
    noop => false,
    managehome => true,
  }
  resources { 'user':
    purge => true,
    unless_system_user => true,
    unless_uid => 500,
    noop => true,
  }
  yumrepo { 'nginx':
    ensure => present,
    baseurl => "http://nginx.org/packages/centos/7/x86_64/",
    enabled => true,
    gpgcheck => false
  }
  resources { 'yumrepo':
    purge => true,
    noop => true,
  }
}
