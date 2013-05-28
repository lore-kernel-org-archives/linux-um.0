Return-Path: <linuxppc-dev-bounces+geert=linux-m68k.org@lists.ozlabs.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 28 May 2013 19:20:37 +0200
References: <519DCBEF.3090208@asianux.com> <201305281743.52649.arnd@arndb.de>
 <51A4D618.3080208@zytor.com>
In-Reply-To: <51A4D618.3080208@zytor.com>
MIME-Version: 1.0
Message-Id: <201305281920.37452.arnd@arndb.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linuxppc-dev-bounces+geert=linux-m68k.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+geert=linux-m68k.org@lists.ozlabs.org>
Subject: Re: [PATCH] arch: configuration,
 deleting 'CONFIG_BUG' since always need it.
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Linux-sh list <linux-sh@vger.kernel.org>, Chen Gang <gang.chen@asianux.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "paulus@samba.org" <paulus@samba.org>, Michel Lespinasse <walken@google.com>, Ingo Molnar <mingo@kernel.org>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, "mingo@redhat.com" <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, H?vard Skinnemoen <hskinnemoen@gmail.com>, Serge Hallyn <serge.hallyn@canonical.com>, Mike Frysinger <vapier@gentoo.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Will Deacon <will.deacon@arm.com>, Jeff Dike <jdike@addtoit.com>, Akinobu Mita <akinobu.mita@gmail.com>, uml-user <user-mode-linux-user@lists.sourceforge.net>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Parisc List <linux-parisc@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, Paul Mundt <lethal@linux-sh.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-hexagon@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, David Miller <davem@davemloft.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tuesday 28 May 2013, H. Peter Anvin wrote:
> On 05/28/2013 08:43 AM, Arnd Bergmann wrote:
> > 
> > Right, that is what the patch I just posted does.
> > 
> > On a related note, I found that WARN_ON() can no longer be compiled
> > out since there is already code that relies on the side-effects of
> > the condition. I assume that was an intentional change I missed,
> > since it used to be defined so that you could remove it completely.
> > 
> 
> It is possible to define WARN_ON() as:
> 
> #define WARN_ON(x) ((void)(x))
> 
> ... which preserves side effects.

Yes, actually the return value has to be maintained as well.
The current (!CONFIG_BUG) default implementation is

#define WARN_ON(condition) ({                                           \
        int __ret_warn_on = !!(condition);                              \
        unlikely(__ret_warn_on);                                        \
})

which seems fine.

#define WARN_ON(condition) unlikely(!!(condition))

is probably just as good.

	Arnd
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev

