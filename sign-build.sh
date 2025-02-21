#!/bin/bash

rm -rf $KEYS_DIR
mkdir $KEYS_DIR

subject='/C=US/ST=California/L=Mountain View/O=Android/OU=Android/CN=Android/emailAddress=android@android.com'
for x in releasekey platform shared media networkstack
do
  $AOSP_DIR/development/tools/make_key $KEYS_DIR/$x "$subject"
done
