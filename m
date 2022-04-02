Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1naeRe-0099uK-4P
 for linux-um@lists.infradead.org; Sat, 02 Apr 2022 14:09:40 +0000
Message-ID: <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
Subject: Re: UML time-travel warning from __run_timers
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sat, 02 Apr 2022 16:09:29 +0200
In-Reply-To: <20220330110156.GA9250@axis.com>
References: <20220330110156.GA9250@axis.com>
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
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>

Hi Vincent,


> [10737482.720000][    C0] ------------[ cut here ]------------
> [10737482.720000][    C0] WARNING: CPU: 0 PID: 0 at kernel/time/timer.c:1729 __run_timers+0x36d/0x380
> 

[for those new on the thread, full message and config here:
https://lore.kernel.org/r/20220330110156.GA9250@axis.com]


I think maybe you found a bug in the timers code?

Your config has CONFIG_NO_HZ_COMMON, so we have both BASE_STD and
BASE_DEF.

Evidently, in your config, we *never* have any timer with
TIMER_DEFERRABLE, which would put it into BASE_DEF.

(I put a WARN_ON into get_timer_cpu_base() and get_timer_this_cpu_base()
in the if, and it never triggered; I guess my config has something that
creates a deferrable timer, so it didn't trigger, but I didn't check
that now.)

Therefore, base->next_expiry never changes or something?

At init, we get

init_timer_cpu(0) base 0 clk=0xffff8ad0, next_expiry=0x13fff8acf
init_timer_cpu(0) base 1 clk=0xffff8ad0, next_expiry=0x13fff8acf

which makes sense, jiffies is set up to wrap very quickly after boot.

The warning triggers when we have jiffies=0x13fff9600, so it's just
after the "next_expiry", so in this code:

static inline void __run_timers(struct timer_base *base)
{
   struct hlist_head heads[LVL_DEPTH];
   int levels;

   if (time_before(jiffies, base->next_expiry))
           return;


we no longer return. Previously, we've *never* executed past that if for
BASE_DEF.

But we never touched this timer base nor did we ever want to recalc it I
guess, so

    WARN_ON_ONCE(!levels && !base->next_expiry_recalc);

triggers.


I thought about changing that condition to

  if (time_before(...) || !base->timers_pending)
          return;

and that *does* make the splat go away, but I fear that might make it
not recalculate when needed, so perhaps in the condition we should have

  if (time_before(...) ||
      (!base->timers_pending && !base->next_expiry_recalc))
          return;

or something? (which also avoids hitting the warning)

But I really don't know anything about this code, so adding a few CCs.
Can you help?

Thanks,
johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

