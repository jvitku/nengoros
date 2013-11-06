This document summarizes changes problems and and TODOs.

@author Jaroslav Vitku

Changelog
-----------


###master-v0.0.1

* The first stable version. Version is mainly taken from my older repositories on bitbucket.org. 

* Includes demos on rosjava, ROS nodes and native process.

* Communication with ROS nodes is synchronous or asyncnrhonous


TODO
---------------

### Nengo

* ca.nengo.util.implNodeThreadPool: waits for syncedUnits (that is sync. ROS nodes), ask for resending the message?

* third type of communication: send time marks (starttime, stoptime) as in the Nengo simulator


### Demos

* make demo how to write own RosBackend for support of custom ROS messages



Notes
--------
Hopefully all changes in the nengo project (in the original packages) are marked by the string ///my

Locations of Some Useful Files
-------------------------------


### Nengo Simulator Core:

* everything is under `simulator` project
* waiting for synchedUnits (synchronously running ROS ndodes) ca.nengo.util.implNodeThreadPool , or ca.nengo.sim.impl.LocalSimulator. 
* checking how the nodes are called to run their simulation step: ca.nengo.sim.impl.LocalSimulator.step(). 

### Nengoros Communication - Make Custom Messages

* Everything necessary to parse new message should be in the `simulator`, package `ctu.nengoros.comm.rosBackend.backend`
* DataTypesMap: add short and long version of name (long has to be the same as type of ROS message (e.g. "std_msgs.Float32MultiArray"), short can be used in jython scripts (e.g. "float"))
* Backend: copy e.g. the file: `ctu.nengoros.comm.rosBackend.backend.impl.FloatBackend` and rewrite it to use your custom messages





