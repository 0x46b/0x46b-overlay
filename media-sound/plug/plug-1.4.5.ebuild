# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
inherit cmake
inherit udev

DESCRIPTION="Software for Fender Mustang Amps"
HOMEPAGE="https://github.com/offa/plug"
SRC_URI="https://github.com/offa/plug/archive/refs/tags/v${PV}.tar.gz"
KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"
IUSE="doc test lto"

RDEPEND="dev-qt/qtbase:6[widgets,gui] >=dev-libs/libusb-1.0 virtual/udev"
DEPEND="${RDEPEND}"
RESTRICT="!test? ( test )"

src_prepare() {
	cmake_src_prepare
}

src_configure(){
	## Remove udev-rules from cmake-install, we install it via portage the right way
	sed -i "1,6d" cmake/Install.cmake
	## We do not want the cmake-config in the lib-directory...
	sed -i 's/DESTINATION ${CMAKE_INSTALL_LIBDIR}/DESTINATION \/usr\/share\/${PN}/' cmake/Install.cmake
	local mycmakeargs=(
		-DPLUG_UNITTEST=$(usex tests TRUE FALSE)
		-DPLUG_LTO=$(usex lto TRUE FALSE)
		)
	cmake_src_configure
}

src_compile(){
	cmake_src_compile
}

src_install(){
	cmake_src_install
	udev_dorules cmake/50-mustang.rules
	udev_dorules cmake/70-mustang-uaccess.rules
	udev_dorules cmake/70-mustang-plugdev.rules

	if use doc; then
		dodoc README.md CONTRIBUTING.md
		dodoc -r doc
	fi
}

pkg_postinst(){
	udev_reload
}

pkg_postrm(){
	udev_reload
}
