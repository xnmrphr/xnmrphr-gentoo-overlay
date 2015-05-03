# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils python-r1 git-2 distutils-r1

DESCRIPTION="U-Air allows you to upload, browse and download your files wherever you are.
Do you sometimes forget to bring some file from your home computer to your friend? It's not a problem anymore.
You can easly browse your files, upload new and listen to songs in MP3."
HOMEPAGE="http://michal0468.github.io/u-air/"
#SRC_URI="ftp://foo.example.org/${P}.tar.gz"
EGIT_REPO_URI="https://github.com/michal0468/u-air" 
LICENSE=""
SLOT="0"

KEYWORDS="~x86"
#IUSE="gnome X"

# A space delimited list of portage features to restrict. man 5 ebuild
# for details.  Usually not needed.
#RESTRICT="strip"

# Build-time dependencies, such as
#    ssl? ( >=dev-libs/openssl-0.9.6b )
#    >=dev-lang/perl-5.6.1-r1

DEPEND=">=dev-python/flask-0.10.1-r1
dev-python/jsonrpclib
"
RDEPEND="${DEPEND}"

PYTHON_TARGETS="python2_7 python3_2 python3_3"
PYTHON_SINGLE_TARGET="python2_7"

#S=${WORKDIR}/${P}

src_unpack() {
    einfo "Unpacking git repo."
    git-2_src_unpack
}

#src_prepare() {
#    einfo "Prepare source"
#}


src_configure() {
	#econf
	#./configure \
	#	--host=${CHOST} \
	#	--prefix=/usr \
	#	--infodir=/usr/share/info \
	#	--mandir=/usr/share/man || die
	einfo "Removing already precompiled python bytecode files."
	rm -f ${S}/*.pyc
}

#src_compile() {
	# emake (previously known as pmake) is a script that calls the
	# standard GNU make with parallel building options for speedier
	# builds (especially on SMP systems).  Try emake first.  It might
	# not work for some packages, because some makefiles have bugs
	# related to parallelism, in these cases, use emake -j1 to limit
	# make to a single process.  The -j1 is a visual clue to others
	# that the makefiles have bugs that have been worked around.

	#emake || die
#}

#src_install() {
	#emake DESTDIR="${D}" install || die

	#emake \
	#	prefix="${D}"/usr \
	#	mandir="${D}"/usr/share/man \
	#	infodir="${D}"/usr/share/info \
	#	libdir="${D}"/usr/$(get_libdir) \
	#	install || die

	#einstall || die
#}
