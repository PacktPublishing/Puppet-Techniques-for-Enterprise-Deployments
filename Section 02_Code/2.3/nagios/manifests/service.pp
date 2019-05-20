class nagios::service {

    nagios_hostgroup { 'all-servers':
        ensure  => present,
        target  => '/etc/nagios/conf.d/nagios_hostgroup.cfg',
        require => Class[ 'nagios::install' ],
        notify  => Exec[ 'fix-permissions' ],
    }

    nagios_command { 'check_nrpe':
        command_name => 'check_nrpe',
        ensure       => present,
        command_line => '$USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$',
        target       => '/etc/nagios/objects/commands.cfg',
        require      => Class[ 'nagios::install' ],
        notify       => Exec[ 'fix-permissions' ],
    }

    nagios_command { 'check_nrpe_arg':
        command_name => 'check_nrpe_arg',
        ensure       => present,
        command_line => '$USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$ -a $ARG2$',
        target       => '/etc/nagios/objects/commands.cfg',
        require      => Class[ 'nagios::install' ],
        notify       => Exec[ 'fix-permissions' ],
    }

    exec { 'fix-permissions':
        command     => "/bin/find /etc/nagios/conf.d -type f -name '*cfg' | xargs chmod +r",
        refreshonly => true,
        require     => Class[ 'nagios::install' ],
    } ->

    service { 'nagios':
        ensure      => running,
        enable      => true,
        require     => Class[ 'nagios::install' ],
    }
}
