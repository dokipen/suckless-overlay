# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib toolchain-funcs mercurial

DESCRIPTION="A dynamic window manager for X11"
HOMEPAGE="http://wmii.suckless.org/"
EHG_REPO_URI="http://code.suckless.org/hg/wmii"

LICENSE="MIT"
SLOT="0"
IUSE="doc ruby python plan9port"

DEPEND="
	app-text/txt2tags
	sys-libs/libixp
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXrandr
	x11-libs/libXinerama
"
RDEPEND="
	${DEPEND}
	x11-apps/xmessage
	x11-apps/xsetroot
	ruby? (
		>=dev-ruby/rumai-3.2.0
		>=x11-misc/dmenu-4.0
	)
	python? ( dev-lang/python )
"

S="${WORKDIR}/${PN}"

src_unpack() {
	mercurial_src_unpack

	cp "${FILESDIR}"/config.local.mk "${S}"
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use doc ;
	then
		dodoc {NOTES,README,TODO,DISTRIBUTORS,NEWS} || die
		insinto /usr/share/doc/"${P}" && 
		  doins "${S}"/img/{wmii.{eps,mp,png},icon.png} || die
	fi

	echo -e "#!/bin/sh\n/usr/bin/wmii" > "${T}/${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}/${PN}"

	insinto /usr/share/xsessions
	newins "${FILESDIR}/${PN}.desktop.tip" "${PN}.desktop"

	use ruby || rm -Rf ${D}/etc/wmii/ruby
	use python || rm -Rf ${D}/etc/wmii/python
	use plan9port || rm -Rf ${D}/etc/wmii/plan9port

	ewarn "Note that the default config files use xterm as the terminal "
	ewarn "emulator.  If you don't have xterm installed, then you will need "
	ewarn "to edit your wmii configuration to get <Alt>-<Return> working."
}
