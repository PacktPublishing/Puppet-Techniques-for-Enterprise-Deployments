class nagios::export {

    @@nagios_host { $::hostname :
        ensure              => present,
        address             => $::networking[interfaces][eth1][ip],
        use                 => 'generic-host',
        check_command       => 'check-host-alive',
        hostgroups          => 'all-servers',
        target              => "/etc/nagios/conf.d/${::hostname}.cfg",
        max_check_attempts  => 3,
    }

    @@nagios_service { "${::hostname}_check-ssh":
        ensure              => present,
        use                 => 'generic-service',
        host_name           => $::hostname,
        service_description => 'Service SSH',
        check_command       => "check_nrpe!check_ssh",
        target              => "/etc/nagios/conf.d/${::hostname}.cfg",
        max_check_attempts  => 3,
    }

    @@nagios_service { "${::hostname}_check-disk":
        ensure              => present,
        use                 => 'generic-service',
        host_name           => $::hostname,
        service_description => 'Disk - /',
        check_command       => "check_nrpe_arg!check_disk!20%!10%!/",
        target              => "/etc/nagios/conf.d/${::hostname}.cfg",
        max_check_attempts  => 3,
    }
}
