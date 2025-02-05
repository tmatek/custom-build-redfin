PRODUCT_SOONG_NAMESPACES += \
    vendor/google/redfin

PRODUCT_COPY_FILES += \
    Telemach/mcfg_sw.mbn:$(TARGET_COPY_OUT_VENDOR)/rfs/msm/mpss/readonly/vendor/mbn/mcfg_sw/generic/Pixel/EU/Telemach/Commercial/pixel_Slovenia/mcfg_sw.mbn \
    mbn_sw.txt:$(TARGET_COPY_OUT_VENDOR)/rfs/msm/mpss/readonly/vendor/mbn/mcfg_sw/mbn_sw.txt

PRODUCT_PRODUCT_PROPERTIES +=\
    persist.dbg.ims_volte_enable=1 \
    persist.dbg.volte_avail_ovr=1