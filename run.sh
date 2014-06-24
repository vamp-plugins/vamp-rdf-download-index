#!/bin/bash

mydir=`dirname "$0"`

#if [ ! -f "spark/target/classes/spark/Spark.class" ]; then
#    ( cd spark ; mvn compile ) || exit 1
#fi

export CLASSPATH="$mydir/target/classes":`echo jar/*.jar | sed 's/ /:/g'`
export VAMP_PATH="$mydir/rdf/plugins"

# Compile the app!
java yeti.lang.compiler.yeti -d target/classes pluginlist.yeti || exit 1

# Run the app!
java pluginlist

