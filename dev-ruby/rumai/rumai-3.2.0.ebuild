# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gems

USE_RUBY="ruby18"

DESCRIPTION="Ruby interface to the WMII window manager."
HOMEPAGE="http://snk.tuxfamily.org/lib/rumai"
LICENSE="ISC"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""

DEPEND="
	${DEPEND}
	dev-ruby/rake
	dev-ruby/trollop
	dev-ruby/configuration
	dev-ruby/launchy
	dev-ruby/inochi
"
RDEPEND="
	${DEPEND}
	>=x11-wm/wmii-3.7
"
