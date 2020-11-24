Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 14/19] softirq: Make softirq control and processing RT
 aware
In-Reply-To: <20201124001350.GF1751@lothringen>
References: <20201113140207.499353218@linutronix.de>
 <20201113141734.324061522@linutronix.de> <20201123134437.GA95787@lothringen>
 <87r1ojnaai.fsf@nanos.tec.linutronix.de> <20201123235801.GE1751@lothringen>
 <87wnyblitk.fsf@nanos.tec.linutronix.de> <20201124001350.GF1751@lothringen>
Date: Tue, 24 Nov 2020 01:22:16 +0100
Message-ID: <87r1ojli2v.fsf@nanos.tec.linutronix.de>
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

Frederic,

On Tue, Nov 24 2020 at 01:13, Frederic Weisbecker wrote:
> On Tue, Nov 24, 2020 at 01:06:15AM +0100, Thomas Gleixner wrote:
>> Good point. Haven't thought about that. Let me have a look again.
>
> But I'm cooking a patchset which moves account_irq_enter_time() after
> HARDIRQ_OFFSET or SOFTIRQ_OFFSET is incremented. This will allow us to move
> tick_irq_enter() under this layout:
>
> 		 preempt_count_add(HARDIRQ_OFFSET)
> 		 lockdep_hardirq_enter()
> 		 tick_irq_enter()
> 		 account_irq_enter_time()
>
> This way tick_irq_enter() can be correctly handled by lockdep and we can remove
> the nasty hack which temporarily disables softirqs around it.
>
> And as a side effect it should also fix your issue.
>
> I should have that ready soonish.

Sounds to good to be true :)

Looking forward to it!

Thanks for taking care of that!

       tglx

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

