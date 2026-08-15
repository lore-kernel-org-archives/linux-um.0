Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C379FC5DF6A
	for <linux-um@archiver.kernel.org>; Sat, 15 Aug 2026 18:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q2A0VpZ3jEW63u/fB0uqkGhkDFeSh86cNwd3FvE985o=; b=dCZVa6srfgLexuLy5cNtr3mQ72
	CkL/I9zpgCsAAB/iB5Tcbtt3jlZQUejvsY9sVaVBFJjFB6ItBo3JspssXnt3ZTWIYxGji0Ddbao1R
	5gQ3jAYPHZzxp8aqEe5/S5kSSIWAQJQq4u5R946Tj4k+oBVDH9pUrkaMtBpvTVvUmYATE20xx8Hld
	840xv7cn1dPx1CVXr8oN/DIFf/YgMJ5c9U3B8Utz1mBC5Gpz/7yr7WdvkIqlSt1P5gPv0p/tbQi33
	jc8dxFAyIERTIY10NE6KP25SRwiq020wOIvwB2hyL+qqmsTuzJiDg8vAgkLC3MbVr8TGww6OZXWI1
	W7ZoeLIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIs4-000000041Fz-16Du;
	Sat, 15 Aug 2026 18:12:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIs1-000000041Ba-0oGp
	for linux-um@lists.infradead.org;
	Sat, 15 Aug 2026 18:12:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A30C3600B1;
	Sat, 15 Aug 2026 18:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58F01F00A3D;
	Sat, 15 Aug 2026 18:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786817556;
	bh=Q2A0VpZ3jEW63u/fB0uqkGhkDFeSh86cNwd3FvE985o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c4wGJ8VhfbWJcDXsBWiYh+o+RaU1oHSwqYO5XkKUDm3SwYB1bM/Jig7ny6pjVCX+z
	 LWYigBVe0JYLa+bZdolB7OrxOskpY0bDqWsIDBSVS7BrxMuE7l85gE94/PM/ipaLSZ
	 5h8ZjdKFDpA4HAWuoqogtJvw3SvlVVzrC9h61NdU6w71A/bgrQ9+vwqGDnoZO3OUAi
	 pZkHG+lww+sKuVNmgFH4BcNLtj1gZnEgB2k4aSaJ31HFAesK6PBHb5n34NPfj14glr
	 oa89nzefpeYK5UAs++FLPAUJT4ZkbvGFMu2BlW/oOUIHNaDF/g2BszZ66R34poxAmg
	 ZZu4eY3eouuww==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v4 6/8] x86/fpu: Remove cpu_has_xfeatures()
Date: Sat, 15 Aug 2026 11:10:22 -0700
Message-ID: <20260815181024.28924-7-ebiggers@kernel.org>
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

The only remaining caller of cpu_has_xfeatures() is
print_xstate_features(), which uses it only to check and get the name of
a single feature.

Remove it and just inline the needed code into print_xstate_features().

This also makes the "unknown xstate feature" entry at index XFEATURE_MAX
of xfeature_names[] unnecessary, so remove that too.

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 arch/x86/include/asm/fpu/api.h |  9 -------
 arch/x86/kernel/fpu/xstate.c   | 44 +++-------------------------------
 2 files changed, 3 insertions(+), 50 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 90c63fe19c0f..cfed8b24d64f 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -99,15 +99,6 @@ static inline void fpregs_assert_state_consistent(void) { }
  */
 extern void switch_fpu_return(void);
 
-/*
- * Query the presence of one or more xfeatures. Works on any legacy CPU as well.
- *
- * If 'feature_name' is set then put a human-readable description of
- * the feature there as well - this can be used to print error (or success)
- * messages.
- */
-extern int cpu_has_xfeatures(u64 xfeatures_mask, const char **feature_name);
-
 /* Trap handling */
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 extern void fpu_sync_fpstate(struct fpu *fpu);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 97cfd4fb6cc0..0b17452d1788 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -66,8 +66,8 @@ static const char *xfeature_names[] =
 	"AMX Tile config",
 	"AMX Tile data",
 	"APX registers",
-	"unknown xstate feature",
 };
+static_assert(ARRAY_SIZE(xfeature_names) == XFEATURE_MAX);
 
 static unsigned short xsave_cpuid_features[] __initdata = {
 	[XFEATURE_FP]				= X86_FEATURE_FPU,
@@ -122,44 +122,6 @@ static inline unsigned int next_xfeature_order(unsigned int i, u64 mask)
 #define XSTATE_FLAG_SUPERVISOR	BIT(0)
 #define XSTATE_FLAG_ALIGNED64	BIT(1)
 
-/*
- * Return whether the system supports a given xfeature.
- *
- * Also return the name of the (most advanced) feature that the caller requested:
- */
-int cpu_has_xfeatures(u64 xfeatures_needed, const char **feature_name)
-{
-	u64 xfeatures_missing = xfeatures_needed & ~fpu_kernel_cfg.max_features;
-
-	if (unlikely(feature_name)) {
-		long xfeature_idx, max_idx;
-		u64 xfeatures_print;
-		/*
-		 * So we use FLS here to be able to print the most advanced
-		 * feature that was requested but is missing. So if a driver
-		 * asks about "XFEATURE_MASK_SSE | XFEATURE_MASK_YMM" we'll print the
-		 * missing AVX feature - this is the most informative message
-		 * to users:
-		 */
-		if (xfeatures_missing)
-			xfeatures_print = xfeatures_missing;
-		else
-			xfeatures_print = xfeatures_needed;
-
-		xfeature_idx = fls64(xfeatures_print)-1;
-		max_idx = ARRAY_SIZE(xfeature_names)-1;
-		xfeature_idx = min(xfeature_idx, max_idx);
-
-		*feature_name = xfeature_names[xfeature_idx];
-	}
-
-	if (xfeatures_missing)
-		return 0;
-
-	return 1;
-}
-EXPORT_SYMBOL_GPL(cpu_has_xfeatures);
-
 static bool xfeature_is_aligned64(int xfeature_nr)
 {
 	return xstate_flags[xfeature_nr] & XSTATE_FLAG_ALIGNED64;
@@ -302,9 +264,9 @@ static void __init print_xstate_features(void)
 
 	for (i = 0; i < XFEATURE_MAX; i++) {
 		u64 mask = BIT_ULL(i);
-		const char *name;
+		const char *name = xfeature_names[i];
 
-		if (cpu_has_xfeatures(mask, &name))
+		if (fpu_kernel_cfg.max_features & mask)
 			pr_info("x86/fpu: Supporting XSAVE feature 0x%03Lx: '%s'\n", mask, name);
 	}
 }
-- 
2.55.0


