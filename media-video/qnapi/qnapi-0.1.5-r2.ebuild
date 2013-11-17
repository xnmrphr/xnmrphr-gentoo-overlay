# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib gnome2

DESCRIPTION="Unofficial NAPI-PROJEKT clone for non-Windows systems"
HOMEPAGE="http://krzemin.iglu.cz/qnapi"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc gnome kde kde4"

DEPEND=">=x11-libs/qt-core-4.3
app-arch/p7zip
kde? ( || ( <kde-base/kdebase-startkde-4 <kde-base/kdebase-4 ) )
kde4? ( >=kde-base/kdebase-4 )
gnome? ( gnome-base/gconf )
"

RDEPEND="${DEPEND}"



src_compile() {
	/usr/bin/qmake || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	dobin qnapi
	cd doc/

	if use doc; then
		dodoc ChangeLog changelog.gz README LICENSE qnapi-download.desktop qnapi-download.schemas
	fi

	newman ${PN}.1.gz ${PN}.1
	doman ${PN}.1.gz
	domenu qnapi.desktop

	if use kde;  then
		dodir /usr/share/apps/konqueror/servicemenus/
		insinto /usr/share/apps/konqueror/servicemenus/
		doins	qnapi-download.desktop 
	
		dodir /usr/share/apps/dolphin/servicemenus/
		insinto /usr/share/apps/dolphin/servicemenus/
		doins qnapi-download.desktop 
	
		dodir /usr/share/apps/d3lphin/servicemenus/
		insinto /usr/share/apps/d3lphin/servicemenus/
		doins qnapi-download.desktop 
	fi

	if use kde4;  then
		dodir /usr/$(get_libdir)/kde4/share/kde4/services/ServiceMenus/
		insinto /usr/$(get_libdir)/kde4/share/kde4/services/ServiceMenus/
		doins qnapi-download.desktop 
	fi

	if use gnome; 	then
		dodir /etc/gconf/schemas/
		insinto /usr/share/gconf/schemas/
		doinst qnapi-download.schemas
	fi
	
	cd ../res
	insinto /usr/share/icons/
	doins qnapi*.png
}

pkg_postinst()
{
	if use gnome;	then
		gconf_install
	fi
}
