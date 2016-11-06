#!/bin/sh

echo >/etc/network/interfaces <<EOF
auto lo
iface lo inet loopback

source /etc/network/interfaces.d/*

auto eth0
iface eth0 inet dhcp
  pre-up sleep 2

#VAGRANT-BEGIN
# This section will be auto-replaced
auto eth1
iface eth1 inet manual
pre-up sleep 2

#VAGRANT-END
EOF

# Disable DNS reverse lookup
sed -i "/[# ]*UseDNS[ \t].*/d" /etc/ssh/sshd_config
echo "UseDNS no" >> /etc/ssh/sshd_config

sed -i 's/[ #]*GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/g' /etc/default/grub
update-grub
