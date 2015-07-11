# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/tremulous/tremulous-1.1.0-r4.ebuild,v 1.5 2010/10/15 12:30:03 ranger Exp $

EAPI=2

inherit eutils toolchain-funcs games git-r3

DESCRIPTION="Team-based aliens vs humans FPS with buildable structures"
HOMEPAGE="http://tremulous.net/ http://trem-servers.com"

MY_P="${PN}-1.2.0"
MY_V="1.2.0"

MY_P1="${PN}-1.1.0"
MY_V1="1.1.0"

MY_P2="${PN}-gpp1"
MY_V2="gpp1"

SRC_URI="http://dl.trem-servers.com/${PN}-gentoopatches-1.1.0-r5.zip
	http://dl.trem-servers.com/vms-1.1.t971.pk3
	http://0day.icculus.org/mirrors/${PN}/${MY_P1}.zip
	ftp://ftp.wireplay.co.uk/pub/quake3arena/mods/${PN}/${MY_P1}.zip
	mirror://sourceforge/${PN}/${MY_P1}.zip
	mirror://sourceforge/${PN}/${MY_P2}.zip"

EGIT_REPO_URI="https://github.com/darklegion/tremulous.git"
EGIT_BRANCH="master"	#fetch official tremulous 1.2 from master branch

LICENSE="GPL-2 CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dedicated openal +opengl +opengl2 +vorbis +qvm"

UIDEPEND="
	virtual/jpeg
	media-libs/libsdl[opengl?]
	vorbis? ( media-libs/libogg media-libs/libvorbis )
	openal? ( media-libs/openal )
	x11-libs/libXau
	x11-libs/libXdmcp"
RDEPEND="opengl? ( ${UIDEPEND} )
	!opengl? ( !dedicated? ( ${UIDEPEND} ) )"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}/${MY_P}-src
EGIT_CHECKOUT_DIR=${S}

src_unpack() {
	unpack ${PN}-gentoopatches-${MY_V1}-r5.zip
	unpack ${MY_P1}.zip
	unpack ${MY_P2}.zip
	cd ${PN}
#	unpack ./${MY_P}-src.tar.gz
	git-r3_src_unpack
	#cp -f "${DISTDIR}"/vms-1.1.t971.pk3 "${WORKDIR}"/${PN}/base/ || die
}

src_prepare() {
	# security patches
	#epatch "${WORKDIR}"/${PN}-svn755-upto-971.patch
	#epatch "${WORKDIR}"/${PN}-t971-client.patch
	#epatch "${FILESDIR}"/${MY_P}-system_jpeg.patch \
	epatch  "${FILESDIR}"/${MY_P1}-system_jpeg-2.patch
	#epatch "${FILESDIR}/${MY_P}-libcurl.patch"

	# zonemegs patch
	epatch "${FILESDIR}"/${P}-zonemegs.patch

	# fix the gcc-4.3.3 Werror issue
	# This is probably issue for all icculus q3 based games
	# sed -i -e '16s/-Werror //' src/tools/asm/Makefile || die
}

src_compile() {
	buildit() { use $1 && echo 1 || echo 0 ; }

	local client=1
	if ! use opengl; then
		client=0
		if ! use dedicated; then
			# user is not sure what he wants
			client=1
		fi
	fi

	emake \
		$(use amd64 && echo ARCH=x86_64) \
		BUILD_CLIENT=${client} \
		BUILD_RENDERER_OPENGL2=$(buildit opengl2) \
		BUILD_SERVER=$(buildit dedicated) \
		BUILD_GAME_SO=0 \
		BUILD_GAME_QVM=$(buildit qvm) \
		CC="$(tc-getCC)" \
		DEFAULT_BASEDIR="${GAMES_DATADIR}/${PN}" \
		USE_CODEC_VORBIS=$(buildit vorbis) \
		USE_OPENAL=$(buildit openal) \
		USE_LOCAL_HEADERS=0 \
		OPTIMIZE= \
		|| die "emake failed"
}

src_install() {
	insinto "${GAMES_DATADIR}"/${PN}

	if use qvm; then
		#rm	-f ../base/vms-1.1.0.pk3 || die "rm old vms"
		#rm	-f ../gpp/vms-gpp1.pk3   || die "rm old vms"
		einfo "Zipping VMS pack"
		cd	build/release-linux-*/base/
		zip -r ../../../../base/vms-1.2.0.pk3 vm/ || die "vmsX.pk3"
		cd ${S}
	fi

	mv -f ../gpp/* ../base/ || die "mv gpp->base failed"
	doins -r ../base || die "doins -r base failed"
	#doins -r ../gpp  || die "doins -r gpp failed"
	dodoc ChangeLog ../manual.pdf
	if use opengl || use opengl2 || ! use dedicated ; then
		newgamesbin build/release-linux-*/tremulous.* ${PN} || die "newgamesbin ${PN}"
		doins       build/release-linux-*/renderer_*        || die "doins renderers"
		newicon "${WORKDIR}"/tyrant.xpm ${PN}.xpm
		make_desktop_entry ${PN} Tremulous
	fi
	if use dedicated ; then
		newgamesbin build/release-linux-*/tremded.* ${PN}-ded \
			|| die "newgamesbin ${PN}-ded failed"
	fi
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "If you want to add extra maps, download"
	elog "http://tremulous.bricosoft.com/base/all-maps.tgz"
	elog "and unpack it into ~/.tremulous/base for your user"
	elog "or into ${GAMES_DATADIR}/${PN}/base for all users."
}
