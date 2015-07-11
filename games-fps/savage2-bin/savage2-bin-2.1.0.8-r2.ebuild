# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="Unique mix of strategy and FPS"
HOMEPAGE="http://savage2.s2games.com/"
SRC_URI="x86? ( http://savage2.s2games.com/downloads/Savage2-$PV-linux-installer.run )
	 amd64? ( http://savage2.s2games.com/downloads//Savage2-$PV-linux-x64-installer.run )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="mirror strip fetch"

RDEPEND="virtual/opengl"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/savage2

src_unpack() {
	cd ${S}	
	unzip $DISTDIR/${A} &> /dev/null
	rm data/modelviewer.sh \
		data/dedicated_server.sh \
		data/editor.sh
}

src_install() {
	cd ${S}/data
	insinto "${dir}"
	doins -r * || die "doins failed"
	fperms g+x "${dir}"/savage2_update.bin || die "fperms failed"
	fperms g+x "${dir}"/savage2.bin || die "fperms failed"
	doicon s2icon.png
	
	games_make_wrapper savage2 "./savage2.bin" "${dir}" "${dir}:${dir}/libs"
	make_desktop_entry savage2 "Savage 2: A Tortured Soul" s2icon

	games_make_wrapper savage2-editor "./savage2.bin \"PushMod editor; Set host_autoExec StartClient\"" \
		"${dir}" "${dir}:${dir}/libs"
	make_desktop_entry savage2-editor "Savage 2: Editor" s2icon

	games_make_wrapper savage2-modelviewer "./savage2.bin \"PushMod modelviewer; Set host_autoExec StartClient\"" \
		"${dir}" "${dir}:${dir}/libs"
	make_desktop_entry savage2-modelviewer "Savage 2: Model Viewer" s2icon

	games_make_wrapper savage2-dedicated "./savage2.bin \"Set host_dedicatedServer true\"" \
	"${dir}" "${dir}:${dir}/libs"

	prepgamesdirs
}
pkg_postinst(){
	einfo "Run as root:"
	einfo "LD_LIBRARY_PATH=\"\${LD_LIBRARY_PATH}:/opt/savage2:/opt/savage2/libs\" ${GAMES_PREFIX_OPT}/savage2/savage2_update.bin --update-runpath"
	einfo "once to complete installation"
}


