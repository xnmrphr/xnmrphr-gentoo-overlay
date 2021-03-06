# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

LANGS="en cz de el es fr hu id it pl pt sk sr"

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
>=dev-qt/qtgui-4.8.4-r1
>=media-libs/libmediainfo-0.7.52
>=dev-libs/libtar-1.2.11-r4
>=app-arch/p7zip-9.20.1-r1"
#>=app-arch/p7zip-9.20.1

RDEPEND="${DEPEND}"

#DOCSDIR="${S}/docs/"
DOCS="Authors ChangeLog README"

#PATCHES=(
#"${FILESDIR}/unlib7zip.patch"
#)
#"${FILESDIR}/endl.patch"3
#"${FILESDIR}/path-fix-1.9.patch"
#"${FILESDIR}/unlib7zip.patch"
#"${FILESDIR}/path-fix.patch"

S="${WORKDIR}/${MY_PN}-${PV}"


src_unpack () {
    unpack ${A}
}

src_configure() {
    sed -i -e 's/DEFINES+=USE_LIB7ZIP/#DEFINES+=USE_LIB7ZIP/' ${S}/src/cdcat.pro || die "Problem with edit project file."
    sed -i -e 's/LIBS+=\ -l7zip/#LIBS+=\ -l7zip/' ${S}/src/cdcat.pro || die "Problem with edit project file."
    sed -i -e 's/DEFINES+=USE_LIB7ZIP/#DEFINES+=USE_LIB7ZIP/' ${S}/src/cdcat_debug.pro || die "Problem with edit project file."
    sed -i -e 's/LIBS+=\ -l7zip/#LIBS+=\ -l7zip/' ${S}/src/cdcat_debug.pro || die "Problem with edit project file."

    sed -i -e 's/\/usr\/local/\/usr/' ${S}/src/cdcat.pro || die "Problem with edit project file."
    sed -i -e 's/\/usr\/local/\/usr/' ${S}/src/cdcat_debug.pro || die "Problem with edit project file."

    lrelease "${S}/src/cdcat.pro"
    eqmake4 "${S}/src/cdcat.pro"
}

src_install() {
    qt4-r2_src_install
    mv "${D}/usr/bin/${MY_PN}" "${D}/usr/bin/${PN}" || die rename failed

    for l in ${LANGS}; do
        if ! use linguas_${l} && [ "${l}" != "en" ]; then
                rm ${D}/usr/share/cdcat/translations/${MY_PN}_${l}.qm
        fi
    done

    #newicon cdcat.png ${MY_PN}.png
    make_desktop_entry ${PN} "Hyper's CD Catalog" /usr/share/${MY_PN}/${MY_PN}.png "AudioVideo;DiscBurning"
}
