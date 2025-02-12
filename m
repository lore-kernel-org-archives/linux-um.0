Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809D6C02198
	for <linux-um@archiver.kernel.org>; Wed, 12 Feb 2025 04:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=l3cySQwtW2L6IPLiAVn50hsL87KnNvGabd4tA/yuZJk=; b=YcdgXv/giVKfydM/LMOFaLZ2VQ
	zZYPnZq0xmODpx8990LV+imZFwpWO/fn4xDt6Ecsxmalv0A8EGpFIkx78WalHx4Pi9V2k5VnHDcpg
	UOfCJ7enUfnBe5dx8bB7Uk5HNvl9L+g2ZVPWRCObvUODaiBaMKK2evzbq+NLIJiDM9TOSovflNWCN
	3Qc3gibcw3uIgubNB7aZReoWaGeLrpCqfbjF2pLqltb68lw+zLAnqLBUzwcSCTR9/LbvjgRP8HWYr
	9prVHANWQJKcapvT+F04tNafBUJPVZmY9QFBu2BQbFXxdCn+ogAMg2RsEz5g6NVSFZzstdvoTIZ91
	nfdDDw9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ti4pF-00000006CCV-1cCT;
	Wed, 12 Feb 2025 04:58:17 +0000
Received: from out0-195.mail.aliyun.com ([140.205.0.195])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ti4pC-00000006CBI-2g1T
	for linux-um@lists.infradead.org;
	Wed, 12 Feb 2025 04:58:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1739336287; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=l3cySQwtW2L6IPLiAVn50hsL87KnNvGabd4tA/yuZJk=;
	b=JhhvGA/pwo/ha8SJPp+n3pVEs/D0Pyc0Yk1mBy/6bEibRqdX9QyYlCyYT75/7DfI7RvWg576+9cBJzjRk2exBRyNCyC/O29JblRml7yjdvSy6PFWlwJ8VKBDJTe2aVEWPVMfO9vP1g79sT7wWXb49bzwFgJw1H+IHLYqBfvCcpw=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.bNm9VfJ_1739336279 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 12 Feb 2025 12:58:05 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH] um: Allocate vdso page pointer statically
Date: Wed, 12 Feb 2025 12:57:56 +0800
Message-Id: <20250212045756.164977-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250211_205815_209343_A973D331 
X-CRM114-Status: UNSURE (   9.84  )
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

Instead of dynamically allocating the pointer to the vdso page during
boot, we can just allocate it statically. Doing so will reduce error
handling and make the code slightly more readable.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/x86/um/vdso/vma.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index f238f7b33cdd..dc8dfb2abd80 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -12,33 +12,22 @@
 
 static unsigned int __read_mostly vdso_enabled = 1;
 unsigned long um_vdso_addr;
+static struct page *um_vdso;
 
 extern unsigned long task_size;
 extern char vdso_start[], vdso_end[];
 
-static struct page **vdsop;
-
 static int __init init_vdso(void)
 {
-	struct page *um_vdso;
-
 	BUG_ON(vdso_end - vdso_start > PAGE_SIZE);
 
 	um_vdso_addr = task_size - PAGE_SIZE;
 
-	vdsop = kmalloc(sizeof(struct page *), GFP_KERNEL);
-	if (!vdsop)
-		goto oom;
-
 	um_vdso = alloc_page(GFP_KERNEL);
-	if (!um_vdso) {
-		kfree(vdsop);
-
+	if (!um_vdso)
 		goto oom;
-	}
 
 	copy_page(page_address(um_vdso), vdso_start);
-	*vdsop = um_vdso;
 
 	return 0;
 
@@ -56,6 +45,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	struct mm_struct *mm = current->mm;
 	static struct vm_special_mapping vdso_mapping = {
 		.name = "[vdso]",
+		.pages = &um_vdso,
 	};
 
 	if (!vdso_enabled)
@@ -64,7 +54,6 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	vdso_mapping.pages = vdsop;
 	vma = _install_special_mapping(mm, um_vdso_addr, PAGE_SIZE,
 		VM_READ|VM_EXEC|
 		VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
-- 
2.34.1


