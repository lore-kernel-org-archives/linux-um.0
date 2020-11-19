Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 12/19] softirq: Add RT specific softirq accounting
In-Reply-To: <20201119121801.GA20115@lothringen>
References: <20201113140207.499353218@linutronix.de>
 <20201113141734.096224353@linutronix.de> <20201119121801.GA20115@lothringen>
Date: Thu, 19 Nov 2020 19:34:13 +0100
Message-ID: <87ima1p55m.fsf@nanos.tec.linutronix.de>
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

On Thu, Nov 19 2020 at 13:18, Frederic Weisbecker wrote:
> On Fri, Nov 13, 2020 at 03:02:19PM +0100, Thomas Gleixner wrote:
>> RT requires the softirq to be preemptible and uses a per CPU local lock to
>> protect BH disabled sections and softirq processing. Therefore RT cannot
>> use the preempt counter to keep track of BH disabled/serving.
>> 
>> Add a RT only counter to task struct and adjust the relevant macros in
>> preempt.h.
>
> You may want to describe a bit the reason for this per task counter.
> It's not intuitive at this stage.

Something like this:

 RT requires the softirq processing and local bottomhalf disabled regions
 to be preemptible. Using the normal preempt count based serialization is
 therefore not possible because this implicitely disables preemption.

 RT kernels use a per CPU local lock to serialize bottomhalfs. As
 local_bh_disable() can nest the lock can only be acquired on the
 outermost invocation of local_bh_disable() and released when the nest
 count becomes zero. Tasks which hold the local lock can be preempted so
 its required to keep track of the nest count per task.

 Add a RT only counter to task struct and adjust the relevant macros in
 preempt.h.

Thanks,

        tglx

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

