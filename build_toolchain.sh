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

build_linux_headers() {
    tar xvf $SOURCE_FOLDER/linux-6.16.1.tar.xz -C $TMP
    cd $TMP/linux-6.16.1
    make mrproper
    make headers
    find usr/include -type f ! -name '*.h' -delete
    cp -rv usr/include $LFS/usr
}

build_glibc() {
    tar xvf $SOURCE_FOLDER/glibc-2.42.tar.xz -C $TMP
    cd $TMP/glibc-2.42
    case $(uname -m) in
        i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
        ;;
        x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
            ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
        ;;
    esac
    patch -Np1 -i $SOURCE_FOLDER/glibc-2.42-fhs-1.patch
    mkdir -v build
    cd       build
    echo "rootsbindir=/usr/sbin" > configparms
    ../configure                            \
      --prefix=/usr                      \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --disable-nscd                     \
      libc_cv_slibdir=/usr/lib           \
      --enable-kernel=5.4
    make
    make DESTDIR=$LFS install
    sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd
    echo 'int main(){}' | $LFS_TGT-gcc -x c - -v -Wl,--verbose &> dummy.log
    readelf -l a.out | grep ': /lib'
    grep -E -o "$LFS/lib.*/S?crt[1in].*succeeded" dummy.log
    grep -B3 "^ $LFS/usr/include" dummy.log
    grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'
    grep "/lib.*/libc.so.6 " dummy.log
    grep found dummy.log
    rm -v a.out dummy.log
}

build_libstdcpp() {
    cd $TMP/gcc-15.2.0
    mkdir -v build
    cd build
    ../libstdc++-v3/configure      \
        --host=$LFS_TGT            \
        --build=$(../config.guess) \
        --prefix=/usr              \
        --disable-multilib         \
        --disable-nls              \
        --disable-libstdcxx-pch    \
        --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/15.2.0
    make
    make DESTDIR=$LFS install
    rm -v $LFS/usr/lib/lib{stdc++{,exp,fs},supc++}.la
}

build_Binutils
build_gcc
build_linux_headers
build_glibc
build_libstdcpp
