# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt4-r2 eutils

MY_PN="misfitmodel3d"

DESCRIPTION="Misfit Model 3D is a 3D modeling and animation program"
HOMEPAGE="http://www.misfitcode.com/misfitmodel3d/"
SRC_URI="mirror://sourceforge/${MY_PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug lua"

#QTDEPEND="$(qt_min_version 3.3)"
QTDEPEND="=dev-qt/qt-meta-4*"

DEPEND="${QTDEPEND}
	virtual/glut
	lua? ( dev-lang/lua )"

src_unpack() {
	unpack ${A} || die "unpack failed"

}

src_prepare() {
	cd ${S}
	# Fix hard-coded path of HTML docs
	sed -i -e "/DOC_ROOT.*PREFIX/s/${PN}/${PF}/" \
		src/libmm3d/mm3dconfig.h \
		|| die "sed mm3dconfig.h failed"
	epatch ${FILESDIR}/libmm.patch
	epatch ${FILESDIR}/desktop.patch
}

src_compile ()
{
	local myconf
	use debug && myconf="${myconf} --with-enable-debug"

	econf \
		${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install ()
{
	emake DESTDIR="${D}" install || die "make install failed"

	# make install put html docs in /usr/share/doc/mm3d, so we'll fix this issue
	mv ${D}/usr/share/doc/${PN} ${D}/usr/share/doc/${PF}

	dodoc AUTHORS ChangeLog NEWS README TODO INSTALL || die "dodoc failed"

	newicon src/pixmap/mm3dlogo-32x32.xpm ${PN}.xpm || die "doicon failed"

	make_desktop_entry ${PN} "Misfit Model 3D" || die "make_desktop_entry failed"
}
