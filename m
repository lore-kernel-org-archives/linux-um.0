Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197EECA0EFF
	for <linux-um@archiver.kernel.org>; Sun, 24 Aug 2025 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AZUgzDSlOQo2n/wfmPCfCySZHQCIjEluJ3AqIU5SzeQ=; b=IUfFsrMlXyXcADy8KARMVBVvCS
	KGI502/eMR3p0UI/ZUdNtXDK3zR3UtKizKyFAJz3BfGtQIQSHESXYFoMxS4TrOC9aGPWikmVO30uA
	1/i0b/ZpxgLl/gb9R0pY+Fb3yytfjNLtW+pJ3mnKhCCmVRmWuhTyM5wEyrqP6py/MK3qMULUBcTr5
	pdN83lAanzEupR+8yJ3dLs6LrBe8bF0CiKb8ck3A/CmqX7Mm/vI4g8UzHJyzxgAuPtol/sHvkIv1z
	y3UuQ+6+1qbgVW84uKHvcagOrMn2UDCrOyNY9XKLszvtzWfbue/MN2s7/c5pPnRaybuVFuHVJ85QR
	vLNmohpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqCuI-00000006JJf-3ceF;
	Sun, 24 Aug 2025 15:45:22 +0000
Received: from out-186.mta1.migadu.com ([2001:41d0:203:375::ba])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqCuG-00000006JGN-0AfT
	for linux-um@lists.infradead.org;
	Sun, 24 Aug 2025 15:45:21 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756050318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZUgzDSlOQo2n/wfmPCfCySZHQCIjEluJ3AqIU5SzeQ=;
	b=OduANwByrwWzpO52dV/CH16wIYbZFiXDjEVJuUc7e7zNimFw22l/4FTFgG/jTdLkjg/hX5
	ZwT/WtKF4TUscUqA6pCHBAEMOF/iNHqLLFBEr//mitw31Tjr3qBXo9VyfS0MXZKXyBjQzW
	n9Zw/3cpwlWrwMJVbN3M34mLw4GXLGQ=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 7/7] um: Centralize stub size calculations
Date: Sun, 24 Aug 2025 23:44:25 +0800
Message-Id: <20250824154425.2243375-8-tiwei.bie@linux.dev>
In-Reply-To: <20250824154425.2243375-1-tiwei.bie@linux.dev>
References: <20250824154425.2243375-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_084520_249593_F3EBC39C 
X-CRM114-Status: UNSURE (   9.93  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

Currently, the stub size is calculated in multiple places. Define
a macro that performs the calculation so that the code is easier
to read and maintain.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/as-layout.h  | 3 ++-
 arch/um/kernel/um_arch.c            | 4 +---
 arch/x86/um/shared/sysdep/stub_32.h | 2 +-
 arch/x86/um/shared/sysdep/stub_64.h | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index eacf18ec9d0c..7c7e17bce403 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -24,7 +24,8 @@
 #define STUB_CODE STUB_START
 #define STUB_DATA (STUB_CODE + UM_KERN_PAGE_SIZE)
 #define STUB_DATA_PAGES 2
-#define STUB_END (STUB_DATA + STUB_DATA_PAGES * UM_KERN_PAGE_SIZE)
+#define STUB_SIZE ((1 + STUB_DATA_PAGES) * UM_KERN_PAGE_SIZE)
+#define STUB_END (STUB_START + STUB_SIZE)
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 2f5ee045bc7a..6cd464c9095f 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -331,9 +331,7 @@ int __init linux_main(int argc, char **argv, char **envp)
 
 	host_task_size = get_top_address(envp);
 	/* reserve a few pages for the stubs */
-	stub_start = host_task_size - STUB_DATA_PAGES * PAGE_SIZE;
-	/* another page for the code portion */
-	stub_start -= PAGE_SIZE;
+	stub_start = host_task_size - STUB_SIZE;
 	host_task_size = stub_start;
 
 	/* Limit TASK_SIZE to what is addressable by the page table */
diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index df568fc3ceb4..9dc2efaf5df1 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -129,7 +129,7 @@ static __always_inline void *get_stub_data(void)
 		"subl %0,%%esp ;"					\
 		"movl %1, %%eax ; "					\
 		"call *%%eax ;"						\
-		:: "i" ((1 + STUB_DATA_PAGES) * UM_KERN_PAGE_SIZE),	\
+		:: "i" (STUB_SIZE),					\
 		   "i" (&fn))
 
 static __always_inline void
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index 9cfd31afa769..9fd56954e2e0 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -133,7 +133,7 @@ static __always_inline void *get_stub_data(void)
 		"subq %0,%%rsp ;"					\
 		"movq %1,%%rax ;"					\
 		"call *%%rax ;"						\
-		:: "i" ((1 + STUB_DATA_PAGES) * UM_KERN_PAGE_SIZE),	\
+		:: "i" (STUB_SIZE),					\
 		   "i" (&fn))
 
 static __always_inline void
-- 
2.34.1


