# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit mercurial

DESCRIPTION="surf is a simple web browser based on WebKit/GTK+."
HOMEPAGE="http://surf.suckless.org/"
EHG_REPO_URI="http://hg.suckless.org/surf"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="net-libs/webkit-gtk"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_unpack() {
	mercurial_src_unpack

	cp "${FILESDIR}"/config.local.mk "${S}"
}

src_compile() {
	epatch "${FILESDIR}/local-mk.patch"
	epatch "${FILESDIR}/noop_source.patch"
	emake -j1 || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	if use doc ;
	then
		dodoc {LICENSE,README} || die
	fi
}

