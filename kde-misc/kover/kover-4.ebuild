# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="Kover is an easy to use WYSIWYG CD cover printer with CDDB support"
HOMEPAGE="http://lisas.de/kover/"
SRC_URI="http://lisas.de/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${DEPEND}
		dev-libs/libcdio
		media-libs/libcddb
		"
PATCHES=(
	"${FILESDIR}"/${P}-gcc4.4.4.patch
)
