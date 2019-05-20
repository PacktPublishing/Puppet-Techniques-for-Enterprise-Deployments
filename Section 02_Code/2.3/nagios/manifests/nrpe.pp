class nagios::nrpe {

    package { [ 'nrpe', 'nagios-plugins', 'nagios-plugins-ssh', 'nagios-plugins-ping', 'nagios-plugins-disk' ]:
        ensure      => present,
        require     => Class[ 'nagios::repo' ],
    } ->
    file { '/usr/lib64/nagios/plugins/check_puppet.rb':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '755',
        source => 'puppet:///modules/nagios/check_puppet.rb',
    } ->
    file { '/etc/nagios/nrpe.cfg':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '664',
        source => 'puppet:///modules/nagios/nrpe.cfg',
    } ~>
    service { 'nrpe':
        ensure      => running,
        enable      => true,
        require     => Package[ 'nrpe', 'nagios-plugins', 'nagios-plugins-ssh', 'nagios-plugins-ping', 'nagios-plugins-disk' ],
    }
}
