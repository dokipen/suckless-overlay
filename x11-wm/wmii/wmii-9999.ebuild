# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit multilib toolchain-funcs mercurial

DESCRIPTION="A dynamic window manager for X11"
HOMEPAGE="http://www.suckless.org/wiki/wmii"
EHG_REPO_URI="http://code.suckless.org/hg/wmii"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="doc"

DEPEND=">=sys-libs/libixp-9999
	x11-libs/libX11"
RDEPEND="${DEPEND}
	x11-apps/xmessage
	x11-apps/xsetroot"

S="${WORKDIR}/${PN}"

src_unpack() {
	mercurial_src_unpack

	cp "${FILESDIR}"/config.local.mk "${S}"
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	if use doc ;
	then
		dodoc {NOTES,README,TODO,DISTRIBUTORS,NEWS} || die
		insinto /usr/share/doc/"${P}" && 
		  doins "${S}"/img/{wmii.{eps,mp,png},icon.png} || die
	fi

	exeinto /etc/X11/Sessions
	doexe "${FILESDIR}/XSessions/${PN}"

	insinto /usr/share/xsessions
	doins "${FILESDIR}/${PN}.desktop"
}
