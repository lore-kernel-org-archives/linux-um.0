Return-Path: <linux-sh-owner@vger.kernel.org>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 10/19] preempt: Cleanup the macro maze a bit
In-Reply-To: <20201116121748.GD3121378@hirez.programming.kicks-ass.net>
References: <20201113140207.499353218@linutronix.de> <20201113141733.864469886@linutronix.de> <20201116121748.GD3121378@hirez.programming.kicks-ass.net>
Date: Mon, 16 Nov 2020 18:42:19 +0100
Message-ID: <871rgtyz9g.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Paul McKenney <paulmck@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Marc Zyngier <maz@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Nov 16 2020 at 13:17, Peter Zijlstra wrote:
> On Fri, Nov 13, 2020 at 03:02:17PM +0100, Thomas Gleixner wrote:
>
>> -#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK \
>> -				 | NMI_MASK))
>> +#define irq_count()	(nmi_count() | hardirq_count() | softirq_count())
>
>
>> +#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
>> -#define in_task()		(!(preempt_count() & \
>> -				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
>
> How horrible is the code-gen? Because preempt_count() is
> raw_cpu_read_4() and at least some old compilers will refuse to CSE it
> (consider the this_cpu_read_stable mess).

I looked at gcc8 and 10 output and the compilers are smart enough to
fold it for the !RT case. But yeah ...

Thanks,

        tglx



