#!/usr/bin/perl -w

#install and configure the node exporter in EC2 Linux
#run as root.
#adds prometheus user if the user isn't already there
#created by Greg Abbas

#add the prometheus user
system "useradd prometheus" or die $!;

#Update the zip filename with the binary info
$thezip = 'node_exporter-1.1.2.linux-amd64.gz'

#parse binary home directory name from zip
$thedir = $thezip;
$thedir =~ s/\.gz//g;

#Unzip and stage the package
    open unzip, "tar -xvf $thezip" or die $1;
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

#start the service
system "systemctl start node_exporter" or die $1;
    
    open state, "servicectl status node_exporter" or die $!;
        while $state = <state>{
        print $state;
    }   close state;

exit 0;