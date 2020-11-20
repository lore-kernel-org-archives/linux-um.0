Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 14/19] softirq: Make softirq control and processing RT
 aware
In-Reply-To: <20201120002621.GA32792@lothringen>
References: <20201113140207.499353218@linutronix.de>
 <20201113141734.324061522@linutronix.de> <20201120002621.GA32792@lothringen>
Date: Fri, 20 Nov 2020 14:27:18 +0100
Message-ID: <87o8jsnop5.fsf@nanos.tec.linutronix.de>
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
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Rich Felker <dalias@libc.org>, Catalin Marinas <catalin.marinas@arm.com>, Paul McKenney <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Valentin Schneider <valentin.schneider@arm.com>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-parisc@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-um@lists.infradead.org, Will Deacon <will@kernel.org>, Helge Deller <deller@gmx.de>, linux-arm-kernel@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Fri, Nov 20 2020 at 01:26, Frederic Weisbecker wrote:
> On Fri, Nov 13, 2020 at 03:02:21PM +0100, Thomas Gleixner wrote:
>> +void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
>> +{
>> +	unsigned long flags;
>> +	int newcnt;
>> +
>> +	WARN_ON_ONCE(in_hardirq());
>> +
>> +	/* First entry of a task into a BH disabled section? */
>> +	if (!current->softirq_disable_cnt) {
>> +		if (preemptible()) {
>> +			local_lock(&softirq_ctrl.lock);
>> +			rcu_read_lock();
>
> Ah you lock RCU because local_bh_disable() implies it and
> since it doesn't disable preemption anymore, you must do it
> explicitly?
>
> Perhaps local_lock() should itself imply rcu_read_lock() ?

It's really only required for local_bh_disable(). Lemme add a comment.

>> +		} else {
>> +			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
>> +		}
>> +	}
>> +
>> +	preempt_disable();
>
> Do you really need to disable preemption here? Migration is disabled by local_lock()
> and I can't figure out a scenario where the below can conflict with a
> preempting task.

Indeed it's pointless.

>> +	/*
>> +	 * Track the per CPU softirq disabled state. On RT this is per CPU
>> +	 * state to allow preemption of bottom half disabled sections.
>> +	 */
>> +	newcnt = this_cpu_add_return(softirq_ctrl.cnt, cnt);
>
> __this_cpu_add_return() ?

Yep.

Thanks,

        tglx

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

