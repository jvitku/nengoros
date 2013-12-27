NengoRos
=========

Official site of this project: [http://nengoros.wordpress.com](http://nengoros.wordpress.com).

This is Nengoros, a tool which merges [Nengo](https://github.com/ctn-waterloo/nengo_1.4) and [rosjava_core](https://github.com/rosjava/rosjava_core) in order to simulate large-scale hybrid neural systems capable of interfacing with real robotic systems. Official site of this project is: 

Author Jaroslav Vitku, research under [Alife group]((http://artificiallife.co.nf/projects/) on [Department of Cybernetics](http://cyber.felk.cvut.cz/) on CTU in Prague. 

The simulator is composed of the following parts (all credits to their authors):

* [Nengo simulator](http://nengo.ca/) - large scale neural simulations (original readme moved to `nengo/README_origNengo.rst`)
* [Rosjava_core](http://wiki.ros.org/rosjava) - java-based implementation of ROS core

	-and potentially with some necessary ROS-components (e.g. [messages](http://wiki.ros.org/std_msgs)) included

Together, these packages provide mostly platform-independent **tool for simulating hybrid neural systems** usable e.g. for experiments with e.g.:

* cognitive modeling
* neuro-evolution
* running simulations of hybrid modular systems composed of arbitrary reusable ([ROS](http://wiki.ros.org/)) nodes
* direct robot control
* ...and much more.

Javadocs
-------------

Javadocs for the nengo/simulator can be found [here](javadoc/nengo-simulator/javadoc/index.html).

Prerequisites:
-------------
##### Download additional python-based ROS **wstool** and init it:

	pip install -U wstool
	

* or download and "python setup.py install" them from [here](https://github.com/vcstools/)
* or "sudo apt-get install python-wstool" on linux


 
##### Create python **virtualenv** called nengoros (optional):

* download fortran

		brew install gfortran

* download virtualenv and wrapper

		sudo pip install virtualenv
		sudo pip install virtualenvwrapper

* create ~/.virtualenvs directory

		source /usr/local/bin/virtualenvwrapper.sh 
	
* create your virtualenv

		mkvirtualenv nengoros
		source ~/.virtualenvs/nengoros/bin/activate
 

##### Install **scipy** and **numpy** (also optional):

	pip install numpy	
	pip install scipy


Installation:
--------------

* Make folder with workspace:

		mkdir -p ~/workspace && cd ~/workspace
	
* In case of ROS not installed, point the ROS\_PACKAGE_PATH into this folder (add to your ~/.profie or ~/.bashrc file )

		export ROS_PACKAGE_PATH=~/workspace
	
* Download Nengoros configuration:

		git clone -b nengoros-master-v0.0.4 https://github.com/jvitku/nengoros.git

	
* Download all repositories and install them (./tool -h)

		cd nengoros
		./tool -unrf


* In Eclipse, import all auto-generated projects from nengoros folder (it is necessary to check the check-box `search for nested projects`, and after importing delete the projectTemplate), clean & build them in Eclipse. 

Running
---------

* Now the simulator can be launched from class files generated by Eclipse. In order to [launch GUI](http://nengo.ca/docs/html/tutorial1.html), start the script under nengo/simulator-ui:

		./nengo
	
* In order to launch [command-line interface](http://nengo.ca/docs/html/scripting_interface.html#running-scripts-from-the-command-line), start the:

		./nengo-cl


Demos
-------

Demos for the Nengoros can be found on the official project site[http://nengoros.wordpress.com](http://nengoros.wordpress.com).

Additionaly, there are two choices how to learn with NengoROS:

##### Learn with Nengo part:
	
* All demos of original Nengo simulator are unchanged and can be found under `nengo/simulator-ui/demo`
* To see detailed information about these demo, go to [Nengo demos](http://nengo.ca/docs/html/tutorial.html) from Waterloo University.

##### Learn with Nengo-ROS part:

* These simple demos show how the modified Nengo can employ ROS nodes in the simulation.
* The demo scripts can be found under: `nengo/simulatori-ui/nr-demo`
* The Nengoros currently features sub-project `demonodes`, where all demos are placed, see its [readme](https://github.com/jvitku/demonodes) for all information.
* To se more information go to [Nengoros tutorials](http://nengoros.wordpress.com/tutorials/). 


Additional information
-----------------------


The tool script is used to update the multi-project from repositories. Now, the complete.rosinstall version is suported. Various older versions are placed under `.versions` folder. In case you want to choose which version to use, e.g. for rosbased (creates .rosinstal file):

	wstool init -j8 . .versions/rosbased.rosinstall

Run the tool script:

	./tool -unrf
	
..this will:

* 	update all repositories from remote
*	compile rosjava_core and install it into ~/.m2 repository
*	compile and install other nengoros components (e.g. install jroscore into ~/.m2 repo and creates runnable application under `jroscore` folder etc..)

###Information about updating Nengoros:

THe script tool can update all projects from remote repositories:

		./tool -h
