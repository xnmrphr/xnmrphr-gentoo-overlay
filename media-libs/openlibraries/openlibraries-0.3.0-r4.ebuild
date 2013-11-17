# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils

DESCRIPTION="OpenLibraries multimedia libraries"
HOMEPAGE="http://www.openlibraries.org"
SRC_URI="mirror://sourceforge/openlibraries/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE="nvidia sqlite3"

RDEPEND=">=media-libs/mlt-0.2.3
		media-libs/mlt++
		>=media-libs/glew-1.3.3
		>=media-libs/freetype-2.1.9
		virtual/glu
		virtual/opengl
		=x11-libs/qt-3*
		dev-libs/boost
		media-libs/openal
		nvidia? ( media-gfx/nvidia-cg-toolkit )
		sqlite3? ( =dev-db/sqlite-3* )"
DEPEND="${RDEPEND}"

pkg_setup() {
	if ! built_with_use dev-libs/boost threads; then
		ewarn "You need to compile dev-libs/boost with USE=\"threads\"!"
		die
	fi
	if ! built_with_use media-libs/mlt xml; then
		ewarn "You need to compile dev-libs/mlt with USE=\"xml\"!"
		die
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-alt-avformat-make.patch"
}

src_compile() {
	econf --with-boostruntime=mt \
		--with-boostthreadruntime=mt \
		--with-qtlib=/usr/qt/3/lib \
		--with-qtinclude=/usr/qt/3/include \
		`use_enable nvidia cg` \
		`use_enable sqlite3` \
		|| die "failed to configure"
		emake || die "failed to compile"
}

src_install() {
	make DESTDIR="${D}" install || die "failed to install"
}
