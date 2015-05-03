# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit git-r3 qmake-utils

SLOT="0"

QT5_MODULE="qtbase"

DESCRIPTION="A good-looking terminal emulator which mimics the old cathode ray tube display."

HOMEPAGE="https://github.com/Swordfish90/cool-retro-term"

EGIT_REPO_URI="${HOMEPAGE}.git"
EGIT_CHECKOUT_DIR="${S}/src/"

LICENSE="GPL-2"

KEYWORDS="~x86 ~amd64"

DEPEND="
>=dev-qt/qtcore-5.3.1
>=dev-qt/qtquickcontrols-5.3.1[widgets]
>=dev-qt/qtdeclarative-5.3.1
>=dev-qt/qtgraphicaleffects-5.3.1
"
src_compile() {
	cd "${EGIT_CHECKOUT_DIR}/konsole-qml-plugin"
	eqmake5 || die
	emake || die
}

src_install() {
	cd "${S}/src/konsole-qml-plugin"
		emake install INSTALL_ROOT=${D}
    exeinto /opt/${PN}
    	doexe ${FILESDIR}/${PN}
    dosym ../../opt/${PN}/${PN} /usr/bin/${PN}
    insinto /opt/${PN}/
    	doins -r ${S}/src/{imports,app,README.md} || die "install failed"
}
