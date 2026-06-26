Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BD5CDE012
	for <linux-um@archiver.kernel.org>; Fri, 26 Jun 2026 04:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LTvew5FISW1+Y3DoGy6/+WEaicn3tFu5Y6jzIXpOte4=; b=MrDMSVITCVmoKBAAUjrgAF2vdI
	2jIpzKZNbA5rhRHGHmzt4o/XMw6jJaxJubNVHXmsX8NJkPteOi3LAeQrhOtnwlY+5ptZ6bZ7ERFH5
	qdH+SF4RW6WEPsOwTGODDL5zdniaB3/lU2TFuDel8M+A4cEwzqjnGjFqVCnSZ2uSFVLxvGVhwEMek
	n8sCkJPsj1kfacWHr1xRhwPIOjYe0+j6EXXG/SmgNdVyRoxnQwAQBf7jugxq6vFP4lW9hXRtGKqRa
	3hDQ+gHwFpLx4lE7Pp0yuuieGhfoqO1VDCUd9lSuydAY2fwlJFRPPDnA+NvIc8GROUgl6UkHz1Chc
	7pLXgUuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcyLf-0000000ATY7-02J0;
	Fri, 26 Jun 2026 04:39:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcyLd-0000000ATXa-1Bhj
	for linux-um@lists.infradead.org;
	Fri, 26 Jun 2026 04:39:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6B726433C5;
	Fri, 26 Jun 2026 04:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4E31F00A3A;
	Fri, 26 Jun 2026 04:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782448764;
	bh=LTvew5FISW1+Y3DoGy6/+WEaicn3tFu5Y6jzIXpOte4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aY5nPgvbra9i2bLfegYp1BAgDIW7yQTbZOTbY43eHQpARuNo8vS8rxIW8dHP97WzX
	 FdHvq7EK/hRKLDUYEuOL8JBSgd5gwtd+ZEC43UuakTmE/iZKhQpcuZwi6fmaJRdOYV
	 GDIHewT/RRFX0RcExOrIJoye03Ek8YK6tUlzKStr7oypfBloh3fc2Lr3/GbDiX+UGn
	 TOYnEbWOEXzSlmqJ6AnERYnsgHw8cB/pvZn2U9Q9AfaNZ8WQkM/7LhCkNxdUmaM25t
	 CEhk2lm8DPDXjkUeRPT8yTLMDkekhAGaEX14YILcfCJUuIkCUtf25WlhuQ0TplOzzr
	 G8+RpnKSX1/Pw==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 1/8] x86/fpu: Check for missing AVX and AVX-512 xstate bits
Date: Thu, 25 Jun 2026 21:37:24 -0700
Message-ID: <20260626043731.319287-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626043731.319287-1-ebiggers@kernel.org>
References: <20260626043731.319287-1-ebiggers@kernel.org>
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
 arch/x86/kernel/fpu/xstate.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a7b6524a9dea..7f7e62e4ebc5 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -797,10 +797,27 @@ static u64 __init guest_default_mask(void)
 	 * for KVM guests.
 	 */
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
  */
 void __init fpu__init_system_xstate(unsigned int legacy_size)
@@ -853,10 +870,12 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		pr_err("x86/fpu: Both APX/MPX present in the CPU's xstate features: 0x%llx.\n",
 		       fpu_kernel_cfg.max_features);
 		goto out_disable;
 	}
 
+	clear_cpu_caps_with_missing_xfeatures(fpu_kernel_cfg.max_features);
+
 	fpu_kernel_cfg.independent_features = fpu_kernel_cfg.max_features &
 					      XFEATURE_MASK_INDEPENDENT;
 
 	/*
 	 * Clear XSAVE features that are disabled in the normal CPUID.
-- 
2.54.0


