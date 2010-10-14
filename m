Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 14 Oct 2010 20:27:55 +0200
Message-ID: <AANLkTinNxzktyttzEjWSUPBiOUwh+4DUL0tmP7p1UiT5@mail.gmail.com>
Subject: [REGRESSION] um: rcu_sched_state detected stall on CPU 0
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
To: arjan@linux.intel.com
Cc: penberg@cs.helsinki.fi, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Arjan!

This commit causes some problems on UML.

The kernel freezes after a few seconds until it gets some input.
e.g: When I run top it stops refreshing the process list until i press a button.

Messages like this appear:
INFO: rcu_sched_state detected stall on CPU 0 (t=7348 jiffies)

After reverting UML works fine again.

commit 78b435368fcd615e695a06012cd963a556284e00
Author: Arjan van de Ven <arjan@linux.intel.com>
Date:   Mon Jul 19 10:59:42 2010 -0700

    slab: use deferable timers for its periodic housekeeping

    slab has a "once every 2 second" timer for its housekeeping.
    As the number of logical processors is growing, its more and more
    common that this 2 second timer becomes the primary wakeup source.

    This patch turns this housekeeping timer into a deferable timer,
    which means that the timer does not interrupt idle, but just runs
    at the next event that wakes the cpu up.

    The impact is that the timer likely runs a bit later, but during the
    delay no code is running so there's not all that much reason for
    a difference in housekeeping to occur because of this delay.

    Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
    Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

diff --git a/mm/slab.c b/mm/slab.c
index e49f8f4..29aad44 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -861,7 +861,7 @@ static void __cpuinit start_cpu_timer(int cpu)
         */
        if (keventd_up() && reap_work->work.func == NULL) {
                init_reap_node(cpu);
-               INIT_DELAYED_WORK(reap_work, cache_reap);
+               INIT_DELAYED_WORK_DEFERRABLE(reap_work, cache_reap);
                schedule_delayed_work_on(cpu, reap_work,
                                        __round_jiffies_relative(HZ, cpu));
        }


-- 
Thanks,
//richard
