#!/bin/sh
# 
# by Jaroslav Vitku [vitkujar@fel.cvut.cz]
#
# After downloading the project into your computer, run this script to 
# install rosjava libraries and initialize Nengoros project tree
#
# This script does by default:
#   -compiles rosjava and installs it into local maven repository (~/.m2/repository/)
#       -this repository is then used by nengoros and by arbitrary other rosjava nodes 
#   -builds all nengoros projects without running tests (TODO: some nengo tests fail)
#   -creates eclipse projects for everything useful in nengoros multi-project
#
#  Script can be used for updating project, run ./tool -h
# 
# note that all (rosjava-dependent) projects are dependent on maven rosjava installation
# this should be easily changed though..
#
# Args parsing based on: http://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash


usage()
{

    echo "\nThis script installs rosjava_core and/or nengoros project tree. Usage:\n"
    echo "-h|help|?     this help"
    echo "-r            (re-)install rosjava_core into ~/.m2/repository (e.g. if you added new message files)"
    echo "-n            (re-)install nengoros project tree"
    echo "-u            UPDATE the entire multiproject from remote repositories"
    echo "-f            FORCE ~ do not run unit tests \n"
}

##################################################### Find variables
prereqs(){
    cd $BASE
    # The ROS_PACKAGE_PATH should point to the ROS installation and/or to the current folder
    echo "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
    echo "   XXXXXXXX Checking the ROS_PACKAGE_PATH .."
    echo "      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n"

    # Basically: ROS installation sets this path to its own ros/[ROS-version]/share folder
    # If this path is not set, ROS is probably not installed and this script presumes the 
    # rosjava_core installation as a standalone version => sets the path to the current folder.
    # 
    # 
    # Note that user may want to use custom messages (e.g. for vivae simulator) which are not defined 
    # in this folder. In this case, add these messages to $ROS_PACKAGE_PATH and rerun this script! 
    IGNORELOCAL=0        # should we ignore messages in the current folder if ROS found?

    if [ -z "$ROS_PACKAGE_PATH" ]; then
    	echo "ROS probably not installed (ROS_PACKAGE_PATH not set) setting it to PWD.." 
        	export ROS_PACKAGE_PATH=$PWD
    else
    	if [ "$IGNORELOCAL" -eq "1" ]; then
    		echo "ROS_PACKAGE_PATH is already set, and we should ignore local messages. Doing nothing.."
    	else
    		echo "ROS_PACKAGE_PATH is set, adding this directory at the end."
    		export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$PWD
    	fi
    fi

    echo "ROS_PACKAGE_PATH="$ROS_PACKAGE_PATH 

    echo "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
    echo "   XXXXXXXX Sourcing nengoros virtualenv .."
    echo "      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n"

    ENVNAME="nengoros"
    if [ -f ~/.virtualenvs/$ENVNAME/bin/activate ]; then
        source ~/.virtualenvs/$ENVNAME/bin/activate
        echo "~/.virtualenvs/$ENVNAME/bin/activate sourced OK"
    else
        echo "Warning: python virtualenv not found, this environment not sourced: ~/.virtualenvs/$ENVNAME"
    fi
}

##################################################### Update all
update(){
    echo "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
    echo "   XXXXXXX Updating Nengo-ros project from github"
    echo "      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n"

    git pull origin

    # Check which version is installed: rosbased or standalone?
    # Standalone contains 'common_msgs' meta-package:
    STD=$(cat .rosinstall | grep common_msgs)
    rm .rosinstall

    if [ ! -z "$STD" -a "$STD" != " " ]; then
        echo "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
        echo "   XXXXXXX Re-initializing workspace with standalone.rosinstall file"
        echo "      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n"
        wstool init -j8 . standalone.rosinstall
    else
        echo "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
        echo "   XXXXXXX Re-initializing workspace with rosbased.rosinstall file"
        echo "      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n"
        wstool init -j8 . rosbased.rosinstall
    fi
    echo "\nNote: if your repositories were not all up-to date, consider re-running this with -nr arguments.\n"
}

##################################################### Deploy Rosjava
deploy(){
    # simulator-ui/nengo script uses rosjava from local jar file so copy the results into the place
    # TODO make this somehow nicer (without changes in original rosjava_core)

    R=rosjava_core
    BL=build/libs
    SUFF=-0.0.0-SNAPSHOT.jar
    DEST=nengo/lib-rosjava/
    
    # note: not all of these are used by nengo
    cp $R/apache_xmlrpc_client/$BL/apache_xmlrpc_client$SUFF $DEST
    cp $R/apache_xmlrpc_common/$BL/apache_xmlrpc_common$SUFF $DEST
    cp $R/apache_xmlrpc_server/$BL/apache_xmlrpc_server$SUFF $DEST
    cp $R/rosjava/$BL/rosjava$SUFF $DEST
    cp $R/rosjava_benchmarks/$BL/rosjava_benchmarks$SUFF $DEST
    cp $R/rosjava_bootstrap/$BL/rosjava_bootstrap$SUFF $DEST
    cp $R/rosjava_geometry/$BL/rosjava_geometry$SUFF $DEST
    cp $R/rosjava_messages/$BL/rosjava_messages$SUFF $DEST
    cp $R/rosjava_test/$BL/rosjava_test$SUFF $DEST
    cp $R/rosjava_tutorial_pubsub/$BL/rosjava_tutorial_pubsub$SUFF $DEST
    cp $R/rosjava_tutorial_right_hand_rule/$BL/rosjava_tutorial_right_hand_rule$SUFF $DEST
    cp $R/rosjava_tutorial_services/$BL/rosjava_tutorial_services$SUFF $DEST
}

##################################################### Build Rosjava
rosjava(){
    cd $BASE
    echo "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
    echo "   XXXXXXX Building rosjava and installing it to local maven repository"
    echo "      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n"
    cd rosjava_core
    # note: after runnign this script, project rosjava/rosjava_messages/.classpath could contain
    # duplicate entry. This is due to Gradle error, e.g. delete one entry (and refresh Eclipse)
    if [ -f rosjava_messages/.classpath ]; then rm rosjava_messages/.classpath
    fi

    # gradle error, duplicate entry path="org.eclipse.jdt.launching.JRE_CONTAINER"
    if [ -f ../nengo/simulator/.classpath ]; then rm ../nengo/simulator/.classpath 
    fi
    if [ -f ../nengo/simulator-ui/.classpath ]; then rm ../nengo/simulator-ui/.classpath 
    fi

    # Nengo tests can fail, authors say that it is OK, so continue after fails
    if [ $F = "1" ]; then
        ./gradlew install eclipse --continue -x test
    else
        ./gradlew install eclipse --continue
    fi
    
    deploy
}


##################################################### Build Nengoros
nengoros(){
    cd $BASE
    
    echo "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
    echo "   XXXXXXX Building and installing the Nengoros multiproject"
    echo "      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n"
    
    if [ $F = "1" ]; then
        ./gradlew install eclipse -x test
    else
        ./gradlew install eclipse
    fi

    # we actually do not wont top-level projects to be imported in eclipse (but the lower ones)
    # TODO: make this nicer
    rm nengo/.project
    rm .project
}

##################################################### Parse command line
BASE=$PWD       # remember our place
R=0             # Rosjava
N=0             # Nengoros
F=0             # Force == do not run tests
U=0             # Update from remote repos?

OPTIND=1        # Reset in case getopts has been used previously in the shell.
while getopts "ufh?helprosjavarnengon:" opt; do
    case "$opt" in
    h|\?|help)
        usage
        exit 0
        ;;
    rosjava|r)
        R=1
        ;;
    nengoros|n)
        N=1
        ;;
    f)
        F=1
        ;;
    u)
        U=1
        ;;
    esac
done

shift $((OPTIND-1))
[ "$1" = "--" ] && shift

##################################################### Do it
prereqs

# recompile rosjava and nengoros by default
if [ $R = "0" -a $N = "0" -a $U = "0" ]; then
    rosjava
    nengoros
fi

if [ $U = "1" ]; then
    update
fi

if [ $R = "1" ]; then
    rosjava
fi

if [ $N = "1" ]; then
    nengoros
fi

echo "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
echo "   XXXXXXX All done.. "
echo "      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n"


#echo "\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
#echo "   XXXXXXX Installing subproject testnodes also as an application (so you can run: ./run org...)"
#echo "      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n"

#cd testnodes
#./gradlew install installApp
