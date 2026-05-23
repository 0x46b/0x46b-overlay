# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Geonkick-Synthesizer/geonkick.git"
else
	SRC_URI="https://github.com/Geonkick-Synthesizer/geonkick/archive/v${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="A free software percussion synthesizer"
HOMEPAGE="https://geonkick.org/"
LICENSE="GPL-3"
SLOT="0"
IUSE="+standalone +lv2"

DEPEND="
	dev-libs/rapidjson
	media-libs/libsndfile
	media-libs/lv2
	standalone? ( virtual/jack )
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	>=dev-build/cmake-3.7
"

src_configure() {
	local mycmakeargs=(
		-DGKICK_STANDALONE=$(usex standalone "ON" "OFF")
		-DGKICK_PLUGIN=$(usex lv2 "ON" "OFF")
	)
	cmake_src_configure
}
