Return-Path: <hpa@zytor.com>
Message-ID: <49FB35C4.6060107@zytor.com>
Date: Fri, 01 May 2009 10:47:48 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/6] Add new macros for page-aligned data and bss sections.
References: <1241121253-32341-1-git-send-email-tabbott@mit.edu> <1241121253-32341-2-git-send-email-tabbott@mit.edu> <20090501091848.GB18326@uranus.ravnborg.org> <alpine.DEB.1.10.0905010951100.3955@vinegar-pot.mit.edu> <49FB2449.1010301@zytor.com> <20090501171717.GA26401@uranus.ravnborg.org> <49FB2EDC.9050300@zytor.com> <20090501174457.GA26559@uranus.ravnborg.org>
In-Reply-To: <20090501174457.GA26559@uranus.ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Tim Abbott <tabbott@MIT.EDU>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Anders Kaseorg <andersk@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@MIT.EDU>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bryan Wu <cooloney@kernel.org>, Chris Zankel <chris@zankel.net>, Cyrill Gorcunov <gorcunov@openvz.org>, David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, dev-etrax@axis.com, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@uclinux.org>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hirokazu Takata <takata@linux-m32r.org>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Kyle McMartin <kyle@mcmartin.ca>, Linus Torvalds <torvalds@linux-foundation.org>, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au, Mikael Starvik <starvik@axis.com>, Paul Mackerras <paulus@samba.org>, Paul Mundt <lethal@linux-sh.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, Roman Zippel <zippel@linux-m68k.org>, Russell King <rmk+kernel@arm.linux.org.uk>, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, uclinux-dist-devel@blackfin.uclinux.org, user-mode-linux-devel@lists.sourceforge.net, Yoshinori Sato <ysato@users.sourceforge.jp>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Sam Ravnborg wrote:
>>
>> What's wrong with @?
> arm does not support it :-(
> I recall it denote a comment in arm assembler.
> 
> I could do some magic to detect the ARM case but I'm reluctant to do so.
> I could also ignore the arm issue for now as it is not used by arm,
> but that strikes me as the wrong approach.
> 

If we really have to use different tokens, I would say:

#ifdef __ARM__
# define _PROGBITS %progbits	/* or whatever */
# define _NOBITS   %nobits
#else
# define _PROGBITS @progbits
# define _NOBITS   @nobits
#endif

Otherwise we probably need to ask the binutils people...

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


