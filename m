Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH] um/time: set ->min_delta_ticks and ->max_delta_ticks
Date: Thu, 30 Mar 2017 21:59:42 +0200
Message-Id: <20170330195942.7946-1-nicstange@gmail.com>
In-Reply-To: <20170326134403.16226-1-nicstange@gmail.com>
References: <20170326134403.16226-1-nicstange@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>
Cc: John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, Nicolai Stange <nicstange@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

In preparation for making the clockevents core NTP correction aware,
all clockevent device drivers must set ->min_delta_ticks and
->max_delta_ticks rather than ->min_delta_ns and ->max_delta_ns: a
clockevent device's rate is going to change dynamically and thus, the
ratio of ns to ticks ceases to stay invariant.

Make the uml arch's clockevent driver initialize these fields properly.

This patch alone doesn't introduce any change in functionality as the
clockevents core still looks exclusively at the (untouched) ->min_delta_ns
and ->max_delta_ns. As soon as this has changed, a followup patch will
purge the initialization of ->min_delta_ns and ->max_delta_ns from this
driver.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---

Notes:
    This prerequisite patch is part of a larger effort to feed NTP
    corrections into the clockevent devices' frequencies and thus
    avoiding their notion of time to diverge from the system's
    one. If you're interested, the current state of the whole series
    can be found at [1].
    
    If you haven't got any objections and these prerequisites get
    merged by 4.12 everywhere, I'll proceed with the remainder of
    this series in 4.13.
    
    Applicable to next-20170324 as well as to John' Stultz tree [2].
    
    [1]
      git://nicst.de/linux.git cev-freq-adj.v10.fortglx-4.12-time
      https://nicst.de/git/?p=linux.git;a=shortlog;h=refs/heads/cev-freq-adj.v10.fortglx-4.12-time
    
    [2]
      https://git.linaro.org/people/john.stultz/linux.git fortglx/4.12/time

 arch/um/kernel/time.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index ba87a27d6715..0b034ebbda2a 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -65,7 +65,9 @@ static struct clock_event_device timer_clockevent = {
 	.set_next_event		= itimer_next_event,
 	.shift			= 0,
 	.max_delta_ns		= 0xffffffff,
-	.min_delta_ns		= TIMER_MIN_DELTA, //microsecond resolution should be enough for anyone, same as 640K RAM
+	.max_delta_ticks	= 0xffffffff,
+	.min_delta_ns		= TIMER_MIN_DELTA,
+	.min_delta_ticks	= TIMER_MIN_DELTA, // microsecond resolution should be enough for anyone, same as 640K RAM
 	.irq			= 0,
 	.mult			= 1,
 };
-- 
2.12.0


