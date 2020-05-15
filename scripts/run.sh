#!/bin/bash

rootdir=$(dirname "$0")/..

#if [ ! -f "spark/target/classes/spark/Spark.class" ]; then
#    ( cd spark ; mvn compile ) || exit 1
#fi

# NB path must contain rootdir so that Spark will serve static files from public/
export CLASSPATH="$rootdir/target/classes:$rootdir:"`echo jar/*.jar | sed 's/ /:/g'`
export VAMP_PATH="$rootdir/rdf/plugins:$rootdir/rdf/packs"

# Compile the app!
java yeti.lang.compiler.yeti -d target/classes pluginlist.yeti || exit 1

# Run the app!
java pluginlist

