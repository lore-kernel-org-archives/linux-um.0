Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69217C433FE
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U8LRUC/w50SbwxVFZnzBXTRz2MtfsfoxMaTcFeJTUO0=; b=i0+yNEik+jhhsR
	HwBp9n8fAwrLL5kHPSzz995l1WdozZQd4IJZV6HXcAESfQBT2YoDnJyHVP+5BF5Hewn7JCcrht9Oe
	3MuacOAhPXgyOYPU5g10+r+b98xKKkNQA8RvntzX7qUi9mWKf8+IL2usZDC/Uxa2Kdtl+IY/FlIHq
	HSIH8cYBt97cqUXDQfrdbID5n7yDYj4QXh7WuqsknLpJ0EiR1pfy/T7bW33kuMHunF6UE+eZ5WjKa
	hxb8HIs+GX4eVIYxVGpa7mHjwNePra0hkcCk0nCC97xNdTE9kjnhDB/Ei1aXskRQASx8T3Xdhqso3
	QbiZQ6qPjZdzucKEgOeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQUf-007o7W-B8; Tue, 22 Nov 2022 10:27:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQTN-007nKg-EB
	for linux-um@bombadil.infradead.org; Tue, 22 Nov 2022 10:25:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=DSZ5KWDl/z52RVWNk2bHbNpZglcD5PTtXIhz0rCVKEE=; b=TwC4urX4tcqYTKWLRtCnVTSyfX
	zT/HyD1/+07We0QLy1l7HzOasMJYoDc4s9s+oMDMml4ZWurVgDYcpQ6+sYNogmF9iDmBy20FOhJpL
	8MwIAbfwBn7Gi5SUlFk5btMB5mTdxyQ935bUtdQysZp/Nd8JuKxRw2v3PTAweEnakx7o9JDDZZ/fm
	6tDnj6f2zdZhqsao9LVhVPvFxyzDuawCKdC6sFGgymMD52pUBPxVbi/dnHpe54XWOGehAsYrbz/m/
	sQGhEXmIDVaSjKeKXHp5UqxcH/unvqonyT7zK3jS/FFXrdsNsejEv4WU51qWW/5Qlbth7auDehWxD
	v9mE9ETw==;
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF1-003P1s-1K
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DSZ5KWDl/z52RVWNk2bHbNpZglcD5PTtXIhz0rCVKEE=;
	t=1669111858; x=1670321458; b=qrQgda8vk9EJCSFUomyEBpRCZtfBJdmlqYLH3xkq1koFAcq
	7cHlCXhJO8pYToJo25ob9+09XnKeSz6Z8UQEjCuSNEBM0Gfy91X2/eq9p/cAXbdwH//2qWh9pVc10
	lq3fHFm16eo5lfvkRTwXFlIIS2rhaTl1q91b/lyJXt1hMGOpInfRNq822a7YZK28xSP/5euiSZmC4
	vRWoW4DYXYRPikO2EUGUwfTHJ42A+P327odA9c7JbLS4WjDuLBh77faVNg0AeSE6dEcnFTHIG0SYF
	6SaHsiqD8sAHlxjQFlyP0N9kE9axBxOKe+ohKNs6Kd+P6ADfb6OQ0mUodGmFmHMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEp-006IGn-2W;
	Tue, 22 Nov 2022 11:10:47 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 14/28] um: Remove stub-data.h include from common-offsets.h
Date: Tue, 22 Nov 2022 11:07:45 +0100
Message-Id: <20221122100759.208290-15-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_101059_285221_3CB17D26 
X-CRM114-Status: UNSURE (   7.49  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
index cdb3396679e1..c413927c6ad0 100644
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
 		"g" (~(UM_KERN_PAGE_SIZE - 1)),
 		"g" (STUB_MMAP_NR),
-		"g" (UML_STUB_FIELD_FD),
-		"g" (UML_STUB_FIELD_OFFSET),
-		"g" (UML_STUB_FIELD_CHILD_ERR),
+		"g" (offsetof(struct stub_data, fd)),
+		"g" (offsetof(struct stub_data, offset)),
+		"g" (offsetof(struct stub_data, child_err)),
 		"c" (UM_KERN_PAGE_SIZE),
 		"d" (PROT_READ | PROT_WRITE),
 		"S" (MAP_FIXED | MAP_SHARED)
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index da6fd28fa95e..361a6a9fe1e4 100644
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
 		"g" (~(UM_KERN_PAGE_SIZE - 1)),
 		"g" (MAP_FIXED | MAP_SHARED),
-		"g" (UML_STUB_FIELD_FD),
-		"g" (UML_STUB_FIELD_OFFSET),
-		"g" (UML_STUB_FIELD_CHILD_ERR),
+		"g" (offsetof(struct stub_data, fd)),
+		"g" (offsetof(struct stub_data, offset)),
+		"g" (offsetof(struct stub_data, child_err)),
 		"S" (UM_KERN_PAGE_SIZE),
 		"d" (PROT_READ | PROT_WRITE)
 		:
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
