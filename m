Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9CFCAC5A8
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 07:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=; b=RfRIuR6RSQAReS2Q+O7yxxgA+P
	cLb0EbSP+OBxAh3krqTIvqzcYTP5CgvR0CNFYQdHp/pkfJNPIhcTGdayTaMknZo1owwdUW1eqotjJ
	N0NWR8eYBwKVfHsPmTV49bEtwUZ0QZGGNvLd/CKTx4H5VIUdfXI1stROC03vJQYvcswrLnakHDNTl
	DlyxMRA8LYHW2DCWvKRsajjfRq7RSVzeLTUT1HgohnsIe2BzsP2pGK/Dq7zREgQhiwU9cuqWZcKKG
	kl3d9YOhz4s8U/JPSI3sJSXLhtASVYVqB+VBBgc34JitsMg9sx1sTVhUZWt2gt8Lj/6gPXEgw1DMG
	8wLQ6FpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Eq-0000000GZEs-2xZd;
	Thu, 18 Sep 2025 07:39:32 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Em-0000000GZA3-3grw
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 07:39:30 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-25669596921so6700565ad.1
        for <linux-um@lists.infradead.org>; Thu, 18 Sep 2025 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181168; x=1758785968; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=;
        b=AyB8x2PJ7RmbkUvtNxuvH/8i8EomKU14aeb3N7XtRlnvAw2ZppsJJkzU5LWyiRRg/M
         RtYcWN/+s3biQ4k97jKIZTA+PN3mX/gUj+tEJW9fX6i7t0VZpvp55VdEwaytjsS5e66u
         NAAeyveBXiZVVB6ENWhxXUJvVIOV0opW1qAdB2xN3y3y28nyg1mq7D8gbJx38mjJj8pR
         HlShXf1w5hdAVxTMTet6/v7gXsEP4JsgJDEZ73szpBfHtTQXHx/fEiFJvZAAMfgKroS9
         AhDxntjdBes9BpBJAr8khaods7JbmiFwnrJXVDbHhnJYE+/hjlZjKxeW+wLqbf6EUxwA
         pwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181168; x=1758785968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=;
        b=Ro3tjbkcLHQgoI+rXvlo7AF4u99+WIXDLJPE4QdsOB9Oa/EH9o8w13ldBkjscxrvAf
         r4kdIYnTH+qzxc3kfnknMasBPP4ywmDIrKrqy5CZ/k0ng5uyHai6eUfm9tnARUq2IrrU
         Bs6h1D7ukhlp8VUJYAHv9avAdpZtoECIjH6jPQdgsHGatEPQSPxKNsMp1ZyAqvzSPI48
         H5K5doKivZlrG+KDMOr+Xhue4bKfIavhZBVsMKeuD/l9oFi5uxE4A8e7ls0byr5mqSER
         lZZxzcC3BI+SEB6OSL4sxLTmyEauMNhu96fgs6qwh1lkvdV5dIuskAJX9pcmYE9KcQPf
         SNsw==
X-Gm-Message-State: AOJu0YxV984DJYjqL6IcTFAkEOIhJH2isXK1pr7acYAhvT0GrSIiBVqn
	xev0I7Cispe3PSN6cLoM+HNraVCTbva5UH9aullC03XXBeISom4drLwS
X-Gm-Gg: ASbGncvyyjmUj3boXkbG8xrOkfjrcT+bvWtzYuDkjRPAmqXYnL0KH3+8c5ip4S7GVL4
	jU3wqfJs/Q4N8IzD0/u8RiYlOudbzW/vMLaI1apVQFnekKzw/4Ulz+I6KawYnliI7PCImX8br8F
	SJCQOoe+/3KLBE3DEmBwQKegUkpR6qDvoTx6NsduEnBNZgfHU8HfQ83p7pp/DywQnzJ1pYNdcqo
	SQ9gkwBn+XvVnihJAMwXiPZcpcNd/i5Q0nuoIytalUDKOfN8YihZoOnD0qParacvZLPKBrlt8CK
	Mf0XpgQjoOfTupkVmaBYATPbd4MMKaZvQxJoTlh4QGzxo9sTO/nZOVhW2cl7/+3ZV0sM6qInl7r
	QBhV61LioLbqelkHAfeJOqo7XmqPxkFsTLPMKZQaEROB/um5H+DGf2bDveb00SsbBfkzEOC0+0P
	+s250GAaSNOiqayXDh6ZpFiA==
X-Google-Smtp-Source: AGHT+IHNzuZzI3jPq8s+w/v0EJThDoVKmlAiVRMnAVUhLpF0S4fB/x53BdW1cn1NajqHcqRK1lVQ1g==
X-Received: by 2002:a17:902:e807:b0:248:811e:f86c with SMTP id d9443c01a7336-268138fdf0bmr60148035ad.34.1758181167976;
        Thu, 18 Sep 2025 00:39:27 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802dfcfasm16349805ad.73.2025.09.18.00.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:26 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 78363106210A; Thu, 18 Sep 2025 16:39:25 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v11 08/13] x86/um/vdso: nommu: vdso memory update
Date: Thu, 18 Sep 2025 16:39:03 +0900
Message-ID: <0f3c31aab253b7a76f96ba758150442d72b52ee4.1758181109.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758181109.git.thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_003928_926675_07981271 
X-CRM114-Status: GOOD (  14.55  )
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
index dc8dfb2abd80..1c8c39f87681 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -9,6 +9,7 @@
 #include <asm/page.h>
 #include <asm/elf.h>
 #include <linux/init.h>
+#include <os.h>
 
 static unsigned int __read_mostly vdso_enabled = 1;
 unsigned long um_vdso_addr;
@@ -21,14 +22,24 @@ static int __init init_vdso(void)
 {
 	BUG_ON(vdso_end - vdso_start > PAGE_SIZE);
 
-	um_vdso_addr = task_size - PAGE_SIZE;
-
 	um_vdso = alloc_page(GFP_KERNEL);
 	if (!um_vdso)
 		goto oom;
 
 	copy_page(page_address(um_vdso), vdso_start);
 
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
@@ -39,6 +50,7 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
 
+#ifdef CONFIG_MMU
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct vm_area_struct *vma;
@@ -63,3 +75,4 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
 }
+#endif
-- 
2.43.0


