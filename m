Return-Path: <ebiederm@xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <519DCBEF.3090208@asianux.com>
Date: Thu, 23 May 2013 22:59:55 -0700
In-Reply-To: <519DCBEF.3090208@asianux.com> (Chen Gang's message of "Thu, 23
	May 2013 15:57:35 +0800")
Message-ID: <877gio3okk.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always need it.
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, hskinnemoen@gmail.com, egtvedt@samfundet.no, Mike Frysinger <vapier@gentoo.org>, ysato@users.sourceforge.jp, rkuo@codeaurora.org, jejb@parisc-linux.org, deller@gmx.de, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, lethal@linux-sh.org, jdike@addtoit.com, richard@nod.at, Thomas Gleixner <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, hpa@zytor.com, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Serge Hallyn <serge.hallyn@canonical.com>, paulmck@linux.vnet.ibm.com, Frederic Weisbecker <fweisbec@gmail.com>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, akinobu.mita@gmail.com, Catalin Marinas <Catalin.Marinas@arm.com>, walken@google.com, Will Deacon <will.deacon@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-arch@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Chen Gang <gang.chen@asianux.com> writes:

> The crazy user can unset 'CONFIG_BUG' in menuconfig: "> General setup >
> Configure standard kernel features (expert users) > BUG() Support".
>
> But in fact, we always need it, and quite a few of architectures have
> already implemented it (e.g. alpha, arc, arm, avr32, blackfin, cris,
> frv, ia64, m68k, mips, mn10300, parisc, powerpc, s390, sh, sparc, x86).
>
> And kernel also already has prepared a default effective implementation
> for the architectures which is unwilling to implement it by themselves
> (e.g. arm64, c6x, h8300, hexagon, m32r, metag, microblaze, openrisc,
> score, tile, um, unicore32, xtensa).
>
> So need get rid of 'CONFIG_BUG', and let it always enabled everywhere.


This looks like the right way to handle this to me.  If the BUG
annotations are too big and not needed they should simply be deleted
from the code base.  Disabling CONFIG_BUG which removes the BUG
annotations from the binaries without modifying the source code seems
like the wrong approach.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

