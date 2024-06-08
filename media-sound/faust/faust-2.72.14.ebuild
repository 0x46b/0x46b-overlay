# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
DESCRIPTION="A functional programming language for real-time signal processing and synthesis."
HOMEPAGE="https://faustdoc.grame.fr/"
SRC_URI="https://github.com/grame-cncm/faust/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~amd64"
IUSE="+light most all"
REQUIRED_USE="?? ( light most all )"

RDEPEND="media-libs/libsndfile"
DEPEND="${RDEPEND}"
BDEPEND="dev-build/cmake"

src_compile() {
	if use light; then
		emake BACKENDS=light.cmake
	fi

	if use most; then
		emake BACKENDS=most.cmake
	fi

	if use all; then
		emake BACKENDS=all.cmake
	fi
}

src_install() {
	emake  PREFIX="${D}"/usr install
}
