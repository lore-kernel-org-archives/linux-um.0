Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E994CCA470
	for <linux-um@archiver.kernel.org>; Tue,  7 Oct 2025 07:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BzuUtXbmr2B8qIKAvnZ2uQaIp5WU2irrCgrncJjQNfM=; b=I/uA8ypfghG/EWqmTihjTJ3rE7
	JA8sLWsOSU9VeiHEK1gXNfAzejPG/GG1qhMgJXRX2RZp9s4nArh/EdmRWSUQ7nb5veKPK+QM0jhxR
	QjBN0N8XH1+Qsb688clNwxU06+XbCjbbLtOIo4WYn6qJ0zlFxgu9CD2/JXKD5GlgV8fWy2VtbyyJq
	U+YNWe97SU3haJVVCrh/Cd/0rYQ3edPhFNMGwa9Tj4euzngyx1oazEQmhgwnWEY2C3rcBeRbiahQZ
	1U4aoZvbBXvXZD280YYoMqPLlDWJCdFAOSQAEYjxyPFd6BzNI5Va7xIbtVzbp/iCuESviwpuMHIUK
	Ot8cAtjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v61m2-00000001Qi8-1I53;
	Tue, 07 Oct 2025 07:06:14 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v61lz-00000001Qhj-4BIF
	for linux-um@lists.infradead.org;
	Tue, 07 Oct 2025 07:06:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=BzuUtXbmr2B8qIKAvnZ2uQaIp5WU2irrCgrncJjQNfM=; t=1759820771; x=1761030371; 
	b=dIHZ7uOpI76x/Xs6vJ08e4qvtX9S9LLjqFc62ZyJDNgSy9y00xsN9/3MdFRe+/eipuYBi0iBv6Q
	3A1vXhe28uCJZKc4VyPid/RCt5vIgmux0ePjQwVn+suEmh3eSXpaSozZCGKAM9mVBnchwdtJ7bGVa
	jwicHMjlrTfosz/6+hu3k0MFG3AXMlSl/2M+c03ltbOMjDswMzjqc1MgztIBmWweUV9EkqOz5onKc
	OO/fnSnynPX/2zzCDdYptPgbbyQ9qdzZERIguldKrkx4Ebg7B6FfP9g0LdxP3PpVGLAsGgAPqeKU7
	2NDnnTdFhOejlAswCnIZS4mDhukJuWy1ZRxg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v61lv-0000000G6ry-1dmm;
	Tue, 07 Oct 2025 09:06:07 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um/hostfs: define HOSTFS_ATTR_* via asm-offsets
Date: Tue,  7 Oct 2025 09:06:03 +0200
Message-ID: <20251007070604.366164-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251007_000612_058718_B6AA5ECC 
X-CRM114-Status: GOOD (  15.09  )
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

The HOSTFS_ATTR_* values were meant to be standalone for
communication between hostfs's kernel and user code parts.
However, it's easy to forget that HOSTFS_ATTR_* should be
used even on the kernel side, and that wasn't consistently
done. As a result, the values need to match ATTR_* values,
which is not useful to maintain by hand. Instead, generate
them via asm-offsets like other constants that UML needs
in user-side code that aren't otherwise available in any
header files that can be included there.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/shared/common-offsets.h    | 10 +++++++
 arch/x86/um/shared/sysdep/kernel-offsets.h |  1 +
 fs/hostfs/hostfs.h                         | 34 +---------------------
 3 files changed, 12 insertions(+), 33 deletions(-)

diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
index 8ca66a1918c3..fcec75a93e0c 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -18,3 +18,13 @@ DEFINE(UM_NSEC_PER_USEC, NSEC_PER_USEC);
 DEFINE(UM_KERN_GDT_ENTRY_TLS_ENTRIES, GDT_ENTRY_TLS_ENTRIES);
 
 DEFINE(UM_SECCOMP_ARCH_NATIVE, SECCOMP_ARCH_NATIVE);
+
+DEFINE(HOSTFS_ATTR_MODE, ATTR_MODE);
+DEFINE(HOSTFS_ATTR_UID, ATTR_UID);
+DEFINE(HOSTFS_ATTR_GID, ATTR_GID);
+DEFINE(HOSTFS_ATTR_SIZE, ATTR_SIZE);
+DEFINE(HOSTFS_ATTR_ATIME, ATTR_ATIME);
+DEFINE(HOSTFS_ATTR_MTIME, ATTR_MTIME);
+DEFINE(HOSTFS_ATTR_CTIME, ATTR_CTIME);
+DEFINE(HOSTFS_ATTR_ATIME_SET, ATTR_ATIME_SET);
+DEFINE(HOSTFS_ATTR_MTIME_SET, ATTR_MTIME_SET);
diff --git a/arch/x86/um/shared/sysdep/kernel-offsets.h b/arch/x86/um/shared/sysdep/kernel-offsets.h
index 6fd1ed400399..ee6b44ef2217 100644
--- a/arch/x86/um/shared/sysdep/kernel-offsets.h
+++ b/arch/x86/um/shared/sysdep/kernel-offsets.h
@@ -5,6 +5,7 @@
 #include <linux/crypto.h>
 #include <linux/kbuild.h>
 #include <linux/audit.h>
+#include <linux/fs.h>
 #include <asm/mman.h>
 #include <asm/seccomp.h>
 
diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
index 15b2f094d36e..aa02599b770f 100644
--- a/fs/hostfs/hostfs.h
+++ b/fs/hostfs/hostfs.h
@@ -3,40 +3,8 @@
 #define __UM_FS_HOSTFS
 
 #include <os.h>
+#include <generated/asm-offsets.h>
 
-/*
- * These are exactly the same definitions as in fs.h, but the names are
- * changed so that this file can be included in both kernel and user files.
- */
-
-#define HOSTFS_ATTR_MODE	1
-#define HOSTFS_ATTR_UID 	2
-#define HOSTFS_ATTR_GID 	4
-#define HOSTFS_ATTR_SIZE	8
-#define HOSTFS_ATTR_ATIME	16
-#define HOSTFS_ATTR_MTIME	32
-#define HOSTFS_ATTR_CTIME	64
-#define HOSTFS_ATTR_ATIME_SET	128
-#define HOSTFS_ATTR_MTIME_SET	256
-
-/* This one is unused by hostfs. */
-#define HOSTFS_ATTR_FORCE	512	/* Not a change, but a change it */
-#define HOSTFS_ATTR_ATTR_FLAG	1024
-
-/*
- * If you are very careful, you'll notice that these two are missing:
- *
- * #define ATTR_KILL_SUID	2048
- * #define ATTR_KILL_SGID	4096
- *
- * and this is because they were added in 2.5 development.
- * Actually, they are not needed by most ->setattr() methods - they are set by
- * callers of notify_change() to notify that the setuid/setgid bits must be
- * dropped.
- * notify_change() will delete those flags, make sure attr->ia_valid & ATTR_MODE
- * is on, and remove the appropriate bits from attr->ia_mode (attr is a
- * "struct iattr *"). -BlaisorBlade
- */
 struct hostfs_timespec {
 	long long tv_sec;
 	long long tv_nsec;
-- 
2.51.0


