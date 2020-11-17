Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 17 Nov 2020 11:21:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 10/19] preempt: Cleanup the macro maze a bit
Message-ID: <20201117102119.GE3121406@hirez.programming.kicks-ass.net>
References: <20201113140207.499353218@linutronix.de>
 <20201113141733.864469886@linutronix.de>
 <20201116121748.GD3121378@hirez.programming.kicks-ass.net>
 <871rgtyz9g.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871rgtyz9g.fsf@nanos.tec.linutronix.de>
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
Cc: Marc Zyngier <maz@kernel.org>, Rich Felker <dalias@libc.org>, Catalin Marinas <catalin.marinas@arm.com>, Paul McKenney <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Richard Weinberger <richard@nod.at>, Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, linux-um@lists.infradead.org, Will Deacon <will@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Mon, Nov 16, 2020 at 06:42:19PM +0100, Thomas Gleixner wrote:
> On Mon, Nov 16 2020 at 13:17, Peter Zijlstra wrote:
> > On Fri, Nov 13, 2020 at 03:02:17PM +0100, Thomas Gleixner wrote:
> >
> >> -#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK \
> >> -				 | NMI_MASK))
> >> +#define irq_count()	(nmi_count() | hardirq_count() | softirq_count())
> >
> >
> >> +#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
> >> -#define in_task()		(!(preempt_count() & \
> >> -				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
> >
> > How horrible is the code-gen? Because preempt_count() is
> > raw_cpu_read_4() and at least some old compilers will refuse to CSE it
> > (consider the this_cpu_read_stable mess).
> 
> I looked at gcc8 and 10 output and the compilers are smart enough to
> fold it for the !RT case. But yeah ...

If recent GCC is smart enough I suppose it doesn't matter, thanks!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

