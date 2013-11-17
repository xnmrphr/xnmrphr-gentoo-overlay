# ebuild Generated  by karl at hiramoto dot org 

inherit flag-o-matic multilib eutils

DESCRIPTION="Myth Stream"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
HOMEPAGE="http://home.kabelfoon.nl/~moongies/streamtuned.html"

#IUSE=""

RDEPEND="dev-perl/XML-Simple
        dev-perl/XML-XQL
        dev-perl/XML-DOM
        >=media-tv/mythtv-0.20
        =sci-libs/fftw-2*"

DEPEND="${RDEPEND}
        "
SRC_URI="http://home.kabelfoon.nl/~moongies/sw9vc4htz2/mythstream_mythtv-r21640.tar.gz"

S="${WORKDIR}/mythstream_mythtv-r21640"


src_unpack() {
 unpack ${A}
 cd ${S}
}


src_compile() {

        qmake mythstream.pro || die "qmake failed"
        emake || die "emake failed"

} 

 src_install() { 
        export INSTALL_ROOT="${D}"
        emake  install || die "install failed"
}
