Return-Path: <gang.chen@asianux.com>
Message-ID: <519DF25E.7060304@asianux.com>
Date: Thu, 23 May 2013 18:41:34 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
References: <519DCBEF.3090208@asianux.com> <20130523090534.GJ18614@n2100.arm.linux.org.uk> <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com> <201305231139.38233.arnd@arndb.de> <20130523100409.GK18614@n2100.arm.linux.org.uk>
In-Reply-To: <20130523100409.GK18614@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?B?SMOldmFyZCBTa2lubmVtb2Vu?= <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Serge Hallyn <serge.hallyn@canonical.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Akinobu Mita <akinobu.mita@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Michel Lespinasse <walken@google.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, linux-hexagon@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 05/23/2013 06:04 PM, Russell King - ARM Linux wrote:
> So, if you want to use this, then you should update the CONFIG_BUG text
> to include a warning to this effect:
> 
>      Warning: if CONFIG_BUG is turned off, and control flow reaches
>      a BUG(), the system behaviour will be undefined.
> 
> so that people can make an informed choice about this, because at the
> moment:
> 
>           Disabling this option eliminates support for BUG and WARN, reducing
>           the size of your kernel image and potentially quietly ignoring
>           numerous fatal conditions. You should only consider disabling this
>           option for embedded systems with no facilities for reporting errors.
>           Just say Y.
> 
> will become completely misleading.  Turning this option off will _not_
> result in "quietly ignoring numerous fatal conditions".
> 
> And I come back to one of my previous arguments - is it not better to
> panic() if we hit one of these conditions so that the system can try to
> do a panic-reboot rather than continue blindly into the unknown?

But I still suggest to delete CONFIG_BUG in common kernel.

Since currently, disable 'CONFIG_BUG' is not a common features (most of
architectures are always enable it), it is only belongs to some
architectures specific features (may some embedded systems).

It is not suitable to still let 'CONFIG_BUG' exist in
"asm-generic/bug.h" which is only for common features.

And each architecture can customize their own BUG(), if one architecture
wants to Disabling this option, let it specify its own BUG().

So, most of architectures need not consider this issue again.


Thanks.
-- 
Chen Gang

Asianux Corporation

