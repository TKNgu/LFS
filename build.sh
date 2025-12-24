#!/bash

# Create partition
FILE_IMAGE=partition.img

if [ -f $FILE_IMAGE ]; then
    echo "File $FILE_IMAGE exit"
else
    truncate -s 15G $FILE_IMAGE
    mkfs.ext4 $FILE_IMAGE
fi

LFS=$PWD/lfs
umask 022

mkdir -pv $LFS
if mount | grep -q $LFS; then
    echo "Partition mounted"
else
    echo "Mount partition"
    sudo mount -o loop $FILE_IMAGE $LFS
    sudo chown -R $USER:$USER $LFS
    chmod 0755 $LFS
fi

#chown root:root $LFS
#chmod 0755 $LFS

# Download sources
mkdir -v $LFS/sources
bash ./download_sources.sh $LFS/sources

# Create folder
mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin} 
for i in bin lib sbin; do
    ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

# setup env
source env.sh

# build tool
bash ./build_toolchain.sh

# build cross tool
bash ./build_cross_tools.sh
echo "Build cross tool done"
