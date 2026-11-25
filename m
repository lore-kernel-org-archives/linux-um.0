Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E1C606A31E
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qkt/hBOl;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JqPPHs/Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OKPuTjPfuPhsiqzz0xTmce8aMCN5FcS6jq6gCBxESqc=; b=qkt/hBOl12DxFguapFpNVAboOE
	KZqoqJRDqDFFQBeOzYRbUsJz23ycW6OIyjMOw8+C/qZiaHCSz/OrKh9U0SNnLCr5bJVXKSfEeRO56
	Q8e8rBghhypnwCQXFA4MiaasEh7F/21s1zLAjMoSA/Hy4wmoOcN3LL7XZRJ1PmJCFztkzCcazgEPV
	FXdGT22dG72QIPC+6jVl8CNENlyewUHsnwUiiSUGP+nNlI0UrOei1FsPBvsTyGnLL0IDvLprriIdQ
	nII9YHtnXVLwDCXprFc8II3nVkjNQkZTjUbxLAOIrBVVG93wZvEBGIDP5rbeCZPhZXrw9yE20IQ3b
	h7mepAEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9S0-00000009Kpj-1g3E;
	Wed, 25 Nov 2026 09:38:04 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9Rv-00000009Kk8-0tPH
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 09:38:02 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-5363316fa0cso58607601cf.3
        for <linux-um@lists.infradead.org>; Wed, 25 Nov 2026 01:37:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795599478; cv=none;
        d=google.com; s=arc-20260327;
        b=bvEw06ClbBAxLk/RB8Ctem46FAKYLiufWDXb6ZSBFzvWpGNusqSFUmzYdQHjLmZRv2
         ugH0eTgEABfQ5W8depMxeX4iXryChicDJRuW3bHidZLYbKVcIqMhHFTv8pRwe7PidBpS
         DW/ykZHMMIyzlcrY5OlfHOmuHNv5LE7V6nv2oOkkXoKX92KjYiye9ZjzfLc3D2zl9iLv
         2Cu4QfWXFeZJI20ALei1Nvq+kRo1Z5eNPQIrucgphfzlh1q2XpPZjYTVd5KCKNqJu5KV
         x+9HJK1mfur8wO90x6d6vzk4uou/M3IDe99xQEVxsEdd6sF5HTej2HGL0v/UqAku6Ieg
         +a1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=OKPuTjPfuPhsiqzz0xTmce8aMCN5FcS6jq6gCBxESqc=;
        fh=/gBKL856m721509318RIdz8U4fuFWBADYUOnmaP+UV8=;
        b=pYbVKvVEfl56lFg4eQpVv/TxvtiLVUqg5DZbVmtgydATs88g1yaZS6Qs34MN8Iylj9
         Q/67eDFYc6Myx/TziVoL21TiBl7OAAUNXI0+glEDgeDFp10klfNwcJCvEuWzDecueblp
         sA6WpnxL+F8v1mfoWjpv4uHmPgloM9LuGz1TINhJWOBmYPRtQB7nE2UJmSAwZlH9QSiq
         yxLVZRJQzBxM+mSaf6YyjgcU574L2ooUVsHIqfwesnZiA8+sgJBFf5lYk9FeBnw5PWlT
         Z4fSTyK52a3QgIjjaVhoHZJMdgqvz25BxgVWL6DXjG5BeIEJxq9e2HYilHCM20/VfNa0
         ESQg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795599478; x=1796204278; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OKPuTjPfuPhsiqzz0xTmce8aMCN5FcS6jq6gCBxESqc=;
        b=JqPPHs/ZOUajUVKTgwkdLRIw19t61HLwjP/eJlCjsKSgnkeyAMvFF3j+61hqB6bHfA
         OwGBPGAdOe5aC4iUkmg9lSVWs7LxyhWKsjvmLwXsY89N/ZThgpODielTnS8qUaeQ0K6C
         Voyk0c3xW9Pl7BpzlJfH2MMHEYBgXXdoDaFt4SI4fcITQhXjHBxzHHwWF4wT9SHTBQD2
         XdEpFIVEJqx0M/Tl+i/2WdA5tCVOllC5ZycsjQXn4Ap70oP7JGaX08UI04pLKlVYRNr1
         u5Q3jTO6GuWw0IitHn77DCVBuXVD0OZd0cQ/7JEqW43PdKHuUfWfcyUJu9LeKsVui6+m
         dfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599478; x=1796204278;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OKPuTjPfuPhsiqzz0xTmce8aMCN5FcS6jq6gCBxESqc=;
        b=NTSPmcNlZ5gRVCb1Agvzgk1kgDfbbv0vXJxoRvOSRnUnVZgA4xMhjOCqg52X07b3u6
         lVplhc1bAXTu50BJz7l9aaaFpFsk8hYQJ22/qsm8mRpxVR6i+IJDK9s1wh2IfVbc1/SB
         vDUC+oaCDYVoLpFIlKv+CPj+fJIEE6/EELC+2avmN82ARkipe+66VweTqFOKWqy79qPr
         wy0wC2qbawXloPo6IraB97DIY6+I6hJIeZ7dRPISTZh8sz06t4/frIQN3IkGIrwbGbQc
         BJfwPlGgnY71PPx4OQancAkuKY24eSM0GNIkoDlyaywy1r+3f2F23qzHPyjnvqi884wC
         hvrw==
X-Gm-Message-State: APuU4Z/jbA5Hd8TIcwaku6CkCWPEPhUNlcZbkZjEsdUfgI77zNscQySb
	vDZODFA4Isf1IrSgCHEBNPAliP8qZIE8QyGA6I3m4kkKRtxdNnxfd72spouCJd0T9H+Y+yjXC4Y
	mmBhxNESDahe/t6dwDt9tZnup0L8/0pa2O2q4
X-Gm-Gg: AZFdTZdPVCqgwlahgMF9CWvkQamuQ3m7pZJdZd1NKp6ychNpPAPzjmo8Xive4c1FUGi
	q7bD21noa9qHFWqsYNC0DJMnLFZBr5tpGIWTQ0HJKBctv3UFanDNXMik3hbZgSHIhAaV4jBlDz0
	8cla7NIDfmIAo5WWSZq7si+FIcM+AM0UShBR2mQS8mnYbs+VpXCPMSvf7cRbvx2oH8tD4u2VTIG
	Oq4zIP+krQFVpeLjvrMei3uLeRmbBZkZw6MTDuLGlQkSCMCez6WjJhTcX/x7A+nlVKvAmDCEuPW
	y02bogktnvXhvXZW7oSYAbTqWnpiejWVpUxtk9iiCAQawLWTw74pkYC7K2DJCh5qJN2CXMrB3pv
	9rjDNhVkRzCin/qitTPtx9FFu4ZgggeH1rHvg+H+/dKDbZ/Ejkc2Ye1g=
X-Received: by 2002:ac8:5d89:0:b0:54f:c347:91a8 with SMTP id
 d75a77b69052e-55d769e939dmr323925061cf.25.1795599477729; Wed, 25 Nov 2026
 01:37:57 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Nov 2026 04:37:57 -0500
From: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
In-Reply-To: <CAB2K5aCdEWKvsCUWeHWR0FDVqQ2263PaDQX8VWnma5pF4HwG8Q@mail.gmail.com>
References: <CAB2K5aCdEWKvsCUWeHWR0FDVqQ2263PaDQX8VWnma5pF4HwG8Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Nov 2026 04:37:57 -0500
X-Gm-Features: Aa3M54oCI8Bq3iG5TsCYBY1lqZmNwpK-1n8uL0aQ2FKTCnyihvo5oe4uYhYp_Mo
Message-ID: <CAB2K5aBGCnY+uCGtDig4FMvp+aEeVhrRnhQ5odgjQrtR6tJaig@mail.gmail.com>
Subject: [PATCH v2 3/5] um: time: use the host TSC as clocksource for the vDSO
To: linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_013759_644852_6054FDD5 
X-CRM114-Status: GOOD (  17.17  )
X-Spam-Score: -1.1 (-)
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Calibrate the host TSC at boot (median of 5 rounds over 100 ms
windows against os_nsecs()) and switch the timekeeper clocksource
from os_nsecs() to the raw TSC when calibration succeeds, setting
vdso_clock_mode to VDSO_CLOCKMODE_TSC so the generic vDSO can
interpolate time in userspace.  Under time-travel the guest clock
is independent of the host clock, so calibration is skipped and
the old os_nsecs() clocksource is kept; on calibration failure
the same fallback applies, and the vDSO falls back to syscalls.
Measured: clock_gettime() median 70 ns in the guest (80 ns in
the boot where the syscall baseline was measured) vs 36,535 ns
via the raw syscall: about 457x faster same-boot, about 520x at
the typical median.

Signed-off-by: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
---
 arch/um/kernel/time.c | 99 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index d620b6d63..0f32a02a1 100644
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

@@ -945,11 +1022,33 @@ static void __init um_timer_init(void)
 		return;
 	}

+	/*
+	 * Calibrate the TSC before registering the clocksource, so the
+	 * timekeeper (and the vDSO) use the TSC rate from the first tick.
+	 * Under time-travel the guest clock is independent of the host
+	 * clock, so the host TSC cannot be used and calibration is
+	 * skipped. On failure keep the old os_nsecs() clocksource:
+	 * timer_read() falls back to it and vdso_clock_mode stays NONE.
+	 */
+	if (time_travel_mode == TT_MODE_OFF)
+		um_tsc_hz = um_calibrate_tsc();
+	if (um_tsc_hz) {
+		um_tsc_ok = true;
+		timer_clocksource.name = "tsc";
+		timer_clocksource.vdso_clock_mode = VDSO_CLOCKMODE_TSC;
+		pr_info("UML: TSC clocksource, frequency %llu Hz\n", um_tsc_hz);
+		err = clocksource_register_hz(&timer_clocksource,
+					      (u32)um_tsc_hz);
+		goto registered;
+	}
+	pr_info("UML: TSC unavailable, keeping os_nsecs() (no vDSO)\n");
 	err = clocksource_register_hz(&timer_clocksource,
NSEC_PER_SEC/TIMER_MULTIPLIER);
+registered:
 	if (err) {
 		printk(KERN_ERR "clocksource_register_hz returned %d\n", err);
 		return;
 	}
+
 }

 void read_persistent_clock64(struct timespec64 *ts)
-- 
2.43.0

