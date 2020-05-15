#!/bin/bash

set -eu

./repoint install

( cd yeti ; ant && cp *.jar ../jar && rm asm*.jar )
( cd yertle ; ant && cp yertle.jar ../jar && cp yertle.jar ../may/ext/jar/ )
( cd jvamp ; make jvamp.jar && cp jvamp.jar ../jar && cp jvamp.jar ../may/ext/jar )
( cd may ; ant && cp may.jar ../jar )
( cd spark ; mvn package && rm -f ../jar/spark*.jar && cp target/spark*.jar ../jar/ )

echo "Dependencies built, now run scripts/run.sh to run in test environment"
