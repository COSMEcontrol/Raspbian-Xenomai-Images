#!/bin/bash
#####################################################
#### Alberto Azuara
#### Versión 1.0
#### 12/01/15
#### Download and copy image Raspbian-Xenomai
#####################################################

URL_IMAGE_PART1="https://github.com/COSMEcontrol/RaspbianXenomai-Images/releases/download/3.8.13/Raspbian_3.8.13_Xenomai.img.7z.001"
URL_IMAGE_PART2="https://github.com/COSMEcontrol/RaspbianXenomai-Images/releases/download/3.8.13/Raspbian_3.8.13_Xenomai.img.7z.002"
URL_IMAGE_PART3="https://github.com/COSMEcontrol/RaspbianXenomai-Images/releases/download/3.8.13/Raspbian_3.8.13_Xenomai.img.7z.003"
URL_IMAGE_PART4="https://github.com/COSMEcontrol/RaspbianXenomai-Images/releases/download/3.8.13/Raspbian_3.8.13_Xenomai.img.7z.004"
ruta_sd=""

#check if I root
if [[ $EUID -ne 0 ]]; then
	echo "[Error] This script must be run by the root user.  "
	exit 1
fi

echo "[*] Checking utilities compilation ... "
type 7z > /dev/null 2>&1 || { echo >&2 "[!] Install \"decompressor 7z (apt-get install p7zip-full)\""; read -p "Press [Enter] to continue..."; exit 1; }

while [ -f $ruta_sd ]
do
	echo "[*] Enter the full path of SD card reader (/dev/mmcblk0)"
	read ruta_sd
done
rm -rf downloads/*
mkdir downloads/
cd downloads/
echo "[*] Downloading all parts of the image repository Raspbian-Xenomai... "
wget $URL_IMAGE_PART1
wget $URL_IMAGE_PART2
wget $URL_IMAGE_PART3
wget $URL_IMAGE_PART4
echo "ok! "

echo "[*] Decompressing and joining the parts of the RaspbianRT... "
7z x Raspbian_3.8.13_Xenomai.img.7z.001
echo "ok! "

echo "[*] Copying the image into device ... "
dd if=Raspbian_3.8.13_Xenomai.img  of=$ruta_sd
echo "ok! "

echo "[*] Removing unnecessary items ... "
rm Raspbian_3.8.13_Xenomai.img.7z.001
rm Raspbian_3.8.13_Xenomai.img.7z.002
rm Raspbian_3.8.13_Xenomai.img.7z.003
rm Raspbian_3.8.13_Xenomai.img.7z.004
rm Raspbian_3.8.13_Xenomai.img
echo "ok! "
echo "[*] Ready!"

exit 0
