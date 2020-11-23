Return-Path: <linux-sh-owner@vger.kernel.org>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 14/19] softirq: Make softirq control and processing RT aware
In-Reply-To: <20201123134437.GA95787@lothringen>
References: <20201113140207.499353218@linutronix.de> <20201113141734.324061522@linutronix.de> <20201123134437.GA95787@lothringen>
Date: Mon, 23 Nov 2020 20:27:33 +0100
Message-ID: <87r1ojnaai.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Paul McKenney <paulmck@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Marc Zyngier <maz@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Nov 23 2020 at 14:44, Frederic Weisbecker wrote:
> On Fri, Nov 13, 2020 at 03:02:21PM +0100, Thomas Gleixner wrote:
>> +	/*
>> +	 * Adjust softirq count to SOFTIRQ_OFFSET which makes
>> +	 * in_serving_softirq() become true.
>> +	 */
>> +	cnt = SOFTIRQ_OFFSET;
>> +	__local_bh_enable(cnt, false);
>
> But then you enter __do_softirq() with softirq_count() == SOFTIRQ_OFFSET.
> __do_softirq() calls softirq_handle_begin() which then sets it back to
> SOFTIRQ_DISABLE_OFFSET...

The RT variant of it added in this very same patch
> +static inline void softirq_handle_begin(void) { }
> +static inline void softirq_handle_end(void) { }

Thanks,

        tglx

