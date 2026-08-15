Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15223C5AD5A
	for <linux-um@archiver.kernel.org>; Sat, 15 Aug 2026 18:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WCMvK5ohQOFymbdY0OzMDpa7FyF9XhAAUoMQkc808Wk=; b=kirNcUEKhE5cJ0hOax5p2N+0IN
	xHiz0ITJbk0soWNXZisioZ4NbFWfNyxGsJF6geRSYyH3r6GmzEXHq/P/yhxQUYIlAfphuoTXXFPcm
	0eQiCgPt5DKmNFsuko32NQXZpdsRPMcKl0K566GlMPYTbfcoep7VkwtquQRSvHhqEZzNxU1kbZSMO
	LfZLHQcRS/qdRnh+h4mktGA1kyYijGvVeG0M9YWvBBJf1MCjtymj5z8eHYn3Fvxy3iK16meEqLPp7
	NbA8s8lgFXFqc9k7f16uzTJvSXCHR12GI2v+barnFmRg+s5v7iY5hYR8lpweWXO+V3ZXgET137JJr
	4FoXrYbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIry-000000041Ag-2MUg;
	Sat, 15 Aug 2026 18:12:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIrx-000000041AI-2qKz
	for linux-um@lists.infradead.org;
	Sat, 15 Aug 2026 18:12:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6FD2F43AE3;
	Sat, 15 Aug 2026 18:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B430E1F00A3E;
	Sat, 15 Aug 2026 18:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786817553;
	bh=WCMvK5ohQOFymbdY0OzMDpa7FyF9XhAAUoMQkc808Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=moJlEll/LoWBuhJimpjctgnUSMd48Rlal3HXbk/EN1lGeg421MCoog3x364lo0qfH
	 ofQaiN3HDD5npxbBnMbscR0jAriSH8JhssOsyiDGba9u5+jNP2ufwb4MRTqWFSeB49
	 i5iKMmUkFzwc8AfnY37k6KNmBhQKwvwxHSIH4Wsr+McfnI0tNOM6nG8WYqHINAtdhc
	 yVm0KwePY/yKp6F8A+wQVNmgTQCdsiZJIYcYTl/NCxBx5EZjCvOvaXa3juAvkV5Aha
	 iNuRL9OOzBk6Or4WOAnHg9Zw2p2GYSaI8yyu0Yzo3iWuCwvROWD2mt7Mo/PhY3y2Di
	 TdrfKUlWklM+A==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v4 2/8] um: Check for missing AVX and AVX-512 xstate bits
Date: Sat, 15 Aug 2026 11:10:18 -0700
Message-ID: <20260815181024.28924-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815181024.28924-1-ebiggers@kernel.org>
References: <20260815181024.28924-1-ebiggers@kernel.org>
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
index 2141f5f1f5a2..aafbaef2ae82 100644
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


