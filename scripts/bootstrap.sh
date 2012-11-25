#!/usr/bin/env bash

# Are we on a vanilla system?
if ! test -f "/etc/chef/solo.rb"; then
  echo -e "\n*******************************************************************************\n" \
          "Bootstrapping machine with ruby and chef-solo" \
          "\n*******************************************************************************\n"	

  echo -e "\nUpdating packages..." \
          "\n===============================================================================\n"  

  sudo apt-get update --yes --fix-missing

  echo -e "\nInstalling development dependencies and essential tools..." \
          "\n===============================================================================\n"
  #sudo apt-get install curl bison zlib1g-dev libopenssl-ruby1.9.1 libssl-dev libreadline-dev libncurses5-dev --yes --fix-missing
  #sudo apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config --yes --fix-missing
  sudo apt-get install build-essential ruby1.9.3 liberuby-dev rubygems libopenssl-ruby curl bison openssl --yes --fix-missing
  #sudo apt-get install git-core curl --yes --fix-missing
  #sudo apt-get install build-essential binutils-doc gcc autoconf flex bison openssl --yes --fix-missing
  #sudo apt-get install libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libxml2-dev libxslt1-dev libyaml-dev libsqlite3-dev sqlite3 libxslt-dev libc6-dev ncurses-dev automake libtool subversion pkg-config --yes --fix-missing
  
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