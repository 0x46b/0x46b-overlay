# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
inherit git-r3

DESCRIPTION="Free reverb-effects"

HOMEPAGE="https://michaelwillis.github.io/dragonfly-reverb/"
EGIT_REPO_URI="https://github.com/michaelwillis/dragonfly-reverb.git"
EGIT_COMMIT="${PV}"

LICENSE="GPL-3"
SLOT="0"

IUSE="system-freeverb3 +clap +lv2 +vst3"

RDEPEND="system-freeverb3? ( media-libs/libsamplerate media-libs/freeverb3 )"
DEPEND="${RDEPEND}"
BDEPEND="x11-libs/libX11 x11-libs/libXext x11-libs/libXrandr media-libs/mesa media-sound/jack2 dev-vcs/git"

src_configure() {
	git submodule update --init --recursive
}

src_compile() {
	if use system-freeverb3; then
		SYSTEM_FREEVERB3=true emake
	else
		emake
	fi
}

src_install() {
	dobin bin/DragonflyEarlyReflections bin/DragonflyHallReverb bin/DragonflyPlateReverb bin/DragonflyRoomReverb

	if use lv2; then
		dodir /usr/lib64/lv2/dragonfly-reverb/
		cp bin/DragonflyEarlyReflections.lv2/* "${D}/usr/lib64/lv2/dragonfly-reverb"
		cp bin/DragonflyHallReverb.lv2/* "${D}/usr/lib64/lv2/dragonfly-reverb"
		cp bin/DragonflyPlateReverb.lv2/* "${D}/usr/lib64/lv2/dragonfly-reverb"
		cp bin/DragonflyRoomReverb.lv2/* "${D}/usr/lib64/lv2/dragonfly-reverb"
	fi

	if use vst3; then
		dodir /usr/lib64/vst/dragonfly-reverb/
		cp -r bin/DragonflyEarlyReflections.vst3/* "${D}/usr/lib64/vst/dragonfly-reverb/"
		cp -r bin/DragonflyHallReverb.vst3/* "${D}/usr/lib64/vst/dragonfly-reverb/"
		cp -r bin/DragonflyPlateReverb.vst3/* "${D}/usr/lib64/vst/dragonfly-reverb/"
		cp -r bin/DragonflyRoomReverb.vst3/* "${D}/usr/lib64/vst/dragonfly-reverb/"
	fi

	if use clap; then
		dodir /usr/lib/clap/dragonfly-reverb/
		cp bin/DragonflyEarlyReflections.clap "${D}/usr/lib/clap/dragonfly-reverb/"
		cp bin/DragonflyHallReverb.clap "${D}/usr/lib/clap/dragonfly-reverb/"
		cp bin/DragonflyPlateReverb.clap "${D}/usr/lib/clap/dragonfly-reverb/"
		cp bin/DragonflyRoomReverb.clap "${D}/usr/lib/clap/dragonfly-reverb/"
	fi
}
