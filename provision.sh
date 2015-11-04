#!/usr/bin/env bash

set -eu

cd ~vagrant

echo 'Downloading android sdk...'
wget --no-verbose --continue http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz

echo 'Uncompressing android sdk...'
tar zxf android-sdk_r24.4.1-linux.tgz

echo 'Updating environment...'
echo 'export ANDROID_HOME=~/android-sdk-linux' >> ~vagrant/.bashrc
echo 'export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH' >> ~vagrant/.bashrc

export ANDROID_HOME=~vagrant/android-sdk-linux
export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

echo 'Updating ubuntu packages...'
apt-get update
apt-get install --yes --force-yes openjdk-7-jdk
apt-get install --yes --force-yes lib32z1 lib32ncurses5 lib32stdc++6
apt-get install --yes --force-yes qemu-kvm

echo 'Updating android sdk...'
function accept { while : ; do echo ${1:-y} ; sleep 1 ; done ; }
accept | android update sdk --filter tools,platform-tools,build-tools-23,android-23,extra-android-support,sys-img-armeabi-v7a-android-23 --all --no-ui

echo 'Creating avd...'
accept no | android create avd --name default --abi default/armeabi-v7a --target 1

echo 'Fixing permissions...'
chown --recursive vagrant:vagrant ~vagrant
