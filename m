Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Mon, 23 Nov 2020 14:44:37 +0100
From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch 14/19] softirq: Make softirq control and processing RT
 aware
Message-ID: <20201123134437.GA95787@lothringen>
References: <20201113140207.499353218@linutronix.de>
 <20201113141734.324061522@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201113141734.324061522@linutronix.de>
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
Cc: Rich Felker <dalias@libc.org>, Catalin Marinas <catalin.marinas@arm.com>, Paul McKenney <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Valentin Schneider <valentin.schneider@arm.com>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-parisc@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-um@lists.infradead.org, Will Deacon <will@kernel.org>, Helge Deller <deller@gmx.de>, linux-arm-kernel@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Fri, Nov 13, 2020 at 03:02:21PM +0100, Thomas Gleixner wrote:
> +void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
> +{
> +	bool preempt_on = preemptible();
> +	unsigned long flags;
> +	u32 pending;
> +	int curcnt;
> +
> +	WARN_ON_ONCE(in_irq());
> +	lockdep_assert_irqs_enabled();
> +
> +	local_irq_save(flags);
> +	curcnt = this_cpu_read(softirq_ctrl.cnt);
> +
> +	/*
> +	 * If this is not reenabling soft interrupts, no point in trying to
> +	 * run pending ones.
> +	 */
> +	if (curcnt != cnt)
> +		goto out;
> +
> +	pending = local_softirq_pending();
> +	if (!pending || ksoftirqd_running(pending))
> +		goto out;
> +
> +	/*
> +	 * If this was called from non preemptible context, wake up the
> +	 * softirq daemon.
> +	 */
> +	if (!preempt_on) {
> +		wakeup_softirqd();
> +		goto out;
> +	}
> +
> +	/*
> +	 * Adjust softirq count to SOFTIRQ_OFFSET which makes
> +	 * in_serving_softirq() become true.
> +	 */
> +	cnt = SOFTIRQ_OFFSET;
> +	__local_bh_enable(cnt, false);

But then you enter __do_softirq() with softirq_count() == SOFTIRQ_OFFSET.
__do_softirq() calls softirq_handle_begin() which then sets it back to SOFTIRQ_DISABLE_OFFSET...

> +	__do_softirq();
> +
> +out:
> +	__local_bh_enable(cnt, preempt_on);

You escape from there with a correct preempt_count() but still the softirq executes
under SOFTIRQ_DISABLE_OFFSET and not SOFTIRQ_OFFSET, making in_serving_softirq() false.

> +	local_irq_restore(flags);
> +}
> +EXPORT_SYMBOL(__local_bh_enable_ip);

Thanks.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

