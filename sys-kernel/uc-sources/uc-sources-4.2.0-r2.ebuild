# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="2"
K_DEBLOB_AVAILABLE="0"
K_KDBUS_AVAILABLE="1"

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~alpha ~amd64 ~arm ~arm64 -hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
HOMEPAGE="https://dev.gentoo.org/~mpagano/genpatches"
IUSE="experimental"

DESCRIPTION="Full sources including the Gentoo and uC-Art patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"
#UNIPATCH_STRICTORDER=0
UNIPATCH_LIST="${FILESDIR}/4.1.2-btbcm.patch"

K_EXTRAEINFO="Gentoo sources with some additional patches."


pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "Please consider that kernel package as unsupported from mainline patched version of gentoo-sources"
	einfo "use it only at your risk and don't bother gentoo developers about any problems in future."
	einfo "Package may contain some ugly patches and hardware related \"haxes\""
	einfo "please consider that package as purely experimental and potentially unsafe."
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
