Return-Path: <linux+geert=linux-m68k.org@armlinux.org.uk>
Date: Tue, 26 Oct 2021 11:38:54 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH 2/2] futex: remove futex_cmpxchg detection
Message-ID: <YXfavr6LY1xGPGCA@shell.armlinux.org.uk>
References: <20211026100432.1730393-1-arnd@kernel.org>
 <20211026100432.1730393-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026100432.1730393-2-arnd@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

On Tue, Oct 26, 2021 at 12:03:48PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Now that all architectures have a working futex implementation
> in any configuration, remove the runtime detection code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

For ARM:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

As Arnd explained to me what was going on, I'll include it here...
This patch requires patch 1 which touches other architectures, so
it is not an independent patch.

Patch 1 can be found at:
 https://lore.kernel.org/lkml/20211026100432.1730393-1-arnd@kernel.org/T/#t

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

