#!/usr/bin/env bash

# Are we on a vanilla system?
if ! test -f "/etc/chef/solo.rb"; then
  echo -e "\n*******************************************************************************\n" \
          "Bootstrapping machine with ruby and chef-solo" \
          "\n*******************************************************************************\n"	

  echo -e "\nUpdating packages..." \
          "\n===============================================================================\n"  

  sudo apt-get update --yes --fix-missing
	# Hack: Need to do it twice; it seems the first run does no fetch all repos on the EC2 Alestic AMI
	sudo apt-get update --yes --fix-missing

  echo -e "\nInstalling development dependencies and essential tools..." \
          "\n===============================================================================\n"
  
	sudo apt-get install ruby1.9.3 libruby1.9.1 ruby1.9.1-dev curl openssl build-essential liberuby-dev --yes --fix-missing
  
  echo -e "\nSetting default ruby and gem..." \
          "\n===============================================================================\n"
  sudo update-alternatives --set ruby /usr/bin/ruby1.9.1
  sudo update-alternatives --set gem /usr/bin/gem1.9.1

  echo -e "\nInstalling and bootstrapping Chef..." \
          "\n===============================================================================\n"
  sudo gem install chef --no-rdoc --no-ri
  
  sudo mkdir -p /var/chef-solo/
  echo 'file_cache_path   "/var/chef-solo"
  cookbook_path     "/var/chef-solo/cookbooks"
  role_path         "/var/chef-solo/roles"' | sudo tee -a /var/chef-solo/solo.rb 
  
  
  echo -e "\n*******************************************************************************\n" \
          "Bootstrap finished" \
          "\n*******************************************************************************\n"
else
  echo -e "\n*******************************************************************************\n" \
          "Bootstrap skipped" \
          "\n*******************************************************************************\n"
fi