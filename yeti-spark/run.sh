#!/bin/bash
#
# This script is (I hope) just a stopgap

MAY_DIR=~/code/may
YETI_DIR=~/code/yeti

( cd spark ; mvn compile ) || exit 1

CLASSPATH=`find ~/.m2 "$MAY_DIR" -name \*.jar -print0 | sed 's/\x00/:/g'`:"$YETI_DIR/yeti-lib.jar"

"$MAY_DIR/bin/yc" -d target/classes -cp "spark/target/classes:$CLASSPATH" ./helloworld.yeti || exit 1

LD_LIBRARY_PATH="$MAY_DIR/ext/native/linux64:$LD_LIBRARY_PATH" java -cp target/classes:spark/target/classes:"$CLASSPATH" helloworld

