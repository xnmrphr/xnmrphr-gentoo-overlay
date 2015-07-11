# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MY_P=${PN}${PV}

inherit eutils toolchain-funcs games

DESCRIPTION="Team-based aliens vs humans FPS with buildable structures"
HOMEPAGE="http://tremulous.net/"
SRC_URI="mirror://sourceforge/tremulous/${MY_P}.zip"

LICENSE="GPL-2 CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dedicated openal +opengl +vorbis -qvm"

UIDEPEND="
	virtual/jpeg
	media-libs/libsdl[opengl?]
	vorbis? ( media-libs/libogg media-libs/libvorbis )
	openal? ( media-libs/openal )
	x11-libs/libXau
	x11-libs/libXdmcp"
RDEPEND="opengl? ( ${UIDEPEND} )
	!opengl? ( !dedicated? ( ${UIDEPEND} ) )
	games-fps/tremulous"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/tremulous/tremulous-ggp1-src

pkg_setup() {
    if use qvm; then
        ewarn "======================================================"
        ewarn "BIG FAT WARNING!!!"
        ewarn " Try to do not use qvm flag"
        ewarn "in most systems building deprecated QVMs may fail"
        ewarn "======================================================"
        sleep 2
    fi
}

src_unpack() {
	unpack ${A}
	cd tremulous
	unpack ./${MY_P}-src.tar.gz
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

	if use qvm; then
		einfo "Building source based QVMS"
		qvm=1
	else
		einfo "Using distributed QVMS"
		qvm=0
	fi

	emake \
		$(use amd64 && echo ARCH=x86_64) \
		BUILD_CLIENT=${client} \
		BUILD_CLIENT_SMP=${client} \
		BUILD_SERVER=$(buildit dedicated) \
		BUILD_GAME_SO=0 \
		BUILD_GAME_QVM=${qvm} \
		CC="$(tc-getCC)" \
		DEFAULT_BASEDIR="${GAMES_DATADIR}/tremulous" \
		USE_CODEC_VORBIS=$(buildit vorbis) \
		USE_OPENAL=$(buildit openal) \
		USE_LOCAL_HEADERS=0 \
		OPTIMIZE= \
		|| die "emake failed"
}

src_install() {
	insinto "${GAMES_DATADIR}"/tremulous
	if use qvm; then
		rm	-f ../gpp/vms-gpp1.pk3 || die "rm old vms"
		einfo "Zipping VMS pack"
		cd	build/release-linux-*/base/
		zip -r ../../../../gpp/vms-gpp1.pk3 vm/ || die "vmsX.pk3"
	fi
	
	cd ${S}
	doins -r ../gpp || die "doins -r failed"
	dodoc ChangeLog
	if use opengl || ! use dedicated ; then
		newgamesbin build/release-linux-*/tremulous-smp.* ${PN} \
			|| die "newgamesbin ${PN}"
		newicon "${S}"/misc/tremulous.xpm ${PN}.xpm
		make_desktop_entry ${PN} Tremulous-GPP
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
