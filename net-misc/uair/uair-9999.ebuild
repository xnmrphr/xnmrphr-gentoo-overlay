# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_SINGLE_TARGET="python2_7"

inherit eutils python-single-r1 git-2

DESCRIPTION="U-Air allows you to upload, browse and download your files wherever you are.
Do you sometimes forget to bring some file from your home computer to your friend? It's not a problem anymore.
You can easly browse your files, upload new and listen to songs in MP3."
HOMEPAGE="http://michal0468.github.io/u-air/"

#SRC_URI=""
EGIT_REPO_URI="https://github.com/michal0468/u-air" 
LICENSE=""
SLOT="0"
RESTRICT="mirror"

KEYWORDS="~x86 ~amd64"

DEPEND=">=dev-python/flask-0.10.1-r1
dev-python/jsonrpclib
"
RDEPEND="${DEPEND}"

#PYTHON_TARGETS="python2_7 python3_2 python3_3"


#DOCSDIR="${S}/docs/"
DOCS="todo.txt README"

#S=${WORKDIR}/${P}

src_unpack() {
    einfo "Unpacking git repo."
    git-2_src_unpack
}

src_prepare() {
	epatch ${FILESDIR}/desktop.patch
}

src_configure() {
	#econf
	#./configure \
	#	--host=${CHOST} \
	#	--prefix=/usr \
	#	--infodir=/usr/share/info \
	#	--mandir=/usr/share/man || die
	einfo "Removing already precompiled python bytecode files and other stuff."
	rm -f "${S}"/*.pyc
	rm -f "${S}"/*.out
	rm -f "${S}"/*.deb
}

src_install() {
	insinto "/usr/share/applications"
	doins uair.desktop

	insinto "/opt/${PN}"
	doins *.py
	doins -r static
	doins -r templates

	into "/opt/${PN}"
	dobin uairlauncher

	#dodoc todo.txt README

	newicon ${S}/static/launcher.png	${PN}.png
	#make_desktop_entry /opt/bin/uairlauncher uair /opt/${PN}/static/launcher.png Network Terminal=false

	default
	python_optimize ${D}/opt/uair/*.py
}
