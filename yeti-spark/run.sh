#!/bin/bash
#
# This script is (I hope) just a stopgap

mydir=`dirname "$0"`

MAY_DIR=~/code/may
YETI_DIR=~/code/yeti

if [ ! -f "spark/target/classes/spark/Spark.class" ]; then
    ( cd spark ; mvn compile ) || exit 1
fi

CLASSPATH=`find ~/.m2 "$MAY_DIR" -name \*.jar -print0 | sed 's/\x00/:/g'`:"$YETI_DIR/yeti-lib.jar"

"$MAY_DIR/bin/yc" -d target/classes -cp "spark/target/classes:$CLASSPATH" ./pluginlist.yeti || exit 1

platform_tag=linux32

VAMP_PATH=$mydir/../rdf/plugins:$HOME/vamp LD_LIBRARY_PATH="$MAY_DIR/ext/native/$platform_tag:$LD_LIBRARY_PATH" java -cp target/classes:spark/target/classes:"$CLASSPATH" pluginlist

