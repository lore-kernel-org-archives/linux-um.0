Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 19 Nov 2020 13:18:01 +0100
From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch 12/19] softirq: Add RT specific softirq accounting
Message-ID: <20201119121801.GA20115@lothringen>
References: <20201113140207.499353218@linutronix.de>
 <20201113141734.096224353@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201113141734.096224353@linutronix.de>
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

On Fri, Nov 13, 2020 at 03:02:19PM +0100, Thomas Gleixner wrote:
> RT requires the softirq to be preemptible and uses a per CPU local lock to
> protect BH disabled sections and softirq processing. Therefore RT cannot
> use the preempt counter to keep track of BH disabled/serving.
> 
> Add a RT only counter to task struct and adjust the relevant macros in
> preempt.h.

You may want to describe a bit the reason for this per task counter.
It's not intuitive at this stage.

Thanks.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

