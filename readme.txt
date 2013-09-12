This is Nengo-ros, a tool for simulating large-scale hybrid neural systems by Jaroslav Vitku, see: http://artificiallife.co.nf/ . 

The resulting system is composed of:
 	-Nengo ( http://nengo.ca/ ) 
	-and modified version of ROSjava core ( http://wiki.ros.org/rosjava ), which is independent of ROS installation.



=============================== PREREQUISITES:

Download additional python-based ROS tools and init them:

	pip install -U rosdep
	pip install -U wstool
	
		-or download and "python setup.py install" them from here https://github.com/vcstools/
		-or "sudo apt-get install python-rosdep" on linux
		
	sudo rosdep init
	rosdep update

=============================== INSTALLATION:

Note: this describes installation of tool which uses standalone version of rosjava.

Download this list repo containing list of packages in the .rosinstall file.

Download all required packages:
	wstool update

Set ROS_PACKAGE_PATH to current directory	
	export ROS_PACKAGE_PATH=path_to/nengo-ros

Compile rosjava_core:
	cd rosjava_core
	./gradlew build