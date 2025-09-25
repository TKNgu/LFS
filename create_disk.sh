#!/bin/bash

if [ -n "$DISK_FILE" ]; then
    echo "Disk file $DISK_FILE"
else
    DISK_FILE=disk.img
    echo "Default $DISK_FILE"
fi

if [ -f "$DISK_FILE" ]; then
    echo "File exit"
else
    truncate -s 15G $DISK_FILE
    mkfs.ext4 $DISK_FILE
fi

if [ -n "$LFS" ]; then
    LFS=root/
fi

mkdir -p $LFS 
sudo umount $LFS 
sudo mount -o loop $DISK_FILE $LFS
sudo chown -R $USER $LFS

mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

mkdir -pv $LFS/tools
