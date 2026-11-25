Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3D1606A321
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yCm/EuxB;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cn3lWHZe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=B+Ci2X9ERZduXH4tzRPsR7rwD5u5R81PTNBlveqkU1I=; b=yCm/EuxBtN1Sp0YCPS9qkZqVvV
	XMa6ied31ThmnUHQlEvoXmIFuAd2WEy3DXVaAZJx+BQvwiqgjW+4tEUylIKAD6Je160j52GLOwH41
	KXOJ3pRvQ+lzrgkbY2qPHmKma7rhiuXogSXE/TpVsF58eQvf79pTBtXS3ej1b6DpknygXC0z2255V
	+wvVW9ziPUdVdG5MU19CZF9r6MzEr/kTMHnb0vkGICofL2NXiEx4rl5tCbvInJzjZ3/mtvrr2KaVW
	8VY+zO2Etym7mJfuuqI3QDJ6FXgn+4N0ZlBcrOR+1nigs/l2ZXqe6Pfi/sbYaK5lxcj8rSV8FSEDH
	XxRA6SIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9S8-00000009Kv8-2RI8;
	Wed, 25 Nov 2026 09:38:12 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9S3-00000009Krc-0eEG
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 09:38:11 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-5363316fa0cso58609111cf.3
        for <linux-um@lists.infradead.org>; Wed, 25 Nov 2026 01:38:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795599486; cv=none;
        d=google.com; s=arc-20260327;
        b=KTD4NkG61wIHArRuadjqqssd6bOTLPQ21LbiHPnUs0wrt0HOWxOCTf4W0KKYWBZPDj
         i2X0TLw5XChke0qn9BLdwUBzTR76lTUt0VAibH0mleEctrGwLcDjrIuPyRxLkqWsEnyL
         5XKwaiuI0WX2xTLMDRr9JG37TNnwyJGWZaiaHWXDtHNAt3rlmyWXJ1RKUjpc2ph0e/mH
         +lgzpR6+HqRlV2xFBzbfNNcSVOYGxTXkFBJ+tUd70TCGZiRyi1SI9YbEzjy/+R/w7a8r
         v5iH5ZJfq8CfiENbRpqHXML5oT64D8KMGKrge4KoWsGiM3rMKqTwZ1LO451y0NiXCzm2
         KnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=B+Ci2X9ERZduXH4tzRPsR7rwD5u5R81PTNBlveqkU1I=;
        fh=/gBKL856m721509318RIdz8U4fuFWBADYUOnmaP+UV8=;
        b=Gw99pRVdyruX1BJHzPXloOR1I6gCR+wtZRLxCuRpKGN7/XBeo8oD9Sf8lMH6piq/5S
         b9C+8MjZR6kAl2oFXHJ/pVsdg2kMuCMX0LRUqBmAMto1XRG2W+Tc9S2MwwscXqkvn0U0
         NV6tKtlClITGcqwCCk1dbPZJ0AAjbSn7EuU2X0ta+wgol29ZrZVsbL6EzRTVNqXerX0B
         lD0HJrhRA0L290sxOn2Fq5wqJejhRZvt1zRETLSoDuLIdS5cCHgnGY21mjy7lmNTlyWm
         tuPYptW/W9ZF9I7l9RhppEM6hRBUyHbDzK7D4lyRHaMbxRj2AV91pD6G//fhI0Slt6Hg
         /X8w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795599486; x=1796204286; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B+Ci2X9ERZduXH4tzRPsR7rwD5u5R81PTNBlveqkU1I=;
        b=cn3lWHZeJ2AMHrjr9tMXTM4SZM+C2gVGmK67+V4ipCaB0M9Xif2uiZ+T5/JfeofYFe
         rMf/ZnPCGJKHgqBCh2oHN03sDZreFR8YrrgPgusUSwdj4MGGEN6cppfAN3yHyUwa8MzR
         1eJJQ/eCOMIN6dyPdkXhm9dChcum4Up07M8rMbPWr4QucBZKmmA5Zcz6x2WrnIdLN86h
         FtszZh86ghWmyr/27uDeiHJ5WsBBdX+QCi8FJX+wGZWHdOgmIJWvu/lVLLNmZN++yJ+8
         2AtCp5hHJk7gtJsHTUMA/ELp4VNYLLU+UsIz379uZtANO+h1Dno4ykQ3U2RAid3gMIC0
         JitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599486; x=1796204286;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B+Ci2X9ERZduXH4tzRPsR7rwD5u5R81PTNBlveqkU1I=;
        b=Hj19p+UtvlfvCXBAE1ozSXTfXGtkQy/SrW5BHuqZqZZYlylQshL0pAODFd9Ndk/TqK
         EvYZHg55iQPuOd5bnuW8AFSeM7WCD9hi1ydvFu3y7ry2NSsjj04bw/COP4TEE9JfK5v3
         DS3hH+wn6ZtJNNiSQRypC17dUcrOZgCR2b1/D/C+hjAS2EwTEUENKOfar9O+jR8zDmLe
         uOn7y3eyFd+uRM9mBQfB4xDad3AMpj81zjOSdimItXwKXelzlEVFPON6Mv5SdgnVbeeu
         chPTTrOQtPp+TxvMEUf30d87ZQEGHIUM5zTWG3Epg533lOjYrR6mGoDXm4RRoftRKEtr
         4f5g==
X-Gm-Message-State: APuU4Z9xMcRLkIxXcPpWVQIbxOLiy6y6nY86D/vMVHGrxw01bc4UMnFL
	53AQ6OzQ+uyT8QOyBfNUJm9Uag86GWFl3ecm7AwREiRfm1dp8+ksamQ3le99FQbaOZPD2z7zoEz
	4lze91jvGJEAA5qY8JO//q0YKa40M+iusRfKn
X-Gm-Gg: AZFdTZfSGPyXXi3NvDQAAn+g6ZcQiTp8XPs9msYR+XdVPvRbeGjVWJkBjzR5zFUpWmE
	j+0zDRq+1DGg2A8pXyYxlUNKoAy5DB8xrn8GBRxXd0Y9mq1niXtu+ctI4DFJQylqFfHy1kxNji/
	kkpISvcuLXHCPQ9EBTSWPZ5c8UAx+NJvxBfjRqCgldlo9XCGJSwFXK7TEm0M5BqoYursw03w15D
	mmwcWJjcnK4ATzwB5PZHCDJavvWdXy0dF0kiz8pIMwCbhRDvqn+kfQ5Dc8t2Pk1NAtJwSRKiJu+
	qnrgDxfL+6iSb67UHSEPi8jARd8ztluyV0q1u8Dt5c7YDhXHxwgGUcBxMBIoZUgY2K+G+p1H1DL
	1Itf98bTpYZfcWfOL/rrrAbKY2sGeEj62DMkicmHBC5UnGXENPGCf3mU/4yq0Xxp3cgaQhofjYp
	ORMw==
X-Received: by 2002:a05:622a:4899:b0:533:31b5:bec5 with SMTP id
 d75a77b69052e-55d769e99demr320340781cf.17.1795599485807; Wed, 25 Nov 2026
 01:38:05 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Nov 2026 04:38:05 -0500
From: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
In-Reply-To: <CAB2K5aCdEWKvsCUWeHWR0FDVqQ2263PaDQX8VWnma5pF4HwG8Q@mail.gmail.com>
References: <CAB2K5aCdEWKvsCUWeHWR0FDVqQ2263PaDQX8VWnma5pF4HwG8Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Nov 2026 04:38:05 -0500
X-Gm-Features: Aa3M54qJpY7_5cQSqPd_R3m-YFanJ3vVLSa-ckjDTCelqAAJDBl8u-IR0fS-JZU
Message-ID: <CAB2K5aDgkwsjDLJ++BcMvNjRqaSA6Yie1ks6=B6+-A-wGmBcSQ@mail.gmail.com>
Subject: [PATCH v2 4/5] um: vdso: add the generic vDSO alongside the
 syscall-shim vDSO
To: linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_013807_220733_6FC704AE 
X-CRM114-Status: GOOD (  13.63  )
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

Add vclock_gettime.c, a thin wrapper around lib/vdso/gettimeofday.c
following the same pattern as
arch/x86/entry/vdso/common/vclock_gettime.c. Time is now computed
in userspace from the host TSC and the vvar on MMU builds. getcpu
and getrandom are deliberately not exported: libc falls back to the
syscall for both.

The old um_vdso.c shim ("This vDSO turns all calls into a syscall
so that UML can trap them") is KEPT, not deleted: it is the vDSO
for NOMMU builds, where the generic vDSO framework is not selected
(see the MMU-only selects in the Kconfig patch) and the shim needs
none of it. The Makefile picks vclock_gettime.o on MMU and
um_vdso.o on NOMMU.

Signed-off-by: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
---
 arch/x86/um/vdso/vclock_gettime.c | 60 +++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 arch/x86/um/vdso/vclock_gettime.c

diff --git a/arch/x86/um/vdso/vclock_gettime.c
b/arch/x86/um/vdso/vclock_gettime.c
new file mode 100644
index 000000000..193a133d5
--- /dev/null
+++ b/arch/x86/um/vdso/vclock_gettime.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Fast user context implementation of clock_gettime, gettimeofday,
+ * time and clock_getres for UML.
+ *
+ * This provides the generic vDSO for MMU builds; the old um_vdso.c
+ * shim ("This vDSO turns all calls into a syscall so that UML can
+ * trap them") is kept for NOMMU builds. The time is now computed
+ * in userspace from the host TSC and the vvar published by
+ * update_vsyscall(), via the generic code in lib/vdso/gettimeofday.c
+ * (same pattern as arch/x86/entry/vdso/common/vclock_gettime.c).
+ *
+ * Deliberately NOT exported: getcpu (no guest CPU number exists in
+ * userspace; the x86 LSL/RDPID read would return the host CPU number)
+ * and getrandom (out of scope, needs the RNG vvar page). libc falls
+ * back to the syscall for both.
+ */
+
+/* Disable profiling for userspace code */
+#define DISABLE_BRANCH_PROFILING
+
+#include <linux/time.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <vdso/gettime.h>
+
+#include "lib/vdso/gettimeofday.c"
+
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
+{
+	return __cvdso_gettimeofday(tv, tz);
+}
+
+int gettimeofday(struct __kernel_old_timeval *, struct timezone *)
+	__weak __alias(__vdso_gettimeofday);
+
+__kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
+{
+	return __cvdso_time(t);
+}
+
+__kernel_old_time_t time(__kernel_old_time_t *t)	__weak __alias(__vdso_time);
+
+/* 64-bit only (UML is x86_64 here) */
+int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+int clock_gettime(clockid_t, struct __kernel_timespec *)
+	__weak __alias(__vdso_clock_gettime);
+
+int __vdso_clock_getres(clockid_t clock,
+			struct __kernel_timespec *res)
+{
+	return __cvdso_clock_getres(clock, res);
+}
+
+int clock_getres(clockid_t, struct __kernel_timespec *)
+	__weak __alias(__vdso_clock_getres);
-- 
2.43.0

