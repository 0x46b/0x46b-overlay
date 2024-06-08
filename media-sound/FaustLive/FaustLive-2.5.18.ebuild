# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
DESCRIPTION="The swiss knife for Faust development."
HOMEPAGE="https://github.com/grame-cncm/faustlive"
SRC_URI="https://github.com/grame-cncm/faustlive/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-3"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND="media-libs/libsndfile media-sound/faust[all] dev-qt/qtcore net-libs/libmicrohttpd virtual/jack"
DEPEND="${RDEPEND}"
BDEPEND="dev-build/cmake dev-qt/qtcore sys-devel/llvm net-libs/libmicrohttpd"

src_compile() {
	cd Build
	emake PREFIX="${D}"/usr
}

src_install() {
	cd Build
	emake PREFIX="${D}"/usr install
}
