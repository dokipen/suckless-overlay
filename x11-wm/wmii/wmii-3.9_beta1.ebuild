# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib toolchain-funcs

MY_P="${PN}+ixp-${PV/_beta/b}"

DESCRIPTION="A dynamic window manager for X11"
HOMEPAGE="http://wmii.suckless.org/"
SRC_URI="http://dl.suckless.org/wmii/${MY_P}.tbz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="ruby python plan9port"

DEPEND="
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

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "/^PREFIX/s|=.*|= /usr|" \
		-e "/^  ETC/s|=.*|= /etc|" \
		-e "/^  LIBDIR/s|=.*|= /usr/$(get_libdir)|" \
		-e "/^CFLAGS/s|+=.*|+= |" \
		config.mk || die "sed failed"
		# Probably should fix and add these, too
#		-e "/^CC/s|=.*|= $(tc-getCC) -c|"\
#		-e "/^LD/s|=.*|= $(tc-getCC)|"\
#		-e "/^AR/s|=.*|= $(tc-getAR) crs|"\
}

src_compile() {
	emake -j1|| die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc NEWS NOTES README TODO

	echo -e "#!/bin/sh\n/usr/bin/wmii" > "${T}/${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}/${PN}"

	insinto /usr/share/xsessions
	doins "${FILESDIR}/${PN}.desktop"

	use ruby || rm -Rf ${D}/etc/wmii/ruby
	use python || rm -Rf ${D}/etc/wmii/python
	use plan9port || rm -Rf ${D}/etc/wmii/plan9port

	ewarn "Note that the default config files use xterm as the terminal "
	ewarn "emulator.  If you don't have xterm installed, then you will need "
	ewarn "to edit your wmii configuration to get <Alt>-<Return> working."
}
