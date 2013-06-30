# Accumulo veewee definition

Based upon https://github.com/NREL/vagrant-boxes

* CentOS 6.4
* Puppet 2.7.21
* Facter (latest from EPEL)
* NO CHEF

# How do I use it?

1. Install veewee and vagrant
2. Copy everything from this repo (Vagrantfile included) into your veewee dir
3. Verify that definition exists by running (in the veewee dir) `veewee vbox list`
4. Build a VM locally in veewee... `veewee build 'ssdev-tst-14.0'`
5. Build a Vagrant VM `veewee export 'ssdev-tst-14.0'`
6. Run your newly built Vagrant box like any other `vagrant up`


# TODOs...

* Accumulo, zookeeper, thrift, hadoop installs (yeah, yeah)
