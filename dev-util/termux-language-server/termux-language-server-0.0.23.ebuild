# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Language server for some specific bash scripts"
HOMEPAGE="https://github.com/termux/termux-language-server"
S="${WORKDIR}/termux_language_server-0.0.23"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
# Testing somehow wants to download stuff via pip
RESTRICT="test"

RDEPEND="dev-lang/python"
DEPEND="${RDEPEND}"
