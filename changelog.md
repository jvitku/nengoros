This document summarizes changes problems and and TODOs.

@author Jaroslav Vitku

Changelog
-----------

###master-v0.0.4
* Added support for the [my modification](https://github.com/jvitku/vivae) of the [Vivae](http://cig.felk.cvut.cz/projects/robo/) simulator. More precisely: the old version of Vivae support was removed from the Nengoros and placed into the `vivae/vivaeplugin` project.

###master-v0.0.2

* Added three possibilities how to sync time between Nengo and ROS nodes: TimeMaster, TimeIgnore and TimeSlave. These are used in the `ca.nengo.util.impl.NodeThreadPool.step()`. 

* Added demos representing time synchronization in the project demonodes/basic, the corresponding python scripts are located under `nr-demo/basic/time*`

###master-v0.0.1

* The first stable version. Version is mainly taken from my older repositories on bitbucket.org. 

* Includes demos on rosjava, ROS nodes and native process.

* Communication with ROS nodes is synchronous or asynchronous


TODO
---------------

### Nengoros Project Dependencies

* TODO add better support for plugins, there should be two main scenarios: 

	* everything as project dependencies (source) (almost current situation) 
	* download everything from maven repository as jars

* Problem with the Vivae plugin:

	* Vivae has plugin which depends on Nengoros AbstractNeuralModule => dependency on Nengo. But in order to install Nengo, the vivae Jar file should be copied into lib folder. 
	* In the current situation, the Vivae has to be compiled (which creates `vivae/vivae[plugin&simulator]/build/libs/*jar`) and these jars are then copied as libraries

### Nengo

* `ca.nengo.util.implNodeThreadPool`: waits for syncedUnits (that is sync. ROS nodes), ask for resending the message?


### Demos

* make demo how to write own RosBackend for support of custom ROS messages


Notes
--------
Hopefully all changes in the nengo project (in the original packages) are marked by the string ///my

Locations of Some Useful Files
-------------------------------


### Nengo Simulator Core:

* everything is under `simulator` project
* waiting for synchedUnits (synchronously running ROS nodes) `ca.nengo.util.impl.NodeThreadPool.step()`. 
* checking how the nodes are called to run their simulation step: `ca.nengo.sim.impl.LocalSimulator.step()`.
* time synchronization between Nengo and ROS: `ca.nengo.util.impl.NodeThreadPool.step()`.

* core was modified to publish simulated time across the ROS network, see: `ca.nengo.util.impl.NodeThreadPool.step()`.

### Nengoros Communication - Make Custom Messages

* Everything necessary to parse new message should be in the `simulator`, package `ctu.nengoros.comm.rosBackend.backend`
* DataTypesMap: add short and long version of name (long has to be the same as type of ROS message (e.g. "std_msgs.Float32MultiArray"), short can be used in jython scripts (e.g. "float"))
* Backend: copy e.g. the file: `ctu.nengoros.comm.rosBackend.backend.impl.FloatBackend` and rewrite it to use your custom messages





