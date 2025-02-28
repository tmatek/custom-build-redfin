#!/bin/bash

rm -rf $KEYS_DIR
mkdir $KEYS_DIR

subject='/C=US/ST=California/L=Mountain View/O=Android/OU=Android/CN=Android/emailAddress=android@android.com'
for x in releasekey platform shared media networkstack
do
  $AOSP_DIR/development/tools/make_key $KEYS_DIR/$x "$subject"
done

# extract public key for AVB
openssl pkcs8 -in $KEYS_DIR/releasekey.pk8 -inform DER -out $KEYS_DIR/releasekey.key -nocrypt

source $AOSP_DIR/build/envsetup.sh

(cd $AOSP_DIR && lunch aosp_redfin-user && ./out/host/linux-x86/bin/sign_target_files_apks -o --default_key_mappings $KEYS_DIR \
  ./out/target/product/redfin/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip ./out/signed-target-files.zip > $LOGS_DIR/sign-build.txt 2>&1 &)

echo "Signing started. Logs in $LOGS_DIR/sign-build.txt"
