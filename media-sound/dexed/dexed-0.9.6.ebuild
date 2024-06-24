# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
inherit git-r3
inherit cmake

DESCRIPTION="A multi platform, multi format plugin synth closely modeled on the Yamaha DX7."
HOMEPAGE="https://asb2m10.github.io/dexed/"
EGIT_REPO_URI="https://github.com/asb2m10/dexed"
EDIT_COMMIT="v{PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="clap standalone +vst3"

DEPEND="${RDEPEND}"

BDEPEND="x11-libs/libX11
net-misc/curl[gnutls]
media-libs/freetype
media-libs/alsa-lib
x11-libs/libXinerama
virtual/jack
x11-libs/libXcursor
x11-libs/libXrandr"

src_install(){
	cd {BUILD_DIR}/Source/Dexed_artefacts/RelWithDebInfo/
	dolib.a libDexed_SharedCode.a

	if use vst3; then
		insinto /usr/$(get_libdir)/vst3
		doins -r VST3/Dexed.vst3
	fi

	if use clap; then
		insinto /usr/$(get_libdir)/clap
		doins CLAP/Dexed.clap
	fi

	if use standalone; then
		dobin Standalone/Dexed
	fi
}
