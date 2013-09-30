This is Nengo-ros, a tool for simulating large-scale hybrid neural systems by Jaroslav Vitku, see: http://artificiallife.co.nf/ . 

The resulting system is composed of:
 	-Nengo ( http://nengo.ca/ ) 
	-and modified version of ROSjava core ( http://wiki.ros.org/rosjava ), which is independent of ROS installation.


=============================== PREREQUISITES:

Download additional python-based ROS tool and init it:

	pip install -U wstool
	
		-or download and "python setup.py install" them from here https://github.com/vcstools/
		-or "sudo apt-get install python-wstool" on linux
		
=============================== INSTALLATION:
There are two choices of installation:
	-rosbased:
		-use if you managed to install ROS infrastructure
	-standalone:
		-does not require any other ROS packages
		

Choose which version to use, e.g. for standalone (creates .rosinstal file):
	wstool init -j8 . standalone.rosinstall

Download all required packages:
	wstool update


Run the install script:
	./install
	
	this will:
		-compile rosjava_core and install it into ~/.m2 repository
		-compile and install jroscore intl ~/.m2 repo and as an application under jroscore/
