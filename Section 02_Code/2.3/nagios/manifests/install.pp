class nagios::install {
    package { [ 'nagios', 'nagios-plugins', 'nagios-plugins-nrpe', 'nagios-plugins-ssh', 'nagios-plugins-ping', 'nagios-plugins-disk' ]:
        ensure  => present,
        require => Class[ 'nagios::repo' ],
    } ->
    file { '/etc/nagios/cgi.cfg':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '664',
        source => 'puppet:///modules/nagios/cgi.cfg',
    } ->
    file { '/etc/httpd/conf.d/nagios.conf':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '664',
        source => 'puppet:///modules/nagios/httpd_nagios.conf',
    } ~>
    service { 'httpd':
        ensure      => running,
        enable      => true,
        require     => Package[ 'nagios', 'nagios-plugins', 'nagios-plugins-nrpe', 'nagios-plugins-ssh', 'nagios-plugins-ping', 'nagios-plugins-disk' ],
    }
}
