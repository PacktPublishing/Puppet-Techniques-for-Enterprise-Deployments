class secrettest {
  file { '/tmp/secret':
    ensure => file,
    source => 'puppet:///secret_agents/secret',
  }
}
