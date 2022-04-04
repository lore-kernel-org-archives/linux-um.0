Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbGjA-00DVpf-K7
 for linux-um@lists.infradead.org; Mon, 04 Apr 2022 07:02:18 +0000
Message-ID: <ff314e8556aba7e231ab80c46b30701142e82a43.camel@sipsolutions.net>
Subject: Re: UML time-travel warning from __run_timers
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 04 Apr 2022 09:02:09 +0200
In-Reply-To: <87pmlykksj.ffs@tglx>
References: <20220330110156.GA9250@axis.com>
 <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
 <877d86m978.ffs@tglx>
 <32423b7c0e3a490093ceaca750e8669ac67902c6.camel@sipsolutions.net>
 <87pmlykksj.ffs@tglx>
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
To: Thomas Gleixner <tglx@linutronix.de>, Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>

On Sun, 2022-04-03 at 21:51 +0200, Thomas Gleixner wrote:
> 
> > There was no timer. If there's ever a timer on this base (BASE_DEF) then
> > this doesn't happen.
> 
> You said:
> 
> > > > init_timer_cpu(0) base 0 clk=0xffff8ad0, next_expiry=0x13fff8acf
> > > > init_timer_cpu(0) base 1 clk=0xffff8ad0, next_expiry=0x13fff8acf
> 
> which confused me. It's actually initialized to:
> 
>       base->clk + NEXT_TIMER_MAX_DELTA
> 
> but that's fine and it is overwritten by every timer which is inserted
> to expire before that. So that's not an issue as the prandom timer is
> firing and rearmed.

No, as I said before, there's never any timer with base 1 (BASE_DEF) in
the config we have. The prandom timer is not TIMER_DEFERRABLE (it
probably could be, but it's not now). There's no deferrable timer at
all. Once there is at least one, the warning goes away.

> That would not happen if next_expiry would stay at 0x13fff8acf. The
> first one in your trace expires at 5339070200, i.e.  0x13e3bbef8, which
> is way before that.

But it's not a deferrable timer, so it's on another timer wheel (base),
so it doesn't affect the "base 1" part above.

> Can you please apply the debug patch below and run with the same
> parameters as before?
> 
> Thanks,
> 
>         tglx
> ---
> Hint: I tried to figure out how to use that time travel muck, but did
>       not get to the point where I bothered to try myself. Might be
>       either my incompetence or lack of documentation. Clearly the bug
>       report lacks any hint how to reproduce that problem.

Well, the original bug report did have all the information, I gave the
link to it before:

https://lore.kernel.org/r/20220330110156.GA9250@axis.com

With that kernel config and command line, you can reproduce it easily.
All you need to know is to use "make ARCH=um" with that .config file :)


> +	trace_printk("RUN: now=%lu clk=%lu next_expiry=%lu
> recalc=%d\n",
> +		     jiffies, base->clk, base->next_expiry,
> +		     base->next_expiry_recalc);

IMHO all of this extra debug is a waste of time since you're not
differentiating the two bases anywhere. You'll just get confused (as
above) since timers do happen on BASE_STD, just not on BASE_DEF.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

