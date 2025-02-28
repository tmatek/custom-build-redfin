#!/bin/bash

git -C $AOSP_DIR/device/google/redfin restore aosp_redfin.mk

source $AOSP_DIR/build/envsetup.sh
(cd $AOSP_DIR && lunch $DEVICE_CONFIG && make otatools)

BASE=$(mktemp -d)

curl "https://dl.google.com/dl/android/aosp/redfin-rq3a.211001.001-factory-23f4cec2.zip" > $BASE/redfin-factory.zip
(cd $BASE && unzip redfin-factory.zip)
(cd $BASE/redfin-rq3a.211001.001 && unzip image-redfin-rq3a.211001.001.zip)

for image in vendor system_ext product
do
  (cd $BASE/redfin-rq3a.211001.001 && $AOSP_DIR/out/host/linux-x86/bin/simg2img $image.img $image.raw.img)
  mkdir $BASE/$image
  sudo mount -t ext4 -o ro $BASE/redfin-rq3a.211001.001/$image.raw.img $BASE/$image

  for file in $(grep "^${image}" ./redfin-proprietary-files.txt)
  do
    mkdir -p "$AOSP_DIR/vendor/google/redfin/proprietary/$(dirname $file)"
    cp "$BASE/$file" "$AOSP_DIR/vendor/google/redfin/proprietary/$(dirname $file)"
  done

  sudo umount $BASE/$image
done

cp $BASE/redfin-rq3a.211001.001/radio-redfin-g7250-00132-210419-b-7294132.img $AOSP_DIR/vendor/google/redfin/proprietary/radio.img
cp $BASE/redfin-rq3a.211001.001/bootloader-redfin-r3-0.3-7241848.img $AOSP_DIR/vendor/google/redfin/proprietary/bootloader.img
cp -a ./patches/vendor-redfin/. $AOSP_DIR/vendor/google/redfin/

# time to fix errors in proprietary blobs
# https://github.com/LineageOS/android_device_google_redfin/blob/lineage-18.1/extract-files.sh
sed -i 's/xml version="2.0"/xml version="1.0"/' $AOSP_DIR/vendor/google/redfin/proprietary/product/etc/permissions/vendor.qti.hardware.data.connection-V1.0-java.xml
sed -i 's/qulacomm/qualcomm/' $AOSP_DIR/vendor/google/redfin/proprietary/product/etc/sysconfig/nexus.xml

sed -i -e '/<?xml/d' -e '1i <?xml version="1.0" encoding="UTF-8"?>' $AOSP_DIR/vendor/google/redfin/proprietary/vendor/etc/data/netmgr_config.xml
sed -i -e '/<?xml/d' -e '1i <?xml version="1.0" encoding="UTF-8"?>' $AOSP_DIR/vendor/google/redfin/proprietary/vendor/etc/data/dsi_config.xml

# patch location of proprietary blobs
git -C $AOSP_DIR/device/google/redfin apply $PWD/patches/patch_redfin_device_mkfile.diff
