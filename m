Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 28 May 2013 17:43:52 +0200
References: <519DCBEF.3090208@asianux.com> <20130528081910.GA29557@gmail.com> <51A4C564.4040301@zytor.com>
In-Reply-To: <51A4C564.4040301@zytor.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201305281743.52649.arnd@arndb.de>
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always need it.
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Chen Gang <gang.chen@asianux.com>, H?vard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Serge Hallyn <serge.hallyn@canonical.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Akinobu Mita <akinobu.mita@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Michel Lespinasse <walken@google.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, linux-hexagon@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, Linux-Arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tuesday 28 May 2013, H. Peter Anvin wrote:
> On 05/28/2013 01:19 AM, Ingo Molnar wrote:
> > 
> > So I think the same principle applies to it as to any other debugging 
> > code: it's fine to be able to turn debugging off. It's a performance 
> > versus kernel robustness/determinism trade-off.
> > 
> 
> I suspect, rather, that BUG() should turn into a trap (or jump to a
> death routine) under any circumstances.  The one thing that can be
> omitted for small configurations are the annotations, which only serve
> to output a more human-readable error message.

Right, that is what the patch I just posted does.

On a related note, I found that WARN_ON() can no longer be compiled
out since there is already code that relies on the side-effects of
the condition. I assume that was an intentional change I missed,
since it used to be defined so that you could remove it completely.

	Arnd

