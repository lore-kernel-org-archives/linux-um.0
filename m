Return-Path: <gang.chen@asianux.com>
Message-ID: <519DFB42.7010509@asianux.com>
Date: Thu, 23 May 2013 19:19:30 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
References: <519DCBEF.3090208@asianux.com> <201305231139.38233.arnd@arndb.de> <20130523100409.GK18614@n2100.arm.linux.org.uk> <201305231259.43750.arnd@arndb.de>
In-Reply-To: <201305231259.43750.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?B?SMOldmFyZCBTa2lubmVtb2Vu?= <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Serge Hallyn <serge.hallyn@canonical.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Akinobu Mita <akinobu.mita@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Michel Lespinasse <walken@google.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, linux-hexagon@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 05/23/2013 06:59 PM, Arnd Bergmann wrote:
> You don't just want to avoid the code for printing the bug message and
> the invalid instruction, we also want the compiler to not emit the 
> function call or check the enum for unexpected values. The meaning of
> BUG() is really that person writing that statement was sure it cannot
> happen unless there is a bug in the kernel, which has likely already
> corrupted data. Printing a diagnostic at this point is nice if someone
> is there to look at it, but letting the kernel do further actions that
> may be undefined is not going to make things worse.

So I think neither unreachable() nor panic() are suitable for this
condition.

I guess 'CONFIG_BUG' is not belong to common features, now (and in the
future), so it is not suitable still exist in "asm-generic/bug.h", need
remove it firstly.

And then let the specific architectures to implement their own BUG(), if
they want some special features.

SO most of arches can skip this issue.


Thanks.
-- 
Chen Gang

Asianux Corporation

