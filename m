Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8mC-0002TQ-Qo
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 05:01:42 +0000
Received: by mail-pl1-x642.google.com with SMTP id q21so1404656plr.13
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 22:01:40 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 31/47] cpu: add cpu_yield_to_irqs
Date: Wed, 23 Oct 2019 13:38:05 +0900
Message-Id: <96b59a0a55cdc657750a1f1d7af349550d13ac9c.1571798507.git.thehajime@gmail.com>
In-Reply-To: <cover.1571798507.git.thehajime@gmail.com>
References: <cover.1571798507.git.thehajime@gmail.com>
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
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>

From: Octavian Purdila <tavi.purdila@gmail.com>

Add a new architecture function that should be called in loops that rely
on interrupts to exit the loop (e.g. loops that use a jiffies expression
for the exit condition).

This is needed for architectures where interrupts can not preempt the
currently running thread (e.g. lkl).

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 crypto/xor.c        | 2 ++
 include/linux/cpu.h | 1 +
 kernel/cpu.c        | 5 +++++
 lib/raid6/algos.c   | 9 ++++++---
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/crypto/xor.c b/crypto/xor.c
index ea7349e6ed23..c55a89a9e659 100644
--- a/crypto/xor.c
+++ b/crypto/xor.c
@@ -14,6 +14,7 @@
 #include <linux/raid/xor.h>
 #include <linux/jiffies.h>
 #include <linux/preempt.h>
+#include <linux/cpu.h>
 #include <asm/xor.h>
 
 #ifndef XOR_SELECT_TEMPLATE
@@ -85,6 +86,7 @@ do_xor_speed(struct xor_block_template *tmpl, void *b1, void *b2)
 			mb();
 			count++;
 			mb();
+			cpu_yield_to_irqs();
 		}
 		if (count > max)
 			max = count;
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index fcb1386bb0d4..887702d29498 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -180,6 +180,7 @@ int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
 void play_idle(unsigned long duration_ms);
+void cpu_yield_to_irqs(void);
 
 #ifdef CONFIG_HOTPLUG_CPU
 bool cpu_wait_death(unsigned int cpu, int seconds);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e84c0873559e..9ca61a55ed0c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2339,6 +2339,11 @@ void __init boot_cpu_hotplug_init(void)
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
 }
 
+void __weak cpu_yield_to_irqs(void)
+{
+}
+EXPORT_SYMBOL(cpu_yield_to_irqs);
+
 enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
 
 static int __init mitigations_parse_cmdline(char *arg)
diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
index 17417eee0866..7e6121443ebc 100644
--- a/lib/raid6/algos.c
+++ b/lib/raid6/algos.c
@@ -18,6 +18,7 @@
 #else
 #include <linux/module.h>
 #include <linux/gfp.h>
+#include <linux/cpu.h>
 #if !RAID6_USE_EMPTY_ZERO_PAGE
 /* In .bss so it's zeroed */
 const char raid6_empty_zero_page[PAGE_SIZE] __attribute__((aligned(256)));
@@ -29,7 +30,7 @@ struct raid6_calls raid6_call;
 EXPORT_SYMBOL_GPL(raid6_call);
 
 const struct raid6_calls * const raid6_algos[] = {
-#if defined(__i386__) && !defined(__arch_um__)
+#ifdef CONFIG_X86_32
 #ifdef CONFIG_AS_AVX512
 	&raid6_avx512x2,
 	&raid6_avx512x1,
@@ -45,7 +46,7 @@ const struct raid6_calls * const raid6_algos[] = {
 	&raid6_mmxx2,
 	&raid6_mmxx1,
 #endif
-#if defined(__x86_64__) && !defined(__arch_um__)
+#ifdef CONFIG_X86_64
 #ifdef CONFIG_AS_AVX512
 	&raid6_avx512x4,
 	&raid6_avx512x2,
@@ -79,7 +80,7 @@ const struct raid6_calls * const raid6_algos[] = {
 	&raid6_neonx2,
 	&raid6_neonx1,
 #endif
-#if defined(__ia64__)
+#ifdef CONFIG_IA64
 	&raid6_intx32,
 	&raid6_intx16,
 #endif
@@ -173,6 +174,7 @@ static inline const struct raid6_calls *raid6_choose_gen(
 					    j1 + (1<<RAID6_TIME_JIFFIES_LG2))) {
 				(*algo)->gen_syndrome(disks, PAGE_SIZE, *dptrs);
 				perf++;
+				cpu_yield_to_irqs();
 			}
 			preempt_enable();
 
@@ -197,6 +199,7 @@ static inline const struct raid6_calls *raid6_choose_gen(
 				(*algo)->xor_syndrome(disks, start, stop,
 						      PAGE_SIZE, *dptrs);
 				perf++;
+				cpu_yield_to_irqs();
 			}
 			preempt_enable();
 
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

