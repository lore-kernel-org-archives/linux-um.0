Return-Path: <linux-sh-owner@vger.kernel.org>
Date: Thu, 19 Nov 2020 13:20:06 +0100
From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch 11/19] softirq: Move related code into one section
Message-ID: <20201119122006.GB20115@lothringen>
References: <20201113140207.499353218@linutronix.de>
 <20201113141733.974214480@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113141733.974214480@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Paul McKenney <paulmck@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Marc Zyngier <maz@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Fri, Nov 13, 2020 at 03:02:18PM +0100, Thomas Gleixner wrote:
> To prepare for adding a RT aware variant of softirq serialization and
> processing move related code into one section so the necessary #ifdeffery
> is reduced to one.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Up to this patch at least:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

