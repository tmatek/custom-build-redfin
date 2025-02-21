#!/bin/bash

source $AOSP_DIR/build/envsetup.sh

(cd $AOSP_DIR && lunch aosp_redfin-user)

(cd $AOSP_DIR && make target-files-package otatools > $LOGS_DIR/build-aosp.txt 2>&1 &)

echo "Build started. Logs in $LOGS_DIR/build-aosp.txt"
