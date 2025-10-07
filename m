Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEE1CAC5B0
	for <linux-um@archiver.kernel.org>; Tue,  7 Oct 2025 07:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vKkg99CfARa2Eat4l30+6iS0TqvXZ0Gg+ksLx9eh+Tk=; b=Ur+lhjRc3SErZrRklI5C4cAzz7
	5obtfCz0TZKnYLIaiNmdV6yfoogGKVopmDWdLSMu9zrOPxs2pJw2s/pxTt7KW6DAyRRF52Ud1scLy
	mMXuFSiObQvaGeXxtHoVxnnuhiYo3oz96AWKAw1+GswCHnlTWXRn5DshCcJHlZp4gq3OyRAP9VYrg
	7UUdv9Hpidaa9/BqbVBcfPxD0fqJKsltxeAYQkqYVcetk+URsBoQCDIhrerGvV7QFFEXb0qS1MTYm
	widBQyXioSo7e8bAMvpqsn5tlE7LndoUz/rtw1AJKWUU9MqpDZz7baG4xpMY/r4r8+NRqcI/rLDl1
	pR8cbEpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v61uX-00000001RAd-15TZ;
	Tue, 07 Oct 2025 07:15:01 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v61uU-00000001R9O-3q7b
	for linux-um@lists.infradead.org;
	Tue, 07 Oct 2025 07:15:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vKkg99CfARa2Eat4l30+6iS0TqvXZ0Gg+ksLx9eh+Tk=;
	t=1759821298; x=1761030898; b=IFjjoHoPdv+XH7SZMW14emVjgVoWJRfIEnw5SlpFyum39xp
	9AjsbJuDNv56vLJXevu5HYqsjnKcZATMds8iNe0d5bbP2ftQT9Q+LMS2SSLgLSyWsvLZhICcUFCoS
	BnlGQg2ZL2QYeyu9742VE76f3c8ZH4wlrGty9GI0LhJlxWoIGjcVk1vnP4cLlm4HueMIZ+sMa6vKS
	b01LnFHyx6R/e8dy3P40NoIzrY05t+XSKUWFB63Lt3hCgW+IbkAllSxfnb7U3mVK7kVEhIj/wtaDI
	F+ujtu/1aE26DXxgBB1Yj4YZyTAk8qcpK+v+PSD64IAI61uhZtcfpdjHh8XH1Vig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v61uR-0000000G7NL-2edI;
	Tue, 07 Oct 2025 09:14:55 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] um: move asm-offsets generation into a single file
Date: Tue,  7 Oct 2025 09:14:53 +0200
Message-ID: <20251007071452.367989-4-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007071452.367989-3-johannes@sipsolutions.net>
References: <20251007071452.367989-3-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251007_001458_984598_CD5CFCEE 
X-CRM114-Status: GOOD (  10.39  )
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

From: Johannes Berg <johannes.berg@intel.com>

There's nothing subarch dependent here, and it's odd
that includes need to be done in the subarch, and then
entries defined in the common file.

Simplify the whole thing from three files into one.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/shared/common-offsets.h    | 30 ---------------
 arch/um/kernel/asm-offsets.c               | 44 +++++++++++++++++++++-
 arch/x86/um/shared/sysdep/kernel-offsets.h | 18 ---------
 3 files changed, 43 insertions(+), 49 deletions(-)
 delete mode 100644 arch/um/include/shared/common-offsets.h
 delete mode 100644 arch/x86/um/shared/sysdep/kernel-offsets.h

diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
deleted file mode 100644
index fcec75a93e0c..000000000000
--- a/arch/um/include/shared/common-offsets.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* for use by sys-$SUBARCH/kernel-offsets.c */
-
-DEFINE(KERNEL_MADV_REMOVE, MADV_REMOVE);
-
-DEFINE(UM_KERN_PAGE_SIZE, PAGE_SIZE);
-DEFINE(UM_KERN_PAGE_MASK, PAGE_MASK);
-DEFINE(UM_KERN_PAGE_SHIFT, PAGE_SHIFT);
-
-DEFINE(UM_GFP_KERNEL, GFP_KERNEL);
-DEFINE(UM_GFP_ATOMIC, GFP_ATOMIC);
-
-DEFINE(UM_THREAD_SIZE, THREAD_SIZE);
-
-DEFINE(UM_NSEC_PER_SEC, NSEC_PER_SEC);
-DEFINE(UM_NSEC_PER_USEC, NSEC_PER_USEC);
-
-DEFINE(UM_KERN_GDT_ENTRY_TLS_ENTRIES, GDT_ENTRY_TLS_ENTRIES);
-
-DEFINE(UM_SECCOMP_ARCH_NATIVE, SECCOMP_ARCH_NATIVE);
-
-DEFINE(HOSTFS_ATTR_MODE, ATTR_MODE);
-DEFINE(HOSTFS_ATTR_UID, ATTR_UID);
-DEFINE(HOSTFS_ATTR_GID, ATTR_GID);
-DEFINE(HOSTFS_ATTR_SIZE, ATTR_SIZE);
-DEFINE(HOSTFS_ATTR_ATIME, ATTR_ATIME);
-DEFINE(HOSTFS_ATTR_MTIME, ATTR_MTIME);
-DEFINE(HOSTFS_ATTR_CTIME, ATTR_CTIME);
-DEFINE(HOSTFS_ATTR_ATIME_SET, ATTR_ATIME_SET);
-DEFINE(HOSTFS_ATTR_MTIME_SET, ATTR_MTIME_SET);
diff --git a/arch/um/kernel/asm-offsets.c b/arch/um/kernel/asm-offsets.c
index a69873aa697f..d38447e39d5e 100644
--- a/arch/um/kernel/asm-offsets.c
+++ b/arch/um/kernel/asm-offsets.c
@@ -1,3 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #define COMPILE_OFFSETS
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/elf.h>
+#include <linux/crypto.h>
+#include <linux/kbuild.h>
+#include <linux/audit.h>
+#include <linux/fs.h>
+#include <asm/mman.h>
+#include <asm/seccomp.h>
 
-#include <sysdep/kernel-offsets.h>
+/* workaround for a warning with -Wmissing-prototypes */
+void foo(void);
+
+void foo(void)
+{
+	DEFINE(KERNEL_MADV_REMOVE, MADV_REMOVE);
+
+	DEFINE(UM_KERN_PAGE_SIZE, PAGE_SIZE);
+	DEFINE(UM_KERN_PAGE_MASK, PAGE_MASK);
+	DEFINE(UM_KERN_PAGE_SHIFT, PAGE_SHIFT);
+
+	DEFINE(UM_GFP_KERNEL, GFP_KERNEL);
+	DEFINE(UM_GFP_ATOMIC, GFP_ATOMIC);
+
+	DEFINE(UM_THREAD_SIZE, THREAD_SIZE);
+
+	DEFINE(UM_NSEC_PER_SEC, NSEC_PER_SEC);
+	DEFINE(UM_NSEC_PER_USEC, NSEC_PER_USEC);
+
+	DEFINE(UM_KERN_GDT_ENTRY_TLS_ENTRIES, GDT_ENTRY_TLS_ENTRIES);
+
+	DEFINE(UM_SECCOMP_ARCH_NATIVE, SECCOMP_ARCH_NATIVE);
+
+	DEFINE(HOSTFS_ATTR_MODE, ATTR_MODE);
+	DEFINE(HOSTFS_ATTR_UID, ATTR_UID);
+	DEFINE(HOSTFS_ATTR_GID, ATTR_GID);
+	DEFINE(HOSTFS_ATTR_SIZE, ATTR_SIZE);
+	DEFINE(HOSTFS_ATTR_ATIME, ATTR_ATIME);
+	DEFINE(HOSTFS_ATTR_MTIME, ATTR_MTIME);
+	DEFINE(HOSTFS_ATTR_CTIME, ATTR_CTIME);
+	DEFINE(HOSTFS_ATTR_ATIME_SET, ATTR_ATIME_SET);
+	DEFINE(HOSTFS_ATTR_MTIME_SET, ATTR_MTIME_SET);
+}
diff --git a/arch/x86/um/shared/sysdep/kernel-offsets.h b/arch/x86/um/shared/sysdep/kernel-offsets.h
deleted file mode 100644
index ee6b44ef2217..000000000000
--- a/arch/x86/um/shared/sysdep/kernel-offsets.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <linux/stddef.h>
-#include <linux/sched.h>
-#include <linux/elf.h>
-#include <linux/crypto.h>
-#include <linux/kbuild.h>
-#include <linux/audit.h>
-#include <linux/fs.h>
-#include <asm/mman.h>
-#include <asm/seccomp.h>
-
-/* workaround for a warning with -Wmissing-prototypes */
-void foo(void);
-
-void foo(void)
-{
-#include <common-offsets.h>
-}
-- 
2.51.0


