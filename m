Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1naeZE-009DOV-Do
 for linux-um@lists.infradead.org; Sat, 02 Apr 2022 14:17:30 +0000
Message-ID: <3c9a5194fb2bdf7377552c6fa6c3cd3505c4496c.camel@sipsolutions.net>
Subject: Re: UML time-travel warning from __run_timers
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sat, 02 Apr 2022 16:17:25 +0200
In-Reply-To: <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
References: <20220330110156.GA9250@axis.com>
 <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
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

On Sat, 2022-04-02 at 16:09 +0200, Johannes Berg wrote:
> 
> (I put a WARN_ON into get_timer_cpu_base() and get_timer_this_cpu_base()
> in the if, and it never triggered; I guess my config has something that
> creates a deferrable timer, so it didn't trigger, but I didn't check
> that now.)
> 

OK, so FWIW, I checked that now, and I have e.g. CONFIG_WQ_WATCHDOG
enabled, which makes a deferrable timer:

static void wq_watchdog_init(void)
{
        timer_setup(&wq_watchdog_timer, wq_watchdog_timer_fn, TIMER_DEFERRABLE);


but I think a bunch of other (networking) things too that end up using a
TIMER_DEFERRABLE timer, via workqueues.

But maybe this would also happen if it was used just a single time,
since the timer would run & go away, leaving base->next_expiry never to
change again? But the WQ watchdog and also neigh_managed_work() are
periodic.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

