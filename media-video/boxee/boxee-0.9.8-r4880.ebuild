DESCRIPTION="Boxee is a fork of the XBMC media center project with built-in social networking features"
HOMEPAGE="http://www.boxee.tv"

inherit autotools eutils flag-o-matic libtool

SRC_PKG="boxee-source-${PV}.${PR/r/}.tar.bz2"
SRC_URI="http://dl.boxee.tv/${SRC_PKG}"

LICENSE="GPL LGPL"
SLOT="1"
KEYWORDS="~x86"
IUSE="debug joystick opengl pcre xrandr"

SDLV="1.2"

DEPEND=">=sys-devel/gcc-4.1
	sys-devel/libtool
	sys-devel/automake
	dev-util/cmake
	dev-util/gperf

	opengl? ( media-libs/mesa ) 

	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-gfx
	media-libs/sdl-mixer
	media-libs/sdl-sound


	media-libs/freetype
	media-libs/libogg
	media-libs/alsa-lib
	media-libs/glew
	media-libs/libmad
	media-libs/libvorbis
	media-libs/jasper
	media-libs/fontconfig
	media-libs/faac
	media-libs/libpng
	virtual/jpeg

	dev-libs/fribidi
	dev-libs/lzo
	dev-libs/tre
	pcre? ( dev-libs/libpcre )
	dev-libs/boost

	>=dev-db/sqlite-3
	dev-db/mysql
	dev-python/pysqlite

	dev-lang/nasm

	net-misc/curl

	app-arch/bzip2
	app-arch/unzip
	
	app-i18n/enca

	sys-apps/gawk
	sys-apps/pmount
	sys-apps/dbus
	
	x11-proto/xineramaproto
	x11-libs/libXrender
	xrandr? ( x11-libs/libXrandr )
	x11-libs/libXinerama
	x11-libs/libXt
	x11-libs/libXmu
	"

#	media-libs/sdl-stretch

A="${DISTDIR}/${SRC_PKG}"

S="${WORKDIR}/boxee-source-${PR/r/}"

src_unpack() {
        unpack ${A}
        cd "${S}"
        eautoreconf
        elibtoolize
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable joystick) \
		$(use_enable opengl gl) \
		$(use_enable profile profiling) \
		$(use_enable xrandr) \
		|| die "econf failed" 
}
