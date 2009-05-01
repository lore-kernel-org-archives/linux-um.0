Return-Path: <cl@linux.com>
Date: Fri, 1 May 2009 09:52:18 -0400 (EDT)
From: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 6/6] Add support for __read_mostly to linux/cache.h
In-Reply-To: <20090501094407.GD18326@uranus.ravnborg.org>
Message-ID: <alpine.DEB.1.10.0905010948140.18324@qirst.com>
References: <1241119956-31453-1-git-send-email-tabbott@mit.edu> <1241119956-31453-2-git-send-email-tabbott@mit.edu> <1241119956-31453-3-git-send-email-tabbott@mit.edu> <1241119956-31453-4-git-send-email-tabbott@mit.edu> <1241119956-31453-5-git-send-email-tabbott@mit.edu>
 <1241119956-31453-6-git-send-email-tabbott@mit.edu> <1241119956-31453-7-git-send-email-tabbott@mit.edu> <20090501094407.GD18326@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Tim Abbott <tabbott@MIT.EDU>, Anders Kaseorg <andersk@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@MIT.EDU>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bryan Wu <cooloney@kernel.org>, Chris Zankel <chris@zankel.net>, Cyrill Gorcunov <gorcunov@openvz.org>, David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, dev-etrax@axis.com, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@uclinux.org>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hirokazu Takata <takata@linux-m32r.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Kyle McMartin <kyle@mcmartin.ca>, Linus Torvalds <torvalds@linux-foundation.org>, linux-alpha@vger.kernel.org, linux-am33-list@redhat.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-ia64@vger.kernel.org, linux-m32r@ml.linux-m32r.org, linux-m68k@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au, Mikael Starvik <starvik@axis.com>, Paul Mackerras <paulus@samba.org>, Paul Mundt <lethal@linux-sh.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, Roman Zippel <zippel@linux-m68k.org>, Russell King <rmk+kernel@arm.linux.org.uk>, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, uclinux-dist-devel@blackfin.uclinux.org, user-mode-linux-devel@lists.sourceforge.net, Yoshinori Sato <ysato@users.sourceforge.jp>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, 1 May 2009, Sam Ravnborg wrote:

> Are there any specific reason why we do not support read_mostly on all
> architectures?

Not that I know of.

> read_mostly is about grouping rarely written data together
> so what is needed is to introduce this section in the remaining
> archtectures.
>
> Christoph - git log says you did the inital implmentation.
> Do you agree?

Yes.

There is some concern that __read_mostly is needlessly applied to
numerous variables that are not used in hot code paths. This may make
__read_mostly ineffective and actually increase the cache footprint of a
function since global variables are no longer in the same cacheline. If
such a function is called and the caches are cold then two cacheline
fetches have to be done instead of one.



