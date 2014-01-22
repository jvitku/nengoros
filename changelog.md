Development of the Project 
======================================
This document describes mainly changes in the original [Nengo](http://nengo.ca/) simulator, the chapter `TODO` describes what should/could be done further. 


###nengoros-master-v0.0.5
* Completely rewritten NeuralModule and DefaultNeuralModule. 

* Added support for multiple Terminations for Encoder. Each Encoder now has MultiTermination. Now, the following can be used to add the weighted Termination `module2.newTerminationFor(F2FPubSub.ann2ros,[0.01,0.1,0.02,0.02])`, see `nr-demo/basic/multitermination.py`.
* Written nicer documentation and generated javadoc for all sub-projects (available also online on new [webpage](http://jvitku.github.io/nengoros/))
* Added unit tests 
* Found and fixed many bugs (e.g. in RosUtils)
* Code is now much cleaner

###nengoros-master-v0.0.4
* Added support for the [my modification](https://github.com/jvitku/vivae) of the [Vivae](http://cig.felk.cvut.cz/projects/robo/) simulator. More precisely: the old version of Vivae support was removed from the Nengoros and placed into the `vivae/vivaeplugin` project.

###nengoros-master-v0.0.2

* Added three possibilities how to sync time between Nengo and ROS nodes: TimeMaster, TimeIgnore and TimeSlave. These are used in the `ca.nengo.util.impl.NodeThreadPool.step()`. 

* Added demos representing time synchronization in the project demonodes/basic, the corresponding python scripts are located under `nr-demo/basic/time*`

###nengoros-master-v0.0.1

* The first stable version. Version is mainly taken from my older repositories on bitbucket.org. 

* Includes demos on rosjava, ROS nodes and native process.

* Communication with ROS nodes is synchronous or asynchronous


TODO
==========================


# Simulator Core and General

* TimeUtils now require to be running when the RosUtils is not launched, TODO get rid of this:


	ca.nengo.model.impl.ProjectionImplTest > testAddBias2D STANDARD_ERROR
   		[RosUtils]: error! TimeUtil not initialized yet!

* Better implementation of waiting for `SynchedUnit`s?

* Better handling of Exceptions

* Deprecated ParameterHandler, is launched twice? Delete the deprecated one, use the one in RosUtils?


# ROS integration into Nengo

* Add default value to the termination, so the unconnected configuration will remain on default values, not zero (learning algorithms such as RL do not work well with learning par.=0)

* Choose some method how to **check** whether the ROS nodes are set up and **ready** (now it may be necessary to wait several milliseconds before using the node in synchronous mode)

* Enable sending/receiving entire `RealOutput` value (multiple values) over the ROS network 

	* Sending is done in the `ctu.nengoros.modules.impl.DefaultNeuraoModule.runAllEncoders()`, and therefore in the `Encoder.run()`
	* Receiving values from the ROS network is done asynchronously (events) in the Decoder class.
	
* Enable encoding, sending and decoding `SpikeOutput` to/from the ROS messages. 

	* This requires ROS nodes with support of `SpikeOutput`


# ROS support 

* Encoding/Decoding multidimensional messages. Test it.