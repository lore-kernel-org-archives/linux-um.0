Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E99606A33D
	for <linux-um@archiver.kernel.org>; Sun, 22 Nov 2026 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NFSvb1WD;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AlNEa0Db
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:References:In-Reply-To:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eH0M+8NvuxBSBlMVF4+JtsOKPKxz/81HcwidWOKXTCs=; b=NFSvb1WD8a6abdsBZqHEsPqEhv
	wclLzyhwiyzqzbwv8+nROtOwm+k1G2Cx2taMa0S7XZx5hZgz/oazHSlnL4PAeUGoDHTeGDIoR+PWN
	TOM9M1fAxmBRb1waX0UiuNvohVIcXzaaxZBh7YcEN+ANtqNsJPCS2EpoUsAW+HJMwW/s8I1qMT++S
	Vdou4yCjlNeUsWakQax4gW61oTh5vQWCMJGOz9praM9+bg61j3H4VDm1oSMP59Tey5jPvFUNLkmWX
	ZLrt0GKYPjOQutb4uX80PSgzallfqMC/FYlYGLKkqruS837ubMcpLPA4LywaMAJD5x6wqFgYHWeSm
	sR8XiXVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV7pw-000000019Ws-0QmN;
	Sun, 22 Nov 2026 13:42:32 +0000
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV7pq-000000019UP-4A8o
	for linux-um@lists.infradead.org;
	Sun, 22 Nov 2026 13:42:29 +0000
Received: by mail-yx1-xb132.google.com with SMTP id 956f58d0204a3-67dae7d3f7dso2932573d50.2
        for <linux-um@lists.infradead.org>; Sun, 22 Nov 2026 05:42:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795354946; cv=none;
        d=google.com; s=arc-20260327;
        b=cNlPmMtNkQTP2vulXU7pvs65HkB5ryqUksUkIlWPMp2gYo2dSmy1Pct/pW3NMpjaUR
         Ir4WnaanK2owRHFZ4YSk1Xukne1DWT4i/BWbZo/5Y5XA5207ooAJ99CL+3TQOTabwMvt
         NnzIvTUGuRlQEqB/m2jymmiZBnE0X/J0rF0Zp3PcctManjaE6CkfR7dw5VUn4uNxgF/v
         EyWbGz2aNUIQaZwR3k91ajyTVDEQndipTqd4xOLm92lSTh8EHW9QW6aFE+nHsHlqsDfB
         lzVP7DMAMK+g1R+AzGSqYhe0P+/945UmVzWB3qxjDlwdVR7h5FUbbl13OIsTfYaXLwJq
         3crQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=eH0M+8NvuxBSBlMVF4+JtsOKPKxz/81HcwidWOKXTCs=;
        fh=/gBKL856m721509318RIdz8U4fuFWBADYUOnmaP+UV8=;
        b=Pq1YhqNeC1kXmF3B437hEIsK/jdHMMk4uLQquhpZPY4kpoKZhVuh5rxVFXchUnI7p3
         TeGudizyXDrymgpTADrWSelLOOG+MMEb+rYuJTp1BRuU/88wyY0Q33AJ9h9V7/1MB3Q9
         GVt8EDhRoI+wusRwBQqdXtVeCzXulwKPNRzH8nkzZtuwHyZvFyFxHfln29z1P0jW8Mcx
         BXXsKnwrO4+ibeD0GklARAp9nT2MAlfYN/FTvso4fliSoCej9yG6yM1AN3ryWENjv5Zk
         4T2CckPBICJkNh0OiH8EfYrhD56yXiKW9ARExplq883FhRxZ8xSbGUtCfWgeCP0ql5QV
         s92Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795354946; x=1795959746; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eH0M+8NvuxBSBlMVF4+JtsOKPKxz/81HcwidWOKXTCs=;
        b=AlNEa0Dbrmj4pMS+sN33SlxGAyEhzNqmwimA+n7hB1R5byAM+sTTxlXl0/91se3Htn
         5SeHgwfy9yGDBo8BIRQBgpf7qlsyinZU6vLAvfikY17qam5sqj1KPkazpY/6q5K9h+m+
         ND8P0Efof67XOF5yz5VlcAclXVMhdfWRo3HMW5j2tMbuFQzuopdtFr9ql2nnPLFOKKn5
         wFo1dms3wAGHYq391sBdczzEs5T0JmtY3WWi3vj5bhF1O/OT65uoCMf/rtOFTvArHCJQ
         2WIg5fqzs3UCX2zPnd80bZFi4b9EjhAAYnGSkcfMtzV16qEkVZAOj+r0ss3iwY0UPkfR
         QXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795354946; x=1795959746;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eH0M+8NvuxBSBlMVF4+JtsOKPKxz/81HcwidWOKXTCs=;
        b=WoUIIM2bHYJx1a1PE0BBXv1qMcEyb5K9VTZnrTQGtVl6nrwBwnesBsD9gYAmYaBzhW
         /u0rp6ariBt6ylpC26pSFffMmnaBQsb3wZpIvHTiXOPmDsHEs/unEZrHa+D+H1lq+rX7
         kWUxj19kbrECrDqCJZxohj5PnRUWCw1bt+w2REbC/q15NvLQ7+joeCjXxyZviNL8pXCD
         aEjMYBLBnvwKvq6+ljqQu78GrdTvkwl1BXZYAstlVZ7ttxj9XzZZw3n0QGKyp0F2tBQK
         /Q9uzoFW96IgiZvB92VzarNilM4eWVAHlTcQHHkxxpy7OZZPt2OMaeqWLk30ejCsyNi6
         mR2Q==
X-Gm-Message-State: APuU4Z+fwPfllNVV+BbXwNFkqa7IZcHV83ccxmZsX09Bf+gZTl5wytgF
	1iJTnA3rlzsWcbohrYgHOks5DxA+PVmQ0s/7zZu3BoB03PLqUHqgme/M/l+luKRyDu4dNRcxSi0
	jJYUiCgcZ0vI0gQYLiMosg6QsPGdMkwc+i1obDQY=
X-Gm-Gg: AZFdTZcZX04wQYuyASrM2ICf5Dp1qGEW2yswtj8AkdBymcH4lsKPfQOHwE4FDYcfuHW
	Yt/WLL6cYZX7sqk+4PWWG84zF+Mq8QudQpHxjn8YuCD5tiwoAm+LoMasT0WqUEIIFy45ku1s6AK
	A8ceLdIQecsTfv6EmrqpIcOFfYEdI9x6VaLv3PmKu1wQTNmDP23yZA38dfZitcj4h/7xg2AkpsS
	YunAkL7aPLSb5y/RZb1l6+fsx1lPOEdi37eC2C7Kz6j1qFWZsGIWNhC5btwR0opBuptexbb8Q68
	C1g6J85YwPp1wMUD62wTkdjkIlXk80wN65uUul50arNvFrtEE25tY+o6X0HW31Bqfvppd/SuCgr
	mmVOdyuXII33qYRqBKImmKVAissL0r0z1Vx8=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:690e:d5b:b0:67c:cd5:f5a3 with SMTP id
 956f58d0204a3-67df447a918mr2221873d50.109.1795354945547; Sun, 22 Nov 2026
 05:42:25 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 22 Nov 2026 07:42:25 -0600
In-Reply-To: <CAB2K5aBaXG7Jhi+0UyVfpGan+5XXch5zOg3tM3=kqnO1+8F=fA@mail.gmail.com>
References: <CAB2K5aBaXG7Jhi+0UyVfpGan+5XXch5zOg3tM3=kqnO1+8F=fA@mail.gmail.com>
From: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
Date: Sun, 22 Nov 2026 07:42:25 -0600
X-Gm-Features: Aa3M54pQ1v5R83BQ9gTRhv1wrg6RY95T6RmdeLIsMO7kdWRfadLOr0zny01bbno
Message-ID: <CAB2K5aAw7FOAabNZKNV2=dWO9G0wL5OBQrs0oSjGKGwP7jgY5Q@mail.gmail.com>
Subject: [PATCH 3/5] um: time: use the host TSC as clocksource for the vDSO
To: linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261122_054228_541196_1F64F03D 
X-CRM114-Status: GOOD (  16.67  )
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

Calibrate the host TSC at boot (best-of-5 median over 100 ms
windows against os_nsecs()) and switch the timekeeper clocksource
from os_nsecs() to the raw TSC when calibration succeeds, setting
vdso_clock_mode to VDSO_CLOCKMODE_TSC so the generic vDSO can
interpolate time in userspace.  On calibration failure (or under
time-travel) the old os_nsecs() clocksource is kept and the vDSO
falls back to syscalls.  Measured: clock_gettime() median 70 ns
in the guest (80 ns in the boot where the syscall baseline was
measured) vs 36,535 ns via the raw syscall: about 457x faster
same-boot, about 520x at the typical median.

Signed-off-by: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
---
 arch/um/kernel/time.c | 98 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index d620b6d63..87d86e437 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -881,6 +881,80 @@ static irqreturn_t um_timer(int irq, void *dev)
 	return IRQ_HANDLED;
 }

+/*
+ * TSC-based clocksource.
+ *
+ * The guest userspace can read the host TSC with RDTSC without a trap
+ * (verified by measurement in the guest: no fault, 0 monotonic
+ * decreases, skew p50 ~100 ns), so the timekeeper clocksource is
+ * switched from os_nsecs()/256 to the raw TSC. update_vsyscall()
+ * then publishes cycle_last/mult/shift for this clocksource into the
+ * vvar, and the generic vDSO interpolates the time from the TSC in
+ * userspace.
+ *
+ * The TSC frequency is calibrated at boot against os_nsecs() (host
+ * CLOCK_MONOTONIC). If calibration fails or time-travel is active,
+ * um_tsc_ok stays false and the old os_nsecs() clocksource is kept,
+ * with vdso_clock_mode NONE so the vDSO falls back to syscalls.
+ */
+static __always_inline u64 um_rdtsc(void)
+{
+	u32 lo, hi;
+
+	asm volatile("rdtsc" : "=a" (lo), "=d" (hi));
+	return ((u64)hi << 32) | lo;
+}
+
+static bool um_tsc_ok;
+static u64 um_tsc_hz;
+
+#define UM_TSC_CAL_ROUNDS	5
+#define UM_TSC_CAL_NS		100000000ULL /* 100 ms per round */
+
+static u64 __init um_calibrate_tsc(void)
+{
+	u64 freq[UM_TSC_CAL_ROUNDS];
+	u64 tmp;
+	int i, j;
+
+	if (time_travel_mode != TT_MODE_OFF)
+		return 0;
+
+	for (i = 0; i < UM_TSC_CAL_ROUNDS; i++) {
+		long long t0, t1;
+		u64 c0, c1;
+
+		t0 = os_nsecs();
+		c0 = um_rdtsc();
+		do {
+			t1 = os_nsecs();
+		} while (t1 - t0 < (long long)UM_TSC_CAL_NS);
+		c1 = um_rdtsc();
+		/* t1 is read after c1; the endpoint skew (~one os_nsecs()
+		 * call, < 1 us) is negligible over a 100 ms window.
+		 */
+		if (t1 <= t0 || c1 <= c0)
+			return 0;
+		freq[i] = (c1 - c0) * NSEC_PER_SEC / (u64)(t1 - t0);
+	}
+
+	/* Median of the rounds (robust against one jittered round). */
+	for (i = 0; i < UM_TSC_CAL_ROUNDS; i++)
+		for (j = i + 1; j < UM_TSC_CAL_ROUNDS; j++)
+			if (freq[j] < freq[i]) {
+				tmp = freq[i];
+				freq[i] = freq[j];
+				freq[j] = tmp;
+			}
+
+	/* Sanity: a plausible TSC rate (100 MHz .. 4 GHz, fits u32 Hz). */
+	if (freq[UM_TSC_CAL_ROUNDS / 2] < 100000000ULL ||
+	    freq[UM_TSC_CAL_ROUNDS / 2] > 4000000000ULL)
+		return 0;
+
+	return freq[UM_TSC_CAL_ROUNDS / 2];
+}
+
 static u64 timer_read(struct clocksource *cs)
 {
 	if (time_travel_mode != TT_MODE_OFF) {
@@ -902,6 +976,9 @@ static u64 timer_read(struct clocksource *cs)
 		return time_travel_time / TIMER_MULTIPLIER;
 	}

+	if (um_tsc_ok)
+		return um_rdtsc();
+
 	return os_nsecs() / TIMER_MULTIPLIER;
 }

@@ -945,11 +1022,30 @@ static void __init um_timer_init(void)
 		return;
 	}

-	err = clocksource_register_hz(&timer_clocksource,
NSEC_PER_SEC/TIMER_MULTIPLIER);
+	/*
+	 * Calibrate the TSC before registering the clocksource, so the
+	 * timekeeper (and the vDSO) use the TSC rate from the first tick.
+	 * On failure keep the old os_nsecs() clocksource: timer_read()
+	 * falls back to it and vdso_clock_mode stays NONE.
+	 */
+	um_tsc_hz = um_calibrate_tsc();
+	if (um_tsc_hz) {
+		um_tsc_ok = true;
+		timer_clocksource.name = "tsc";
+		timer_clocksource.vdso_clock_mode = VDSO_CLOCKMODE_TSC;
+		pr_info("UML: TSC clocksource, frequency %llu Hz\n", um_tsc_hz);
+		err = clocksource_register_hz(&timer_clocksource,
+					      (u32)um_tsc_hz);
+	} else {
+		pr_info("UML: TSC calibration failed, keeping os_nsecs() (no vDSO)\n");
+		err = clocksource_register_hz(&timer_clocksource,
+					      NSEC_PER_SEC / TIMER_MULTIPLIER);
+	}
 	if (err) {
 		printk(KERN_ERR "clocksource_register_hz returned %d\n", err);
 		return;
 	}
+
 }

 void read_persistent_clock64(struct timespec64 *ts)
-- 
2.43.0

