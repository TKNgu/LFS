#!/bin/bash

if [ -n "$SOURCE_FOLDER" ]; then
    echo "Source $SOURCE_FOLDER"
else
    SOURCE_FOLDER="source"
    mkdir -p $SOURCE_FOLDER
    echo "Default $SOURCE_FOLDER"
fi 

download_source() {
    packet_name=$1
    packet_url=$2
    packet_md5=$3

    if [ -f $SOURCE_FOLDER/$packet_name ]; then
        echo "Skip file $packet_name"
    else
        aria2c -x 4 -s 4 -d $SOURCE_FOLDER -o $packet_name $packet_url
        if [ "$(md5sum $SOURCE_FOLDER/$packet_name | awk '{print $1}')" = $packet_md5 ]; then
            echo "MD5 success."
        else
            echo "MD5 failed."
            exit
        fi
    fi
}

download_source acl-2.3.2.tar.xz \
    https://download.savannah.gnu.org/releases/acl/acl-2.3.2.tar.xz \
    590765dee95907dbc3c856f7255bd669

download_source attr-2.5.2.tar.gz \
    https://download.savannah.gnu.org/releases/attr/attr-2.5.2.tar.gz \
    227043ec2f6ca03c0948df5517f9c927

download_source autoconf-2.72.tar.xz \
    https://ftp.gnu.org/gnu/autoconf/autoconf-2.72.tar.xz \
    1be79f7106ab6767f18391c5e22be701

download_source automake-1.18.1.tar.xz \
    https://ftp.gnu.org/gnu/automake/automake-1.18.1.tar.xz \
    cea31dbf1120f890cbf2a3032cfb9a68

download_source bash-5.3.tar.gz \
    https://ftp.gnu.org/gnu/bash/bash-5.3.tar.gz \
    977c8c0c5ae6309191e7768e28ebc951

download_source bc-7.0.3.tar.xz \
    https://github.com/gavinhoward/bc/releases/download/7.0.3/bc-7.0.3.tar.xz \
    ad4db5a0eb4fdbb3f6813be4b6b3da74

download_source binutils-2.45.tar.xz \
    https://sourceware.org/pub/binutils/releases/binutils-2.45.tar.xz \
    dee5b4267e0305a99a3c9d6131f45759

download_source bison-3.8.2.tar.xz \
    https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.xz \
    c28f119f405a2304ff0a7ccdcc629713

download_source bzip2-1.0.8.tar.gz \
    https://www.sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz \
    67e051268d0c475ea773822f7500d0e5

download_source coreutils-9.7.tar.xz \
    https://ftp.gnu.org/gnu/coreutils/coreutils-9.7.tar.xz \
    6b7285faf7d5eb91592bdd689270d3f1

download_source dejagnu-1.6.3.tar.gz \
    https://ftp.gnu.org/gnu/dejagnu/dejagnu-1.6.3.tar.gz \
    68c5208c58236eba447d7d6d1326b821

download_source diffutils-3.12.tar.xz \
    https://ftp.gnu.org/gnu/diffutils/diffutils-3.12.tar.xz \
    d1b18b20868fb561f77861cd90b05de4

download_source e2fsprogs-1.47.3.tar.gz \
    https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.47.3/e2fsprogs-1.47.3.tar.gz \
    113d7a7ee0710d2a670a44692a35fd2e

download_source elfutils-0.193.tar.bz2 \
    https://sourceware.org/ftp/elfutils/0.193/elfutils-0.193.tar.bz2 \
    ceefa052ded950a4c523688799193a44

download_source expat-2.7.1.tar.xz \
    https://github.com/libexpat/libexpat/releases/download/R_2_7_1/expat-2.7.1.tar.xz \
    9f0c266ff4b9720beae0c6bd53ae4469

download_source expect5.45.4.tar.gz \
    https://prdownloads.sourceforge.net/expect/expect5.45.4.tar.gz \
    00fce8de158422f5ccd2666512329bd2

download_source file-5.46.tar.gz \
    https://astron.com/pub/file/file-5.46.tar.gz \
    459da2d4b534801e2e2861611d823864

download_source findutils-4.10.0.tar.xz \
    https://ftp.gnu.org/gnu/findutils/findutils-4.10.0.tar.xz \
    870cfd71c07d37ebe56f9f4aaf4ad872

download_source flex-2.6.4.tar.gz \
    https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz \
    2882e3179748cc9f9c23ec593d6adc8d

download_source flit_core-3.12.0.tar.gz \
    https://pypi.org/packages/source/f/flit-core/flit_core-3.12.0.tar.gz \
    c538415c1f27bd69cbbbf3cdd5135d39

download_source gawk-5.3.2.tar.xz \
    https://ftp.gnu.org/gnu/gawk/gawk-5.3.2.tar.xz \
    b7014650c5f45e5d4837c31209dc0037

download_source gcc-15.2.0.tar.xz \
    https://ftp.gnu.org/gnu/gcc/gcc-15.2.0/gcc-15.2.0.tar.xz \
    b861b092bf1af683c46a8aa2e689a6fd

download_source gdbm-1.26.tar.gz \
    https://ftp.gnu.org/gnu/gdbm/gdbm-1.26.tar.gz \
    aaa600665bc89e2febb3c7bd90679115

download_source gettext-0.26.tar.xz \
    https://ftp.gnu.org/gnu/gettext/gettext-0.26.tar.xz \
    8e14e926f088e292f5f2bce95b81d10e

download_source glibc-2.42.tar.xz \
    https://ftp.gnu.org/gnu/glibc/glibc-2.42.tar.xz \
    23c6f5a27932b435cae94e087cb8b1f5

download_source gmp-6.3.0.tar.xz \
    https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz \
    956dc04e864001a9c22429f761f2c283

download_source gperf-3.3.tar.gz \
    https://ftp.gnu.org/gnu/gperf/gperf-3.3.tar.gz \
    31753b021ea78a21f154bf9eecb8b079

download_source grep-3.12.tar.xz \
    https://ftp.gnu.org/gnu/grep/grep-3.12.tar.xz \
    5d9301ed9d209c4a88c8d3a6fd08b9ac

download_source groff-1.23.0.tar.gz \
    https://ftp.gnu.org/gnu/groff/groff-1.23.0.tar.gz \
    5e4f40315a22bb8a158748e7d5094c7d

download_source grub-2.12.tar.xz \
    https://ftp.gnu.org/gnu/grub/grub-2.12.tar.xz \
    60c564b1bdc39d8e43b3aab4bc0fb140

download_source gzip-1.14.tar.xz \
    https://ftp.gnu.org/gnu/gzip/gzip-1.14.tar.xz \
    4bf5a10f287501ee8e8ebe00ef62b2c2

download_source iana-etc-20250807.tar.gz \
    https://github.com/Mic92/iana-etc/releases/download/20250807/iana-etc-20250807.tar.gz \
    de0a909103d4ff59d1424c5ec7ac9e4a

download_source inetutils-2.6.tar.xz \
    https://ftp.gnu.org/gnu/inetutils/inetutils-2.6.tar.xz \
    401d7d07682a193960bcdecafd03de94

download_source intltool-0.51.0.tar.gz \
    https://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz \
    12e517cac2b57a0121cda351570f1e63

download_source iproute2-6.16.0.tar.xz \
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.16.0.tar.xz \
    80e1f91bf59d572acc15d5c6eb4f3e7c

download_source jinja2-3.1.6.tar.gz \
    https://pypi.org/packages/source/J/Jinja2/jinja2-3.1.6.tar.gz \
    66d4c25ff43d1deaf9637ccda523dec8

download_source kbd-2.8.0.tar.xz \
    https://www.kernel.org/pub/linux/utils/kbd/kbd-2.8.0.tar.xz \
    24b5d24f7483726b88f214dc6c77aa41

download_source kmod-34.2.tar.xz \
    https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-34.2.tar.xz \
    36f2cc483745e81ede3406fa55e1065a

download_source less-679.tar.gz \
    https://www.greenwoodsoftware.com/less/less-679.tar.gz \
    0386dc14f6a081a94dfb4c2413864eed

download_source lfs-bootscripts-20250827.tar.xz \
    https://www.linuxfromscratch.org/lfs/downloads/12.4/lfs-bootscripts-20250827.tar.xz \
    3f661c64c2dfb55025767ed56074d059

download_source libcap-2.76.tar.xz \
    https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.76.tar.xz \
    449ade7d620b5c4eeb15a632fbaa4f74

download_source libffi-3.5.2.tar.gz \
    https://github.com/libffi/libffi/releases/download/v3.5.2/libffi-3.5.2.tar.gz \
    92af9efad4ba398995abf44835c5d9e9

download_source libpipeline-1.5.8.tar.gz \
    https://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.5.8.tar.gz \
    17ac6969b2015386bcb5d278a08a40b5

download_source libtool-2.5.4.tar.xz \
    https://ftp.gnu.org/gnu/libtool/libtool-2.5.4.tar.xz \
    22e0a29df8af5fdde276ea3a7d351d30

download_source libxcrypt-4.4.38.tar.xz \
    https://github.com/besser82/libxcrypt/releases/download/v4.4.38/libxcrypt-4.4.38.tar.xz \
    1796a5d20098e9dd9e3f576803c83000

download_source linux-6.16.1.tar.xz \
    https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.16.1.tar.xz \
    32d45755e4b39d06e9be58f6817445ee

download_source lz4-1.10.0.tar.gz \
    https://github.com/lz4/lz4/releases/download/v1.10.0/lz4-1.10.0.tar.gz \
    dead9f5f1966d9ae56e1e32761e4e675

download_source m4-1.4.20.tar.xz \
    https://ftp.gnu.org/gnu/m4/m4-1.4.20.tar.xz \
    6eb2ebed5b24e74b6e890919331d2132

download_source make-4.4.1.tar.gz \
    https://ftp.gnu.org/gnu/make/make-4.4.1.tar.gz \
    c8469a3713cbbe04d955d4ae4be23eeb

download_source man-db-2.13.1.tar.xz \
    https://download.savannah.gnu.org/releases/man-db/man-db-2.13.1.tar.xz \
    b6335533cbeac3b24cd7be31fdee8c83

download_source man-pages-6.15.tar.xz \
    https://www.kernel.org/pub/linux/docs/man-pages/man-pages-6.15.tar.xz \
    16f68d70139dd2bbcae4102be4705753

download_source markupsafe-3.0.2.tar.gz \
    https://pypi.org/packages/source/M/MarkupSafe/markupsafe-3.0.2.tar.gz \
    cb0071711b573b155cc8f86e1de72167

download_source meson-1.8.3.tar.gz \
    https://github.com/mesonbuild/meson/releases/download/1.8.3/meson-1.8.3.tar.gz \
    08221d2f515e759686f666ff6409a903

download_source mpc-1.3.1.tar.gz \
    https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz \
    5c9bc658c9fd0f940e8e3e0f09530c62

download_source mpfr-4.2.2.tar.xz \
    https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.2.tar.xz \
    7c32c39b8b6e3ae85f25156228156061

download_source ncurses-6.5-20250809.tgz \
    https://invisible-mirror.net/archives/ncurses/current/ncurses-6.5-20250809.tgz \
    679987405412f970561cc85e1e6428a2

download_source ninja-1.13.1.tar.gz \
    https://github.com/ninja-build/ninja/archive/v1.13.1/ninja-1.13.1.tar.gz \
    c35f8f55f4cf60f1a916068d8f45a0f8

download_source openssl-3.5.2.tar.gz \
    https://github.com/openssl/openssl/releases/download/openssl-3.5.2/openssl-3.5.2.tar.gz \
    890fc59f86fc21b5e4d1c031a698dbde

download_source packaging-25.0.tar.gz \
    https://files.pythonhosted.org/packages/source/p/packaging/packaging-25.0.tar.gz \
    ab0ef21ddebe09d1803575120d3f99f8

download_source patch-2.8.tar.xz \
    https://ftp.gnu.org/gnu/patch/patch-2.8.tar.xz \
    149327a021d41c8f88d034eab41c039f

download_source perl-5.42.0.tar.xz \
    https://www.cpan.org/src/5.0/perl-5.42.0.tar.xz \
    7a6950a9f12d01eb96a9d2ed2f4e0072

download_source pkgconf-2.5.1.tar.xz \
    https://distfiles.ariadne.space/pkgconf/pkgconf-2.5.1.tar.xz \
    3291128c917fdb8fccd8c9e7784b643b

download_source procps-ng-4.0.5.tar.xz \
    https://sourceforge.net/projects/procps-ng/files/Production/procps-ng-4.0.5.tar.xz \
    90803e64f51f192f3325d25c3335d057

download_source psmisc-23.7.tar.xz \
    https://sourceforge.net/projects/psmisc/files/psmisc/psmisc-23.7.tar.xz \
    53eae841735189a896d614cba440eb10

download_source Python-3.13.7.tar.xz \
    https://www.python.org/ftp/python/3.13.7/Python-3.13.7.tar.xz \
    256cdb3bbf45cdce7499e52ba6c36ea3

download_source python-3.13.7-docs-html.tar.bz2 \
    https://www.python.org/ftp/python/doc/3.13.7/python-3.13.7-docs-html.tar.bz2 \
    b84c0d81b2758398bb7f5b7411d3d908

download_source readline-8.3.tar.gz \
    https://ftp.gnu.org/gnu/readline/readline-8.3.tar.gz \
    25a73bfb2a3ad7146c5e9d4408d9f6cd

download_source sed-4.9.tar.xz \
    https://ftp.gnu.org/gnu/sed/sed-4.9.tar.xz \
    6aac9b2dbafcd5b7a67a8a9bcb8036c3

download_source setuptools-80.9.0.tar.gz \
    https://pypi.org/packages/source/s/setuptools/setuptools-80.9.0.tar.gz \
    82e1d67883b713f9493659b50d13b436

download_source shadow-4.18.0.tar.xz \
    https://github.com/shadow-maint/shadow/releases/download/4.18.0/shadow-4.18.0.tar.xz \
    30ef46f54363db1d624587be68794ef2

download_source sysklogd-2.7.2.tar.gz \
    https://github.com/troglobit/sysklogd/releases/download/v2.7.2/sysklogd-2.7.2.tar.gz \
    af60786956a2dc84054fbf46652e515e

download_source systemd-257.8.tar.gz \
    https://github.com/systemd/systemd/archive/v257.8/systemd-257.8.tar.gz \
    25fe5d328e22641254761f1baa74cee0

download_source systemd-man-pages-257.8.tar.xz \
    https://anduin.linuxfromscratch.org/LFS/systemd-man-pages-257.8.tar.xz \
    a44063e2ec0cf4adfd2ed5c9e9e095c5

download_source sysvinit-3.14.tar.xz \
    https://github.com/slicer69/sysvinit/releases/download/3.14/sysvinit-3.14.tar.xz \
    bc6890b975d19dc9db42d0c7364dd092

download_source tar-1.35.tar.xz \
    https://ftp.gnu.org/gnu/tar/tar-1.35.tar.xz \
    a2d8042658cfd8ea939e6d911eaf4152

download_source tcl8.6.16-src.tar.gz \
    https://downloads.sourceforge.net/tcl/tcl8.6.16-src.tar.gz \
    eaef5d0a27239fb840f04af8ec608242

download_source tcl8.6.16-html.tar.gz \
    https://downloads.sourceforge.net/tcl/tcl8.6.16-html.tar.gz \
    750c221bcb6f8737a6791c1fbe98b684

download_source texinfo-7.2.tar.xz \
    https://ftp.gnu.org/gnu/texinfo/texinfo-7.2.tar.xz \
    11939a7624572814912a18e76c8d8972

download_source tzdata2025b.tar.gz \
    https://www.iana.org/time-zones/repository/releases/tzdata2025b.tar.gz \
    ad65154c48c74a9b311fe84778c5434f

download_source udev-lfs-20230818.tar.xz \
    https://anduin.linuxfromscratch.org/LFS/udev-lfs-20230818.tar.xz \
    acd4360d8a5c3ef320b9db88d275dae6

download_source util-linux-2.41.1.tar.xz \
    https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-2.41.1.tar.xz \
    7e5e68845e2f347cf96f5448165f1764

download_source vim-9.1.1629.tar.gz \
    https://github.com/vim/vim/archive/v9.1.1629/vim-9.1.1629.tar.gz \
    4f856c3233c1c4570bc17572e4f9e8e4

download_source wheel-0.46.1.tar.gz \
    https://pypi.org/packages/source/w/wheel/wheel-0.46.1.tar.gz \
    65e09ee84af36821e3b1e9564aa91bd5

download_source XML-Parser-2.47.tar.gz \
    https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.47.tar.gz \
    89a8e82cfd2ad948b349c0a69c494463

download_source xz-5.8.1.tar.xz \
    https://github.com//tukaani-project/xz/releases/download/v5.8.1/xz-5.8.1.tar.xz \
    cf5e1feb023d22c6bdaa30e84ef3abe3

download_source zlib-1.3.1.tar.gz \
    https://zlib.net/fossils/zlib-1.3.1.tar.gz \
    9855b6d802d7fe5b7bd5b196a2271655

download_source zstd-1.5.7.tar.gz \
    https://github.com/facebook/zstd/releases/download/v1.5.7/zstd-1.5.7.tar.gz \
    780fc1896922b1bc52a4e90980cdda48

download_source bzip2-1.0.8-install_docs-1.patch \
    https://www.linuxfromscratch.org/patches/lfs/12.4/bzip2-1.0.8-install_docs-1.patch \
    6a5ac7e89b791aae556de0f745916f7f

download_source coreutils-9.7-upstream_fix-1.patch \
    https://www.linuxfromscratch.org/patches/lfs/12.4/coreutils-9.7-upstream_fix-1.patch \
    96382a5aa85d6651a74f94ffb61785d9

download_source coreutils-9.7-i18n-1.patch \
    https://www.linuxfromscratch.org/patches/lfs/12.4/coreutils-9.7-i18n-1.patch \
    33ebfad32b2dfb8417c3335c08671206

download_source expect-5.45.4-gcc15-1.patch \
    https://www.linuxfromscratch.org/patches/lfs/12.4/expect-5.45.4-gcc15-1.patch \
    0ca4d6bb8d572fbcdb13cb36cd34833e

download_source glibc-2.42-fhs-1.patch \
    https://www.linuxfromscratch.org/patches/lfs/12.4/glibc-2.42-fhs-1.patch \
    9a5997c3452909b1769918c759eff8a2

download_source kbd-2.8.0-backspace-1.patch \
    https://www.linuxfromscratch.org/patches/lfs/12.4/kbd-2.8.0-backspace-1.patch \
    f75cca16a38da6caa7d52151f7136895

download_source sysvinit-3.14-consolidated-1.patch \
    https://www.linuxfromscratch.org/patches/lfs/12.4/sysvinit-3.14-consolidated-1.patch \
    3af8fd8e13cad481eeeaa48be4247445
