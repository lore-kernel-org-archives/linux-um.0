Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B508606A31E
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1OCUU3Zk;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ByhYnYeR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=x8WuQiUp2yIxvd1qv9fjDlhCkSO2E2h3O8HwzxZH9K4=; b=1OCUU3ZkUui62fbIplf3C6tLzX
	XOCg5VhY0ErZbzvqGJxj6V2jXLIRlPRhES0sBny7tuunhVF9m6NqTpliOxV5+5R5L0dNaTf/P+EGm
	0w6Pw+VsrO6CS1yyk7/s7jxkRbuiOAUI4C/25mLV0ptXcGZViJR1j+a31VfWD2fp1PvneBQcZ3SwL
	i+O90MpS4Tzl3hf2+aF4TumsJKOKFSlScAdvPzGJZaTbwlPtr4UET/1Rc6cAFbTbaT8Myd+R4UpHU
	nBjMGn7ZCX2ekzDvv9TFkVagNeCR2TTWH08v20hXYNmBwEL8arr0ArKYELPkdpit9ir8W8faW8muC
	5NeJ0Xyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9Rw-00000009KlX-3k0b;
	Wed, 25 Nov 2026 09:38:00 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9RY-00000009KZZ-3uAm
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 09:37:43 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-55d2dcbb905so30429451cf.3
        for <linux-um@lists.infradead.org>; Wed, 25 Nov 2026 01:37:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795599456; cv=none;
        d=google.com; s=arc-20260327;
        b=K14KbsJbc9S6pE3TGN116fgbrVHgrZtyCA9caYt9PzbLhtBQvXdccRt+NE0hZhBCMV
         8944tcduDebN1lFrGtq3un4yUBiTYuRC3K+4BqVx/a7x1rH7zvRt2FFnODAgwulpcBLP
         0+atOnOYuhjXEMo7479A0zcgEgX7daucATT03CYfl1iQ5SM15R0BwSYKJz4g2ECK9L72
         yfhVo1Wko0I4CNT4HOxST+vsrHqfU7Pkhi028z7yj8Tq+h2y/+1yl+UEa1jKkU4FFLJz
         8tPae1IScEgjWvilgV6va4RaOdtjxSbBn62UPKu1mAru4rOstr39ITY67RcyOO0s0IMw
         EiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=x8WuQiUp2yIxvd1qv9fjDlhCkSO2E2h3O8HwzxZH9K4=;
        fh=/gBKL856m721509318RIdz8U4fuFWBADYUOnmaP+UV8=;
        b=r8Hoze7SPwKf+GDkZXKWD1TEkgxZbJl2ZRVrqVtwY5nIky91ZQpBE7wW81yf1ioMD8
         feXpFKQyk9lbAVNTXHGr+AOiJ2MFzfd4TIjzG1u6PaQbM9LGyeSTCXRYlxB0nAeIFXGY
         e8Sf7oTUdEVUjYerTqm3qwIUM3MSQZ8MaxEYYAam+tdbEzfzzrC06okuD+lVI6TddcQm
         CJ/I7skJpZEoXVfRcB3W9hD8QJ6a/l4QkDg//LIPoYaNgG6rBzvVpO1m0BF24xTaOACQ
         PwlO+iCBf3dkX8f7qAL6I6qGKhkNeYrCmevf68PtZlAF3+79ZBWs6/2wWi/H/ZWe2Hb+
         dYkA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795599456; x=1796204256; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x8WuQiUp2yIxvd1qv9fjDlhCkSO2E2h3O8HwzxZH9K4=;
        b=ByhYnYeR+Edb9s09YjX2UWAd2gu3JZ4Km8p72h4CFwrv6UkrIZrIDqPf3xEmctnYlr
         NPUjXiwkKubKppC6mC8z15doUymQ5flu36xRA5ifCsED3P2o3J9tfIYghAo0p+MbvFBk
         32iFWJBUF0Mo514YAdsDZhz1u5ohrA2g4o44G1Mj52IHjCiYOAnXPv1Y7xBOmGKokDTN
         q/H8b3znbaEenwI0+P+XT3sTD2CR0VeHshscpluJeUCSgR/ErxOEwKVJs7q4wn6QeF19
         yy110/rTjuibsWmGZU7UYeoQZK7lnhhK0kUSKenWsS1mtmZZoCap3+f8IHuoa5hNIauf
         bcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599456; x=1796204256;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x8WuQiUp2yIxvd1qv9fjDlhCkSO2E2h3O8HwzxZH9K4=;
        b=pgqbEHx6D4XFdOW5uB48JfSZUfNRkT7KMXf4XxYMGDi2WrMXBTO6G4xoYvkAHv0MxZ
         GkdUxEseYc6pR9ci2t4HDEerX/XBk/uWk80BfM93QpzB6BMau4LYeLFU+T/ZBrcSnegS
         Rc6UefTDTMyogYSxfOGbfKbE2TGiXwl9x3UY2F+M6dyb08zzodZju/dLReYTSKROT86F
         /Slc8HSB/Il9efk/Ohsy0pKXKXDP3B8VEfZ6z+KMEDMicvxPjNFO/9sBJRWLt8wOFjo7
         SoWFhfRA5I7sN61PQdXY7EXUebZ1QFqokSsb02HTLsuisdsGEXodP5RlDuCbMMBlaaSb
         pDvw==
X-Gm-Message-State: APuU4Z/ChRDt/v/fbjai41kd3Z+/a8NvJMkyEf5bSAqAknrt7lEXnkBq
	h3/QvlqcOBB9lQmCbrmvuZiDZq1X4Cz1fXUoLeyI7glHpcft8nuNWMABJ57jwNfZ8sBR3jzFzVU
	p9duGqgU/JF18QkDoqenFRiI/GoaBbRMbls12
X-Gm-Gg: AZFdTZel8Ot62o2CnYn0ZeVhV9r1t9OdJttDWzMTRM0xdazejkEFayZEOcBgwBW3gQg
	zH/LsIbMN2DAkiHFwShvCRKLOIPKvzqys9Fiz5JEf1onRLN5ht/mV26J9jcm8ZvrAJSDFB8o7u5
	nhf19NWxQnpOjAqTPrSNLRSfXXlKl/p12DXeWjitXw5nRetyUZanXoO0z1wf7GD2E+Xn2fUrsIj
	8B299lC/7o6HVddkP46EIxd1lvqDClFkhR4NoGRB4y9wgCx3b04uV+v0YLulwVmj9an2MfEbddd
	FA3fnnqFN25btV8gzah9jATBqdDcddpm+F3h27lzyMakYjosS/wCSstwGkDhZDOq23zmu7JDEEk
	+APzoT33vGpodrtqJrLpihm15uio5tAyabl2IzJItr8y7uzif0/JhvgCi
X-Received: by 2002:a05:622a:a0a:b0:535:2314:6280 with SMTP id
 d75a77b69052e-55d76a1d85emr314763841cf.17.1795599455683; Wed, 25 Nov 2026
 01:37:35 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Nov 2026 04:37:34 -0500
From: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
In-Reply-To: <CAB2K5aCdEWKvsCUWeHWR0FDVqQ2263PaDQX8VWnma5pF4HwG8Q@mail.gmail.com>
References: <CAB2K5aCdEWKvsCUWeHWR0FDVqQ2263PaDQX8VWnma5pF4HwG8Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Nov 2026 04:37:34 -0500
X-Gm-Features: Aa3M54rSXBCx4HAQWnVx8u33pAObd2W28KeZfViXUVGDbexm848aBoisaN68RT0
Message-ID: <CAB2K5aDK_RDGtRn10to2UMa0skU_L=itc3MbAkBXGQP7fiiB1Q@mail.gmail.com>
Subject: [PATCH v2 1/5] um: vdso: add shadow headers for the vDSO build
To: linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_013737_102676_15A551C9 
X-CRM114-Status: GOOD (  25.24  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The generic vDSO build needs asm/vdso headers that UML cannot
reuse verbatim from x86, so add shadow copies active only with
-DBUILD_VDSO:
- gettimeofday.h: rdtsc_ordered() as plain "lfence; rdtsc",
  because the x86 ALTERNATIVE patching machinery is not available
  in the UML vDSO build;
- processor.h: avoid redefining cpu_relax, which UML already
  defines with its time-travel handling;
- clocksource.h, vsyscall.h: minimal shims for the vDSO build.
These are workarounds for UML build limitations; a cleaner fix
(such as making ALTERNATIVE patching work in the vDSO build) may
be preferred on review.
Signed-off-by: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
---
 arch/x86/um/asm/vdso/clocksource.h  |  14 +++
 arch/x86/um/asm/vdso/gettimeofday.h | 174 ++++++++++++++++++++++++++++
 arch/x86/um/asm/vdso/processor.h    |  40 +++++++
 arch/x86/um/asm/vdso/vsyscall.h     |  25 ++++
 4 files changed, 253 insertions(+)
 create mode 100644 arch/x86/um/asm/vdso/clocksource.h
 create mode 100644 arch/x86/um/asm/vdso/gettimeofday.h
 create mode 100644 arch/x86/um/asm/vdso/processor.h
 create mode 100644 arch/x86/um/asm/vdso/vsyscall.h

diff --git a/arch/x86/um/asm/vdso/clocksource.h
b/arch/x86/um/asm/vdso/clocksource.h
new file mode 100644
index 000000000..2cbfdc454
--- /dev/null
+++ b/arch/x86/um/asm/vdso/clocksource.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSO_CLOCKSOURCE_H
+#define __ASM_VDSO_CLOCKSOURCE_H
+
+/*
+ * UML vDSO clocksource modes (shadow of arch/x86/include/asm/vdso/
+ * clocksource.h, picked up first via -I arch/x86/um).
+ *
+ * The host TSC is the only counter guest userspace can read without a
+ * trap. No pvclock/hvclock pages exist under UML.
+ */
+#define VDSO_ARCH_CLOCKMODES	VDSO_CLOCKMODE_TSC
+
+#endif /* __ASM_VDSO_CLOCKSOURCE_H */
diff --git a/arch/x86/um/asm/vdso/gettimeofday.h
b/arch/x86/um/asm/vdso/gettimeofday.h
new file mode 100644
index 000000000..3f9d3a54a
--- /dev/null
+++ b/arch/x86/um/asm/vdso/gettimeofday.h
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Fast user context implementation of clock_gettime, gettimeofday,
+ * time and clock_getres for UML.
+ *
+ * Shadow of arch/x86/include/asm/vdso/gettimeofday.h (picked up first
+ * via -I arch/x86/um), reduced to what UML needs: TSC only, no
+ * pvclock/hvclock, no getcpu/getrandom. The generic code in
+ * lib/vdso/gettimeofday.c requires this header to provide:
+ * - __arch_get_hw_counter()
+ * - clock_gettime_fallback(), gettimeofday_fallback(),
+ *   clock_getres_fallback()
+ * - vdso_calc_ns() (the x86 TSC variant, which filters small
+ *   negative motion from TSC skew between host CPUs)
+ */
+#ifndef __ASM_VDSO_GETTIMEOFDAY_H
+#define __ASM_VDSO_GETTIMEOFDAY_H
+
+#ifndef __ASSEMBLER__
+
+#include <uapi/linux/time.h>
+#include <asm/unistd.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <vdso/datapage.h>
+#include <vdso/limits.h>
+#include <vdso/math64.h>
+
+#define VDSO_HAS_TIME 1
+
+#define VDSO_HAS_CLOCK_GETRES 1
+
+/*
+ * Ordered TSC read.
+ *
+ * x86's rdtsc_ordered() uses the
+ * ALTERNATIVE patching machinery (lfence;rdtsc vs rdtscp selected at
+ * boot), which is unavailable in the UML vDSO build. The sequence
+ * used here, "lfence; rdtsc", is exactly the ordered variant x86
+ * selects when X86_FEATURE_LFENCE_RDTSC is present, and is the
+ * architecturally recommended ordered read on AMD and Intel. The
+ * "memory" clobber additionally stops the compiler from hoisting
+ * vvar loads above the counter read.
+ */
+static __always_inline u64 um_rdtsc_ordered(void)
+{
+	u32 lo, hi;
+
+	asm volatile("lfence; rdtsc" : "=a" (lo), "=d" (hi) : : "memory");
+	return ((u64)hi << 32) | lo;
+}
+
+static __always_inline
+long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	long ret;
+
+	asm volatile("syscall"
+		     : "=a" (ret)
+		     : "0" (__NR_clock_gettime), "D" (_clkid), "S" (_ts)
+		     : "rcx", "r11", "memory");
+	return ret;
+}
+
+static __always_inline
+long gettimeofday_fallback(struct __kernel_old_timeval *_tv,
+			   struct timezone *_tz)
+{
+	long ret;
+
+	asm volatile("syscall"
+		     : "=a" (ret)
+		     : "0" (__NR_gettimeofday), "D" (_tv), "S" (_tz)
+		     : "rcx", "r11", "memory");
+	return ret;
+}
+
+static __always_inline
+long clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	long ret;
+
+	asm volatile("syscall"
+		     : "=a" (ret)
+		     : "0" (__NR_clock_getres), "D" (_clkid), "S" (_ts)
+		     : "rcx", "r11", "memory");
+	return ret;
+}
+
+static inline u64 __arch_get_hw_counter(s32 clock_mode,
+					const struct vdso_time_data *vd)
+{
+	if (likely(clock_mode == VDSO_CLOCKMODE_TSC))
+		return um_rdtsc_ordered() & S64_MAX;
+	return U64_MAX;
+}
+
+static inline bool arch_vdso_clocksource_ok(const struct vdso_clock *vc)
+{
+	return true;
+}
+
+#define vdso_clocksource_ok arch_vdso_clocksource_ok
+
+/*
+ * Clocksource read value validation: U64_MAX is the invalid marker
+ * for the memory-mapped vclock types, and the x86 variant below uses
+ * the sign bit the same way, so the effective mask is S64_MAX.
+ */
+static inline bool arch_vdso_cycles_ok(u64 cycles)
+{
+	return (s64)cycles >= 0;
+}
+
+#define vdso_cycles_ok arch_vdso_cycles_ok
+
+/*
+ * x86 specific calculation of nanoseconds for the current cycle count
+ * (copied from arch/x86/include/asm/vdso/gettimeofday.h).
+ *
+ * The regular implementation assumes that clocksource reads are
+ * globally monotonic. The TSC can be slightly off across sockets
+ * which can cause the regular delta calculation (@cycles - @last)
+ * to return a huge time jump.
+ *
+ * Therefore it needs to be verified that @cycles are greater than
+ * @vd->cycles_last. If not then use @vd->cycles_last, which is the
+ * base time of the current conversion period.
+ *
+ * This variant also uses a custom mask because while the clocksource
+ * mask of all the VDSO capable clocksources on x86 is U64_MAX, the
+ * above code uses U64_MASK as an exception value, additionally
+ * arch_vdso_cycles_ok() above declares everything with the
+ * MSB/Sign-bit set as invalid. Therefore the effective mask is
+ * S64_MAX.
+ *
+ * Requires CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT (vc->max_cycles).
+ */
+static __always_inline u64 vdso_calc_ns(const struct vdso_clock *vc,
+					u64 cycles, u64 base)
+{
+	u64 delta = cycles - vc->cycle_last;
+
+	/*
+	 * Negative motion and deltas which can cause multiplication
+	 * overflow require special treatment. This check covers both as
+	 * negative motion is guaranteed to be greater than @vc::max_cycles
+	 * due to unsigned comparison.
+	 *
+	 * Due to the MSB/Sign-bit being used as invalid marker (see
+	 * arch_vdso_cycles_ok() above), the effective mask is S64_MAX, but that
+	 * case is also unlikely and will also take the unlikely path here.
+	 */
+	if (unlikely(delta > vc->max_cycles)) {
+		/*
+		 * Due to the above mentioned TSC wobbles, filter out
+		 * negative motion.  Per the above masking, the effective
+		 * sign bit is now bit 62.
+		 */
+		if (delta & (1ULL << 62))
+			return base >> vc->shift;
+
+		/* Handle multiplication overflow gracefully */
+		return mul_u64_u32_add_u64_shr(delta & S64_MAX, vc->mult, base, vc->shift);
+	}
+
+	return ((delta * vc->mult) + base) >> vc->shift;
+}
+
+#define vdso_calc_ns vdso_calc_ns
+
+#endif /* !__ASSEMBLER__ */
+
+#endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/x86/um/asm/vdso/processor.h b/arch/x86/um/asm/vdso/processor.h
new file mode 100644
index 000000000..599835e97
--- /dev/null
+++ b/arch/x86/um/asm/vdso/processor.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Shadow of arch/x86/include/asm/vdso/processor.h (picked up first
+ * via -I arch/x86/um).
+ *
+ * The x86 header defines native_pause()/cpu_relax() for the vDSO.
+ * Under UML those two are already defined by arch/x86/um/asm/
+ * processor.h (with extra time-travel handling in cpu_relax()), so
+ * defining them again kernel-side would be a redefinition error
+ * (kernel/time/vsyscall.c includes <vdso/helpers.h>, which includes
+ * this header, after <asm/processor.h>).
+ *
+ * Therefore the definitions below are only active for the vDSO build
+ * itself (-DBUILD_VDSO, see arch/x86/um/vdso/Makefile), where
+ * <asm/processor.h> is not included. Kernel-side this header is
+ * empty and cpu_relax() keeps coming from <asm/processor.h>.
+ *
+ * Deliberately no __vdso_getcpu declaration: UML exports no getcpu.
+ */
+#ifndef __ASM_VDSO_PROCESSOR_H
+#define __ASM_VDSO_PROCESSOR_H
+
+#ifndef __ASSEMBLER__
+
+#ifdef BUILD_VDSO
+/* PAUSE is a good thing to insert into busy-wait loops. */
+static __always_inline void native_pause(void)
+{
+	asm volatile("pause" ::: "memory");
+}
+
+static __always_inline void cpu_relax(void)
+{
+	native_pause();
+}
+#endif /* BUILD_VDSO */
+
+#endif /* !__ASSEMBLER__ */
+
+#endif /* __ASM_VDSO_PROCESSOR_H */
diff --git a/arch/x86/um/asm/vdso/vsyscall.h b/arch/x86/um/asm/vdso/vsyscall.h
new file mode 100644
index 000000000..da5a12651
--- /dev/null
+++ b/arch/x86/um/asm/vdso/vsyscall.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSO_VSYSCALL_H
+#define __ASM_VDSO_VSYSCALL_H
+
+/*
+ * UML vDSO layout (shadow of arch/x86/include/asm/vdso/vsyscall.h,
+ * picked up first via -I arch/x86/um).
+ *
+ * UML has 4 vvar pages: TIME, TIMENS, RNG, ARCH (see the vdso_pages
+ * enum in include/vdso/datapage.h, with the default 1-page
+ * struct vdso_arch_data). There are no pvclock/hvclock vclock pages,
+ * unlike x86 which uses 6 pages.
+ */
+#define __VDSO_PAGES	4
+
+#ifndef __ASSEMBLER__
+
+#include <vdso/datapage.h>
+
+/* The asm-generic header needs to be included after the definitions above */
+#include <asm-generic/vdso/vsyscall.h>
+
+#endif /* !__ASSEMBLER__ */
+
+#endif /* __ASM_VDSO_VSYSCALL_H */
-- 
2.43.0

