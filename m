Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F447606A320
	for <linux-um@archiver.kernel.org>; Sun, 22 Nov 2026 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LsKOGgzZ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DkcBzbAz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:References:In-Reply-To:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2V/0fd1siYsqZb7sTLwiFsPw4FvEFu9uXU8LFcj2RFo=; b=LsKOGgzZm+XdlTn5DoD3hZbXh0
	d3Dd0qLLC0ckXIuaOYcI1m5pS38ZIQIi4fDP/bOzp68WdAXjNvwSyYOOWbIHpDPKPW1kzPRJiDJQc
	N1hOOAe/dp6Vi5Vmh1WdTgpg64OIRzus40xeDPsRfdjCxEwVJpOxEgQhpUZURvhqRQ0qI41X7sJ6M
	rGTQYJgBJUlLza71owtqwPEZ/fdsxiWWkWtlk4jLHYWqikakz69+3C4mFs35FuU0wwYOop4BZ0Dsx
	+RDbY3fMmvmnTvGJVGj4KbrZIVvF6YNmsIKTiO96uE6a4J7TKF14qtTwkCeqBgMYvT8VRiMFHbJoh
	0LlnZw0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV7pe-000000019Rn-3bvo;
	Sun, 22 Nov 2026 13:42:14 +0000
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV7pc-000000019RS-0B8I
	for linux-um@lists.infradead.org;
	Sun, 22 Nov 2026 13:42:13 +0000
Received: by mail-yx1-xb12c.google.com with SMTP id 956f58d0204a3-67dae7d3f7dso2932451d50.2
        for <linux-um@lists.infradead.org>; Sun, 22 Nov 2026 05:42:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795354931; cv=none;
        d=google.com; s=arc-20260327;
        b=r5n4wZl7XsMWwNtyvsfxq4N7mShjFZrKwK466APJWmDoqAkHewY5SZPFnSCxKJRCUT
         8zM6sJNSC0OoiBB8nk/NQtqRptaD/OSQnZkpbab/kZ0GySiIokza0MAM7m3lK7zt4h42
         5H+GtchPwTyPGN6PmLjCeGPDSRDsSEvpSHhL2H94EgQSF5NAPJEDgbKDwZxsSm2GJ1Qe
         y3oNHofx3lNT1280ni6SWyWrZ/6WOJ7m9O2DA+aaME4VE8DzExqu0iIjv54pTWQYD/vg
         ZJsioFpwtb8JO37HiSglYPxT4cf/SMMVqF66BKiHBIPVGcV+oByCE66dHHewUBGnVg8c
         ZHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=2V/0fd1siYsqZb7sTLwiFsPw4FvEFu9uXU8LFcj2RFo=;
        fh=/gBKL856m721509318RIdz8U4fuFWBADYUOnmaP+UV8=;
        b=kWMPNkXyntS0ZCRY8Ra2+/Yw1+puKDaOabbLFsO3sE8+lKlxKfEDtkYa+o+czCpeFi
         qiV797xD31WW5pcp3jpaNqA+4Qx7gE3eObEcuk+4cNlOVeUfRXIymJh9Jgzltv19GRG1
         FaqNgvcoJWvcF/LvXXgqD6kKGd/4T1eVlxq1hevU8VvW1NgduWsPFUlGTBSAWrMLFqNE
         6k3UUNTaZ/gmYPd42B9OsXkuU0iES+ASCJynW74mb6erbLKzNoEHYBTeNzi/aPMQeZRP
         XUXm1budsmt/KSUrwIPueNv1bXFycjRzpfEx7G4PihIvJeIVxvoTCGd+0TC4Z/DbiJL5
         2C6g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795354931; x=1795959731; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2V/0fd1siYsqZb7sTLwiFsPw4FvEFu9uXU8LFcj2RFo=;
        b=DkcBzbAzFylIALUl7w0XYN5SRiEfzVqNQvcYRSbesiUrKFFUIvn1OB7vMMBS7JusCO
         T2oyIOVAx08F3oALGnp+/fk1QhBnfTITuc3VbRojxBc9mvMkxTA9nTfq+GYk6t5mAM+n
         y5LYT0EiTUo9WDiLyLemelHdS11jTaz+/WGsJoIMNsmv+EFx0n2QRG87NEIfxVyFAJz7
         ggGO8cBojGYh4duhKX9hSrD8HHpE6DNqTWNcNkzhyxE/0CVd9V2Wnc79rlZhCUAq4Cio
         Oc08NI+xq3UVqeMVodnZRdXZ1+8FBc3UM9A0OCXAQrxf/g5BI8UT2daLZage8sE9WuBA
         txYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795354931; x=1795959731;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2V/0fd1siYsqZb7sTLwiFsPw4FvEFu9uXU8LFcj2RFo=;
        b=x1qsaRvluRRvMvXc88waxX/TkIb/HP5CoB9fjTtj5sMOeWMjEKym8ZnK+UQBwsLeYT
         GNGGZOrhrJkaZwqJOtvwoT7iNDtkTZQmq/sxGaHBD/awNl16bG34XlX9cV6ot16l1mvq
         wnt+SflyxIAU2s4I8GRgBjdhpnjMWR/cjFCZApZ7azRSDWYqIlhpav4a7rwRlewOQFVW
         xY4jVmiQ97NerxvXfP26dw6TKxv4iU+lDXaoj0QsBrgL6f4fT3R5RfPLgPWrV+Zt9cLw
         7QQal481jVgcODgRpl997S6C2Lx2wxfbUcz4SwBKZ97GTDPsKJDnFvEstR/msjuc3owZ
         CYKg==
X-Gm-Message-State: APuU4Z++iGmRQ6GA3UUnDgdFbedhM5JpcZ/MHRm4jQHuyCoVOatHbJ1C
	67td3uF2hF4+ZJPPA8PHLhZ/Y7NpPWT0vxpjbxzx+yzkYjFe8wDf0SHGaUdTynoo4vIvNir2HFh
	tbVJ2H6LtWS/k9kKyOdPWxoodSI2HjxdkD3/XY08=
X-Gm-Gg: AZFdTZdLhbzrZ4ie7wWrdQIvyALGK4SI7BJC7nDlIDHlLS2SCx9lPiQ+F4xQrvP4lm1
	VtceNqS4mvcpmOrHu/jfrUzb9sNmgh2yoDa7ns4ljf3acJMnCS7zOgANYPE/FBKznmKNK0wsQnK
	9BjVuHO15Kd9qWcT/ewyoXnW0rUOjTKKBGNPVvOx6S6VFzesw/eukwlTh5AfJ/EW5C6q1OUsxhm
	UpBM1L/zkn2o10/KzK4XBeOTrmg+3pjp3ww9pP/zFtgaoJEu5MDF1XmXnhHVWEfcgXqe597kU59
	wEpw7cf9dTYc5CzTq+y27jJcEiPpz/pG9zC4xM2HFloNZFEqCGjH7IsENvmLPJj38u4ilIPFocl
	KunZo+ZvaNext0cQg8VL/ke/XLYBjjXnU6tpG1Q==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:690e:4085:b0:67c:1171:4fab with SMTP id
 956f58d0204a3-67df43f326dmr2505021d50.43.1795354930595; Sun, 22 Nov 2026
 05:42:10 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 22 Nov 2026 13:42:09 +0000
In-Reply-To: <CAB2K5aBaXG7Jhi+0UyVfpGan+5XXch5zOg3tM3=kqnO1+8F=fA@mail.gmail.com>
References: <CAB2K5aBaXG7Jhi+0UyVfpGan+5XXch5zOg3tM3=kqnO1+8F=fA@mail.gmail.com>
From: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
Date: Sun, 22 Nov 2026 13:42:09 +0000
X-Gm-Features: Aa3M54pTY2TICUSm0DhXGxQZCEAFVwGcebxKkhkxRV8xj18R2N7npL5PSd9hXxs
Message-ID: <CAB2K5aBm_UXWkfYadSB3iEdyf716auT0H2VtwdvG7g4-mudCZA@mail.gmail.com>
Subject: [PATCH 1/5] um: vdso: add shadow headers for the vDSO build
To: linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261122_054212_137505_82AE9BCC 
X-CRM114-Status: GOOD (  23.90  )
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
 arch/x86/um/asm/vdso/gettimeofday.h | 173 ++++++++++++++++++++++++++++
 arch/x86/um/asm/vdso/processor.h    |  40 +++++++
 arch/x86/um/asm/vdso/vsyscall.h     |  25 ++++
 4 files changed, 252 insertions(+)
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
index 000000000..a0a404fe0
--- /dev/null
+++ b/arch/x86/um/asm/vdso/gettimeofday.h
@@ -0,0 +1,173 @@
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
u64 cycles, u64 base)
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

