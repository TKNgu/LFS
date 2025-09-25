#!/bin/bash

build_Binutils() {
    tar xvf $SOURCE_FOLDER/binutils-2.45.tar.xz -C $TMP
    cd $TMP/binutils-2.45
    mkdir -v build/
    cd build/
    ../configure --prefix=$LFS/tools \
             --with-sysroot=$LFS \
             --target=$LFS_TGT   \
             --disable-nls       \
             --enable-gprofng=no \
             --disable-werror    \
             --enable-new-dtags  \
             --enable-default-hash-style=gnu
    make -j3
    make install
}

build_gcc() {
    tar xvf $SOURCE_FOLDER/gcc-15.2.0.tar.xz -C $TMP
    cd $TMP/gcc-15.2.0
    tar -xf $SOURCE_FOLDER/mpfr-4.2.2.tar.xz
    mv -v mpfr-4.2.2 mpfr
    tar -xf $SOURCE_FOLDER/gmp-6.3.0.tar.xz
    mv -v gmp-6.3.0 gmp
    tar -xf $SOURCE_FOLDER/mpc-1.3.1.tar.gz
    mv -v mpc-1.3.1 mpc
    
    case $(uname -m) in
        x86_64)
        sed -e '/m64=/s/lib64/lib/' \
            -i.orig gcc/config/i386/t-linux64
    ;;
    esac
    mkdir -v build
    cd       build
    ../configure                  \
        --target=$LFS_TGT         \
        --prefix=$LFS/tools       \
        --with-glibc-version=2.42 \
        --with-sysroot=$LFS       \
        --with-newlib             \
        --without-headers         \
        --enable-default-pie      \
        --enable-default-ssp      \
        --disable-nls             \
        --disable-shared          \
        --disable-multilib        \
        --disable-threads         \
        --disable-libatomic       \
        --disable-libgomp         \
        --disable-libquadmath     \
        --disable-libssp          \
        --disable-libvtv          \
        --enable-languages=c,c++

    make -j3
    make install
    cd ..
    cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
        `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include/limits.h
}

# build_Binutils
build_gcc
