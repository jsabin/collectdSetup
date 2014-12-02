#!/bin/bash

# Instructions: Run as sudo or root

cwd=$(pwd)

# Get zip file
wget https://raw.githubusercontent.com/jsabin/collectdSetup/master/collectd.gzip

# Extract zip
pushd /
tar xvfz $cwd/collectd.gzip
chown -R root /opt/proofpoint/collectd
chgrp -R root /opt/proofpoint/collectd

# Copy config file
mkdir /etc/collectd
cp /opt/proofpoint/collectd/distribute/collectd.conf /etc/collectd

# Add links
sudo ln --symbolic /opt/proofpoint/collectd/sbin/collectd /usr/sbin/collectd
sudo ln --symbolic /opt/proofpoint/collectd/sbin/collectdmon /usr/sbin/collectdmon

# Copy startup script
cp /opt/proofpoint/collectd/distribute/collectd /etc/init.d
update-rc.d collectd defaults

# Start collectd
/etc/init.d/collectd start

popd
rm collectd.gzip


