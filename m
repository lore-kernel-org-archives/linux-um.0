Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D861DC3814E
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z4n0uYG0UC7vwotbUjj/qKB79pJMgDxapYaRkDx1N5k=; b=vSt8rh0z5ZLoPnuVZBcRChVu93
	+wZx4OOoVHVRqbaDnQ9gixTbzEuaaiBoNex4HAmLtnm2U2+X7KmNv4fzRBMrLAWhqNMUj8tIBA0Lb
	/yrHxTWTsSCDI8pV/cK4rcFm71UJ3byQ0cCJS+TiMuSdeOHY7q8O3C/y+yMg3fzSphiCmolaLKzxU
	eXnfHsmgCHGwZV4UUuJP1L5dBNZgQlUeByRzBOcTERQI8owqMaQq8mbEGuj6LI/f1ySpxFwz/B0km
	Mv3lJjQpvBwTZZEyRncWlw6t1KHJQA9RZMjcSvL6qXPldEZKt79tifZ7cROjZUwnnSqYZevp1GqTJ
	CJsfoQaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1TU-0000000AabU-2Lhw;
	Wed, 03 Jul 2024 15:00:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0JP-0000000ALHe-0wub
	for linux-um@bombadil.infradead.org;
	Wed, 03 Jul 2024 13:46:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=z4n0uYG0UC7vwotbUjj/qKB79pJMgDxapYaRkDx1N5k=; b=fdnkUGbxkdyUikdFObqsJPzwcV
	BJdmWKHx6Gg3j2k1dFH38W2lZjA0NMVTqquJI0mdIFvEEAtXACmmC/s5TjNu5nqbUrybRMT86yAAi
	o8bx0WWNPQoP/9BsNwVph7VzXNei1MMPqyqwMNj0lXFU234Ai+vLfd9XeUsx99+XpIiP4UFGOq9Cs
	VSfaKMTFgWLwZcufQB8yhxezVUGOKXX/N9ovUvXGyvORBFimWWyhGiQP+o7m16TNwGmtP6yFFpSor
	vC6dd8LG6uX02DLz4pjpzbA7Ew6uAmg2g3r+XuWWNUs1q4Utfc0WdD8u7NzUG5ANQZIEaE5P2qbj6
	Ay6f3GNw==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0JL-0000000A1GT-1TRR
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 13:46:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=z4n0uYG0UC7vwotbUjj/qKB79pJMgDxapYaRkDx1N5k=;
	t=1720014375; x=1721223975; b=tVWoRjuGQvGZ71u4WqLL8Ki/rAVQJWwIcBCnLKsWb2IjDXz
	HX8O7v5kOL0kOZNuQWiPZXaWFcVDBGcfCVqYjbofuMlhccYqKSSt5M1bye2CRabF53gyChJZeF+bQ
	pwV9Vkysak7npOzQczEvTph6vCCINKO6QhcX+REgW0BalaeWyL9gRu4mhWjwBFDO9//MaLUkAK1V3
	azkIBulxdP1aOEcfXyWnkkQzuZbR71nJGNfGbgSymx2KG8xtsgP4jZvPqROwPDHzcGbybBv3SoDeM
	6TMcusOoJxoKqCECkFx/DSZ46d/JwmWdAyyPtNq70ONQEqE7+3ylz5mg4xpkkdtA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sP0JH-000000094nb-2LUd;
	Wed, 03 Jul 2024 15:46:11 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v4 02/12] um: Create signal stack memory assignment in stub_data
Date: Wed,  3 Jul 2024 15:45:26 +0200
Message-ID: <20240703134536.1161108-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703134536.1161108-1-benjamin@sipsolutions.net>
References: <20240703134536.1161108-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_144615_765462_2B2931AE 
X-CRM114-Status: GOOD (  14.91  )
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

When we switch to use seccomp, we need both the signal stack and other
data (i.e. syscall information) to co-exist in the stub data. To
facilitate this, start by defining separate memory areas for the stack
and syscall data.

This moves the signal stack onto a new page as the memory area is not
sufficient to hold both signal stack and syscall information.

Only change the signal stack setup for now, as the syscall code will be
reworked later.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/as-layout.h      |  2 +-
 arch/um/include/shared/skas/stub-data.h |  9 +++++++++
 arch/um/kernel/skas/clone.c             |  6 ++++--
 arch/um/kernel/skas/mmu.c               |  4 ++++
 arch/um/os-Linux/skas/process.c         | 11 ++++++-----
 5 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index c22f46a757dc..06292fca5a4d 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -23,7 +23,7 @@
 #define STUB_START stub_start
 #define STUB_CODE STUB_START
 #define STUB_DATA (STUB_CODE + UM_KERN_PAGE_SIZE)
-#define STUB_DATA_PAGES 1 /* must be a power of two */
+#define STUB_DATA_PAGES 2 /* must be a power of two */
 #define STUB_END (STUB_DATA + STUB_DATA_PAGES * UM_KERN_PAGE_SIZE)
 
 #ifndef __ASSEMBLY__
diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 5e3ade3fb38b..779d2a3bac5d 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -8,10 +8,19 @@
 #ifndef __STUB_DATA_H
 #define __STUB_DATA_H
 
+#include <linux/compiler_types.h>
+#include <as-layout.h>
+
 struct stub_data {
 	unsigned long offset;
 	int fd;
 	long parent_err, child_err;
+
+	/* 128 leaves enough room for additional fields in the struct */
+	unsigned char syscall_data[UM_KERN_PAGE_SIZE - 128] __aligned(16);
+
+	/* Stack for our signal handlers and for calling into . */
+	unsigned char sigstack[UM_KERN_PAGE_SIZE] __aligned(UM_KERN_PAGE_SIZE);
 };
 
 #endif
diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
index 62435187dda4..906f7454887c 100644
--- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -27,9 +27,11 @@ stub_clone_handler(void)
 	struct stub_data *data = get_stub_data();
 	long err;
 
+	/* syscall data as a temporary stack area (bottom half). */
 	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
-			    (unsigned long)data +
-				STUB_DATA_PAGES * UM_KERN_PAGE_SIZE / 2);
+			    (unsigned long) data->syscall_data +
+					    sizeof(data->syscall_data) / 2 -
+					    sizeof(void *));
 	if (err) {
 		data->parent_err = err;
 		goto done;
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index aeed1c2aaf3c..681839cdd795 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -14,6 +14,10 @@
 #include <as-layout.h>
 #include <os.h>
 #include <skas.h>
+#include <stub-data.h>
+
+/* Ensure the stub_data struct covers the allocated area */
+static_assert(sizeof(struct stub_data) == STUB_DATA_PAGES * UM_KERN_PAGE_SIZE);
 
 int init_new_context(struct task_struct *task, struct mm_struct *mm)
 {
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 45885deb6cae..56403a1b006a 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -474,11 +474,12 @@ static int __init init_thread_regs(void)
 	thread_regs[REGS_IP_INDEX] = STUB_CODE +
 				(unsigned long) stub_clone_handler -
 				(unsigned long) __syscall_stub_start;
-	thread_regs[REGS_SP_INDEX] = STUB_DATA + STUB_DATA_PAGES * UM_KERN_PAGE_SIZE -
-		sizeof(void *);
-#ifdef __SIGNAL_FRAMESIZE
-	thread_regs[REGS_SP_INDEX] -= __SIGNAL_FRAMESIZE;
-#endif
+
+	/* syscall data as a temporary stack area (top half). */
+	thread_regs[REGS_SP_INDEX] = STUB_DATA +
+				     offsetof(struct stub_data, syscall_data) +
+				     sizeof(((struct stub_data *) 0)->syscall_data) -
+				     sizeof(void *);
 	return 0;
 }
 
-- 
2.45.2


