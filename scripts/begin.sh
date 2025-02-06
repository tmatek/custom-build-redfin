#!/bin/bash

# copy custom modem config to proprietary blobs directory
mkdir -p /srv/src/LINEAGE_18_1/vendor/google/redfin/proprietary/vendor/rfs/msm/mpss/readonly/vendor/mbn/mcfg_sw/generic/Pixel/EU/Telemach/Commercial/pixel_Slovenia
cp /root/userscripts/Telemach/mcfg_sw.mbn $_
echo "mcfg_sw/generic/Pixel/EU/Telemach/Commercial/pixel_Slovenia/mcfg_sw.mbn" >> /srv/src/LINEAGE_18_1/vendor/google/redfin/proprietary/vendor/rfs/msm/mpss/readonly/vendor/mbn/mcfg_sw/mbn_sw.txt

# enable VoLTE for Telemach
cp /root/userscripts/Telemach/carrier_config_carrierid_1712_Tusmobil-doo.xml /srv/src/LINEAGE_18_1/packages/apps/CarrierConfig/assets/carrier_config_carrierid_1712_Tusmobil-doo.xml

# override user-builds signature spoofing patch to work with LineageOS 18.1
cp /root/userscripts/android_frameworks_base-user_build.patch /root/signature_spoofing_patches/android_frameworks_base-user_build.patch
