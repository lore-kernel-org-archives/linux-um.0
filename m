Return-Path: <sam@ravnborg.org>
Date: Fri, 1 May 2009 11:44:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 6/6] Add support for __read_mostly to linux/cache.h
Message-ID: <20090501094407.GD18326@uranus.ravnborg.org>
References: <1241119956-31453-1-git-send-email-tabbott@mit.edu> <1241119956-31453-2-git-send-email-tabbott@mit.edu> <1241119956-31453-3-git-send-email-tabbott@mit.edu> <1241119956-31453-4-git-send-email-tabbott@mit.edu> <1241119956-31453-5-git-send-email-tabbott@mit.edu> <1241119956-31453-6-git-send-email-tabbott@mit.edu> <1241119956-31453-7-git-send-email-tabbott@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1241119956-31453-7-git-send-email-tabbott@mit.edu>
To: Tim Abbott <tabbott@MIT.EDU>, Christoph Lameter <cl@linux-foundation.org>
Cc: Anders Kaseorg <andersk@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@MIT.EDU>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bryan Wu <cooloney@kernel.org>, Chris Zankel <chris@zankel.net>, Cyrill Gorcunov <gorcunov@openvz.org>, David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, dev-etrax@axis.com, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@uclinux.org>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hirokazu Takata <takata@linux-m32r.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Kyle McMartin <kyle@mcmartin.ca>, Linus Torvalds <torvalds@linux-foundation.org>, linux-alpha@vger.kernel.org, linux-am33-list@redhat.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-ia64@vger.kernel.org, linux-m32r@ml.linux-m32r.org, linux-m68k@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au, Mikael Starvik <starvik@axis.com>, Paul Mackerras <paulus@samba.org>, Paul Mundt <lethal@linux-sh.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, Roman Zippel <zippel@linux-m68k.org>, Russell King <rmk+kernel@arm.linux.org.uk>, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, uclinux-dist-devel@blackfin.uclinux.org, user-mode-linux-devel@lists.sourceforge.net, Yoshinori Sato <ysato@users.sourceforge.jp>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Apr 30, 2009 at 03:32:36PM -0400, Tim Abbott wrote:
> Signed-off-by: Tim Abbott <tabbott@mit.edu>
> ---
>  include/linux/cache.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/cache.h b/include/linux/cache.h
> index 97e2488..99d8a6f 100644
> --- a/include/linux/cache.h
> +++ b/include/linux/cache.h
> @@ -13,7 +13,13 @@
>  #endif
>  
>  #ifndef __read_mostly
> +#ifdef CONFIG_HAVE_READ_MOSTLY_DATA
> +#define __read_mostly __attribute__((__section__(".data.read_mostly")))
> +#define __READ_MOSTLY .section ".data.read_mostly", "aw"
> +#else
>  #define __read_mostly
> +#define __READ_MOSTLY
> +#endif /* CONFIG_HAVE_READ_MOSTLY_DATA */
>  #endif

Are there any specific reason why we do not support read_mostly on all
architectures?

read_mostly is about grouping rarely written data together
so what is needed is to introduce this section in the remaining
archtectures.

Christoph - git log says you did the inital implmentation.
Do you agree?

	Sam

