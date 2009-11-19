# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gems

USE_RUBY="ruby18"

DESCRIPTION=""
HOMEPAGE=""
LICENSE=""

KEYWORDS="~amd64"
SLOT="0"
IUSE=""

DEPEND="
	${DEPEND}
	dev-ruby/rake
	dev-ruby/configuration
"
