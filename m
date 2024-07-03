Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DF7C30653
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=spKYQ+TZjiVY2xZUNnWcBarJP2Qt38/d0L97xrR4IDI=; b=reDb92rSCZLM7362xFg/6qIZ7T
	tV7+RzlGNo/XsTebVaBHrksLWeljmQyh5xDnKf5nR2GnjJW3dGLjWW2YE3+WAccV1HPhLE0qivGMJ
	8rFy9Cz2+VylZhMX9In+hnKfSZnezyFFy3Hretr03IeJrSa1jb4deYiLg2rKBLknGnl5ZSA4L7wLS
	mBo36D5X+JljSVfUoL2bexaNTW5yfcfucVupTkQNzz44elk67leDZozqATw4GWqyXYAMH9bWE3yt4
	rZ1EU6eugby1KmLM7qpLD5+1az739QoULDfoQox3QeJ3iDAOeen/2QWDkaDZt9xsETAwLF887FRt7
	u0HlQ4dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1TT-0000000Aaaa-2jQR;
	Wed, 03 Jul 2024 15:00:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0JN-0000000ALH1-33vO
	for linux-um@bombadil.infradead.org;
	Wed, 03 Jul 2024 13:46:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=spKYQ+TZjiVY2xZUNnWcBarJP2Qt38/d0L97xrR4IDI=; b=OPIFYwDiA97mmOvTrcF7q1HOOs
	mRjP3yqnOdeiVpOZZia3vIPeySsoqtv20eGH1jdCSXfV1P8h/DXisDWIugZ5agUNXdP8f9/DRhVUp
	YIhBARteyiAmeFwVpHSEAkE0r5R+mLSOWq/YcWR53Uw7Mrb3/O44D3+kMoxSnHMDLY3qHckl8iZmX
	1LzSbJpZ8CFxO0K7EITtvbfQYOiByZtzzVkOjrhkxyzPVWXxtWi76U8hZYHAWj4dC8oUpSn1/3bhu
	l9KnsWjY9r2aUI6NOKaQyGW6oY4XQkIUHR/KkRyOeC5KjQCAd/0mvXiEqAWvlkeHjhGdSfaOMGeon
	u+fHCrZw==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0JK-0000000A1Fz-2SSC
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 13:46:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=spKYQ+TZjiVY2xZUNnWcBarJP2Qt38/d0L97xrR4IDI=;
	t=1720014373; x=1721223973; b=hHGVNhfTgVGAD1vH1s/lQP8kp3hxekes76ZVMfpdJPcwa1+
	qeytsAnvqOnKOGr/LbrPMScd5din0z+scaXTD8tkJl/n9bVWn2qPGMS69SqGmaexkeFfEIX+tnJqu
	AaV3FbEBSTd5CvUNqgUpa6xrak5MQ4aMK0aXBDSj6p4AqO6eUinrsz9g4EoeCs/y356QFH41uvVPH
	4m6W6kPUClnsWVY9TmvPL/NbSwyyzhj8N06sbXvdRAYvj+ChXoOi8HPDrdzgnKOBo8Xejo9Fa6iia
	t9iC6VlVxVS+DEPmhzvoJ6XTAie8w1cdI4VN/KIuHxOEuI1mrJwNvh8X9WDirEqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sP0JG-000000094nb-0O13;
	Wed, 03 Jul 2024 15:46:10 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v4 01/12] um: Remove stub-data.h include from common-offsets.h
Date: Wed,  3 Jul 2024 15:45:25 +0200
Message-ID: <20240703134536.1161108-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703134536.1161108-1-benjamin@sipsolutions.net>
References: <20240703134536.1161108-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_144614_805227_2A29F5F5 
X-CRM114-Status: UNSURE (   7.27  )
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
2.45.2


