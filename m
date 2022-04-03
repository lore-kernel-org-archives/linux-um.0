Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nb9Yp-00CWXO-OQ
 for linux-um@lists.infradead.org; Sun, 03 Apr 2022 23:23:09 +0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: UML time-travel warning from __run_timers
In-Reply-To: <43785c9c6ee74a995963144946c67893ebbf8852.camel@sipsolutions.net>
References: <20220330110156.GA9250@axis.com>
 <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
 <877d86m978.ffs@tglx>
 <32423b7c0e3a490093ceaca750e8669ac67902c6.camel@sipsolutions.net>
 <43785c9c6ee74a995963144946c67893ebbf8852.camel@sipsolutions.net>
Date: Mon, 04 Apr 2022 01:23:01 +0200
Message-ID: <87h779lpka.ffs@tglx>
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
To: Johannes Berg <johannes@sipsolutions.net>, Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>

Johannes,

On Sun, Apr 03 2022 at 19:19, Johannes Berg wrote:
> Actually, in a sense, this *is* the case of (just) recalculating
> next_expiry, no? We just never set next_expiry_recalc since there was
> never any timer on this?

why are you insisting on fishing in the dark? 

> So actually this also makes the warning go away:
>
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1729,6 +1733,7 @@ static inline void __run_timers(struct timer_base *base)
>  		WARN_ON_ONCE(!levels && !base->next_expiry_recalc);
>  		base->clk++;
>  		base->next_expiry = __next_timer_interrupt(base);
> +		base->next_expiry_recalc = !levels;

You are papering over the problem. That makes the warnign go away, but
does not explain anyhting about the root cause. Can you please provide
the information which was asked for?

>  		while (levels--)
>  			expire_timers(base, heads + levels);
> @@ -2005,6 +2010,7 @@ static void __init init_timer_cpu(int cpu)
>  		raw_spin_lock_init(&base->lock);
>  		base->clk = jiffies;
>  		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
> +		base->next_expiry_recalc = true;

This is complete nonsense because at the point where the CPU base is
initialized next_expiry _IS_ correct at the outer max. Why would it be
required to be recalculated? The only reason why it needs to be
recalculated is when a timer is canceled before expiry, but there is
_NO_ timer which can be canceled at this point.

So what are you trying to solve here?

Thanks,

        tglx

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

