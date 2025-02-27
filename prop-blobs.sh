#!/bin/bash

BASE=$(mktemp -d)

curl "https://dl.google.com/dl/android/aosp/redfin-rq3a.211001.001-factory-23f4cec2.zip" > $BASE/redfin-factory.zip
(cd $BASE && unzip redfin-factory.zip)
(cd $BASE/redfin-rq3a.211001.001 && unzip image-redfin-rq3a.211001.001.zip)

source $AOSP_DIR/build/envsetup.sh
(cd $AOSP_DIR && lunch aosp_redfin-user)

for image in vendor system_ext product
do
  (cd $BASE/redfin-rq3a.211001.001 && $AOSP_DIR/out/host/linux-x86/bin/simg2img $image.img $image.raw.img)
  mkdir $BASE/$image
  sudo mount -t ext4 -o ro $BASE/redfin-rq3a.211001.001/$image.raw.img $BASE/$image

  for file in $(grep "^${image}" ./redfin-proprietary-files.txt)
  do
    mkdir -p "$AOSP_DIR/vendor/google_devices/redfin/proprietary/$file"
    cp "$BASE/$file" "$AOSP_DIR/vendor/google_devices/redfin/proprietary/$file"
  done

  sudo umount $BASE/$image
done

cp $BASE/redfin-rq3a.211001.001/radio-redfin-g7250-00132-210419-b-7294132.img $AOSP_DIR/vendor/google_devices/redfin/proprietary
cp $BASE/redfin-rq3a.211001.001/bootloader-redfin-r3-0.3-7241848.img $AOSP_DIR/vendor/google_devices/redfin/proprietary
