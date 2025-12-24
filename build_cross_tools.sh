#!/bin/bash

build_m4() {
    tar xvf $SOURCE_FOLDER/m4-1.4.20.tar.xz -C $TMP
    cd $TMP/m4-1.4.20
    ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
    make -j3
    make DESTDIR=$LFS install
}

build_ncurses() {
    tar xvf $SOURCE_FOLDER/ncurses-6.5-20250809.tgz -C $TMP
    cd $TMP/ncurses-6.5-20250809
    mkdir build
    pushd build
        ../configure --prefix=$LFS/tools AWK=gawk
        make -C include
        make -C progs tic
        install progs/tic $LFS/tools/bin
    popd
    ./configure --prefix=/usr                \
            --host=$LFS_TGT              \
            --build=$(./config.guess)    \
            --mandir=/usr/share/man      \
            --with-manpage-format=normal \
            --with-shared                \
            --without-normal             \
            --with-cxx-shared            \
            --without-debug              \
            --without-ada                \
            --disable-stripping          \
            AWK=gawk
    make
    make DESTDIR=$LFS install
    ln -sv libncursesw.so $LFS/usr/lib/libncurses.so
    sed -e 's/^#if.*XOPEN.*$/#if 1/' \
        -i $LFS/usr/include/curses.h
}

build_bash() {
    tar xvf $SOURCE_FOLDER/bash-5.3.tar.gz -C $TMP
    cd $TMP/bash-5.3
    ./configure --prefix=/usr                      \
            --build=$(sh support/config.guess) \
            --host=$LFS_TGT                    \
            --without-bash-malloc
    make
    make DESTDIR=$LFS install
    ln -sv bash $LFS/bin/sh
}

build_coreutils() {
    tar xvf $SOURCE_FOLDER/coreutils-9.7.tar.xz -C $TMP
    cd $TMP/coreutils-9.7
    ./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --enable-install-program=hostname \
            --enable-no-install-program=kill,uptime
    make
    make DESTDIR=$LFS install
    mv -v $LFS/usr/bin/chroot              $LFS/usr/sbin
    mkdir -pv $LFS/usr/share/man/man8
    mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
    sed -i 's/"1"/"8"/'                    $LFS/usr/share/man/man8/chroot.8
}

build_diffutils() {
    tar xvf $SOURCE_FOLDER/diffutils-3.12.tar.xz -C $TMP
    cd $TMP/diffutils-3.12
    ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            gl_cv_func_strcasecmp_works=y \
            --build=$(./build-aux/config.guess)
    make 
    make DESTDIR=$LFS install
}

build_file() {
    tar xvf $SOURCE_FOLDER/file-5.46.tar.gz -C $TMP
    cd $TMP/file-5.46
    mkdir build
    pushd build
      ../configure --disable-bzlib      \
               --disable-libseccomp \
               --disable-xzlib      \
               --disable-zlib
      make
    popd
    ./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess)
    make FILE_COMPILE=$(pwd)/build/src/file
    make DESTDIR=$LFS install
    rm -v $LFS/usr/lib/libmagic.la
}

build_findutils() {
    tar xvf $SOURCE_FOLDER/findutils-4.10.0.tar.xz -C $TMP
    cd $TMP/findutils-4.10.0
    ./configure --prefix=/usr                   \
            --localstatedir=/var/lib/locate \
            --host=$LFS_TGT                 \
            --build=$(build-aux/config.guess)
    make
    make DESTDIR=$LFS install
}

build_gawk() {
    tar xvf $SOURCE_FOLDER/gawk-5.3.2.tar.xz -C $TMP
    cd $TMP/gawk-5.3.2
    sed -i 's/extras//' Makefile.in
    ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
    make
    make DESTDIR=$LFS install
}

build_grep() {
    tar xvf $SOURCE_FOLDER/grep-3.12.tar.xz -C $TMP
    cd $TMP/grep-3.12
    ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(./build-aux/config.guess)
    make
    make DESTDIR=$LFS install
}

build_gzip() {
    tar xvf $SOURCE_FOLDER/gzip-1.14.tar.xz -C $TMP
    cd $TMP/gzip-1.14
    ./configure --prefix=/usr --host=$LFS_TGT
    make
    make DESTDIR=$LFS install
}

build_make() {
    tar xvf $SOURCE_FOLDER/make-4.4.1.tar.gz -C $TMP
    cd $TMP/make-4.4.1
    ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
    make
    make DESTDIR=$LFS install
}

build_patch() {
    tar xvf $SOURCE_FOLDER/patch-2.8.tar.xz -C $TMP
    cd $TMP/patch-2.8
    ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
    make
    make DESTDIR=$LFS install
}

build_sed() {
    tar xvf $SOURCE_FOLDER/sed-4.9.tar.xz -C $TMP
    cd $TMP/sed-4.9
    ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(./build-aux/config.guess)
    make
    make DESTDIR=$LFS install
}

build_tar() {
    tar xvf $SOURCE_FOLDER/tar-1.35.tar.xz -C $TMP
    cd $TMP/tar-1.35
    ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
    make
    make DESTDIR=$LFS install
}

build_xz() {
    tar xvf $SOURCE_FOLDER/xz-5.8.1.tar.xz -C $TMP
    cd $TMP/xz-5.8.1
    ./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --disable-static                  \
            --docdir=/usr/share/doc/xz-5.8.1
    make
    make DESTDIR=$LFS install
    rm -v $LFS/usr/lib/liblzma.la
}

build_binutils() {
    tar xvf $SOURCE_FOLDER/binutils-2.45.tar.xz -C $TMP
    cd $TMP/binutils-2.45
    sed '6031s/$add_dir//' -i ltmain.sh
    rm -rf build
    mkdir -v build
    cd       build
    ../configure                   \
        --prefix=/usr              \
        --build=$(../config.guess) \
        --host=$LFS_TGT            \
        --disable-nls              \
        --enable-shared            \
        --enable-gprofng=no        \
        --disable-werror           \
        --enable-64-bit-bfd        \
        --enable-new-dtags         \
        --enable-default-hash-style=gnu
    make
    make DESTDIR=$LFS install
    rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}
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
    sed '/thread_header =/s/@.*@/gthr-posix.h/' \
        -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in
    rm -rf build
    mkdir -v build
    cd       build
    ../configure                   \
        --build=$(../config.guess) \
        --host=$LFS_TGT            \
        --target=$LFS_TGT          \
        --prefix=/usr              \
        --with-build-sysroot=$LFS  \
        --enable-default-pie       \
        --enable-default-ssp       \
        --disable-nls              \
        --disable-multilib         \
        --disable-libatomic        \
        --disable-libgomp          \
        --disable-libquadmath      \
        --disable-libsanitizer     \
        --disable-libssp           \
        --disable-libvtv           \
        --enable-languages=c,c++   \
        LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc

    make -j3
    make DESTDIR=$LFS install
    ln -sv gcc $LFS/usr/bin/cc
}

build_m4
build_ncurses
build_bash
build_coreutils
build_diffutils
build_file
build_findutils
build_gawk
build_grep
build_gzip
build_make
build_patch
build_sed
build_tar
build_xz
build_binutils
build_gcc
