#!/usr/bin/env bash

# This script will be available on the VirtualBox VM through the /vagrant shared folder
# Use it to re-apply any local Chef cookbook changes
sudo chef-solo -c /tmp/vagrant-chef-1/solo.rb -j /tmp/vagrant-chef-1/dna.json