Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 24 Nov 2020 00:58:01 +0100
From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch 14/19] softirq: Make softirq control and processing RT
 aware
Message-ID: <20201123235801.GE1751@lothringen>
References: <20201113140207.499353218@linutronix.de>
 <20201113141734.324061522@linutronix.de>
 <20201123134437.GA95787@lothringen>
 <87r1ojnaai.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r1ojnaai.fsf@nanos.tec.linutronix.de>
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

On Mon, Nov 23, 2020 at 08:27:33PM +0100, Thomas Gleixner wrote:
> On Mon, Nov 23 2020 at 14:44, Frederic Weisbecker wrote:
> > On Fri, Nov 13, 2020 at 03:02:21PM +0100, Thomas Gleixner wrote:
> >> +	/*
> >> +	 * Adjust softirq count to SOFTIRQ_OFFSET which makes
> >> +	 * in_serving_softirq() become true.
> >> +	 */
> >> +	cnt = SOFTIRQ_OFFSET;
> >> +	__local_bh_enable(cnt, false);
> >
> > But then you enter __do_softirq() with softirq_count() == SOFTIRQ_OFFSET.
> > __do_softirq() calls softirq_handle_begin() which then sets it back to
> > SOFTIRQ_DISABLE_OFFSET...
> 
> The RT variant of it added in this very same patch
> > +static inline void softirq_handle_begin(void) { }
> > +static inline void softirq_handle_end(void) { }

Ah but then account_irq_enter_time() is called with SOFTIRQ_OFFSET (it's
currently called with softirq_count == 0 at this point) and that may mess
up irqtime accounting which relies on it. It could spuriously account all
the time between the last (soft-)IRQ exit until now as softirq time.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

