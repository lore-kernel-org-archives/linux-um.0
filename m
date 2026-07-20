Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96A3C4452D
	for <linux-um@archiver.kernel.org>; Mon, 20 Jul 2026 18:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oaaoMiKfsi+ZQm1+oOag/gblwhWR02viRN4QevvfU9A=; b=lRonRTJ7Bceai8e1S4464hLqA2
	JT9bVKdZEP6EF3dQtI7TJyxfRmFptZNmnFmEaQs2gLoUm4O9OKaY25GIUA5CJCfQJMxPARu6IEz5A
	kF+K4X8yitkoiiS6K7efzuUMTEhT1RQM79aUzxpGa3wKYYekE9ETdnRJeUzNst7OGVWvf26WASPs5
	dQNEs2cLE/Cq2F68ZRdw3nMjW6jwCCIEOqWwUmaz5lHFjqB9JCkjOOx5R9mpt0KI8lulXA3tc/EVi
	alrWuN7QkkJqkZJASStTtzO/uWiOoIi8X7G7zViF5ePgE0kIZ8b73FsYgsFp3aGh56p1DhXzJGPzU
	KxE5MyvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlt5E-00000007h4n-2NuH;
	Mon, 20 Jul 2026 18:51:20 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlt59-00000007h11-2hZE
	for linux-um@lists.infradead.org;
	Mon, 20 Jul 2026 18:51:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oaaoMiKfsi+ZQm1+oOag/gblwhWR02viRN4QevvfU9A=;
	t=1784573475; x=1785783075; b=usu0usLTub+IPwOxtwBzuNSal858v7GMKDAPZS/FgfSqEzx
	2dDn2ES1pjO9Ko5ITBLX8N14uaSSAwqoGVsock1F6IHfm00N93B1ouXsYbGCp3X+bq8eI3QlUYOGC
	FkSrPzI1Fypyx3WoCaTl5YDTmAb6Qvkc9u+CtvxbDpTKHF8MdKGTp7VyTkFFdvmszGAjJ3K5JKM2N
	byRaLITg29NLeh9zdFtyXb3mBTHJphDHkv0DFFp2YY/N1kDkoeISsAig3lsgQlNfEV1GOetuyYrOZ
	X+A2ppfmEWMbhYNYWwuMFhYQFMrSvL3VaXLquML+mJYxXmC+MHX4U2lONSjMIaQg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wlt55-0000000GsPP-0ehk;
	Mon, 20 Jul 2026 20:51:11 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 5/9] x86/um/vdso: nommu: vdso memory update
Date: Mon, 20 Jul 2026 20:26:55 +0200
Message-ID: <20260720185103.530603-16-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720185103.530603-11-johannes@sipsolutions.net>
References: <20260720185103.530603-11-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_115115_994931_668E37F0 
X-CRM114-Status: GOOD (  14.35  )
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
Link: https://patch.msgid.link/1779dfb80f0e6fc25c001062a1e00cb661531c23.1770170302.git.thehajime@gmail.com
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


