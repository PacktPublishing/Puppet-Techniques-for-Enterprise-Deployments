class dashboard::reporter {
  class { 'logstash_reporter':
    logstash_host => '192.168.33.140',
    logstash_port => 9601,
  }
}
