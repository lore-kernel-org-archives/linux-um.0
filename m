Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05694CD4F3C
	for <linux-um@archiver.kernel.org>; Sun, 17 May 2026 23:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JRMBAbgRVexPfq6YzE4iuqHwU1pkT7p6WoFGRBKz/5o=; b=K2PALFHtWgVjL86YEDqNpBo7m4
	D1qg/ovbmFmYNdAUseSCe+K8cQ4Oa8IEgVwfCI9QheAx1zMAHLNlMAcVcnF4O0zJOpslGlPH99GsA
	9qV01WpBILQjH5fJBBFbSdc/H7Bz08vKX5BPnr4FIxxhvQw6v8Ku8KGAmyEteya/hRMRZukGGrr6w
	8cjiG8oN/dc8yQOQ1kZV4uDQnfz6w5YXYyAR2uNtMHpLjEokelnsXAKyc8X+60gwDAzD2wAcRNpyA
	H0Jor8YJnJ5YARUAMOYd5zoqWaK0SunZi+op6GU1KJx5p6/fwTf4vJYJFDtDm8XKEVlcP+5eKJ56k
	P4ZEeOJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOl38-0000000Dg01-1X3E;
	Sun, 17 May 2026 23:37:34 +0000
Received: from out28-169.mail.aliyun.com ([115.124.28.169])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOl34-0000000DfyI-0evi
	for linux-um@lists.infradead.org;
	Sun, 17 May 2026 23:37:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1779061042; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JRMBAbgRVexPfq6YzE4iuqHwU1pkT7p6WoFGRBKz/5o=;
	b=Yuz8yuXQ6O2bG5IAXIkxCFGku1P1dB5otm7UDvKbrk95TCb1NRVHyTtQa1vbNynXhtFWRI9LdRIpDO6n554VSjDFydycSK2mC9LKAJ8EAcnvqD2NkrOnFsc8vaVi1KuwgIXE9c453icSHK7sNFBWEbOLTYi257+Xmbdh5txmlwE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---.hZWRg1x_1779061016;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.hZWRg1x_1779061016 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 07:37:20 +0800
From: Tiwei Bie <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	Tiwei Bie <tiwei.btw@antgroup.com>
Subject: [PATCH] um: Tighten exec permissions on page mappings
Date: Mon, 18 May 2026 07:36:41 +0800
Message-Id: <20260517233641.127433-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_163730_734918_C53C2E60 
X-CRM114-Status: UNSURE (   7.51  )
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

In UML, page mappings are backed by mmap, which allows us to
effectively manage exec permissions. Introduce a _PAGE_EXEC
bit so that pages can be mapped without granting unnecessary
exec permissions.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/pgtable.h | 25 ++++++++++++++++---------
 arch/um/kernel/mem.c          | 16 ++++++++--------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 88ea8434364d..6304026a2b2e 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -13,6 +13,7 @@
 
 #define _PAGE_PRESENT	0x001
 #define _PAGE_NEEDSYNC	0x002
+#define _PAGE_EXEC	0x004
 #define _PAGE_RW	0x020
 #define _PAGE_USER	0x040
 #define _PAGE_ACCESSED	0x080
@@ -55,14 +56,19 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 #define _PAGE_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED | _PAGE_DIRTY)
 #define _KERNPG_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
 #define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
-#define __PAGE_KERNEL_EXEC                                              \
-	 (_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED)
-#define PAGE_NONE	__pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED)
-#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED)
-#define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
-#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
-#define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED)
-#define PAGE_KERNEL_EXEC	__pgprot(__PAGE_KERNEL_EXEC)
+
+#define _PAGE_BASE		(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
+#define PAGE_NONE		__pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED)
+#define PAGE_SHARED		__pgprot(_PAGE_BASE | _PAGE_RW)
+#define PAGE_SHARED_EXEC	__pgprot(_PAGE_BASE | _PAGE_RW | _PAGE_EXEC)
+#define PAGE_COPY		__pgprot(_PAGE_BASE)
+#define PAGE_COPY_EXEC		__pgprot(_PAGE_BASE | _PAGE_EXEC)
+#define PAGE_READONLY		__pgprot(_PAGE_BASE)
+#define PAGE_READONLY_EXEC	__pgprot(_PAGE_BASE | _PAGE_EXEC)
+
+#define _PAGE_KERNEL		(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED)
+#define PAGE_KERNEL		__pgprot(_PAGE_KERNEL)
+#define PAGE_KERNEL_EXEC	__pgprot(_PAGE_KERNEL | _PAGE_EXEC)
 
 /*
  * The i386 can't do page protection for execute, and considers that the same
@@ -117,7 +123,8 @@ static inline int pte_read(pte_t pte)
 
 static inline int pte_exec(pte_t pte)
 {
-	return !pte_get_bits(pte, _PAGE_PROTNONE);
+	return pte_get_bits(pte, _PAGE_EXEC) &&
+	       !pte_get_bits(pte, _PAGE_PROTNONE);
 }
 
 static inline int pte_write(pte_t pte)
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 1eef0e42ef5d..7a018357aba4 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -115,18 +115,18 @@ static const pgprot_t protection_map[16] = {
 	[VM_READ]					= PAGE_READONLY,
 	[VM_WRITE]					= PAGE_COPY,
 	[VM_WRITE | VM_READ]				= PAGE_COPY,
-	[VM_EXEC]					= PAGE_READONLY,
-	[VM_EXEC | VM_READ]				= PAGE_READONLY,
-	[VM_EXEC | VM_WRITE]				= PAGE_COPY,
-	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY,
+	[VM_EXEC]					= PAGE_READONLY_EXEC,
+	[VM_EXEC | VM_READ]				= PAGE_READONLY_EXEC,
+	[VM_EXEC | VM_WRITE]				= PAGE_COPY_EXEC,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY_EXEC,
 	[VM_SHARED]					= PAGE_NONE,
 	[VM_SHARED | VM_READ]				= PAGE_READONLY,
 	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
 	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
-	[VM_SHARED | VM_EXEC]				= PAGE_READONLY,
-	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY,
-	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED,
-	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED
+	[VM_SHARED | VM_EXEC]				= PAGE_READONLY_EXEC,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY_EXEC,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED_EXEC,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED_EXEC
 };
 DECLARE_VM_GET_PAGE_PROT
 
-- 
2.34.1


