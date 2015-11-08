#!/bin/bash

set -eu

echo 'Updating ubuntu packages...'
apt-get update
apt-get install --yes --force-yes openjdk-7-jdk
apt-get install --yes --force-yes lib32z1 lib32ncurses5 lib32stdc++6
apt-get install --yes --force-yes qemu-kvm
apt-get install --yes --force-yes tmux

sudo -H -u vagrant /vagrant/provision-android.sh

echo 'Setting up emulator in rc.local...'
sed -i 's/exit 0//g' /etc/rc.local
cat >> /etc/rc.local << EOF
~vagrant/android-sdk-linux/tools/emulator -avd default -no-window -no-audio &
exit 0
EOF

echo 'Done. Please `vagrant reload` now.'
