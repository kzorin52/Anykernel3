# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Instaling kernel...
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=sweet
device.name2=sweetin
supported.versions=11 - 13
supported.patchlevels=
'; } # end properties

# shell variables
block=auto;
is_slot_device=0;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;


## AnyKernel boot install
dump_boot;

# magisk
if [ -e /data/adb/magisk.db ]; then
ui_print "Magisk installed, u can disable ksu by adding 'NSU' for avoid conflict"
fi

## start custom  cmd
#  hadeh :)
gladi_resik() {
    patch_cmdline "aghisna.dimen" " "
    patch_cmdline "aghisna.fps" " "
    patch_cmdline "aghisna.ksu" " "
    patch_cmdline "aghisna.hapticm" " "
    patch_cmdline "aghisna.haptico" " "
    patch_cmdline "aghisna.haptica" " "
    patch_cmdline "aghisna.nps" " "
    patch_cmdline "aghisna.kcal" " "
    patch_cmdline "aghisna.klapse" " "
    patch_cmdline "aghisna.hdr" " "
}

# ho ho hooo looks like you are looking for something '-'
# I guess for sure you find out about what is below, right?  '-'
# call function 10x biar seru
X=10
while [ $X != 0 ];
do
    gladi_resik
    X=$(($X-1))
done

cleanup_n_update() {
    local Yaitu="$1"
    local Isinya="$2"
    local X=10
    while [ $X != 0 ];
    do
        patch_cmdline "$Yaitu" " "
        X=$(($X-1))
    done
    if [ "$Isinya" != "null" ];then
        patch_cmdline "$Yaitu" "$Yaitu=$Isinya"
    fi
}

# hayoh mau ngapain?
# panel masbroo
if [ ! -z "$(cat /data/local/aghisna | grep OSS )" ];then
    cleanup_n_update "aghisna.dimen" "0"
    cleanup_n_update "aghisna.haptico" "1"
    ui_print "- OSS option selected"
elif [ ! -z "$(cat /data/local/aghisna | grep ARYN )" ];then
    cleanup_n_update "aghisna.dimen" "0"
    cleanup_n_update "aghisna.haptica" "1"
    ui_print "- Aryan tree's option selected"
elif [ ! -z "$(cat /data/local/aghisna | grep NEO )" ];then
    cleanup_n_update "aghisna.dimen" "1"
    cleanup_n_update "aghisna.haptico" "1"
    ui_print "- Neo Buddy tree's option selected"
elif [ ! -z "$(cat /data/local/aghisna | grep MIUI )" ];then
    cleanup_n_update "aghisna.dimen" "1"
    cleanup_n_update "aghisna.hapticm" "1"
    ui_print "- MIUI option selected"
else
    cleanup_n_update "aghisna.dimen" "0"
    cleanup_n_update "aghisna.haptico" "1"
    ui_print "- info panel not detected, OSS default"
fi

######
if [ ! -z "$(cat /data/local/aghisna | grep 90HZ )" ];then
    cleanup_n_update "aghisna.fps" "1"
    ui_print "- Enable 90HZ option (120~90)"
else
    cleanup_n_update "aghisna.fps" "0"
fi

######
if [ ! -z "$(cat /data/local/aghisna | grep NSU )" ];then
    cleanup_n_update "aghisna.ksu" "0"
    ui_print "- Disable kernelSu"
else
    cleanup_n_update "aghisna.ksu" "1"
fi

######
if [ ! -z "$(cat /data/local/aghisna | grep NPS )" ];then
    cleanup_n_update "aghisna.nps" "0"
    ui_print "- Disable proximity sensor"
else
    cleanup_n_update "aghisna.nps" "1"
fi

# I know you're reading this, so what's your point here?
# let's do something interesting

if [ ! -z "$(ls $home | grep "mie-" )" ];then
    if [ -f $home/mie-kuah ] && [ ! -z "$(cat /data/local/aghisna | grep BQ )" ];then
        cp -af $home/mie-kuah $home/dtbo.img;
        ui_print "- BQ2597x driver charger selected";
    elif [ -f $home/mie-ayam ] && [ ! -z "$(cat /data/local/aghisna | grep LN )" ];then
        cp -af $home/mie-ayam $home/dtbo.img;
        ui_print "- LN8000 driver charger selected";
    else
        cp -af $home/mie-kuah $home/dtbo.img;
        ui_print "- charger driver not detected, BQ2597x default";
    fi
    rm -rf $home/mie-*;
fi

## pembersih
rm -rf /data/local/aghisna;

write_boot;
## end boot install


# shell variables
#block=vendor_boot;
#is_slot_device=1;
#ramdisk_compression=auto;
#patch_vbmeta_flag=auto;

# reset for vendor_boot patching
#reset_ak;


## AnyKernel vendor_boot install
#split_boot; # skip unpack/repack ramdisk since we don't need vendor_ramdisk access

#flash_boot;
## end vendor_boot install


