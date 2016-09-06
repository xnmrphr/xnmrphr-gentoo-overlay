# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_3,3_4,3_5} pypy2_0 )
#PYTHON_TARGETS=( python{2_6,2_7,3_3,3_4,3_5} )
#PYTHON_SINGLE_TARGET="python2_7"

inherit eutils python-single-r1 git-r3

DESCRIPTION="A Google Chrome/Chromium extension providing a HTML5 Geolocation API polyfill which connects to gpsd."
HOMEPAGE="https://github.com/micolous/gpsd-chrome-polyfill"

#SRC_URI=""
EGIT_REPO_URI="https://github.com/micolous/gpsd-chrome-polyfill.git"
LICENSE=""
SLOT="0"
RESTRICT="mirror"

KEYWORDS="~x86 ~amd64"

DEPEND="sci-geosciences/gpsd"
RDEPEND="${DEPEND}"

DOCS="README.md COPYING COPYING.LESSER"

src_compile() {
	return 0	#nothing to compile
}

src_install() {
	insinto "/etc/opt/chrome/native-messaging-hosts"
	doins   gpspipew/au.id.micolous.gpspipe.json
	
	insinto "/etc/chromium/native-messaging-hosts"
	doins   gpspipew/au.id.micolous.gpspipe.json

	into "/usr/local"
	dobin gpspipew/gpspipew.py
	dodoc ${DOCS}
}
