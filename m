Return-Path: <linux-mips-bounce@linux-mips.org>
Date: Mon, 17 Jan 2011 11:57:48 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Message-ID: <20110117115748.GA20615@n2100.arm.linux.org.uk>
References: <1295262433.30950.53.camel@laptop> <20110117112637.GA18599@n2100.arm.linux.org.uk> <1295263884.30950.54.camel@laptop> <1295264509.30950.59.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1295264509.30950.59.camel@laptop>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
        smp_send_reschedule()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@tilera.com>, Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Jan 17, 2011 at 12:41:49PM +0100, Peter Zijlstra wrote:
> ===================================================================
> --- linux-2.6.orig/arch/arm/kernel/smp.c
> +++ linux-2.6/arch/arm/kernel/smp.c
> @@ -575,10 +575,7 @@ asmlinkage void __exception do_IPI(struc
>  				break;
>  
>  			case IPI_RESCHEDULE:
> -				/*
> -				 * nothing more to do - eveything is
> -				 * done on the interrupt return path
> -				 */
> +				scheduler_ipi();
>  				break;
>  
>  			case IPI_CALL_FUNC:

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>


