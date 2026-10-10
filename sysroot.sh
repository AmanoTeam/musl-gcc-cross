cd /tmp

git clone https://git.musl-libc.org/git/musl --depth 1
cd musl

./configure --host=${CROSS_COMPILE_TRIPLET} --prefix=/tmp/${CROSS_COMPILE_TRIPLET}
make
make install

cd ..

case "${CROSS_COMPILE_TRIPLET}" in
	'arm'*)
		kernel_arch='arm'
		;;
	'aarch64-'*)
		kernel_arch='arm64'
		;;
	'i386-'* | 'x86_64-'*)
		kernel_arch='x86'
		;;
esac

git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git --depth 1
cd linux

make headers_install ARCH=${kernel_arch} INSTALL_HDR_PATH=/tmp/${CROSS_COMPILE_TRIPLET}

cd ..

tar \
	--directory='/tmp' \
	--create \
	--file=- \
	"${CROSS_COMPILE_TRIPLET}" |
		xz \
			--threads='0' \
			--compress \
			-9 > "/tmp/${CROSS_COMPILE_TRIPLET}.tar.xz"
