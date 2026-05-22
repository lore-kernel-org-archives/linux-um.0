Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84666CD5BB4
	for <linux-um@archiver.kernel.org>; Fri, 22 May 2026 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IwI+0IE7UYNHP6pLGdqMWIPaS64i6mHL5V4w1xLWQFk=; b=CH/LLnhejgiaWGnkFu2D6ZytNn
	YKr+J+rFAJHCGXqIdjRXiSN8eKs/U7qaxff4pN/ddPf6CM0E+YBEKBjsFcKL1AeJbFLjKn6OTEycl
	OCV2NqElW3Hy/S0cEuOKJlD+xItgPQ9Zoqe8BPfmbv1Y7c1RtvSUVT943Rt8obSd3rNzp/2OI2o7R
	tqQAjfxtkJceRGQlytTvmJCS4USnNlzJoOkwrHuXo9qR5ID+stNATJv1gl6/pFo1K5NbJLjLZwxCt
	ZL5OLtrRi4keTU0VTmeZ6SpuxjC7Rha30IVcCSXPccHQ5l+SjAhoy07Ir/moZlHzCw+nM27uCkYSn
	4wf7cf+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQQjx-0000000B72u-18N1;
	Fri, 22 May 2026 14:20:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQQju-0000000B70v-1PfR
	for linux-um@lists.infradead.org;
	Fri, 22 May 2026 14:20:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EDC5743817;
	Fri, 22 May 2026 14:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843971F00A3F;
	Fri, 22 May 2026 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459637;
	bh=IwI+0IE7UYNHP6pLGdqMWIPaS64i6mHL5V4w1xLWQFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eB3AKZw6fPVwL1oR8MQ6AsLdNMTptplxtUAU9pP23/eFcCeyJQ2zDYJCy2ZfHuSTw
	 UGN/VYx2XGwb6LK2abVBD8GYomypffpLJZU2avsylWY5mOE6Jha9ZBjYPELVSDPL/O
	 v0ODdbfYwX7gzzvzyoSj9HB1OsyvgMvVUvHvcGg/CUwjbN1Q86DmRHe0RV9SSnTXAR
	 FiykGSt7eJHuEKLMtqrWcmwb1x+/dyE36cTVz6JG43zv/4GNup9tj9jJSwv5gVexJb
	 EenkrIs7OwSKrc68EsbyMNt28vQRS0Nex4TkOdkFec1KmggjGXs+VARfs3yHvVrzdi
	 RkllDLwugyBeQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 3/8] x86: make TSC usage unconditional
Date: Fri, 22 May 2026 16:19:54 +0200
Message-Id: <20260522141959.1071595-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260522141959.1071595-1-arnd@kernel.org>
References: <20260522141959.1071595-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_072038_426490_227310E0 
X-CRM114-Status: GOOD (  27.82  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

There are multiple levels of functionality of the TSC that are checked
for: built into the kernel, present in the CPU, reliable and probably
more.

Since the TSC-less CPUs are no longer supported in the kernel,
remove all checks for CONFIG_TSC and X86_FEATURE_TSC and assume
it's always there. Unfortunately the tsc_clocksource_reliable
checks are still required though.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/virt/kvm/x86/timekeeping.rst |  1 -
 arch/x86/Kconfig                           |  1 -
 arch/x86/Kconfig.cpu                       |  1 -
 arch/x86/events/msr.c                      |  5 ----
 arch/x86/include/asm/timex.h               |  3 ---
 arch/x86/include/asm/trace_clock.h         |  8 -------
 arch/x86/include/asm/tsc.h                 | 13 ----------
 arch/x86/kernel/Makefile                   |  4 ++--
 arch/x86/kernel/apic/apic.c                | 23 +++++++-----------
 arch/x86/kernel/apic/io_apic.c             | 22 +----------------
 arch/x86/kernel/cpu/centaur.c              |  2 --
 arch/x86/kernel/cpu/common.c               |  4 +---
 arch/x86/kernel/cpu/proc.c                 | 15 +++++-------
 arch/x86/kernel/i8253.c                    |  3 ---
 arch/x86/kernel/tsc.c                      | 28 ++--------------------
 arch/x86/lib/kaslr.c                       | 20 ++++------------
 arch/x86/xen/time.c                        |  2 --
 drivers/net/ethernet/intel/igc/igc_ptp.c   |  4 ++--
 drivers/ptp/Kconfig                        |  2 +-
 tools/power/cpupower/debug/kernel/Makefile |  5 +---
 20 files changed, 29 insertions(+), 137 deletions(-)

diff --git a/Documentation/virt/kvm/x86/timekeeping.rst b/Documentation/virt/kvm/x86/timekeeping.rst
index 21ae7efa29ba..e8519451000d 100644
--- a/Documentation/virt/kvm/x86/timekeeping.rst
+++ b/Documentation/virt/kvm/x86/timekeeping.rst
@@ -471,7 +471,6 @@ The following feature bits are used by Linux to signal various TSC attributes,
 but they can only be taken to be meaningful for UP or single node systems.
 
 =========================	=======================================
-X86_FEATURE_TSC			The TSC is available in hardware
 X86_FEATURE_RDTSCP		The RDTSCP instruction is available
 X86_FEATURE_CONSTANT_TSC	The TSC rate is unchanged with P-states
 X86_FEATURE_NONSTOP_TSC		The TSC does not stop in C-states
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a188ed90b1ca..2fd99a5b4a68 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -683,7 +683,6 @@ config X86_INTEL_QUARK
 	depends on X86_32
 	depends on X86_EXTENDED_PLATFORM
 	depends on X86_PLATFORM_DEVICES
-	depends on X86_TSC
 	depends on PCI
 	depends on PCI_GOANY
 	depends on X86_IO_APIC
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index f4a12b74bed3..fe0246477345 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -261,7 +261,6 @@ config X86_USE_PPRO_CHECKSUM
 
 config X86_TSC
 	def_bool y
-	depends on (MWINCHIP3D || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MVIAC3_2 || MVIAC7 || MGEODEGX1 || MGEODE_LX || MATOM) || X86_64
 
 config X86_HAVE_PAE
 	def_bool y
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 76d6418c5055..130f1a8c8800 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -229,11 +229,6 @@ static struct pmu pmu_msr = {
 
 static int __init msr_init(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_TSC)) {
-		pr_cont("no MSR PMU driver.\n");
-		return 0;
-	}
-
 	msr_mask = perf_msr_probe(msr, PERF_MSR_EVENT_MAX, true, NULL);
 
 	perf_pmu_register(&pmu_msr, "msr", -1);
diff --git a/arch/x86/include/asm/timex.h b/arch/x86/include/asm/timex.h
index 956e4145311b..ec2e37c19760 100644
--- a/arch/x86/include/asm/timex.h
+++ b/arch/x86/include/asm/timex.h
@@ -7,9 +7,6 @@
 
 static inline unsigned long random_get_entropy(void)
 {
-	if (!IS_ENABLED(CONFIG_X86_TSC) &&
-	    !cpu_feature_enabled(X86_FEATURE_TSC))
-		return random_get_entropy_fallback();
 	return rdtsc();
 }
 #define random_get_entropy random_get_entropy
diff --git a/arch/x86/include/asm/trace_clock.h b/arch/x86/include/asm/trace_clock.h
index 7061a5650969..1efab284c32a 100644
--- a/arch/x86/include/asm/trace_clock.h
+++ b/arch/x86/include/asm/trace_clock.h
@@ -5,17 +5,9 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 
-#ifdef CONFIG_X86_TSC
-
 extern u64 notrace trace_clock_x86_tsc(void);
 
 # define ARCH_TRACE_CLOCKS \
 	{ trace_clock_x86_tsc,	"x86-tsc",	.in_ns = 0 },
 
-#else /* !CONFIG_X86_TSC */
-
-#define ARCH_TRACE_CLOCKS
-
-#endif
-
 #endif  /* _ASM_X86_TRACE_CLOCK_H */
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 4f7f09f50552..88d9d2a22152 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -76,9 +76,6 @@ extern void disable_TSC(void);
 
 static inline cycles_t get_cycles(void)
 {
-	if (!IS_ENABLED(CONFIG_X86_TSC) &&
-	    !cpu_feature_enabled(X86_FEATURE_TSC))
-		return 0;
 	return rdtsc();
 }
 #define get_cycles get_cycles
@@ -94,25 +91,15 @@ extern unsigned long native_calibrate_tsc(void);
 extern unsigned long long native_sched_clock_from_tsc(u64 tsc);
 
 extern int tsc_clocksource_reliable;
-#ifdef CONFIG_X86_TSC
 extern bool tsc_async_resets;
-#else
-# define tsc_async_resets	false
-#endif
 
 /*
  * Boot-time check whether the TSCs are synchronized across
  * all CPUs/cores:
  */
-#ifdef CONFIG_X86_TSC
 extern bool tsc_store_and_check_tsc_adjust(bool bootcpu);
 extern void tsc_verify_tsc_adjust(bool resume);
 extern void check_tsc_sync_target(void);
-#else
-static inline bool tsc_store_and_check_tsc_adjust(bool bootcpu) { return false; }
-static inline void tsc_verify_tsc_adjust(bool resume) { }
-static inline void check_tsc_sync_target(void) { }
-#endif
 
 extern int notsc_setup(char *);
 extern void tsc_save_sched_clock_state(void);
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 47a32f583930..31f46fd00527 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -108,7 +108,7 @@ apm-y				:= apm_32.o
 obj-$(CONFIG_APM)		+= apm.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP)		+= smpboot.o
-obj-$(CONFIG_X86_TSC)		+= tsc_sync.o
+obj-y				+= tsc_sync.o
 obj-$(CONFIG_SMP)		+= setup_percpu.o
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-y				+= apic/
@@ -117,7 +117,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace_$(BITS).o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += ftrace.o
 obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
-obj-$(CONFIG_X86_TSC)		+= trace_clock.o
+obj-y				+= trace_clock.o
 obj-$(CONFIG_TRACING)		+= trace.o
 obj-$(CONFIG_RETHOOK)		+= rethook.o
 obj-$(CONFIG_VMCORE_INFO)	+= vmcore_info_$(BITS).o
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 8c614750a19b..254a6ce6487c 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -666,8 +666,7 @@ static void __init lapic_cal_handler(struct clock_event_device *dev)
 	long tapic = apic_read(APIC_TMCCT);
 	u32 pm = acpi_pm_read_early();
 
-	if (boot_cpu_has(X86_FEATURE_TSC))
-		tsc = rdtsc();
+	tsc = rdtsc();
 
 	switch (lapic_cal_loops++) {
 	case 0:
@@ -727,13 +726,11 @@ calibrate_by_pmtimer(u32 deltapm, long *delta, long *deltatsc)
 	*delta = (long)res;
 
 	/* Correct the tsc counter value */
-	if (boot_cpu_has(X86_FEATURE_TSC)) {
-		res = (((u64)(*deltatsc)) * pm_100ms);
-		do_div(res, deltapm);
-		apic_pr_verbose("TSC delta adjusted to PM-Timer: %lu (%ld)\n",
-				(unsigned long)res, *deltatsc);
-		*deltatsc = (long)res;
-	}
+	res = (((u64)(*deltatsc)) * pm_100ms);
+	do_div(res, deltapm);
+	apic_pr_verbose("TSC delta adjusted to PM-Timer: %lu (%ld)\n",
+			(unsigned long)res, *deltatsc);
+	*deltatsc = (long)res;
 
 	return 0;
 }
@@ -902,12 +899,10 @@ static int __init calibrate_APIC_clock(void)
 	apic_pr_verbose("..... mult: %u\n", lapic_clockevent.mult);
 	apic_pr_verbose("..... calibration result: %u\n", lapic_timer_period);
 
-	if (boot_cpu_has(X86_FEATURE_TSC)) {
-		delta_tsc_khz = (deltatsc * HZ) / (1000 * LAPIC_CAL_LOOPS);
+	delta_tsc_khz = (deltatsc * HZ) / (1000 * LAPIC_CAL_LOOPS);
 
-		apic_pr_verbose("..... CPU clock speed is %ld.%03ld MHz.\n",
-				delta_tsc_khz / 1000, delta_tsc_khz % 1000);
-	}
+	apic_pr_verbose("..... CPU clock speed is %ld.%03ld MHz.\n",
+			delta_tsc_khz / 1000, delta_tsc_khz % 1000);
 
 	bus_khz = (long)lapic_timer_period * HZ / 1000;
 	apic_pr_verbose("..... host bus clock speed is %ld.%03ld MHz.\n",
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 352ed5558cbc..e8eb18d859ef 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1491,23 +1491,6 @@ static void __init delay_with_tsc(void)
 	} while ((now - start) < 40000000000ULL / HZ &&	time_before_eq(jiffies, end));
 }
 
-static void __init delay_without_tsc(void)
-{
-	unsigned long end = jiffies + 4;
-	int band = 1;
-
-	/*
-	 * We don't know any frequency yet, but waiting for
-	 * 40940000000/HZ cycles is safe:
-	 * 4 GHz == 10 jiffies
-	 * 1 GHz == 40 jiffies
-	 * 1 << 1 + 1 << 2 +...+ 1 << 11 = 4094
-	 */
-	do {
-		__delay(((1U << band++) * 10000000UL) / HZ);
-	} while (band < 12 && time_before_eq(jiffies, end));
-}
-
 /*
  * There is a nasty bug in some older SMP boards, their mptable lies
  * about the timer IRQ. We do the following to work around the situation:
@@ -1524,10 +1507,7 @@ static int __init timer_irq_works(void)
 		return 1;
 
 	local_irq_enable();
-	if (boot_cpu_has(X86_FEATURE_TSC))
-		delay_with_tsc();
-	else
-		delay_without_tsc();
+	delay_with_tsc();
 
 	/*
 	 * Expect a few ticks at least, to be sure some possible
diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 681d2da49341..75b4de9c4d44 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -140,8 +140,6 @@ static void init_centaur(struct cpuinfo_x86 *c)
 			name = "C6";
 			fcr_set = ECX8|DSMC|EDCTLB|EMMX|ERETSTK;
 			fcr_clr = DPDC;
-			pr_notice("Disabling bugged TSC.\n");
-			clear_cpu_cap(c, X86_FEATURE_TSC);
 			break;
 		case 8:
 			switch (c->x86_stepping) {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a3df21d26460..6943d3aff580 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2471,9 +2471,7 @@ void cpu_init(void)
 #endif
 	pr_debug("Initializing CPU#%d\n", cpu);
 
-	if (IS_ENABLED(CONFIG_X86_64) || cpu_feature_enabled(X86_FEATURE_VME) ||
-	    boot_cpu_has(X86_FEATURE_TSC) || boot_cpu_has(X86_FEATURE_DE))
-		cr4_clear_bits(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
+	cr4_clear_bits(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
 
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		loadsegment(fs, 0);
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 6571d432cbe3..8086c39c2922 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -64,7 +64,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 {
 	struct cpuinfo_x86 *c = v;
 	unsigned int cpu;
-	int i;
+	int freq, i;
 
 	cpu = c->cpu_index;
 	seq_printf(m, "processor\t: %u\n"
@@ -85,14 +85,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	if (c->microcode)
 		seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
 
-	if (cpu_has(c, X86_FEATURE_TSC)) {
-		int freq = arch_freq_get_on_cpu(cpu);
-
-		if (freq < 0)
-			seq_puts(m, "cpu MHz\t\t: Unknown\n");
-		else
-			seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
-	}
+	freq = arch_freq_get_on_cpu(cpu);
+	if (freq < 0)
+		seq_puts(m, "cpu MHz\t\t: Unknown\n");
+	else
+		seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
 
 	/* Cache size */
 	if (c->x86_cache_size)
diff --git a/arch/x86/kernel/i8253.c b/arch/x86/kernel/i8253.c
index cb9852ad6098..0c91426e4a08 100644
--- a/arch/x86/kernel/i8253.c
+++ b/arch/x86/kernel/i8253.c
@@ -31,9 +31,6 @@ struct clock_event_device *global_clock_event;
  */
 static bool __init use_pit(void)
 {
-	if (!IS_ENABLED(CONFIG_X86_TSC) || !boot_cpu_has(X86_FEATURE_TSC))
-		return true;
-
 	/* This also returns true when APIC is disabled */
 	return apic_needs_pit();
 }
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index c5110eb554bc..e7a43471783f 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -305,23 +305,11 @@ int check_tsc_unstable(void)
 }
 EXPORT_SYMBOL_GPL(check_tsc_unstable);
 
-#ifdef CONFIG_X86_TSC
 int __init notsc_setup(char *str)
 {
 	mark_tsc_unstable("boot parameter notsc");
 	return 1;
 }
-#else
-/*
- * disable flag for tsc. Takes effect by clearing the TSC cpu flag
- * in cpu/common.c
- */
-int __init notsc_setup(char *str)
-{
-	setup_clear_cpu_cap(X86_FEATURE_TSC);
-	return 1;
-}
-#endif
 __setup("notsc", notsc_setup);
 
 enum {
@@ -942,9 +930,6 @@ void recalibrate_cpu_khz(void)
 #ifndef CONFIG_SMP
 	unsigned long cpu_khz_old = cpu_khz;
 
-	if (!boot_cpu_has(X86_FEATURE_TSC))
-		return;
-
 	cpu_khz = x86_platform.calibrate_cpu();
 	tsc_khz = x86_platform.calibrate_tsc();
 	if (tsc_khz == 0)
@@ -1059,8 +1044,6 @@ static struct notifier_block time_cpufreq_notifier_block = {
 
 static int __init cpufreq_register_tsc_scaling(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_TSC))
-		return 0;
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC))
 		return 0;
 	cpufreq_register_notifier(&time_cpufreq_notifier_block,
@@ -1266,7 +1249,7 @@ static void __init check_system_tsc_reliable(void)
  */
 int unsynchronized_tsc(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_TSC) || tsc_unstable)
+	if (tsc_unstable)
 		return 1;
 
 #ifdef CONFIG_SMP
@@ -1416,7 +1399,7 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 
 static int __init init_tsc_clocksource(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_TSC) || !tsc_khz)
+	if (!tsc_khz)
 		return 0;
 
 	if (tsc_unstable) {
@@ -1515,8 +1498,6 @@ static void __init tsc_enable_sched_clock(void)
 
 void __init tsc_early_init(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_TSC))
-		return;
 	/* Don't change UV TSC multi-chassis synchronization */
 	if (is_early_uv_system())
 		return;
@@ -1530,11 +1511,6 @@ void __init tsc_early_init(void)
 
 void __init tsc_init(void)
 {
-	if (!cpu_feature_enabled(X86_FEATURE_TSC)) {
-		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
-		return;
-	}
-
 	/*
 	 * native_calibrate_cpu_early can only calibrate using methods that are
 	 * available early in boot.
diff --git a/arch/x86/lib/kaslr.c b/arch/x86/lib/kaslr.c
index 8c7cd115b484..9984eeeb1a7c 100644
--- a/arch/x86/lib/kaslr.c
+++ b/arch/x86/lib/kaslr.c
@@ -54,7 +54,6 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	const unsigned long mix_const = 0x3f39e593UL;
 #endif
 	unsigned long raw, random = get_boot_seed();
-	bool use_i8254 = true;
 
 	if (purpose) {
 		debug_putstr(purpose);
@@ -66,24 +65,13 @@ unsigned long kaslr_get_random_long(const char *purpose)
 			debug_putstr(" RDRAND");
 		if (rdrand_long(&raw)) {
 			random ^= raw;
-			use_i8254 = false;
 		}
 	}
 
-	if (has_cpuflag(X86_FEATURE_TSC)) {
-		if (purpose)
-			debug_putstr(" RDTSC");
-		raw = rdtsc();
-
-		random ^= raw;
-		use_i8254 = false;
-	}
-
-	if (use_i8254) {
-		if (purpose)
-			debug_putstr(" i8254");
-		random ^= i8254();
-	}
+	if (purpose)
+		debug_putstr(" RDTSC");
+	raw = rdtsc();
+	random ^= raw;
 
 	/* Circular multiply for better bit diffusion */
 	asm(_ASM_MUL "%3"
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index d62c14334b35..604fdc941468 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -541,8 +541,6 @@ static void __init xen_time_init(void)
 	xen_read_wallclock(&tp);
 	do_settimeofday64(&tp);
 
-	setup_force_cpu_cap(X86_FEATURE_TSC);
-
 	/*
 	 * We check ahead on the primary time info if this
 	 * bit is supported hence speeding up Xen clocksource.
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 3d6b2264164a..3551a83ef90b 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -947,7 +947,7 @@ int igc_ptp_hwtstamp_get(struct net_device *netdev,
  */
 static bool igc_is_crosststamp_supported(struct igc_adapter *adapter)
 {
-	if (!IS_ENABLED(CONFIG_X86_TSC))
+	if (!IS_ENABLED(CONFIG_X86))
 		return false;
 
 	/* FIXME: it was noticed that enabling support for PCIe PTM in
@@ -965,7 +965,7 @@ static bool igc_is_crosststamp_supported(struct igc_adapter *adapter)
 
 static struct system_counterval_t igc_device_tstamp_to_system(u64 tstamp)
 {
-#if IS_ENABLED(CONFIG_X86_TSC) && !defined(CONFIG_UML)
+#if IS_ENABLED(CONFIG_X86) && !defined(CONFIG_UML)
 	return (struct system_counterval_t) {
 		.cs_id		= CSID_X86_ART,
 		.cycles		= tstamp,
diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index b93640ca08b7..585cf98ae42f 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -133,7 +133,7 @@ config PTP_1588_CLOCK_KVM
 
 config PTP_1588_CLOCK_VMCLOCK
 	tristate "Virtual machine PTP clock"
-	depends on X86_TSC || ARM_ARCH_TIMER
+	depends on X86 || ARM_ARCH_TIMER
 	depends on PTP_1588_CLOCK && ARCH_SUPPORTS_INT128
 	default PTP_1588_CLOCK_KVM
 	help
diff --git a/tools/power/cpupower/debug/kernel/Makefile b/tools/power/cpupower/debug/kernel/Makefile
index 7b5c43684be1..89954bba1453 100644
--- a/tools/power/cpupower/debug/kernel/Makefile
+++ b/tools/power/cpupower/debug/kernel/Makefile
@@ -1,12 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-m	:=
+obj-m	:= cpufreq-test_tsc.o
 
 KDIR	:= /lib/modules/$(shell uname -r)/build
 KMISC   := /lib/modules/$(shell uname -r)/cpufrequtils/
 
-ifeq ("$(CONFIG_X86_TSC)", "y")
-  obj-m	 += cpufreq-test_tsc.o
-endif
 
 default:
 	$(MAKE) -C $(KDIR) M=$(CURDIR)
-- 
2.39.5


