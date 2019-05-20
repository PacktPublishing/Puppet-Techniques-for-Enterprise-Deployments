class dashboard {
  class { 'elasticsearch':
    java_install => true,
    manage_repo  => true,
    repo_version => '5.x',
    version      => '5.6.1',

    instances => {
      'es-01' => {
        'config' => {
          'network.host' => '0.0.0.0'
        }
      }
    },
    templates => {
      'logstash' => {
        'content' => {
          'template' => 'logstash-*',
          'settings' => {
            'number_of_replicas' => 0
          }
        }
      }
    }
  } ->

  class { 'logstash':
    version => '5.6.1',
  } ->

  logstash::configfile { 'puppet':
    source => 'puppet:///modules/dashboard/puppet.conf',
  } ->

  class { 'kibana':
    ensure => latest,
    config => {
      'elasticsearch.url' => 'http://localhost:9200',
    }
  }

  class { 'nginx': }

  nginx::resource::server { 'elkstack.local':
    listen_port => 80,
    proxy       => 'http://localhost:5601',
  }
}
