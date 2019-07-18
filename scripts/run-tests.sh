#!/bin/sh

# if any command inside script returns error, exit and return that error 
set -e

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
cd $SCRIPT_DIR/..

 
echo "Running tests..."

./gradlew test --quiet

if [[ $? -eq 0 ]]; then
    echo "Tests passed."
fi
