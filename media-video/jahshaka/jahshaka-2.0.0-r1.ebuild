# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="The worlds first OpenSource Realtime Editing and Effects System."
HOMEPAGE="http://www.jahshaka.org"
SRC_URI="mirror://sourceforge/${PN}fx/${PN}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

IUSE="debug static"

DEPEND="media-libs/mlt++
	virtual/glut
	>=media-libs/freetype-2.1.9

	=media-libs/openlibraries-0.3.0-r4
	media-libs/openal"

#	=x11-libs/qt-3*
RDEPEND=${DEPEND}

RESTRICT="nostrip"


S="${WORKDIR}/${PN}"

src_compile() {
	# fix Qt stuff
	sed -e "s/qmake/\$\{QTDIR\}\/bin\/qmake QMAKE=\$\{QTDIR\}\/bin\/qmake/" \
		-i ${S}/configure || die

	econf \
		`use_enable static` \
		`use_enable debug` \
		|| die "configure failed"

	cd "{S}"/plugins
	${QTDIR}/bin/qmake QMAKE=${QTDIR}/bin/qmake plugins.pro
	cd "${S}"

	make || die "make failed"
	#cd "${S}"/plugins
	#make || die "make plugins failed"
}

src_install() {

	cd ${S}
	make INSTALL_ROOT="${D}" DESTDIR="${D}" install || die
	#dobin jahshaka
	
	# They do no harm but we don't like 'CVS' dirs in every subdir
	for i in $(ls -la -R * | grep CVS | grep / | cut -f1 -d:)
	do
	    rm -rf ${i}
	done

	#dodir /usr/lib/jahshaka
	#cp -pPR ${S}/source/OpenLibraries/lib/* ${D}/usr/lib/${PN}/
	#cp -pPR $(find plugins -iname *.so) ${D}usr/share/${PN}/
	#cp -pPR $(find plugins -iname *.fp) ${D}usr/share/${PN}/

	#cp -pPR ${S}/database/JahDesktopDB.bak ${D}/usr/share/jahshaka/database/JahDesktopDB
	#chmod 664 ${D}/usr/share/jahshaka/database/*

	#dodir /etc/env.d
	#echo "LDPATH=/usr/lib/"${PN} > ${D}etc/env.d/98${P}

	dodoc README AUTHORS TODO
	
	newicon "Pixmaps/jahicon.PNG" "${PN}.png"
	make_desktop_entry "${PN}" "Jahshaka" "${PN}" "AudioVideo;Video"
}