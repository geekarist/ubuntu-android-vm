#!/bin/bash -login

set -eu

cd ~

echo 'Downloading android sdk...'
wget --no-verbose --continue http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz

echo 'Uncompressing android sdk...'
tar zxf android-sdk_r24.4.1-linux.tgz

echo 'Updating environment...'
echo 'export ANDROID_HOME=~/android-sdk-linux' >> ~/.bashrc
echo 'export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH' >> ~/.bashrc

export ANDROID_HOME=~/android-sdk-linux
export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

echo 'Updating android sdk...'
function accept { while : ; do sleep 5 ; echo ${1:-y} ; done ; }
accept | android update sdk --filter tools,platform-tools,build-tools-23.0.2,android-23,extra-android-support,extra-android-m2repository,sys-img-armeabi-v7a-android-23 --no-ui --all --force

echo 'Creating avd...'
accept 'no' | android create avd --name default --abi default/armeabi-v7a --target 1 --force
