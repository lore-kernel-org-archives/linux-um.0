Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CED1C531CB
	for <linux-um@archiver.kernel.org>; Thu, 23 Jul 2026 09:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I/8aOvCvl4p3pPM2VO66L/wX0WVjP7/aFdJ07fEYHdY=; b=d+jDKwZKOMA8DwFOV/Uc8YfWPC
	6x0+IDJO/b6USneKrqA9VeWku2YdUIMVGZ4l3Akn7lVqLJVOvoMI9CnOwsxyH6ZCohgxh9vHxDfDg
	Vfxy9nzP0S7aJD2EbxXf1njIAoXd9amahHZQCENeLI7LtgLtLHeqgNGJfZ5++f2+3ARtEr74bHOna
	I2ONsrconhonRg9h17AtJDufF1QiS3aRBqgqYX6yZsPj7PDtA5yZYRC9K5nosd93FWJ6svJuNXoda
	eTu+RENkkj/jmwr24YqgDudmq9SD35wkCI+Uk43h0Y55qn17qNvF5uUzIAHhIAJIo5u+TjDVSOf8D
	uO8SEM7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmprD-0000000Drtf-1DOy;
	Thu, 23 Jul 2026 09:36:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmpr8-0000000DrmE-2f8U
	for linux-um@lists.infradead.org;
	Thu, 23 Jul 2026 09:36:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=I/8aOvCvl4p3pPM2VO66L/wX0WVjP7/aFdJ07fEYHdY=;
	t=1784799402; x=1786009002; b=qMo42PUkMKVEE+bzoiKIjUemrCX72B9/pTXrCESE/QqzDCM
	ykU3TGZ7XPSMo/LZTDRzLlCW3UjvSEh1AiAK7Zu9C0U9aijwZthupTA4z5BnZGBF03fUDwBStQdVf
	mwNd5zkVlKxCC0DhtnXtBW/omVM+iadYrnYbiO6R9TzSom1GBohPOsWFZeRysnOKagF+0aFiR1PO5
	naVnBHBIx7Amg3zehJAI6eGrbjLdXNqoXB0o9ELJL+ng5J4/MXZPduPEtT1rrOUV2yFKipWaIJuHT
	2Vq0GOfwbDqg9FbHnkIBRWOPQXDY8Qz6n5JvmPrLnfDu5S8mSTaj4RdjO3FNUJJw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wmpr5-0000000Aeqq-3P70;
	Thu, 23 Jul 2026 11:36:40 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>,
	liam@infradead.org,
	ljs@kernel.org,
	Ricardo Koller <ricarkol@google.com>
Subject: [PATCH v2 05/10] x86/um/vdso: nommu: vdso memory update
Date: Thu, 23 Jul 2026 11:35:46 +0200
Message-ID: <20260723113633.6393b6b5c614.Ia508c720e53c944e663430117899fb4912021d8a@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723093633.140989-12-johannes@sipsolutions.net>
References: <20260723093633.140989-12-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_023642_701299_7DD4B0CB 
X-CRM114-Status: GOOD (  14.24  )
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

From: Hajime Tazaki <thehajime@gmail.com>

On !MMU mode, the address of vdso is accessible from userspace.  This
commit implements the entry point by pointing a block of page address.

This commit also add memory permission configuration of vdso page to be
executable.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
[remove print, add comment on #endif]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/x86/um/vdso/vma.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index 51a2b9f2eca9..8e1f5ee44f4e 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -9,6 +9,7 @@
 #include <asm/page.h>
 #include <asm/elf.h>
 #include <linux/init.h>
+#include <os.h>
 
 unsigned long um_vdso_addr;
 static struct page *um_vdso;
@@ -20,18 +21,25 @@ static int __init init_vdso(void)
 {
 	BUG_ON(vdso_end - vdso_start > PAGE_SIZE);
 
-	um_vdso_addr = task_size - PAGE_SIZE;
-
 	um_vdso = alloc_page(GFP_KERNEL);
 	if (!um_vdso)
 		panic("Cannot allocate vdso\n");
 
 	copy_page(page_address(um_vdso), vdso_start);
 
+#ifdef CONFIG_MMU
+	um_vdso_addr = task_size - PAGE_SIZE;
+#else
+	/* this is fine with NOMMU as everything is accessible */
+	um_vdso_addr = (unsigned long)page_address(um_vdso);
+	os_protect_memory((void *)um_vdso_addr, vdso_end - vdso_start, 1, 0, 1);
+#endif
+
 	return 0;
 }
 subsys_initcall(init_vdso);
 
+#ifdef CONFIG_MMU
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct vm_area_struct *vma;
@@ -53,3 +61,4 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
 }
+#endif /* CONFIG_MMU */
-- 
2.53.0


