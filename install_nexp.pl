#!/usr/bin/perl

#install and configure the node exporter #make sure you run as root.
#add prometheus user if the user is already there
#created by Greg Abbas

#add the prometheus user
system "useradd prometheus" or die $!;

#unzip the package
$thezip = 'node_exporter-1.1.2.linux-amd64.gz'
$thedir =~ s//.gz/g;

    open unzip, "tar -xvf $thezip]" or die $1;
        while $status = <unzip>{
            print $status;
        }   
    close unzip;


#move the files

system "mv -rp ${thedir} /usr/share/" or die $!; 
system "chown -R prometheus.prometheus /usr/share/${thedir}/" or die $!;
system "cp node_exporter.service /etc/systemd/system/" or die $!;

    open service, "servicectl enable node_exporter" or die $!;
        while $service = <service>{
            print $service;
        }
    close service;


system "systemctl start node_exporter" or die $1;
    
    open state, "servicectl status node_exporter" or die $!;
        while $state = <state>{
        print $state;
    }   close state;

exit 0;