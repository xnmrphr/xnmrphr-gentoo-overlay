# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="An open source Evernote clone"
HOMEPAGE="http://nevernote.sourceforge.net/index.htm"

FN="${PN}2-$( echo ${PV} | tr '_' '-'  )"

SRC_URI="x86?    ( mirror://sourceforge/nevernote/${FN}_i386.tar.gz )
	 amd64?  ( mirror://sourceforge/nevernote/${FN}_amd64.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="mirror"

DEPEND=""
RDEPEND=">=virtual/jdk-1.5
	media-libs/libpng:1.2"

S="${PN}2"
src_install() {
	cp -rf "${S}/usr" "${D}/"
}
