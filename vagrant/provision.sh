#/bin/bash

# Replace original resolve conf (temporary)
rm /etc/resolv.conf
cp /home/vagrant/resolv.conf /etc/resolv.conf
chown root: /etc/resolv.conf

# Generate machine-id (For unique ID)
dbus-uuidgen > /etc/machine-id

# Install new resolvconf manager
apt install resolvconf -y
systemctl start resolvconf
systemctl enable resolvconf

# Configure resolv.conf permanently
cp /home/vagrant/resolv.conf /etc/resolv.conf
mv /home/vagrant/resolv.conf /etc/resolvconf/resolv.conf.d/head
systemctl restart resolvconf
systemctl restart systemd-resolved