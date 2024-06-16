# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DESCRIPTION="Free reverb-effects"

HOMEPAGE="https://michaelwillis.github.io/dragonfly-reverb/"
SRC_URI="https://github.com/michaelwillis/dragonfly-reverb/releases/download/${PV}/${PN%-plugins}-${PV}-src.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="system-freeverb3 +clap +lv2 +vst2 +vst3 +jack"
REQUIRED_USE="|| ( clap lv2 vst2 vst3 jack )"

RDEPEND="
	system-freeverb3? ( media-libs/libsamplerate media-libs/freeverb3 )
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr
	media-libs/mesa
	virtual/jack
"
DEPEND="${RDEPEND}"
BDEPEND="
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr
	media-libs/mesa
	virtual/jack
"

src_prepare() {
	default
	sed -i '/^BASE_OPTS/s/-O3//' dpf/Makefile.base.mk || die
}

src_compile() {
	cd plugins
	for plugin in */; do
		cd "${plugin}"
			emake $(usev system-freeverb3 SYSTEM_FREEVERB3=true) SKIP_STRIPPING=true $(usev jack jack) $(usev lv2 lv2_sep) $(usev vst2 vst2) $(usev vst3 vst3) $(usev clap clap)
		cd ..
	done
}

src_install() {
	cd bin || die

	if use jack; then
		dobin DragonflyEarlyReflections DragonflyHallReverb DragonflyPlateReverb DragonflyRoomReverb
	fi

	if use lv2; then
		for plugin in DragonflyEarlyReflections DragonflyHallReverb DragonflyPlateReverb DragonflyRoomReverb; do
			insinto	"/usr/$(get_libdir)/lv2"
			doins -r "${plugin}.lv2"
		done
	fi

	if use vst2; then
		insinto	"/usr/$(get_libdir)/vst"
		doins DragonflyEarlyReflections-vst.so DragonflyHallReverb-vst.so DragonflyPlateReverb-vst.so DragonflyRoomReverb-vst.so
	fi

	if use vst3; then
		for plugin in DragonflyEarlyReflections DragonflyHallReverb DragonflyPlateReverb DragonflyRoomReverb; do
			insinto	"/usr/$(get_libdir)/vst3"
			doins -r "${plugin}.vst3"
		done
	fi

	if use clap; then
		for plugin in DragonflyEarlyReflections DragonflyHallReverb DragonflyPlateReverb DragonflyRoomReverb; do
			insinto	"/usr/$(get_libdir)/clap"
			doins -r "${plugin}.clap"
		done
	fi
}
