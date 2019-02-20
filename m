Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Wed, 20 Feb 2019 14:47:56 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v4 2/3] locking/rwsem: Remove rwsem-spinlock.c & use
 rwsem-xadd.c for all archs
Message-ID: <20190220144756.GK7523@fuggles.cambridge.arm.com>
References: <1550095217-12047-1-git-send-email-longman@redhat.com>
 <1550095217-12047-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550095217-12047-3-git-send-email-longman@redhat.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Waiman Long <longman@redhat.com>
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-mips@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Tim Chen <tim.c.chen@linux.intel.com>, linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org

On Wed, Feb 13, 2019 at 05:00:16PM -0500, Waiman Long wrote:
> Currently, we have two different implementation of rwsem:
>  1) CONFIG_RWSEM_GENERIC_SPINLOCK (rwsem-spinlock.c)
>  2) CONFIG_RWSEM_XCHGADD_ALGORITHM (rwsem-xadd.c)
> 
> As we are going to use a single generic implementation for rwsem-xadd.c
> and no architecture-specific code will be needed, there is no point
> in keeping two different implementations of rwsem. In most cases, the
> performance of rwsem-spinlock.c will be worse. It also doesn't get all
> the performance tuning and optimizations that had been implemented in
> rwsem-xadd.c over the years.
> 
> For simplication, we are going to remove rwsem-spinlock.c and make all
> architectures use a single implementation of rwsem - rwsem-xadd.c.
> 
> All references to RWSEM_GENERIC_SPINLOCK and RWSEM_XCHGADD_ALGORITHM
> in the code are removed.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/alpha/Kconfig              |   7 -
>  arch/arc/Kconfig                |   3 -
>  arch/arm/Kconfig                |   4 -
>  arch/arm64/Kconfig              |   3 -
>  arch/c6x/Kconfig                |   3 -
>  arch/csky/Kconfig               |   3 -
>  arch/h8300/Kconfig              |   3 -
>  arch/hexagon/Kconfig            |   6 -
>  arch/ia64/Kconfig               |   4 -
>  arch/m68k/Kconfig               |   7 -
>  arch/microblaze/Kconfig         |   6 -
>  arch/mips/Kconfig               |   7 -
>  arch/nds32/Kconfig              |   3 -
>  arch/nios2/Kconfig              |   3 -
>  arch/openrisc/Kconfig           |   6 -
>  arch/parisc/Kconfig             |   6 -
>  arch/powerpc/Kconfig            |   7 -
>  arch/riscv/Kconfig              |   3 -
>  arch/s390/Kconfig               |   6 -
>  arch/sh/Kconfig                 |   6 -
>  arch/sparc/Kconfig              |   8 -
>  arch/unicore32/Kconfig          |   6 -
>  arch/x86/Kconfig                |   3 -
>  arch/x86/um/Kconfig             |   6 -
>  arch/xtensa/Kconfig             |   3 -
>  include/linux/rwsem-spinlock.h  |  47 ------
>  include/linux/rwsem.h           |   5 -
>  kernel/Kconfig.locks            |   2 +-
>  kernel/locking/Makefile         |   4 +-
>  kernel/locking/rwsem-spinlock.c | 339 ----------------------------------------
>  kernel/locking/rwsem.h          |   3 -
>  31 files changed, 2 insertions(+), 520 deletions(-)
>  delete mode 100644 include/linux/rwsem-spinlock.h
>  delete mode 100644 kernel/locking/rwsem-spinlock.c

Another nice cleanup, and it looks like the optimistic spinning in the xadd
implementation is predicated on ARCH_SUPPORTS_ATOMIC_RMW, so we're all good
there too.

Acked-by: Will Deacon <will.deacon@arm.com>

Will

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

