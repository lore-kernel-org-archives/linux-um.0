Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92809C61DD3
	for <linux-um@archiver.kernel.org>; Tue,  1 Sep 2026 14:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GjHnvhTUIuOR14d0OFZbby0ThaLZzSviDPcvynF6ARQ=; b=wamwiakOEx0twG6aADDocGuc+3
	Cwodn3oSC5SsyAUHMAyC1a2Bol5yQ9INBAxt13DX8I0tAYRKxU92AE0ZW2S8rYnxruu91tyO4Dh0d
	jZ/+WTOnftMRjq19s8dK4nNLj/5miuMdS/Vchx3L75u49GStiD8zPa3RS9KbFwbsuAAs0pc7gy99v
	1DL3o/iaP75HKWC7vj91j9GWubCfuR0nIwNM5aNDjSgkq4WL0PhZpARtZAUVT1UJPbPENq9v8pCji
	DbmgFwAuzsexzXBwOmeyMSv028sHj/GXJrWkmeQPtzq0X6viJr2g09xzpN0li9aWmiIaszphNkPVP
	7fndSMxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1PwH-0000000COWh-13qI;
	Tue, 01 Sep 2026 14:58:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1PwE-0000000COUE-0IJc
	for linux-um@lists.infradead.org;
	Tue, 01 Sep 2026 14:58:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 82BEF6025B;
	Tue,  1 Sep 2026 14:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C491F00A3E;
	Tue,  1 Sep 2026 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788274693;
	bh=GjHnvhTUIuOR14d0OFZbby0ThaLZzSviDPcvynF6ARQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LbmV/iL1gmV5lbQzrEMjAHuwjKpDYu0O8yaAsMGyAEJLPpqDGy7IvC4HA4g5B2PKf
	 2VWwCKAOhGUW7gGkejv/Acnva8zIS1wdH2e8wV5f1OGIdilBPyBOagxCL+LUzT5EQw
	 ni3ApPIWXnImGpAaOd8UN5+ecRYLYIIotuihFZZ0p2q68nY2qPxEQOb7pZ5rr6U7E1
	 lDJ5Jd3YB3MuxJ8TBaRWNzI+UrcVoJajygPSHchEDMyTUyyrk/o5VVm5QVyUcCZD0/
	 Y1EZipLsaqlWWTTwGbKlFsyPRlc9G39gJa7EdyXOXy2Y+41FoI3zMjiSZpE/tCz4Gc
	 5//xo9ymGV/Zw==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v5 2/8] um: Check for missing AVX and AVX-512 xstate bits
Date: Tue,  1 Sep 2026 07:57:34 -0700
Message-ID: <20260901145740.42337-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901145740.42337-1-ebiggers@kernel.org>
References: <20260901145740.42337-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If the CPU declares AVX or AVX-512 support, verify that all the
corresponding bits are set in the XCR0 register.  If any are missing,
warn and don't set the corresponding X86_FEATURE_* flags.

This eliminates the perceived need for UML-supporting AVX and AVX-512
optimized code in the kernel (that is, lib/raid/ currently) to start
checking the XCR0 bits in addition to X86_FEATURE_AVX*.

This aligns UML with the vast majority of userspace programs, which
check the XCR0 bits before considering AVX and AVX-512 to be supported,
as per the procedure documented in Intel's CPU manual.

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 arch/um/kernel/um_arch.c | 78 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index e4ee693961e4..9d53cc6a783d 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -264,12 +264,88 @@ unsigned long brk_start;
 
 #define MIN_VMALLOC (32 * 1024 * 1024)
 
+static u64 __init read_xcr0(void)
+{
+	u32 a, b, c, d;
+
+	asm volatile("cpuid"
+		     : "=a"(a), "=b"(b), "=c"(c), "=d"(d)
+		     : "a"(0), "c"(0));
+	if (a >= 1) { /* max_leaf >= 1 */
+		asm volatile("cpuid"
+			     : "=a"(a), "=b"(b), "=c"(c), "=d"(d)
+			     : "a"(1), "c"(0));
+		if (c & (1 << 27)) { /* XSAVE enabled by OS */
+			asm volatile("xgetbv" : "=d"(d), "=a"(a) : "c"(0));
+			return ((u64)d << 32) | a;
+		}
+	}
+	return 0;
+}
+
+static void __init validate_and_set_cpu_cap(int cap, u64 xcr0)
+{
+	/*
+	 * Check for missing xstate features right away, so that there's no
+	 * perceived need for all optimized code in the kernel to do so.
+	 */
+	switch (cap) {
+	case X86_FEATURE_AVX:
+	case X86_FEATURE_AVX2:
+	case X86_FEATURE_AVX_VNNI:
+	case X86_FEATURE_FMA:
+	case X86_FEATURE_VAES:
+	case X86_FEATURE_VPCLMULQDQ:
+		if ((xcr0 & 0x7) != 0x7) {
+			static bool warned;
+
+			if (!warned) {
+				os_warn("Disabling AVX support due to missing xstate features\n");
+				warned = true;
+			}
+			return;
+		}
+		break;
+	case X86_FEATURE_AVX512F:
+	case X86_FEATURE_AVX512BW:
+	case X86_FEATURE_AVX512CD:
+	case X86_FEATURE_AVX512DQ:
+	case X86_FEATURE_AVX512ER:
+	case X86_FEATURE_AVX512IFMA:
+	case X86_FEATURE_AVX512PF:
+	case X86_FEATURE_AVX512VBMI:
+	case X86_FEATURE_AVX512VL:
+	case X86_FEATURE_AVX512_4FMAPS:
+	case X86_FEATURE_AVX512_4VNNIW:
+	case X86_FEATURE_AVX512_BF16:
+	case X86_FEATURE_AVX512_BITALG:
+	case X86_FEATURE_AVX512_FP16:
+	case X86_FEATURE_AVX512_VBMI2:
+	case X86_FEATURE_AVX512_VNNI:
+	case X86_FEATURE_AVX512_VP2INTERSECT:
+	case X86_FEATURE_AVX512_VPOPCNTDQ:
+		if ((xcr0 & 0xe7) != 0xe7) {
+			static bool warned;
+
+			if (!warned) {
+				os_warn("Disabling AVX-512 support due to missing xstate features\n");
+				warned = true;
+			}
+			return;
+		}
+		break;
+	}
+	set_cpu_cap(&boot_cpu_data, cap);
+}
+
 static void __init parse_host_cpu_flags(char *line)
 {
+	u64 xcr0 = read_xcr0();
 	int i;
+
 	for (i = 0; i < 32*NCAPINTS; i++) {
 		if ((x86_cap_flags[i] != NULL) && strstr(line, x86_cap_flags[i]))
-			set_cpu_cap(&boot_cpu_data, i);
+			validate_and_set_cpu_cap(i, xcr0);
 	}
 }
 
-- 
2.55.0


