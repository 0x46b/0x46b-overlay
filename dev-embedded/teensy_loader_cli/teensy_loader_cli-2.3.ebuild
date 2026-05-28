# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit udev

DESCRIPTION="Teensy Loader - Command Line Version"
HOMEPAGE="https://github.com/PaulStoffregen/teensy_loader_cli"

SRC_URI="https://github.com/PaulStoffregen/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"
RDEPEND="virtual/udev"
DEPEND="
	${RDEPEND}
	dev-libs/libusb-compat
"
RESTRICT="strip"

src_install() {
	if use examples; then
		dodoc *.hex
	fi
	dobin teensy_loader_cli
	udev_dorules "${FILESDIR}/00-teensy.rules"
}

pkg_postinst() {
		udev_reload
}

pkg_postrm() {
		udev_reload
}
