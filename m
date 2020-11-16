Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Mon, 16 Nov 2020 10:01:10 +0000
From: Will Deacon <will@kernel.org>
Subject: Re: [patch 06/19] arm64: irqstat: Get rid of duplicated declaration
Message-ID: <20201116100110.GA29459@willie-the-truck>
References: <20201113140207.499353218@linutronix.de>
 <20201113141733.392015387@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201113141733.392015387@linutronix.de>
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
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Rich Felker <dalias@libc.org>, Paul McKenney <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Richard Weinberger <richard@nod.at>, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, Marc Zyngier <maz@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-um@lists.infradead.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Fri, Nov 13, 2020 at 03:02:13PM +0100, Thomas Gleixner wrote:
> irq_cpustat_t is exactly the same as the asm-generic one. Define
> ack_bad_irq so the generic header does not emit the generic version of it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/include/asm/hardirq.h |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

