vagrant-stash
=============

Instant provisioning of [Atlassian's Stash (version 2.8.2)][1] with the help of [Vagrant][2] & [Puppet][3] 

What will it do?
----------------

1. Download Ubuntu 12.04
1. Create a new virtual machine, install Ubuntu and forward port 7990
1. Inside the virtual machine 
  1. Download & Install [Java][6]
  1. Download & Install & Start [Stash][1]
 
Do it!
------

1. Install [VirtualBox][4] and [Vagrant][2] and make sure you have [git][5] available.
1. Open your favorite terminal (mine is [iTerm2][7]) and clone the github repository 
	`git clone --recursive https://github.com/tstangenberg/vagrant-stash.git`

	`cd vagrant-stash`
1. Start up and provision automatically all dependencies in the vm
	`vagrant up --provision` 
1. *** You're almost DONE! *** --> open the [stash setup page][8] (http://localhost:7990/setup) & configure it


Thanks
------
This project is very closely based off of [Nicola Paolucci's][9] [Stash provisioning example][10].
Check out his [blog][11] for more details.


[1]: https://www.atlassian.com/software/stash/overview
[2]: http://www.vagrantup.com/
[3]: http://puppetlabs.com/
[4]: https://www.virtualbox.org 
[5]: http://git-scm.com
[6]: http://jdk7.java.net
[7]: http://www.iterm2.com
[8]: http://localhost:7990
[9]: https://bitbucket.org/durdn
[10]: https://bitbucket.org/durdn/stash-vagrant-install.git
[11]: https://blogs.atlassian.com/2013/03/instant-java-provisioning-with-vagrant-and-puppet-stash-one-click-install