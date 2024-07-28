# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
CMAKE_MAKEFILE_GENERATOR="emake"
CMAKE_VERBOSE="OFF"
inherit cmake
DESCRIPTION="Surge software synthesizer"
HOMEPAGE="https://foo.example.org/"
SRC_URI="https://github.com/surge-synthesizer/releases-xt/releases/download/1.3.2/surge-src-${PV}.tar.gz"
S="${WORKDIR}/${PN}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="lv2 clang python"
#RESTRICT="strip"
#RDEPEND=""
#DEPEND="${RDEPEND}"
BDEPEND="virtual/jack
dev-build/cmake
x11-libs/cairo
x11-libs/libxkbcommon
x11-libs/xcb-util-cursor
x11-libs/xcb-util-keysyms
x11-libs/xcb-util
x11-apps/xrandr
x11-libs/libXinerama
media-libs/alsa-lib"

src_configure() {
	cmake -Bbuild -DCMAKE_BUILD_TYPE=Release -DSURGE_BUILD_LV2=$(usex lv2 TRUE FALSE) -DSURGE_BUILD_PYTHON_BINDINGS=$(usex python TRUE FALSE) -DCMAKE_INSTALL_PREFIX=${ED}/usr
}

src_compile(){
	cmake --build build --config Release --parallel 4
	if use python; then
		cmake --build build --parallel --target surgepy
	fi
}

cmake_src_install(){
	cmake --install build
}
