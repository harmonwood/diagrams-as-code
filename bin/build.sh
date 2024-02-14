#!/bin/sh
cd $DAC_OUTPUT_LOCATION;
for file in $DAC_LOCATION/*.py; do python3 $file; done
find $DAC_LOCATION -type f \( -name "*.uml" -o -name "*.puml" \) -exec java -jar $JAVA_JARS_LOCATION/plantuml.jar -o $DAC_OUTPUT_LOCATION {} \;
