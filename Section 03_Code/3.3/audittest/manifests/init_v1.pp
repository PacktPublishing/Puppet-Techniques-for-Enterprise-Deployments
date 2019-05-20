class audittest {
  yumrepo { 'nginx':
    ensure => present,
    baseurl => "http://nginx.org/packages/centos/7/x86_64/",
    enabled => true,
    gpgcheck => false,
    audit => "all"
  }
}
