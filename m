Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722AD60726FA
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sgOE+VDG;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y64WzQMC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=HqwjPpKwvqB3f2lQ/WiqvfGq81Ovob3JwxDhZbOpv7k=; b=sgOE+VDGQnjGc1
	f0PeehjH27QJPzHxJrIVVC0ultjrHy3IQeCb8cfpXtzu1QELWsooizxDv+9/Tqgeacr9rHV8GJ0Q0
	Ko3AhX3kvjpb1XhFgkFCx4+7jNhmJfbnfwC+YQUdrv6d4Vp2Cr1sMVv+DXNG0LlaisuFQAU36VnVn
	aA+aF6EWdtrQAPTuXQPFsB/Rnc+fUqpp/0DoVGq6YjYKYTUfeAWdAXTEGWy5aLZbCg6jIxRniS6YF
	4iiSTMnJdsLw5rTVMSO1JA3h1YOtz4M+9/q15vhfeTXSgtHWKyv4xqrHAVy5tD9iEVZpueg6Fojaq
	i7bAQhragb36NizxdVDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0Qk-00000009ea0-3mfD;
	Thu, 05 Nov 2026 16:35:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0QX-00000009eVF-2w64
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 16:35:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0DA0960A7B;
	Thu,  5 Nov 2026 16:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D201F00919;
	Thu,  5 Nov 2026 16:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896500;
	bh=HqwjPpKwvqB3f2lQ/WiqvfGq81Ovob3JwxDhZbOpv7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y64WzQMCoI9Mqf4nNMB4/rcpKnwPNKfTY3B2bJYmxzN2htDIOImXQYNoMof75/QqQ
	 n/s0w3hCgJbgZKYeu0tgjLUDnQPQOZVoscGP4wfHdr74zwmA+k0aOVJkP0XQEF8NLU
	 Koi7ruYhRm6F2Cbhw6oEc9rKkHblnv7ZzN+4usm9XJtVxq0V2gNzwdxC+2WMnxdCvS
	 aLtZbWnXf8OFYRuNUR+ic8bTa53ec1Ta3J9NBHs9H7XVCZH5E8PfxhHMcMZxDBo8gu
	 ol7Dzar357+p6ueIHIXFDuKfafrX/iN8F3+erG1U73fp4knh2NqmIiX/Io8kmujRbu
	 n0KRNBCdombOg==
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
Subject: [PATCH 2/7] x86: make TSC usage unconditional
Date: Thu,  5 Nov 2026 17:34:33 +0100
Message-ID: <20261105163440.2381661-3-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105163440.2381661-1-arnd@kernel.org>
References: <20261105163440.2381661-1-arnd@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 arch/x86/Kconfig.cpu                       |  3 ---
 arch/x86/events/msr.c                      |  5 -----
 arch/x86/include/asm/timex.h               |  2 --
 arch/x86/include/asm/tsc.h                 |  2 --
 arch/x86/kernel/apic/apic.c                | 23 +++++++++-------------
 arch/x86/kernel/apic/io_apic.c             | 22 +--------------------
 arch/x86/kernel/cpu/centaur.c              |  2 --
 arch/x86/kernel/cpu/common.c               |  4 +---
 arch/x86/kernel/cpu/proc.c                 | 15 ++++++--------
 arch/x86/kernel/i8253.c                    |  3 ---
 arch/x86/kernel/tsc.c                      | 16 ++-------------
 arch/x86/lib/kaslr.c                       | 20 ++++---------------
 arch/x86/xen/time.c                        |  2 --
 drivers/net/ethernet/intel/igc/igc_ptp.c   |  4 ++--
 drivers/ptp/Kconfig                        |  2 +-
 tools/power/cpupower/debug/kernel/Makefile |  5 +----
 17 files changed, 27 insertions(+), 104 deletions(-)

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
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 5b67a4567434..f2c1f544f5f9 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -270,9 +270,6 @@ config X86_USE_PPRO_CHECKSUM
 	def_bool y
 	depends on MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MGEODE_LX || MATOM
 
-config X86_TSC
-	def_bool y
-
 config X86_HAVE_PAE
 	def_bool y
 	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC7 || MATOM || X86_64
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
index f397072cf294..a4770765b34d 100644
--- a/arch/x86/include/asm/timex.h
+++ b/arch/x86/include/asm/timex.h
@@ -7,8 +7,6 @@
 
 static inline unsigned long random_get_entropy(void)
 {
-	if (!cpu_feature_enabled(X86_FEATURE_TSC))
-		return random_get_entropy_fallback();
 	return rdtsc();
 }
 #define random_get_entropy random_get_entropy
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 4d2d2f21ff06..88d9d2a22152 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -76,8 +76,6 @@ extern void disable_TSC(void);
 
 static inline cycles_t get_cycles(void)
 {
-	if (!cpu_feature_enabled(X86_FEATURE_TSC))
-		return 0;
 	return rdtsc();
 }
 #define get_cycles get_cycles
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 90025451ace2..31c890618762 100644
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
index 7d7175d01228..b3c5ff599fda 100644
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
index 513fa1f640f9..f66ca8335af9 100644
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
index 9bd50c68cd7e..355bcbfdf2dd 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2478,9 +2478,7 @@ void cpu_init(void)
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
index 0b991035f127..0c91426e4a08 100644
--- a/arch/x86/kernel/i8253.c
+++ b/arch/x86/kernel/i8253.c
@@ -31,9 +31,6 @@ struct clock_event_device *global_clock_event;
  */
 static bool __init use_pit(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_TSC))
-		return true;
-
 	/* This also returns true when APIC is disabled */
 	return apic_needs_pit();
 }
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 723347e2cf7f..02269dcbde1f 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -929,9 +929,6 @@ void recalibrate_cpu_khz(void)
 #ifndef CONFIG_SMP
 	unsigned long cpu_khz_old = cpu_khz;
 
-	if (!boot_cpu_has(X86_FEATURE_TSC))
-		return;
-
 	cpu_khz = x86_platform.calibrate_cpu();
 	tsc_khz = x86_platform.calibrate_tsc();
 	if (tsc_khz == 0)
@@ -1046,8 +1043,6 @@ static struct notifier_block time_cpufreq_notifier_block = {
 
 static int __init cpufreq_register_tsc_scaling(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_TSC))
-		return 0;
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC))
 		return 0;
 	cpufreq_register_notifier(&time_cpufreq_notifier_block,
@@ -1253,7 +1248,7 @@ static void __init check_system_tsc_reliable(void)
  */
 int unsynchronized_tsc(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_TSC) || tsc_unstable)
+	if (tsc_unstable)
 		return 1;
 
 #ifdef CONFIG_SMP
@@ -1403,7 +1398,7 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 
 static int __init init_tsc_clocksource(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_TSC) || !tsc_khz)
+	if (!tsc_khz)
 		return 0;
 
 	if (tsc_unstable) {
@@ -1502,8 +1497,6 @@ static void __init tsc_enable_sched_clock(void)
 
 void __init tsc_early_init(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_TSC))
-		return;
 	/* Don't change UV TSC multi-chassis synchronization */
 	if (is_early_uv_system())
 		return;
@@ -1517,11 +1510,6 @@ void __init tsc_early_init(void)
 
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
index 5c7822254a01..b29c94bfce35 100644
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
index b40aba9ab685..3736bd800a5d 100644
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
index feb50f8cc406..52845a1de7fa 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -134,7 +134,7 @@ config PTP_1588_CLOCK_KVM
 
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
2.53.0


