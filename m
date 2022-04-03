Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nb2wJ-00BrVu-11
 for linux-um@lists.infradead.org; Sun, 03 Apr 2022 16:18:56 +0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: UML time-travel warning from __run_timers
In-Reply-To: <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
References: <20220330110156.GA9250@axis.com>
 <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
Date: Sun, 03 Apr 2022 18:18:51 +0200
Message-ID: <877d86m978.ffs@tglx>
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

On Sat, Apr 02 2022 at 16:09, Johannes Berg wrote:
> At init, we get
>
> init_timer_cpu(0) base 0 clk=0xffff8ad0, next_expiry=0x13fff8acf
> init_timer_cpu(0) base 1 clk=0xffff8ad0, next_expiry=0x13fff8acf
>
> which makes sense, jiffies is set up to wrap very quickly after boot.
>
> The warning triggers when we have jiffies=0x13fff9600, so it's just
> after the "next_expiry", so in this code:

which does not make sense. If next_expiry is 0x13fff8acf and jiffies
advanced to 0x13fff9600 when the warning triggered, then either it
missed to expire the timer at 0x13fff8acf or it failed to recalculate
next_expiry.

Could you enable all [hr]timer tracepoints on the kernel command line,
set panic on warn and ftrace_dump_on_oops which should spill out the
tracebuffer on the console and provide the output. That should at least
give us an hint what's going on.

Thanks,

        tglx



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

