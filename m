Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nb6G1-00CHan-FU
 for linux-um@lists.infradead.org; Sun, 03 Apr 2022 19:51:31 +0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: UML time-travel warning from __run_timers
In-Reply-To: <32423b7c0e3a490093ceaca750e8669ac67902c6.camel@sipsolutions.net>
References: <20220330110156.GA9250@axis.com>
 <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
 <877d86m978.ffs@tglx>
 <32423b7c0e3a490093ceaca750e8669ac67902c6.camel@sipsolutions.net>
Date: Sun, 03 Apr 2022 21:51:24 +0200
Message-ID: <87pmlykksj.ffs@tglx>
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

On Sun, Apr 03 2022 at 19:13, Johannes Berg wrote:
> On Sun, 2022-04-03 at 18:18 +0200, Thomas Gleixner wrote:
>> On Sat, Apr 02 2022 at 16:09, Johannes Berg wrote:
> There was no timer. If there's ever a timer on this base (BASE_DEF) then
> this doesn't happen.

You said:

>> > init_timer_cpu(0) base 0 clk=0xffff8ad0, next_expiry=0x13fff8acf
>> > init_timer_cpu(0) base 1 clk=0xffff8ad0, next_expiry=0x13fff8acf

which confused me. It's actually initialized to:

      base->clk + NEXT_TIMER_MAX_DELTA

but that's fine and it is overwritten by every timer which is inserted
to expire before that. So that's not an issue as the prandom timer is
firing and rearmed.

That would not happen if next_expiry would stay at 0x13fff8acf. The
first one in your trace expires at 5339070200, i.e.  0x13e3bbef8, which
is way before that.

So that 0x13fff8acf thing is really a red herring.

> Sure, but since we simulate ~50 days of uptime, that's a massive number
> of events and lots of them are not there:

Thanks for providing that. This does not give much of an hint. jiffies,
base clock and clock monotonic advance as expected. The prandom timer
seems to be the only timer which is armed here, but of course the trace
does not go far enough back to be sure. OTOH, there is no timer canceled
just before that which might trigger this. I suspect that's a base
forward call missing and I have a nagging feeling where, but I'm not
sure.

Can you please apply the debug patch below and run with the same
parameters as before?

Thanks,

        tglx
---
Hint: I tried to figure out how to use that time travel muck, but did
      not get to the point where I bothered to try myself. Might be
      either my incompetence or lack of documentation. Clearly the bug
      report lacks any hint how to reproduce that problem.
---

--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -52,15 +52,19 @@ DEFINE_EVENT(timer_class, timer_init,
 TRACE_EVENT(timer_start,
 
 	TP_PROTO(struct timer_list *timer,
-		unsigned long expires,
-		unsigned int flags),
+		 unsigned long expires,
+		 unsigned long bucket_expiry,
+		 unsigned long next_expiry,
+		 unsigned int flags),
 
-	TP_ARGS(timer, expires, flags),
+	TP_ARGS(timer, expires, bucket_expiry, next_expiry, flags),
 
 	TP_STRUCT__entry(
 		__field( void *,	timer		)
 		__field( void *,	function	)
 		__field( unsigned long,	expires		)
+		__field( unsigned long,	bucket_expiry	)
+		__field( unsigned long,	next_expiry	)
 		__field( unsigned long,	now		)
 		__field( unsigned int,	flags		)
 	),
@@ -69,13 +73,16 @@ TRACE_EVENT(timer_start,
 		__entry->timer		= timer;
 		__entry->function	= timer->function;
 		__entry->expires	= expires;
+		__entry->bucket_expiry	= bucket_expiry;
+		__entry->next_expiry	= next_expiry;
 		__entry->now		= jiffies;
 		__entry->flags		= flags;
 	),
 
-	TP_printk("timer=%p function=%ps expires=%lu [timeout=%ld] cpu=%u idx=%u flags=%s",
+	TP_printk("timer=%p function=%ps expires=%lu [timeout=%ld] bucket_expiry=%lu next_expiry=%lu cpu=%u idx=%u flags=%s",
 		  __entry->timer, __entry->function, __entry->expires,
 		  (long)__entry->expires - __entry->now,
+		  __entry->bucket_expiry, __entry->next_expiry,
 		  __entry->flags & TIMER_CPUMASK,
 		  __entry->flags >> TIMER_ARRAYSHIFT,
 		  decode_timer_flags(__entry->flags & TIMER_TRACE_FLAGMASK))
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -583,8 +583,6 @@ static void enqueue_timer(struct timer_b
 	__set_bit(idx, base->pending_map);
 	timer_set_idx(timer, idx);
 
-	trace_timer_start(timer, timer->expires, timer->flags);
-
 	/*
 	 * Check whether this is the new first expiring timer. The
 	 * effective expiry time of the timer is required here
@@ -600,6 +598,7 @@ static void enqueue_timer(struct timer_b
 		base->next_expiry_recalc = false;
 		trigger_dyntick_cpu(base, timer);
 	}
+	trace_timer_start(timer, timer->expires, bucket_expiry, base->next_expiry, timer->flags);
 }
 
 static void internal_add_timer(struct timer_base *base, struct timer_list *timer)
@@ -893,6 +892,9 @@ static inline void forward_timer_base(st
 {
 	unsigned long jnow = READ_ONCE(jiffies);
 
+	trace_printk("FWD: now=%lu clk=%lu next_expiry=%lu recalc=%d\n",
+		     jnow, base->clk, base->next_expiry,
+		     base->next_expiry_recalc);
 	/*
 	 * No need to forward if we are close enough below jiffies.
 	 * Also while executing timers, base->clk is 1 offset ahead
@@ -1710,6 +1712,7 @@ void timer_clear_idle(void)
 static inline void __run_timers(struct timer_base *base)
 {
 	struct hlist_head heads[LVL_DEPTH];
+	bool confused = false;
 	int levels;
 
 	if (time_before(jiffies, base->next_expiry))
@@ -1718,6 +1721,10 @@ static inline void __run_timers(struct t
 	timer_base_lock_expiry(base);
 	raw_spin_lock_irq(&base->lock);
 
+	trace_printk("RUN: now=%lu clk=%lu next_expiry=%lu recalc=%d\n",
+		     jiffies, base->clk, base->next_expiry,
+		     base->next_expiry_recalc);
+
 	while (time_after_eq(jiffies, base->clk) &&
 	       time_after_eq(jiffies, base->next_expiry)) {
 		levels = collect_expired_timers(base, heads);
@@ -1726,7 +1733,12 @@ static inline void __run_timers(struct t
 		 * timer at this clk is that all matching timers have been
 		 * dequeued.
 		 */
-		WARN_ON_ONCE(!levels && !base->next_expiry_recalc);
+		if (!levels && !base->next_expiry_recalc) {
+			trace_printk("WTH: now=%lu clk=%lu next_expiry=%lu recalc=%d\n",
+				     jiffies, base->clk, base->next_expiry,
+				     base->next_expiry_recalc);
+			confused = true;
+		}
 		base->clk++;
 		base->next_expiry = __next_timer_interrupt(base);
 
@@ -1735,6 +1747,9 @@ static inline void __run_timers(struct t
 	}
 	raw_spin_unlock_irq(&base->lock);
 	timer_base_unlock_expiry(base);
+
+	if (confused)
+		panic("Confused");
 }
 
 /*




_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

