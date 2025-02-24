#!/bin/bash

export AOSP_DIR="$PWD/aosp"
export KERNEL_DIR="$PWD/kernel"
export LOGS_DIR="$PWD/logs"
export KEYS_DIR="$PWD/keys"
export PY_DIR="$PWD/python2"
export CCACHE_DIR="$PWD/ccache"
export USE_CCACHE=1
export CCACHE_EXEC="/usr/bin/ccache"
export _JAVA_OPTIONS="-Xmx6g"  # helps prevent build from getting stuck

# create workspace
mkdir -p $AOSP_DIR
mkdir -p $KERNEL_DIR
mkdir -p $LOGS_DIR
mkdir -p $KEYS_DIR
mkdir -p $CCACHE_DIR

sudo apt-get update

# https://source.android.com/docs/setup/start/requirements#install-packages
sudo apt-get install -y git-core gnupg flex bison build-essential \
  curl zip zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev \
  lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig

# not mentioned in AOSP build guide
sudo apt-get install -y ccache rsync libncurses5

# required for building kernel
sudo apt-get install -y libssl-dev

# required for signing builds
sudo apt-get install -y android-sdk-build-tools

# install repo tool
if [ ! $(which repo) ]
then
  curl https://storage.googleapis.com/git-repo-downloads/repo > ./repo
  sudo chmod a+x ./repo
  sudo mv ./repo /usr/local/bin
fi

# configure git
git config --global user.name "Redfin Builder"
git config --global user.email "android@android.com"
git config --global color.ui false

# setup compiler cache
ccache -M 50G

# Make sure Python2 is built (from source) and installed globally
if [ ! -f $PY_DIR/bin/python ]
then
  curl https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz > ./Python-2.7.18.tgz
  tar -xzvf ./Python-2.7.18.tgz
  rm -rf ./Python-2.7.18.tgz

  (cd ./Python-2.7.18 && ./configure --prefix=$PY_DIR)
  (cd ./Python-2.7.18 && make)
  (cd ./Python-2.7.18 && make install)
  rm -rf ./Python-2.7.18

  sudo ln -s $PY_DIR/bin/python /usr/local/bin/python
fi
