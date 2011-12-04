Return-Path: <linux-mips-bounce@linux-mips.org>
Date: Sun, 4 Dec 2011 21:33:16 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Message-ID: <20111204213316.GB14542@n2100.arm.linux.org.uk>
References: <1323013369-29691-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1323013369-29691-1-git-send-email-sven@narfation.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
Subject: Re: [PATCHv5] atomic: add *_dec_not_zero
To: Sven Eckelmann <sven@narfation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Randy Dunlap <rdunlap@xenotime.net>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@tilera.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-hexagon@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Dec 04, 2011 at 04:42:49PM +0100, Sven Eckelmann wrote:
> diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
> diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
> diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/arch/tile/include/asm/atomic_32.h b/arch/tile/include/asm/atomic_32.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
> diff --git a/arch/tile/include/asm/atomic_64.h b/arch/tile/include/asm/atomic_64.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
> diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
> diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
> +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)

I think this is rather silly - all these definitions are very similar to
each other.  Is there really no way to put this into include/linux/atomic.h,
maybe as something like:

#ifndef atomic64_dec_not_zero
#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
#endif

and avoid having to add essentially the same definition to 12 individual
files?

Architectures which want to override it can do by the following:

#define atomic64_dec_not_zero		atomic64_dec_not_zero

which won't have any effect on C nor asm code.


