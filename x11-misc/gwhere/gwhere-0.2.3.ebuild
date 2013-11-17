# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


inherit eutils flag-o-matic

DESCRIPTION="Removable media cataloger made with GTK+"
HOMEPAGE="http://www.gwhere.org/"
SRC_URI="http://www.gwhere.org/download/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.16.6
	>=dev-libs/glib-2.20.5
	>=x11-libs/libXi-1.2.1
	>=x11-libs/libXext-1.0.5
	>=x11-libs/libX11-1.2.2
	>=sys-libs/glibc-2.9
	>=sys-libs/zlib-1.2.3-r1
	>=x11-libs/libXau-1.0.5
	>=x11-libs/libXdmcp-1.0.2
	"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}.diff
	epatch ${FILESDIR}/${P}-makefile.diff
}

src_compile() {
	use amd64 && append-flags "-Wall -fPIC"
	use amd64 && filter-flags -fomit-frame-pointer
	econf --enable-gtk20 || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	# einstall is needed here
	einstall || die "einstall failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO || die "dodoc failed"
	dodir /usr/lib/gwhere/plugins
	dodir /usr/lib/gwhere/plugins/catalog
	dodir /usr/lib/gwhere/plugins/descr
	ln -s /usr/share/gwhere/plugins/catalog/libgwplugincatalogcsv.a ${D}/usr/lib/gwhere/plugins/catalog/
	ln -s /usr/share/gwhere/plugins/catalog/libgwplugincatalogcsv.la ${D}/usr/lib/gwhere/plugins/catalog/
	ln -s /usr/share/gwhere/plugins/catalog/libgwplugincatalogcsv.so ${D}/usr/lib/gwhere/plugins/catalog/
	ln -s /usr/share/gwhere/plugins/catalog/libgwplugincatalogcsv.so.1 ${D}/usr/lib/gwhere/plugins/catalog/
	ln -s /usr/share/gwhere/plugins/catalog/libgwplugincatalogcsv.so.1.0.0 ${D}/usr/lib/gwhere/plugins/catalog/
	ln -s /usr/share/gwhere/plugins/catalog/libgwplugincataloggwcatalog.a ${D}/usr/lib/gwhere/plugins/catalog/
	ln -s /usr/share/gwhere/plugins/catalog/libgwplugincataloggwcatalog.la ${D}/usr/lib/gwhere/plugins/catalog/
	ln -s /usr/share/gwhere/plugins/catalog/libgwplugincataloggwcatalog.so ${D}/usr/lib/gwhere/plugins/catalog/
	ln -s /usr/share/gwhere/plugins/catalog/libgwplugincataloggwcatalog.so.1 ${D}/usr/lib/gwhere/plugins/catalog/
	ln -s /usr/share/gwhere/plugins/catalog/libgwplugincataloggwcatalog.so.1.0.0 ${D}/usr/lib/gwhere/plugins/catalog/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionavi.a ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionavi.la ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionavi.so ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionavi.so.1 ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionavi.so.1.0.0 ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptiondescript_ion.a ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptiondescript_ion.la ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptiondescript_ion.so ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptiondescript_ion.so.1 ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptiondescript_ion.so.1.0.0 ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionfile_id_diz.a ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionfile_id_diz.la ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionfile_id_diz.so ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionfile_id_diz.so.1 ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionfile_id_diz.so.1.0.0 ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionhtml.a ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionhtml.la ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionhtml.so ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionhtml.so.1 ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionhtml.so.1.0.0 ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionmp3.a ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionmp3.la ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionmp3.so ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionmp3.so.1 ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionmp3.so.1.0.0 ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionmpc.a ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionmpc.la ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionmpc.so ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionmpc.so.1 ${D}/usr/lib/gwhere/plugins/descr/
	ln -s /usr/share/gwhere/plugins/descr/libgwplugindescriptionmpc.so.1.0.0 ${D}/usr/lib/gwhere/plugins/descr/
}
