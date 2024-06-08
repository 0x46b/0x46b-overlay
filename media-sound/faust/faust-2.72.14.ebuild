# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
DESCRIPTION="A functional programming language for real-time signal processing and synthesis."
HOMEPAGE="https://faustdoc.grame.fr/"
SRC_URI="https://github.com/grame-cncm/faust/releases/download/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"

SLOT="0"

KEYWORDS="~amd64"
IUSE="most libsall sound2faust"

RDEPEND="
sound2faust? ( media-libs/libsndfile )
net-libs/libmicrohttpd"

DEPEND="${RDEPEND}"

BDEPEND="dev-build/cmake
most? ( sys-devel/llvm )
sound2faust? ( media-libs/libsndfile )
net-libs/libmicrohttpd"

src_compile() {

	if use libsall; then
		emake libsall
	fi

	if use most; then
		emake most
	else
		emake compiler
	fi

	if use sound2faust; then
		emake sound2faust
	fi
}

src_install() {
	emake  PREFIX="${D}"/usr install
}
