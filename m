Return-Path: <tglx@linutronix.de>
Message-Id: <20200914204442.204800632@linutronix.de>
Date: Mon, 14 Sep 2020 22:42:21 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 12/13] rcutorture: Clenaup PREEMPT_COUNT leftovers
References: <20200914204209.256266093@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Valentin Schneider <valentin.schneider@arm.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-ID: <linux-um.lists.infradead.org>

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: rcu@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-t            |    1 -
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-u            |    1 -
 tools/testing/selftests/rcutorture/configs/rcu/TINY01            |    1 -
 tools/testing/selftests/rcutorture/doc/TINY_RCU.txt              |    5 ++---
 tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt      |    1 -
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h |    1 -
 6 files changed, 2 insertions(+), 8 deletions(-)

--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
@@ -7,4 +7,3 @@ CONFIG_RCU_TRACE=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_DEBUG_ATOMIC_SLEEP=y
-#CHECK#CONFIG_PREEMPT_COUNT=y
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
@@ -7,4 +7,3 @@ CONFIG_RCU_TRACE=n
 CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_PROVE_LOCKING=y
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-CONFIG_PREEMPT_COUNT=n
--- a/tools/testing/selftests/rcutorture/configs/rcu/TINY01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY01
@@ -10,4 +10,3 @@ CONFIG_RCU_TRACE=n
 #CHECK#CONFIG_RCU_STALL_COMMON=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-CONFIG_PREEMPT_COUNT=n
--- a/tools/testing/selftests/rcutorture/doc/TINY_RCU.txt
+++ b/tools/testing/selftests/rcutorture/doc/TINY_RCU.txt
@@ -3,11 +3,10 @@ This document gives a brief rationale fo
 
 Kconfig Parameters:
 
-CONFIG_DEBUG_LOCK_ALLOC -- Do all three and none of the three.
-CONFIG_PREEMPT_COUNT
+CONFIG_DEBUG_LOCK_ALLOC -- Do both and none of the two.
 CONFIG_RCU_TRACE
 
-The theory here is that randconfig testing will hit the other six possible
+The theory here is that randconfig testing will hit the other two possible
 combinations of these parameters.
 
 
--- a/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
+++ b/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
@@ -43,7 +43,6 @@ CONFIG_64BIT
 
 	Used only to check CONFIG_RCU_FANOUT value, inspection suffices.
 
-CONFIG_PREEMPT_COUNT
 CONFIG_PREEMPT_RCU
 
 	Redundant with CONFIG_PREEMPT, ignore.
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h
+++ b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h
@@ -8,7 +8,6 @@
 #undef CONFIG_HOTPLUG_CPU
 #undef CONFIG_MODULES
 #undef CONFIG_NO_HZ_FULL_SYSIDLE
-#undef CONFIG_PREEMPT_COUNT
 #undef CONFIG_PREEMPT_RCU
 #undef CONFIG_PROVE_RCU
 #undef CONFIG_RCU_NOCB_CPU


