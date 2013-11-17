# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

LANGS="en cz de el es fr hu id it pl pt sk sr"
#LANGSLONG="en_US pl_PL"

inherit eutils qt4-r2

MY_PN=${PN/h/}

DESCRIPTION="Hyper's CD Catalog"
HOMEPAGE="http://cdcat.sourceforge.net"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}-${PV}.tar.bz2"
RESTRICT="mirror"


LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~amd64"

IUSE="debug" #Mostly for qt4-r2 build-in availbility.

DEPEND="sys-libs/zlib
x11-libs/qt-gui:4
>=media-libs/libmediainfo-0.7.52
>=dev-libs/libtar-1.2.11-r4
>=app-arch/p7zip-9.20.1-r1"
#>=app-arch/p7zip-9.20.1

RDEPEND="${DEPEND}"

#DOCSDIR="${S}/docs/"
DOCS="Authors ChangeLog README"

#S="${WORKDIR}/${P}"


#LINGUAS="en_US"

PATCHES=(
"${FILESDIR}/unlib7zip.patch"
"${FILESDIR}/endl.patch"
"${FILESDIR}/path-fix-1.9.patch"
)
#"${FILESDIR}/path-fix.patch"

S="${WORKDIR}/${MY_PN}-${PV}"


src_unpack () {
unpack ${A}
#epatch ${FILESDIR}/unlib7zip.diff
}



src_configure() {
    lrelease "${S}/src/cdcat.pro"
    eqmake4 "${S}/src/cdcat.pro"
}

src_install() {
    qt4-r2_src_install

#    insinto /usr/share/${MY_PN}/translations

    for l in ${LANGS}; do
	if ! use linguas_${l} && [ "${l}" != "en" ]; then
		rm ${D}/usr/share/cdcat/translations/${MY_PN}_${l}.qm
	fi
    done

    #rm ${D}/usr/share/cdcat/cdcat.png

#newicon cdcat.png ${MY_PN}.png
make_desktop_entry ${MY_PN} "Hyper's CD Catalog" /usr/share/${MY_PN}/${MY_PN}.png "AudioVideo;DiscBurning"
}
