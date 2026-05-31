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
IUSE="clap +standalone vst3 +alsa doc"

DEPEND="${RDEPEND}"

BDEPEND="x11-libs/libX11
net-misc/curl[gnutls]
media-libs/freetype
media-libs/alsa-lib
x11-libs/libXinerama
virtual/jack
x11-libs/libXcursor
x11-libs/libXrandr"

src_prepare() {
	cmake_src_prepare
}

src_configure(){
	local mycmakeargs=(
		-DDEXED_SKIP_VST3=$(usex vst3 FALSE TRUE)
		-DDEXED_NO_ALSA=$(usex alsa FALSE TRUE)
		-DJUCE_COPY_PLUGIN_AFTER_BUILD=TRUE
	)
	cmake_src_configure
}

src_install(){
	if use doc; then
		dodoc Documentation/*
	fi

	cd "${BUILD_DIR}/Source/Dexed_artefacts/RelWithDebInfo/"

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
