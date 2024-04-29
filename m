Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC02C25B10
	for <linux-um@archiver.kernel.org>; Mon, 29 Apr 2024 13:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2LfZ4MoJ+9KROOT5YK74Hxu9SnlJPUZk7LmiCFjzKsE=; b=n2EyDm6favZ3yVYs6MWqaLAQvT
	9fgzTnp/1psltWVuAK+7MsE2ZJYOz/8oOETXCIfgIzL5GQPQagGx2P1qzWhyGi9AKwz8PmQmtHlYQ
	ZZWbU/2IM16Pzek3mbsVaeAWUA9P2XDFpsucH6XMQlhHUNDUTGgAGstz4hfLptfestv59rTnvTM0X
	b8FgZUVu9UpIDGFj6YTeXp3WFkoUdBuIrJSMOlv0Vx1qxpPfeyz9+KlB2A+7b6ZYs3c9nYm31g9OD
	Pi81pQKJCdb9HgFQ2zdkMNEbNyAxs0IhHuuRukIxhPNz9kGhkhZBmnzlcdOZ/f9frZV0adm7C8U1N
	fPbT+OIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1RMu-00000002zxH-0272;
	Mon, 29 Apr 2024 13:48:32 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1RMn-00000002zpV-12xW
	for linux-um@lists.infradead.org;
	Mon, 29 Apr 2024 13:48:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2LfZ4MoJ+9KROOT5YK74Hxu9SnlJPUZk7LmiCFjzKsE=;
	t=1714398501; x=1715608101; b=v0DjKkA0cloWMZZlXA7aPEu2C+HJkVnUeagyKOPw6XKMOGc
	FVdli7KP96MYCFtotZGk1B4LtqfwcsFlLyHRE/yDKxQ6d/h2CfvBJJVI9xI0Je5TN1ndnACPZJc4Y
	AfGPBmca9QmVJ4UOwvCZ6o9ososYwUG27cKREJMSThl+Ci9lPmcY+ykXhLM9+Zcje4W3e5pXynNwN
	RonJqSqoDUV1bZ6imurxjMEx0p5wfbaYyfhC30SGclXnFiQn6S91Nc7vkQk4H0O7ui5gbTLx/0Ccg
	53qAxX7vae4eOdrYapDlNsWS8Bs9wZ/1L8mO7TQKa1D8B4eN7aOTakbPayDOmprQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1s1RMf-0000000CW0d-0Cbp;
	Mon, 29 Apr 2024 15:48:17 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 02/12] um: Create signal stack memory assignment in stub_data
Date: Mon, 29 Apr 2024 15:47:49 +0200
Message-ID: <20240429134759.244517-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429134759.244517-1-benjamin@sipsolutions.net>
References: <20240429134759.244517-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_064825_547856_139F8B8F 
X-CRM114-Status: GOOD (  15.30  )
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
index 9ec3015bc5e2..4ef98c0339fa 100644
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
index 656fe16c9b63..b6b9679e6e11 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -13,6 +13,10 @@
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
index 1f5c3f2523d1..72114720be10 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -470,11 +470,12 @@ static int __init init_thread_regs(void)
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
2.44.0


