#!/bin/bash

REPO_BASE="/srv/src/LINEAGE_18_1"
VENDOR_BASE="$REPO_BASE/vendor/google/redfin"

# apply Telemach MBN patch
git -C $VENDOR_BASE am < /root/userscripts/Telemach/0001-add-Telemach-MBN-config.patch

# apply Telemach VoLTE patch
git -C $REPO_BASE/packages/apps/CarrierConfig am < /root/userscripts/Telemach/0001-enable-VoLTE-for-Telemach.patch
