Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Mon, 15 Oct 2018 02:42:09 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Message-ID: <20181015094209.GA31999@infradead.org>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181013013200.206928-3-joel@joelfernandes.org>
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
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, elfring@users.sourceforge.net, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org, kernel-team@android.com, Sam Creasey <sammy@sammy.net>, linux-xtensa@linux-xtensa.org, Jeff Dike <jdike@addtoit.com>, linux-alpha@vger.kernel.org, linux-um@lists.infradead.org, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Ley Foon Tan <lftan@altera.com>, kirill@shutemov.name, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org, pantin@google.com, linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, minchan@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Richard Weinberger <richard@nod.at>, anton.ivanov@kot-begemot.co.uk, nios2-dev@lists.rocketboards.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Fri, Oct 12, 2018 at 06:31:58PM -0700, Joel Fernandes (Google) wrote:
> Android needs to mremap large regions of memory during memory management
> related operations.

Just curious: why?

> +	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
> +	    || old_end - old_addr < PMD_SIZE)

The || goes on the first line.

> +		} else if (extent == PMD_SIZE && IS_ENABLED(CONFIG_HAVE_MOVE_PMD)) {

Overly long line.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

