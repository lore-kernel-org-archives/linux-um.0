Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE81C53219
	for <linux-um@archiver.kernel.org>; Tue, 28 Jul 2026 02:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MCVeeNdoxXfPsfpQPY8gX2ITb7N+ezoKC7QMn07irFk=; b=sQO5LkFn79jsrNA5YV0L141fwH
	1QN4MzRU1i/MPe11xzv8eTQsX/9354T+ninfTngXOshmSu399dZTRVD9RKLe8ICO5YCcFzcb+Aj86
	FV0PpAarfSXQlHiUOLvNrvW5qQ1MERZMI3FHFuBCYdxMbiCmKkMXvsLp9abisgFM4gZtrrCvBoWhg
	GElLf2IqhnGzhtDlBm7VCH/g8Oh7FVXeCNjtD98Nu1JkuSdTDE5cbc0LMV9oOOy2PjabWwzQDh25q
	EH3sl0P0ydQj0uFRKXPLrhb+lW+Q6Uc/JpM91Q75u2RpOkWmZ3I4uQ3FgIiZRhtNY1Ou/6hNg0Y+q
	PLFRDthA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woXPa-00000004Fdv-1dOQ;
	Tue, 28 Jul 2026 02:19:18 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woXPZ-00000004FdK-1F8t
	for linux-um@lists.infradead.org;
	Tue, 28 Jul 2026 02:19:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1401543B64;
	Tue, 28 Jul 2026 02:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70D71F00A3E;
	Tue, 28 Jul 2026 02:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785205157;
	bh=MCVeeNdoxXfPsfpQPY8gX2ITb7N+ezoKC7QMn07irFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GfsfHvyyOAHyP6ZKanOnAHzJ0qgB9nTYymqSkDgkiqF90LytugcETR+egj33wXCm/
	 KUDR+sXyRHVnX95TzapiMFAQ9S/88F0mLxe786heodJ2w8Z8aph5EtXRiUCYbfVshk
	 BfRnHQGJoT+xItyC7/7db325j5yEj6W6JihcpNGWD1mg4cdb8DdEpuD516+bnAgExe
	 FhNIAutgDhFesr6ICNBsFW++npqUy3FhajVERauogUSPZ0oRywDLdcEez4TGrpSG36
	 ryF0bB8G6wjYFkRdEobG8Swgf97desrnX21dfv0qwa8zU3632SZlrgE9bGMgJIq+TD
	 1ZFrNPWx2BM4A==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 1/8] x86/fpu: Check for missing AVX and AVX-512 xstate bits
Date: Mon, 27 Jul 2026 19:15:56 -0700
Message-ID: <20260728021603.79870-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728021603.79870-1-ebiggers@kernel.org>
References: <20260728021603.79870-1-ebiggers@kernel.org>
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

If the CPU declares AVX or AVX-512 support, verify that the
corresponding xstate bits are also set.  If not, warn and clear them.

This eliminates the perceived need for AVX and AVX-512 optimized code in
the kernel to call cpu_has_xfeatures().  That has never been universally
done, which strongly suggests that it has never really been needed in
practice, but this should remove any remaining doubt.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 arch/x86/kernel/fpu/xstate.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a7b6524a9dea2..904ff933c0d88 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -799,6 +799,23 @@ static u64 __init guest_default_mask(void)
 	return ~(u64)XFEATURE_MASK_USER_DYNAMIC;
 }
 
+/* Clear any X86_FEATURE_* used by the kernel whose xfeatures are missing. */
+static void __init clear_cpu_caps_with_missing_xfeatures(u64 xfeatures)
+{
+	u64 mask;
+
+	mask = XFEATURE_MASK_FPSSE | XFEATURE_MASK_YMM;
+	if (boot_cpu_has(X86_FEATURE_AVX) && (xfeatures & mask) != mask) {
+		pr_err("x86/fpu: Disabling AVX support due to missing xstate features\n");
+		setup_clear_cpu_cap(X86_FEATURE_AVX);
+	}
+	mask = XFEATURE_MASK_FPSSE | XFEATURE_MASK_YMM | XFEATURE_MASK_AVX512;
+	if (boot_cpu_has(X86_FEATURE_AVX512F) && (xfeatures & mask) != mask) {
+		pr_err("x86/fpu: Disabling AVX-512 support due to missing xstate features\n");
+		setup_clear_cpu_cap(X86_FEATURE_AVX512F);
+	}
+}
+
 /*
  * Enable and initialize the xsave feature.
  * Called once per system bootup.
@@ -812,12 +829,14 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 
 	if (!boot_cpu_has(X86_FEATURE_FPU)) {
 		pr_info("x86/fpu: No FPU detected\n");
+		clear_cpu_caps_with_missing_xfeatures(0);
 		return;
 	}
 
 	if (!boot_cpu_has(X86_FEATURE_XSAVE)) {
 		pr_info("x86/fpu: x87 FPU will use %s\n",
 			boot_cpu_has(X86_FEATURE_FXSR) ? "FXSAVE" : "FSAVE");
+		clear_cpu_caps_with_missing_xfeatures(0);
 		return;
 	}
 
@@ -855,6 +874,8 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		goto out_disable;
 	}
 
+	clear_cpu_caps_with_missing_xfeatures(fpu_kernel_cfg.max_features);
+
 	fpu_kernel_cfg.independent_features = fpu_kernel_cfg.max_features &
 					      XFEATURE_MASK_INDEPENDENT;
 
-- 
2.55.0


