NengoRos
=========


This is Nengo-ros, a tool for simulating large-scale hybrid neural systems by Jaroslav Vitku, see: http://nengoros.wordpress.com (temporary website Alife group on CTU in Prague: http://artificiallife.co.nf/ ). 

The resulting system mainly fuses these following main systems (all credit to their authors) :

* Nengo ( http://nengo.ca/ ) 
* and modified version of ROSjava core ( http://wiki.ros.org/rosjava ), which is independent of ROS installation.



Prerequisites:
-------------
Download additional python-based ROS tool and init it:

	pip install -U wstool
	
* 		or download and "python setup.py install" them from here https://github.com/vcstools/
* 		or "sudo apt-get install python-wstool" on linux

Create python virtualenv called nengoros:

download fortran

	brew install gfortran

download virtualenv and wrapper

	sudo pip install virtualenv
	sudo pip install virtualenvwrapper

create ~/.virtualenvs directory

	source /usr/local/bin/virtualenvwrapper.sh 
	
create your virtualenv

	mkvirtualenv nengoros
	source ~/.virtualenvs/nengoros/bin/activate
 
	
"It is activated by default, so running any pip command will only impact this environment. Note that if you deactivate the virtualenv, you will lose access to any packages installed in it. You can switch between virtualenvs with the workon command." [ http://www.thisisthegreenroom.com/2011/installing-python-numpy-scipy-matplotlib-and-ipython-on-lion/ ]


Install scipy and numpy:

	pip install numpy	
	pip install scipy


Installation:
--------------

Make folder with workspace:

	mkdir -p ~/workspace && cd ~/workspace
	
Point the ROS\_PACKAGE_PATH into this folder (add to your ~/.profie or ~/.bashrc file )

	export ROS_PACKAGE_PATH=~/workspace
	
Download nengoros configs

	git clone https://github.com/jvitku/nengoros.git
	
Download and install selected packages (./tool -h)

	cd nengoros
	./tool -unrf



Updating:
--------

The script ./tool can be used for updating the entire multi-project from remote repositories. It does:
	-determines type of installation
	-removes .rosinstall file and creates new with information from *.rosinstall file
	-updates all sub-projects from remote(s)

run this:

	./tool -u
	
	
	
Additional information
-----------------------

There are two choices of installation:

####complete:
*	does not require any other ROS packages and contains ALL additional rosjava nodes (other can be added) and these are supported by nengo GUI

####rosbased:
*	use if you managed to install ROS infrastructure
		
####standalone:   
*	this is similar to "complete" without additional rosjava nodes
*	this version is now deprecated, the nengo GUI layout requires nodes contained in "complete.rosinstall" version
*	use if you managed to install ROS infrastructure and you do not want all nodes 


		
Choose which version to use, e.g. for complete (creates .rosinstal file):

	wstool init -j8 . complete.rosinstall

Run the tool script:

	./tool
*	this will:
*	compile rosjava_core and install it into ~/.m2 repository
*	compile and install other nengoros components (e.g. install jroscore intl ~/.m2 repo and as an application under jroscore)


For more useful features, run:

	./tool -h
