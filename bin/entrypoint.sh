#!/bin/sh

# Check if MY_ENV_VAR is set to a specific value
if [ "$RUN_AS_TASK" = "true" ]; then
    # Execute command A
    exec /opt/bin/build.sh
else
    # Execute command B
    exec tail -f /dev/null
fi
