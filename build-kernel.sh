#!/bin/bash

(cd $KERNEL_DIR && ./build_redbull.sh > $LOGS_DIR/build-kernel.txt 2>&1 &)

echo "Build started. Logs in $LOGS_DIR/build-kernel.txt"
