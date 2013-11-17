# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="a live performance tool featuring non-linear editing and mixing from multiple sources"
HOMEPAGE="http://www.veejayhq.net/"
SRC_URI="mirror://sourceforge/veejay/${P}.tar.bz2"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="debug directfb dv gtk jack jpeg opengl sdl v4l xml"

DEPEND="directfb? ( dev-libs/DirectFB )
	dv? ( media-libs/libdv )
	gtk? ( >=x11-libs/gtk+-2.0 )
	jack? ( >=media-sound/jack-audio-connection-kit-0.101.1 )
	jpeg? ( media-libs/jpeg )
	sdl? ( media-libs/libsdl )
	v4l? ( x11-libs/libXxf86dga )
	xml? ( dev-libs/libxml2 )
	>=media-libs/libquicktime-0.9.7
	media-libs/freetype
	media-libs/unicap
	media-video/ffmpeg
	media-video/mjpegtools"
RDEPEND=""
# Also uses media-libs/jpeg-mmx, treecleaned #156373

# Uses an internal copy of goom,
#  http://sourceforge.net/project/showfiles.php?group_id=30354

src_compile() {
	export PKG_CONFIG_PATH=/usr/bin
	econf \
		$(use_enable debug) \
		$(use_enable opengl gl) \
		$(use_with dv libdv) \
		$(use_with directfb) \
		$(use_with gtk pixbuf) \
		$(use_with jack) \
		$(use_with jpeg) \
		$(use_with jpeg) \
		$(use_with v4l) \
		$(use_with xml xml2) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
	doman man/veejay.1
}
