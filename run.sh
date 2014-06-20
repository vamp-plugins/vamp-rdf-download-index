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

ARCH=unknown

case `uname -a` in
Linux*x86_64*) ARCH=linux64;;
Linux*) ARCH=linux32;;
Darwin*) ARCH=osx;;
CYG*) ARCH=win32;;
MINGW*) ARCH=win32;;
esac

if [ "$ARCH" = "unknown" ]; then
    echo "Failed to guess architecture for native libraries, sorry!" 1>&2
    exit 2
fi

VAMP_PATH=$mydir/public/rdf/plugins LD_LIBRARY_PATH="$MAY_DIR/ext/native/$ARCH:$LD_LIBRARY_PATH" java -cp target/classes:spark/target/classes:"$CLASSPATH" pluginlist

