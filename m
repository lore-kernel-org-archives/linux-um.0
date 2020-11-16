Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
References: <20201113140207.499353218@linutronix.de>
 <20201113141733.276505871@linutronix.de>
From: Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [patch 05/19] ARM: irqstat: Get rid of duplicated declaration
In-reply-to: <20201113141733.276505871@linutronix.de>
Date: Mon, 16 Nov 2020 18:19:04 +0000
Message-ID: <jhjy2j1w4fb.mognet@arm.com>
MIME-Version: 1.0
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
Cc: Rich Felker <dalias@libc.org>, Catalin Marinas <catalin.marinas@arm.com>, Paul McKenney <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, linux-sh@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Richard Weinberger <richard@nod.at>, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-um@lists.infradead.org, Will Deacon <will@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>


On 13/11/20 14:02, Thomas Gleixner wrote:
> irq_cpustat_t is exactly the same as the asm-generic one. Define
> ack_bad_irq so the generic header does not emit the generic version of it.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

