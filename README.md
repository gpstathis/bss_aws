Boston Startup School - AWS Automation Class - Chef/Vagrant/EC2 Scripts 
=======================================================================

Automated provisioning scripts for `EC2` and [VirtualBox 4](http://www.virtualbox.org/wiki/Downloads) VMs using [Chef Solo](http://wiki.opscode.com/display/chef/Chef+Solo), [Vagrant](http://vagrantup.com) and [vagrant-ec2](https://github.com/lynaghk/vagrant-ec2).

These scripts were created for the [Boston Startup School](http://www.bostonstartupschool.com/) Fall '12 AWS class. They are meant to be a learning tool on automated provisioning.

Setup local machine
===================

For EC2 Provisioning
--------------------

+ Install [ec2-api-tools](http://www.ubuntuupdates.org/package/core/precise/multiverse/base/ec2-api-tools)
+ Copy `scripts/config-sample.sh` to `scripts/config.sh` and edit the following to match your local environment:

		export JAVA_HOME=<path to your Java home>
		...
		export EC2_HOME=<path to ec2 api tools home>
		...
		export AWS_ACCESS_KEY=<your AWS_ACCESS_KEY>
		export AWS_SECRET_KEY=<your AWS_SECRET_KEY>
		...
		export EC2_KEY_PAIR=<path to your key pair file>
		export EC2_KEY_NAME=<your key name>

+ If you need to create a new key pair file, use:

		bash$ ec2-add-keypair --aws-access-key <your AWS_ACCESS_KEY> --aws-secret-key <your AWS_SECRET_KEY> --region us-east-1 ec2-us-east-1-keypair > ~/.ec2/ec2-us-east-1-keypair
		bash$ chmod 600 ~/.ec2/ec2-us-east-1-keypair	

For VirtualBox Provisioning
---------------------------

+ Download and install [VirtualBox 4](http://www.virtualbox.org/wiki/Downloads)
+ [Vagrant](http://vagrantup.com) rubygem: `gem install vagrant`
+ The `precise64` Vagrant base box: `vagrant box add precise64 http://files.vagrantup.com/precise64.box`.
  Take a look at the [vagrant-ubuntu](https://github.com/lynaghk/vagrant-ubuntu) repository for scripts to make custom Ubuntu-based Vagrant base boxes.

Usage
=====

For EC2 Provisioning
--------------------

+ Run `scripts/launch_ec2_instance.sh` to create a new EC2 box (see config.sh for default AMI) and apply the chef recipes to it
+ Run `scripts/provision_ec2_instance.sh <EC2 box host name>` to apply any chef script changes to an existing EC2 box
	
For VirtualBox Provisioning
---------------------------

+ `cd vagrant`
+ `vagrant up`

Thanks
======

This project was made possible by [vagrant-ec2](https://github.com/lynaghk/vagrant-ec2/) from Keming labs.


