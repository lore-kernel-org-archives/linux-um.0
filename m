Return-Path: <gang.chen@asianux.com>
Message-ID: <51A48628.9030105@asianux.com>
Date: Tue, 28 May 2013 18:25:44 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
References: <519DCBEF.3090208@asianux.com> <20130523090534.GJ18614@n2100.arm.linux.org.uk> <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com> <201305231139.38233.arnd@arndb.de> <20130523100409.GK18614@n2100.arm.linux.org.uk> <20130528081910.GA29557@gmail.com>
In-Reply-To: <20130528081910.GA29557@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
To: Ingo Molnar <mingo@kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, H?vard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Serge Hallyn <serge.hallyn@canonical.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Akinobu Mita <akinobu.mita@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Michel Lespinasse <walken@google.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, linux-hexagon@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, Linux-Arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 05/28/2013 04:19 PM, Ingo Molnar wrote:
>> > And I come back to one of my previous arguments - is it not better to 
>> > panic() if we hit one of these conditions so that the system can try to 
>> > do a panic-reboot rather than continue blindly into the unknown?
> It will often continue blindly into the unknown even if the compiler is 
> happy ...
> 

For Server, it is necessary to always enable CONFIG_BUG and call panic()

When analyzing core dump or KDB trap, we have to assume that the kernel
has already "continued blindly", but lucky, we can get the core dump or
KDB trap finally (sometimes, we really even can not get core dump or KDB
trap).


For PC, it is useless to disable CONFIG_BUG

The PC memory has already large enough to skip the minimal size
optimization. And its speed is also high enough to skip the speed
improvement by minimal size optimization.


For Embedded system, some of architectures may disable CONFIG_BUG.

Embedded system are widely used in many area, so the requirement of each
architectures for BUG() may be different,

  some may need reboot as quickly as possible for urgent processing;
  some may need dead looping in BUG() for avoid user amazing;
    (if auto-reboot, users feel out of control, don't know what happens)
  some may still need panic() just like Server requirements.
  others may not care about it, just implement it as minimal size.



> The only difference is that i

t's "unpredictable" in a way not visible from
> the C code: the code won't necessarily fall through the BUG() when hitting 
> that condition - although in practice it probably will.
> 
> So I think the same principle applies to it as to any other debugging 
> code: it's fine to be able to turn debugging off. It's a performance 
> versus kernel robustness/determinism trade-off.

'minimal size' for BUG() is belongs to some of Embedded system specific
features, it is not 'generic' enough to be in "include/asm-generic/".

If we still provide the "disable CONFIG_BUG", some of 'crazy users'
(e.g. randconfig) may make 'noise' to most of architectures.

So we need not provide "disable CONFIG_BUG" features for all platforms,
since most of architectures need not support it, and the architecture
which really need minimal size, can implement it by itself as a
architecture specific feature.



Thanks.
-- 
Chen Gang

Asianux Corporation

