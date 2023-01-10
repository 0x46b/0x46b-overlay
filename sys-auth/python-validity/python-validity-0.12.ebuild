# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..10} pypy )

inherit distutils-r1 systemd udev

DESCRIPTION="Validity fingerprint sensor prototype"
HOMEPAGE="https://github.com/uunicorn/python-validity"
SRC_URI="https://github.com/uunicorn/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"

IUSE="systemd"

KEYWORDS="~amd64 ~x86"

RDEPEND="
	app-arch/innoextract
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/pyusb[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	sys-auth/fprintd
"

DEPEND="
	${RDEPEND}
"

PATCHES=(
	"${FILESDIR}/${PN}-0.12-fix-unsafe-load.patch"
)

python_install_all() {
	distutils-r1_python_install_all
	if use systemd ; then
		systemd_dounit "${S}"/debian/python3-validity.service
	fi
	if ! use systemd ; then
		doinitd "${FILESDIR}"/python3-validity
	fi
	udev_newrules "${S}"/debian/python3-validity.udev 60-python-validity.rules
	insinto /etc/python-validity
	doins "${S}"/etc/python-validity/dbus-service.yaml
}

pkg_postinst() {
	elog "Sample configurations are available at:"
	elog "https://github.com/uunicorn/python-validity"
	if use systemd ; then
		elog "To enable this service:"
		elog "systemctl enable python3-validity"
		elog "systemctl start python3-validity"
	fi
		if ! use systemd ; then
		elog "To enable this service:"
		elog "rc-update add python3-validity default"
		elog "rc-service python3-validity start"
	fi
}
