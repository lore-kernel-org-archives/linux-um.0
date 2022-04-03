Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nb3sm-00Bzvy-4S
 for linux-um@lists.infradead.org; Sun, 03 Apr 2022 17:19:21 +0000
Message-ID: <43785c9c6ee74a995963144946c67893ebbf8852.camel@sipsolutions.net>
Subject: Re: UML time-travel warning from __run_timers
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sun, 03 Apr 2022 19:19:17 +0200
In-Reply-To: <32423b7c0e3a490093ceaca750e8669ac67902c6.camel@sipsolutions.net>
References: <20220330110156.GA9250@axis.com>
 <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
 <877d86m978.ffs@tglx>
 <32423b7c0e3a490093ceaca750e8669ac67902c6.camel@sipsolutions.net>
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

On Sun, 2022-04-03 at 19:13 +0200, Johannes Berg wrote:
> On Sun, 2022-04-03 at 18:18 +0200, Thomas Gleixner wrote:
> > On Sat, Apr 02 2022 at 16:09, Johannes Berg wrote:
> > > At init, we get
> > > 
> > > init_timer_cpu(0) base 0 clk=0xffff8ad0, next_expiry=0x13fff8acf
> > > init_timer_cpu(0) base 1 clk=0xffff8ad0, next_expiry=0x13fff8acf
> > > 
> > > which makes sense, jiffies is set up to wrap very quickly after boot.
> > > 
> > > The warning triggers when we have jiffies=0x13fff9600, so it's just
> > > after the "next_expiry", so in this code:
> > 
> > which does not make sense.
> 
> If you say so, I have no idea :)
> 
> > If next_expiry is 0x13fff8acf and jiffies
> > advanced to 0x13fff9600 when the warning triggered, then either it
> > missed to expire the timer at 0x13fff8acf or it failed to recalculate
> > next_expiry.
> 
> There was no timer. If there's ever a timer on this base (BASE_DEF) then
> this doesn't happen.
> 
> So it has to be the latter, but I'm trying to understand in the code
> where it would*ever* recalculate next_expiry if it in fact never
> expires?
> 

Actually, in a sense, this *is* the case of (just) recalculating
next_expiry, no? We just never set next_expiry_recalc since there was
never any timer on this?

So actually this also makes the warning go away:

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1729,6 +1733,7 @@ static inline void __run_timers(struct timer_base *base)
 		WARN_ON_ONCE(!levels && !base->next_expiry_recalc);
 		base->clk++;
 		base->next_expiry = __next_timer_interrupt(base);
+		base->next_expiry_recalc = !levels;
 
 		while (levels--)
 			expire_timers(base, heads + levels);
@@ -2005,6 +2010,7 @@ static void __init init_timer_cpu(int cpu)
 		raw_spin_lock_init(&base->lock);
 		base->clk = jiffies;
 		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
+		base->next_expiry_recalc = true;
 		timer_base_init_expiry_lock(base);
 	}
 }


johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

