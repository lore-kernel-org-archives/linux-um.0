Return-Path: <linux-mips-bounce@linux-mips.org>
From: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <1295296310.2148.29.camel@pasglop>
References: <1295262433.30950.53.camel@laptop>
         <1295296310.2148.29.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date: Mon, 17 Jan 2011 21:43:03 +0100
Message-ID: <1295296983.30950.369.camel@laptop>
Mime-Version: 1.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
 smp_send_reschedule()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mike Frysinger <vapier@gentoo.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@tilera.com>, Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, 2011-01-18 at 07:31 +1100, Benjamin Herrenschmidt wrote:
> 
> Beware of false positive, I've used "fake" reschedule IPIs in the past
> for other things (like kicking a CPU out of sleep state for unrelated
> reasons). Nothing that I know that is upstream today but some of that
> might come back. I'd like to avoid having to add an atomic to know if
> it's a real reschedule, will the scheduler be smart enough to not bother
> with false positives ? 

Yes it can deal with that, some will be for reschedules, some will be
for ttwu tail ends and x86 too uses this ipi for a few random other
things like kicking kvm out of guest context..


