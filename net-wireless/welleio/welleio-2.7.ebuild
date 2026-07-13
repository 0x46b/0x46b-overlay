EAPI=8
inherit cmake
DESCRIPTION="welle.io is an open source DAB and DAB+ software defined radio (SDR) with support for rtl-sdr (RTL2832U) and airspy."

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://www.welle.io/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="https://github.com/AlbrechtL/welle.io/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/welle.io-${PV}/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="rtlsdr +soapysdr"

# A space delimited list of portage features to restrict. man 5 ebuild
# for details.  Usually not needed.
#RESTRICT="strip"

# Run-time dependencies. Must be defined to whatever this depends on to run.
# Example:
#    ssl? ( >=dev-libs/openssl-1.0.2q:0= )
#    >=dev-lang/perl-5.24.3-r1
# It is advisable to use the >= syntax show above, to reflect what you
# had installed on your system when you tested the package.  Then
# other users hopefully won't be caught without the right version of
# a dependency.
RDEPEND="
	rtlsdr? ( net-wireless/rtl-sdr )
	soapysdr? ( net-wireless/soapysdr )
	dev-qt/qtbase
	dev-qt/qtdeclarative
	dev-qt/qtmultimedia
	dev-qt/qtcharts
"

DEPEND="${RDEPEND}"
#BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DRTLSDR=$(usex rtlsdr ON OFF)
		-DSOAPYSDR=$(usex soapysdr ON OFF)
		#-DBUILD_WELLE_IO=$(usex gui ON OFF)
		-DBUILD_WELLE_CLI=ON
	)

	cmake_src_configure
}
