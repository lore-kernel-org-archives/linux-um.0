Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98759C7115C
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 01:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=; b=Ym8cUaVLaxDoDociypIUMyeRiC
	vKx7cMTQ3NYINkrAJPdZ/PoSjh+hMPzoUwuQbFPlpHZds8/SfcbRymbNEKa+IY6E1e7yXjM0+Yoln
	g6kCZwcgxMlqMDLaEaQXzibfze9VMHDVj2GBLvDvqi4E1Q8X6hil0MMkfydY8/JBFJcTUoinx7u8T
	nseRxRBaHYetmjRwrsGFKB+Bu8ZwFE5ZyjcZIvnXD6NX9WdU01lCmChv4pUQ16Boy9q9rTDedcfzB
	L3s7QlGMLxEaPYjElR8hpxAFzZzJIB3ecrUM+hpB/r9niSyY1SckzGNJa0kNAMYHmp6TR0ZeGtN45
	hawRt4UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3i2-0000000BgjM-1Uf3;
	Thu, 19 Jun 2025 01:04:54 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3i0-0000000Bgh2-1ekJ
	for linux-um@lists.infradead.org;
	Thu, 19 Jun 2025 01:04:53 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-313a001d781so113424a91.3
        for <linux-um@lists.infradead.org>; Wed, 18 Jun 2025 18:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750295092; x=1750899892; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=;
        b=Ic8z0gvgiblVd4xCaISHTfO6dIoZYvaK+paKlGwiV9PbO2EMdPIKEy+kydVqJt+lSo
         uwmjsjtqDt97KDyiUy18Ntdh0UZQP9f4+DrwA88iiWDsh/i0TDN72ck0idrbYJ3x/8X0
         slfzgPjKS//NMRrDRB3XuU4PSuoSnBYflHYJ28G/G/yp9Q9rtbZGUNn7rV4QgTaCUut7
         KoJueOOmdFQp2+kJe41552ZlfGc0N+Y38TDD3sD2h+fXA0lIV6poW3cZsDWTUPMm5JHU
         fRomZdFirKcffv8f4x965lwRXzBzpfxB/Pag3OsUS3UyHZHB6h2b3NKo1Bzojo9iL3mR
         bj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750295092; x=1750899892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=;
        b=wVXtBm+1Ur82jmUOZBYCf0fvMh2R1R+U/CB0aRM442mitZ0pTbmUsbMc9+6I2OACow
         wAu92B2MPpf67Z+3lrSLSh8EF2d+jOiT1TE3wvxX1ZAE+eAOg8TQGz3mvYfUJs1pySu3
         zfKGQfxA2KNQcCc/q3pjbalA1hXsLjbjAw+GO97/dmgEBKNgi8ua4Lj9mYlCKdbZPMXs
         ibiOyq6kMrt4/vIq1/KpADKYVT0vJWKcImvbTAJrpWPknXaviMwtDKhguSYGKSGOQ5ZP
         hAZxC52s+u3zUJ000QwQL6ebOMIHeTMfDk0TTSjZ7S4Afi40HuAva0ju20ix7hleL5+H
         OqDA==
X-Gm-Message-State: AOJu0YwIr1n+FYGLPAxc59+eP/B6SVJPZ46mM2e1R570I6heLlBghYbx
	syRNkOw2Q16Pelhd54Bgb6aLVQzh7YkrxqIsD5TEqYxNUU2c9q3lboZc
X-Gm-Gg: ASbGnctAR+7S2Kf6ZvYlg4WQo0vYGzhFjh8UeTT/Ad6JUtsBkyBTBOurR0XI9mPdfu0
	uKykjsX6CT6iEQJeoXBRY5KsWI6XVEX83zlhTQVEuvhFGSiceWcvmy16/9MiG0Dgchpeb9I7K7J
	KDxHv2gWD4UNrviCBiHxD7/jdZBmeXb864+gNBJHlPpPuZnpgD5JzxwsH2mnNoA0Xi6fOtGTNoZ
	1kkPcaECsdfUvH5u0fuBzT1iUdPOsjymPuqI25lMPMmn8fe94eVTgHPTneU1Pbg1H5qg2jqMj6N
	zm36AIN08WgHxJ+7Yx320v9QWdNNhJTRCE+Tl1I4eh2uIrWRVHZCp8ydy9k8jRXtRwVeFUzl13a
	Q3GGuwyhRjlRu1MgzyyQXFW5enWc66LV2
X-Google-Smtp-Source: AGHT+IFATU8cH8BDAswTDg8t16Qex6ZAiu2Oi4jWZUV6j/DJuzeYMglD71cpXwlvvkHyyfeb+uGavw==
X-Received: by 2002:a17:90b:268a:b0:313:283e:e881 with SMTP id 98e67ed59e1d1-313f1cc5abbmr29510777a91.11.1750295091595;
        Wed, 18 Jun 2025 18:04:51 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a25617asm840600a91.33.2025.06.18.18.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 18:04:50 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 26684ED6538; Thu, 19 Jun 2025 10:04:48 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 08/13] x86/um/vdso: nommu: vdso memory update
Date: Thu, 19 Jun 2025 10:04:12 +0900
Message-ID: <207204e01eab3318e475f80be9fbaece51dd13cb.1750294482.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750294482.git.thehajime@gmail.com>
References: <cover.1750294482.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250618_180452_452931_324E31B6 
X-CRM114-Status: GOOD (  14.58  )
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


