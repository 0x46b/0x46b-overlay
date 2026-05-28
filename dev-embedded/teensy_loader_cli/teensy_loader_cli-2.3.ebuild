# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DESCRIPTION="Teensy Loader - Command Line Version"
HOMEPAGE="https://github.com/PaulStoffregen/teensy_loader_cli"

SRC_URI="https://github.com/PaulStoffregen/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"
DEPEND="
	dev-libs/libusb-compat
"
src_install() {
	if use examples; then
		dodoc *.hex
	fi
	dobin teensy_loader_cli
}
