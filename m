Return-Path: <tglx@linutronix.de>
Message-Id: <20200914204441.486057928@linutronix.de>
Date: Mon, 14 Sep 2020 22:42:14 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 05/13] mm/pagemap: Clenaup PREEMPT_COUNT leftovers
References: <20200914204209.256266093@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Valentin Schneider <valentin.schneider@arm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 include/linux/pagemap.h |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -168,9 +168,7 @@ void release_pages(struct page **pages,
 static inline int __page_cache_add_speculative(struct page *page, int count)
 {
 #ifdef CONFIG_TINY_RCU
-# ifdef CONFIG_PREEMPT_COUNT
-	VM_BUG_ON(!in_atomic() && !irqs_disabled());
-# endif
+	VM_BUG_ON(preemptible())
 	/*
 	 * Preempt must be disabled here - we rely on rcu_read_lock doing
 	 * this for us.


