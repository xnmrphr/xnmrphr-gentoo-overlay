# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit eutils versionator scons-utils python-r1

MY_PV=$(get_version_component_range 1-2)
DESCRIPTION="Python binding to exiv2"
HOMEPAGE="http://tilloy.net/dev/pyexiv2/"
SRC_URI="http://launchpad.net/${PN}/${MY_PV}.x/${MY_PV}/+download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="
	>=media-gfx/exiv2-0.20
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-libs/boost[python,${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-docs.patch
}

src_compile() {
	escons lib
	if use doc; then
		escons doc

		# To enable doins -r in src_install
		rm -R doc/_build/.doctrees || die
	fi
}

src_install() {
	escons DESTDIR="${D}" install
	dodoc NEWS README todo

	if use examples; then
		insinto /usr/share/${PN}/examples
		doins src/*example*.py
	fi

	if use doc; then
		docinto html
		dodoc -r doc/html/*
	fi
	python_optimize
}
