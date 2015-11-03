#!/usr/bin/env bash

set -eu

cd ~vagrant
wget --no-verbose --continue http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
tar zxf android-sdk_r24.4.1-linux.tgz

echo 'export ANDROID_HOME=~/android-sdk-linux' >> ~vagrant/.bashrc
echo 'export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH' >> ~vagrant/.bashrc

export ANDROID_HOME=~vagrant/android-sdk-linux
export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

apt-get update
apt-get install --yes --force-yes openjdk-7-jdk
apt-get install --yes --force-yes lib32z1 lib32ncurses5 lib32stdc++6

function accept { while : ; do echo y ; sleep 1 ; done ; }
accept | android update sdk --all --filter platform-tools,build-tools,android,extra-android-support --no-ui --force

chown --recursive vagrant:vagrant ~vagrant
