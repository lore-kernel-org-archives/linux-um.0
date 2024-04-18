Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189AEC4345F
	for <linux-um@archiver.kernel.org>; Thu, 18 Apr 2024 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tFqQ/QnxZyj8jY+DnvYm25JUVTIxfRUpuOVcBaZqx8M=; b=Sw+ExEr/zPMd1fOI8uzVSKXWyR
	QG41Oi2CWkUlFaHD5+/CmTyX4ycg8YAGnHrRXn8qNRTk1gSNKoWGR7gwnfrvy2asncJiQ6UjWHfq0
	mDggnJv0LXkFfSQqGBKgng+QHbJlWlr2yUGRmCWwanNdTwhtBF4KO1RACs57ZczBUN4jZACDa6Lvz
	8mP8bKlm0c30+4aj2Kekub2x14bQ8R6j1XP6H8UWnvtrwD/TllPmlGkgQ6kmt8/0QKIVWC4kCgIjQ
	Bt1CYu6yYySceUXi2ePLbyHrq2rbHHo/2zuEirlFvmcvSfEzihCq3AxpKKvYfFrxOL7oz7guZ591c
	NCzBY9Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO0n-00000001bFv-0IFZ;
	Thu, 18 Apr 2024 09:24:57 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO0k-00000001bCZ-0L2o
	for linux-um@lists.infradead.org;
	Thu, 18 Apr 2024 09:24:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tFqQ/QnxZyj8jY+DnvYm25JUVTIxfRUpuOVcBaZqx8M=;
	t=1713432292; x=1714641892; b=HFX8K3Bz/wU3S9hoVILnYKMHBoMsSJZ4TvDMXwcgLY70bqI
	r+yHWoI3MSqXKgTkIAUDlc2wR1Kvu9xiM1MRHZydyTiCqOYuoxqin/DVfcXWaMbIZnOzAiekNOmE6
	cEsdLEF9r4YZWgTUB6Js4OX+ED2UVsEpW4Zeige6bKCo+z/K31q80ugwcn+LtHopPvwiAI4ryd3d9
	8b3a3IsaxkvBVHUvbjFRFH69V7/NOuxJByAAWUx6S+XTz3fydDvLH1gB+eNyqw1axJvoHn0iW6Zgg
	T/HjDIl2xrXhEbqm2OJ1KB9/7yF5y3zpHLKzFdYj7bpVOIiEyOvJtNdY35Xz6HJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rxO0e-0000000CKXH-3FuU;
	Thu, 18 Apr 2024 11:24:48 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 01/12] um: Remove stub-data.h include from common-offsets.h
Date: Thu, 18 Apr 2024 11:23:16 +0200
Message-ID: <20240418092327.860135-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418092327.860135-1-benjamin@sipsolutions.net>
References: <20240418092327.860135-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_022454_589151_BA55F633 
X-CRM114-Status: UNSURE (   7.23  )
X-CRM114-Notice: Please train this message.
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

From: Benjamin Berg <benjamin@sipsolutions.net>

Further commits will require values from common-offsets.h inside
stub-data.h. Resolve the possible circular dependency and simply use
offsetof() inside stub_32.h and stub_64.h.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/common-offsets.h | 5 -----
 arch/x86/um/shared/sysdep/stub_32.h     | 7 ++++---
 arch/x86/um/shared/sysdep/stub_64.h     | 7 ++++---
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
index 96195483fbd0..579ed946a3a9 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -1,6 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* for use by sys-$SUBARCH/kernel-offsets.c */
-#include <stub-data.h>
 
 DEFINE(KERNEL_MADV_REMOVE, MADV_REMOVE);
 
@@ -30,7 +29,3 @@ DEFINE(UML_CONFIG_64BIT, CONFIG_64BIT);
 DEFINE(UML_CONFIG_UML_TIME_TRAVEL_SUPPORT, CONFIG_UML_TIME_TRAVEL_SUPPORT);
 #endif
 
-/* for stub */
-DEFINE(UML_STUB_FIELD_OFFSET, offsetof(struct stub_data, offset));
-DEFINE(UML_STUB_FIELD_CHILD_ERR, offsetof(struct stub_data, child_err));
-DEFINE(UML_STUB_FIELD_FD, offsetof(struct stub_data, fd));
diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index ea8b5a2d67af..2748b7ee031a 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -6,6 +6,7 @@
 #ifndef __SYSDEP_STUB_H
 #define __SYSDEP_STUB_H
 
+#include <stddef.h>
 #include <asm/ptrace.h>
 #include <generated/asm-offsets.h>
 
@@ -98,9 +99,9 @@ static __always_inline void remap_stack_and_trap(void)
 		: :
 		"g" (~(STUB_DATA_PAGES * UM_KERN_PAGE_SIZE - 1)),
 		"g" (STUB_MMAP_NR),
-		"g" (UML_STUB_FIELD_FD),
-		"g" (UML_STUB_FIELD_OFFSET),
-		"g" (UML_STUB_FIELD_CHILD_ERR),
+		"g" (offsetof(struct stub_data, fd)),
+		"g" (offsetof(struct stub_data, offset)),
+		"g" (offsetof(struct stub_data, child_err)),
 		"c" (STUB_DATA_PAGES * UM_KERN_PAGE_SIZE),
 		"d" (PROT_READ | PROT_WRITE),
 		"S" (MAP_FIXED | MAP_SHARED)
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index b24168ef0ac4..50c5e0529dfb 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -6,6 +6,7 @@
 #ifndef __SYSDEP_STUB_H
 #define __SYSDEP_STUB_H
 
+#include <stddef.h>
 #include <sysdep/ptrace_user.h>
 #include <generated/asm-offsets.h>
 #include <linux/stddef.h>
@@ -101,9 +102,9 @@ static __always_inline void remap_stack_and_trap(void)
 		"g" (STUB_MMAP_NR),
 		"g" (~(STUB_DATA_PAGES * UM_KERN_PAGE_SIZE - 1)),
 		"g" (MAP_FIXED | MAP_SHARED),
-		"g" (UML_STUB_FIELD_FD),
-		"g" (UML_STUB_FIELD_OFFSET),
-		"g" (UML_STUB_FIELD_CHILD_ERR),
+		"g" (offsetof(struct stub_data, fd)),
+		"g" (offsetof(struct stub_data, offset)),
+		"g" (offsetof(struct stub_data, child_err)),
 		"S" (STUB_DATA_PAGES * UM_KERN_PAGE_SIZE),
 		"d" (PROT_READ | PROT_WRITE)
 		:
-- 
2.44.0


