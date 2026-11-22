Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD19606A331
	for <linux-um@archiver.kernel.org>; Sun, 22 Nov 2026 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=U61UD+nN;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dgCQPg+O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:References:In-Reply-To:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=B+Ci2X9ERZduXH4tzRPsR7rwD5u5R81PTNBlveqkU1I=; b=U61UD+nNzmi/SzWBXibfyPYhTX
	YEzB0v+yazZ/UwWQEBH5njFIoKF3LJnXMra88yCVxlAoOs8q92+2/C2gdCvRoOGj7Vf/n2rzmF0z8
	1eDWpZygArXCxoP3JArpdSYT/7pEudTaW0bNyrhewwSwvTawTB9wx2gj19Fnv298OR5sq5EPCK7d6
	E5vLf2PkldaZaxjFAlzqnu/BNEuK0Yv9BirmUzoF2ObL9r07L3YCOshXj+4U1fr3sSXqkJk5IQAiR
	tggJoIItJqQRnMjfr8E6MkFn1z9peWBkjpSr4OiT4KcsyieJIXxQMIsB/FOE6Om3pvCpbYiOdJTKk
	Io6YaEWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV7q6-000000019gG-2RBU;
	Sun, 22 Nov 2026 13:42:42 +0000
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV7q0-000000019aJ-3RZ7
	for linux-um@lists.infradead.org;
	Sun, 22 Nov 2026 13:42:41 +0000
Received: by mail-yx1-xb136.google.com with SMTP id 956f58d0204a3-67df3b1ca06so2635615d50.2
        for <linux-um@lists.infradead.org>; Sun, 22 Nov 2026 05:42:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795354956; cv=none;
        d=google.com; s=arc-20260327;
        b=SgZbZ7tnsFg/JwPZyz8Nj9zZhxb2cJQJmot+zLOL73LNgO5X6J1CuZ0yXbx2Btkazl
         6mp/yotWio2Y6zLlqtN0HOZjjNgsFXZCcJn2PwFlH6E5ZVQ3rmuEEJlNpjMZWY4B9ssk
         ABUMJsgcyIXA0XNi4Ed5z9waUCo+mEOrfMMudDQZXgKe9hW0hL7Stnx4GrlBhrjdNXi1
         fVzUFiGIlrZ1STEqGaJI1cYy6J8usHaRkzUc8dhGCnusN4lsTanJfSNhixdFmM23xd/d
         TkLAu7EfloBS+kBVRcV1ESxCM+YbOkhSEP4w5KgLtx1GUxAIDenxy27NR10XR9XKoFx4
         gXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=B+Ci2X9ERZduXH4tzRPsR7rwD5u5R81PTNBlveqkU1I=;
        fh=/gBKL856m721509318RIdz8U4fuFWBADYUOnmaP+UV8=;
        b=FJiKvGN0yUcSt8d66SQK0Jpl9r5JHC/tdrIBDN4Iy4ZZSZz+VHjnrVy8KQcd3mft4C
         ngpTetQzIAlWyDeEnNn7hYgeriVTdIVmDRx0LxqGPdVlSLZwgmbfW76z0+7f20Q95EOX
         towoRDSVQynEaH6/zMR0TBolciGp4Gfj8uFpke1aYN5h3gMx7uVOV7JBD3ewzuHq+nxw
         QegJq3rdha8eatUPYaRzZK5Z7hfQQpGDtrO7kZcxP+cNa4Z9iR4FtafXzm+mUWWzTt/t
         cpPXxng1dBSzrrwjD7pcSoUvpqqkZYDv4GIiNXXezhl+j00OvK6A81Ur90550Nuy7EoQ
         EJyw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795354956; x=1795959756; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B+Ci2X9ERZduXH4tzRPsR7rwD5u5R81PTNBlveqkU1I=;
        b=dgCQPg+OzUnRJFcxcP9h+fPTcWtN1W3SoipT0KXvoAEHNKwZBsMotdv2xNx1z8bEVJ
         rO+6YXT1ZrBmNq8+iFpgWq7njZhif42oIJDxzEPnGomCOa4OnhweENMRHVcy/fp1d5Eu
         HBkss+M/zgxEoE80BAQSVSUhoajJba97SsJqmw0PG7U+wvIVyHyMDk+QnclJ62MUPDE9
         wolJwFWb07PohxAE1Q18JRRLq/9ndxfsDl1yh0GeYUDyhjr8Y5pneo8kzJeGokzWjevK
         b0D51u7PErvPz2fVNoRQW4OkUbr9gkR8gXaPQDT130Fc7GbxQr5iQhOXycnEYgMY1vZK
         O39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795354956; x=1795959756;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B+Ci2X9ERZduXH4tzRPsR7rwD5u5R81PTNBlveqkU1I=;
        b=eCWv3gYVN6joRdJ8glLtLtPkLEFFk6VA7gxpfhMBnWMHgq/usF0nLFQbZeUKAx2INR
         JIbFhZZrp/wILltrlfaoc8rybUOjXY8spzYaO70tPw/NX0t+ORQCS3Cewmhj1Oj/JAeV
         fy+Q4eKwslt8Ivh/sRRxqPlYbZvF46vj+kayumutUQuFPzxfeCLS07zzYvomEWTHd0/S
         w/lxpTMnpWD2o6Ohq5w9il8DYBTMbh9Ixd2ic6+gLUdmqTV/DTg+lH7hV806wq7bbTm7
         UH1so5tT55X/nvOUZnSmCNj/vIy2dsushPi8sT57ZKR8c8d/U2QaQhVe011chaIVD7P3
         PQpA==
X-Gm-Message-State: APuU4Z80+xVi1jzX8spheXZRw3DBMz5YDY4wA8aROj5gbL/0cM4cGsdO
	TZSzkyVoXiDIRUSntf4grcgl9wH3dC3OWRDkTGoWzf3TTg9sBnIahbeJs17AL/O6J2phtykAYE2
	vTZVbZN2d8pkmZojLLRXBoKWFOzIkfNL9ZBsto0A=
X-Gm-Gg: AZFdTZcM33F41UGKmf/Hfs90ikl0ZU8lfPGRKISZ+6325lfyiVX4AARXltBl/U+6R3A
	spN5Gw7MyKJqX6BvyZ1XUZxAao3Ygo4rUv31n8+bmRPQ2xTMcdyn8xJ70sqIubwk/U6EuUHAm4r
	Vh79Mmqvs4dT8D1SBMdQ0IcxPnWpTT8ADI49ly20Lu3jNH/k5iB8KLKGrXvx9okbh1k6xlNzsJ3
	l2WD6QSFl1T3VYmgyH8yBU+ZDDFMZTpmM1rI204kjPKc7orxtR5//G5+y1e2MAqKqtgPAfU8ufa
	3qS0Iq6Rg83xVgE6D58Sm+YhVH+XpMw/L3WFdkJRJ46brxFdTGwgDlvxBE9pqfpJx+JOgNg40h5
	kNIoSpmNjS0uMup5UWnl1AnW5xPOnmE0D6+0=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:690e:c87:b0:67d:c8a9:c5e2 with SMTP id
 956f58d0204a3-67df442507emr3830252d50.59.1795354955768; Sun, 22 Nov 2026
 05:42:35 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 22 Nov 2026 07:42:34 -0600
In-Reply-To: <CAB2K5aBaXG7Jhi+0UyVfpGan+5XXch5zOg3tM3=kqnO1+8F=fA@mail.gmail.com>
References: <CAB2K5aBaXG7Jhi+0UyVfpGan+5XXch5zOg3tM3=kqnO1+8F=fA@mail.gmail.com>
From: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
Date: Sun, 22 Nov 2026 07:42:34 -0600
X-Gm-Features: Aa3M54pcJcokKt1kNxtkyDdZtKEYm3b8Zsih_HBjbibxD-WZAd_eStP_N9tN_E4
Message-ID: <CAB2K5aCsdMRz=sUYKy6Aiyk68qaVujiTucGfO=+09AU+PNMerA@mail.gmail.com>
Subject: [PATCH 4/5] um: vdso: add the generic vDSO alongside the syscall-shim vDSO
To: linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261122_054236_925834_79E8B34A 
X-CRM114-Status: GOOD (  12.55  )
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

