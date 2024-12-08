Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF1FE77173
	for <linux-um@archiver.kernel.org>; Sun,  8 Dec 2024 10:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VxwQVsybhdKNONI5OZ03CW9Pb9uuYQgJfh4piPN+9Hg=; b=SR4qKopwKKJJqoGoBkALi8CYj4
	uUY+iB0zR4kHr1P64VSiC2GhDQ4b30oeWU65R96BY02Q7eAPQYtUPJEJN4Pk1AnXXJE/AoMl5r5GM
	2N8Tb7PUcV/MZbiGlg14tYksRx6AqLZrskDloCcCSbO3WLZNsZ26HBtsaj0TzWGXVnAU6BxKELItV
	8qmJOEXxWiGKd6wq/r7K0SaAREGh7if4D0aW1uOKWJOXZQ9Uz2zeV0KcUmhvcKDShT1g8VKDP/30B
	CUNFzJJhK37YAVwS5t+AGPXzBUGGR5aKYNDQcEOQkz7NBWC8TezV5OVFOv9Tg3J19ngOpdV6Aws7H
	3WnnKnLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKt-000000057eM-0ntS;
	Sun, 08 Dec 2024 10:16:23 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKq-000000057cg-1gyd
	for linux-um@lists.infradead.org;
	Sun, 08 Dec 2024 10:16:21 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-215853ed047so33994795ad.2
        for <linux-um@lists.infradead.org>; Sun, 08 Dec 2024 02:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733652979; x=1734257779; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxwQVsybhdKNONI5OZ03CW9Pb9uuYQgJfh4piPN+9Hg=;
        b=LFdjXk014xO5ncNt2J9vP1VYRJVPxXho69xWleoAH/1cH84Xu9Z+7O2Pu4C3V7nlS7
         pA5speISLmh9wLObMET4TadojElRG9srUPzU7PeZlEdydICNjwbm3ihsMe7ykEVWsBO1
         L9lwAIBCTHB6PuTDtqEhs6Jjfkv0EAvjXkXGShHB2rjPP3EdFl8Z7A7eN53Gw4lpw6CQ
         B2WlX9dxWwgYaPQAVbuULk8jtSkjkRaEuMY8+Pqmtw14LEZkLVwJMfcsjWPtbezA2MYR
         dLVvohTjyUFs5SGPN3QJV/F1k/Q8oRxUDygAX3W2kCNfOIMBNF4w0/tGPZxMFputuI2A
         84pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733652979; x=1734257779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxwQVsybhdKNONI5OZ03CW9Pb9uuYQgJfh4piPN+9Hg=;
        b=t2goEWHtdn+vqnzu6f7uMKQqDV/tHXdO9HnXpOf/MQVCPlUCnerHC2V9XfYd38c5WD
         FG/nmCbJlHZETR/Ybjdn0rc2rDPqlgCsuQXF6C45neIs9wq5I/LvSEtzfLXa5iO6ELJJ
         3CFd7cLQMM4yhUREuwG9BKDD2e1RnzAz/VIlt1MqezhUnI26hVlzbWegkC49TTcYay1N
         XqoBArblSI2w83UJJ6x0ydfcAY4BZEtZ2uz4q/8aZ6/BXLHyVpHdnCrPTjXGtT64eT6B
         PO7r6H5dyAqIphhpU7J7Lmcj8zVs1MOnd6FqhHNgBmEE+GJcs6iLbqiJ+B25jy4WwM7+
         VqoQ==
X-Gm-Message-State: AOJu0YwCj4SCuNz5iIjjEvbLc/cqaKj8i9WCwoBFaT6ACtBn7sBsvU5Z
	l33bMlmQjGUr1Y0Z9ZR+U7n7Rfs4bzhnIZ7iEuWEDTVj2pOH63nA9jWSQw==
X-Gm-Gg: ASbGncughGYQ4Ijdagc7g+JMJAQL/Gkoh6nYtdTJR9S6ru5M0ocbWSldTVRWGKdDsf7
	K/asK8z9L5RfLn1oXOOXqEAqHnpXWZTHnyMMpgYyF796XU/UuipTupqN5LU3ko9aqbC5Innnfte
	1c0k7BRFL+tPUIJiGwmT+hPO3ZGGBrBKFlZAFLJTwyunKW9gIZaeb/WDnD0Jx56QWqUR3VLZdzo
	59pYbZqmXW0Hk8TjLVluqoGYZ0hBNAY/4rLNapCO168acvtCQuykNz0DiAfGMJ31d6byBFfdV+v
	7Or2bAOpYYZndz/3pmKN
X-Google-Smtp-Source: AGHT+IH/9ucq5HdSCJY3dXu0l5R/R0sU1zvyZM5ECm3EdsyTuhZ9ScwAfWpkRz/OKuF5Xo4IzUwz4g==
X-Received: by 2002:a17:902:ea11:b0:215:9d29:1a99 with SMTP id d9443c01a7336-21614d8d8e1mr127882155ad.31.1733652979505;
        Sun, 08 Dec 2024 02:16:19 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21613889367sm38866585ad.51.2024.12.08.02.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 02:16:18 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 7B1AEDDB030; Sun,  8 Dec 2024 19:16:17 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v4 09/13] x86/um/vdso: nommu: vdso memory update
Date: Sun,  8 Dec 2024 19:15:36 +0900
Message-ID: <9eed5ceaa7602f09c1cafa25e892a9b74d314537.1733652929.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733652929.git.thehajime@gmail.com>
References: <cover.1733652929.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_021620_574292_78212636 
X-CRM114-Status: GOOD (  13.11  )
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

On !MMU mode, the address of vdso is accessible from userspace.  This
commit implements the entry point by pointing a block of page address.

This commit also add memory permission configuration of vdso page to be
executable.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/x86/um/vdso/vma.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index f238f7b33cdd..2dc38cd77f23 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -9,6 +9,7 @@
 #include <asm/page.h>
 #include <asm/elf.h>
 #include <linux/init.h>
+#include <os.h>
 
 static unsigned int __read_mostly vdso_enabled = 1;
 unsigned long um_vdso_addr;
@@ -24,8 +25,6 @@ static int __init init_vdso(void)
 
 	BUG_ON(vdso_end - vdso_start > PAGE_SIZE);
 
-	um_vdso_addr = task_size - PAGE_SIZE;
-
 	vdsop = kmalloc(sizeof(struct page *), GFP_KERNEL);
 	if (!vdsop)
 		goto oom;
@@ -40,6 +39,18 @@ static int __init init_vdso(void)
 	copy_page(page_address(um_vdso), vdso_start);
 	*vdsop = um_vdso;
 
+#ifdef CONFIG_MMU
+	um_vdso_addr = task_size - PAGE_SIZE;
+#else
+	/* this is fine with NOMMU as everything is accessible */
+	um_vdso_addr = (unsigned long)page_address(um_vdso);
+	os_protect_memory((void *)um_vdso_addr, vdso_end - vdso_start, 1, 0, 1);
+#endif
+
+	pr_info("vdso_start=%lx um_vdso_addr=%lx pg_um_vdso=%lx",
+	       (unsigned long)vdso_start, um_vdso_addr,
+	       (unsigned long)page_address(um_vdso));
+
 	return 0;
 
 oom:
@@ -50,6 +61,7 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
 
+#ifdef CONFIG_MMU
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct vm_area_struct *vma;
@@ -74,3 +86,4 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
 }
+#endif
-- 
2.43.0


