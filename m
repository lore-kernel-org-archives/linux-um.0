Return-Path: <linux-sh-owner@vger.kernel.org>
Date: Thu, 19 Nov 2020 23:52:27 +0100
From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch 12/19] softirq: Add RT specific softirq accounting
Message-ID: <20201119225227.GA29717@lothringen>
References: <20201113140207.499353218@linutronix.de>
 <20201113141734.096224353@linutronix.de>
 <20201119121801.GA20115@lothringen>
 <87ima1p55m.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ima1p55m.fsf@nanos.tec.linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Paul McKenney <paulmck@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Marc Zyngier <maz@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Thu, Nov 19, 2020 at 07:34:13PM +0100, Thomas Gleixner wrote:
> On Thu, Nov 19 2020 at 13:18, Frederic Weisbecker wrote:
> > On Fri, Nov 13, 2020 at 03:02:19PM +0100, Thomas Gleixner wrote:
> >> RT requires the softirq to be preemptible and uses a per CPU local lock to
> >> protect BH disabled sections and softirq processing. Therefore RT cannot
> >> use the preempt counter to keep track of BH disabled/serving.
> >> 
> >> Add a RT only counter to task struct and adjust the relevant macros in
> >> preempt.h.
> >
> > You may want to describe a bit the reason for this per task counter.
> > It's not intuitive at this stage.
> 
> Something like this:
> 
>  RT requires the softirq processing and local bottomhalf disabled regions
>  to be preemptible. Using the normal preempt count based serialization is
>  therefore not possible because this implicitely disables preemption.
> 
>  RT kernels use a per CPU local lock to serialize bottomhalfs. As
>  local_bh_disable() can nest the lock can only be acquired on the
>  outermost invocation of local_bh_disable() and released when the nest
>  count becomes zero. Tasks which hold the local lock can be preempted so
>  its required to keep track of the nest count per task.
> 
>  Add a RT only counter to task struct and adjust the relevant macros in
>  preempt.h.
> 
> Thanks,

Very good, thanks!

