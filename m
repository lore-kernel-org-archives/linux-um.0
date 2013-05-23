Return-Path: <ebiederm@xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <519DCBEF.3090208@asianux.com>
	<20130523090534.GJ18614@n2100.arm.linux.org.uk>
	<CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
	<201305231139.38233.arnd@arndb.de>
Date: Thu, 23 May 2013 03:09:50 -0700
In-Reply-To: <201305231139.38233.arnd@arndb.de> (Arnd Bergmann's message of
	"Thu, 23 May 2013 11:39:37 +0200")
Message-ID: <878v369fdd.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always need it.
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chen Gang <gang.chen@asianux.com>, =?utf-8?Q?H=C3=A5vard?= Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Serge Hallyn <serge.hallyn@canonical.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Akinobu Mita <akinobu.mita@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Michel Lespinasse <walken@google.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, linux-hexagon@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Arnd Bergmann <arnd@arndb.de> writes:

> On Thursday 23 May 2013, Geert Uytterhoeven wrote:
>> > The problem is: trying to fix that will mean the result is a larger
>> > kernel than if you just do the usual arch-implemented thing of placing
>> > an defined faulting instruction at the BUG() site - which defeats the
>> > purpose of turning off CONFIG_BUG.
>> 
>> Is __builtin_unreachable() working well these days?
>> 
>
> Hmm, I just tried the trivial patch below, which seemed to do the right thing.
> Needs a little more investigation, but that might actually be the correct
> solution. I thought that at some point __builtin_unreachable() was the same
> as "do {} while (1)", but this is not the case with the gcc I was using --
> it just tells gcc that we don't expect to ever get here.

Yes.

We already have this abstracted in compiler.h as the macro unreachable,
so the slight modification of your patch below should handle this case.

For compilers without __builtin_unreachable() unreachable() expands to
do {} while(1) but an infinite loop seems reasonable and preserves the
semantics of the code, unlike the current noop that is do {} while(0).

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 7d10f96..9afff7d 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -108,11 +108,11 @@ extern void warn_slowpath_null(const char *file, const int line);
 
 #else /* !CONFIG_BUG */
 #ifndef HAVE_ARCH_BUG
-#define BUG() do {} while(0)
+#define BUG() unreachable ()
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
-#define BUG_ON(condition) do { if (condition) ; } while(0)
+#define BUG_ON(condition) do { if (condition) unreachable(); } while(0)
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON

