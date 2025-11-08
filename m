Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C025CD1292
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 08:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KXlvIxBTzUi2fvQwFF5f1ABJZvc5EYR8EZzXkNvyLME=; b=k6Y2QtMTgPQ7lfnaAVrhPezWHs
	2wEV7z/kSUGIiSOjglBuSdky0y8RutveWOSXGVOF8peA6FfbQRdRuyVqd+8FewYYdmsWANTNZjxGK
	M/cP0fVewocsPOcb21cDcWwM9CAaqT0QoSV6AM1b9im910RsBOPU157G2JRofGTDMuBP4cSs7cEvJ
	IaUdXlVR9LPnNK0FiBVzwjVtD3UdUq9ikddrCw6nbskZy9nfowWXPNpJFp/mZ2gi/zmzwZa2QrCca
	G25V/5h8Gjynbl/Fdu4SoD7S5ruRSQoRxYA85dfW1MSxlIHEcgWJLQc4YRFmj+kjKxc2AX4jvcqfC
	q1jnM54g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxi-00000002j1Q-09yE;
	Sat, 08 Nov 2025 08:06:18 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxf-00000002izZ-4Biy
	for linux-um@lists.infradead.org;
	Sat, 08 Nov 2025 08:06:17 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-782e93932ffso1266294b3a.3
        for <linux-um@lists.infradead.org>; Sat, 08 Nov 2025 00:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589175; x=1763193975; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXlvIxBTzUi2fvQwFF5f1ABJZvc5EYR8EZzXkNvyLME=;
        b=HG+DL91MZucMofdGRJ1EmcSFEEDmTdgnxqZiSPQQ1/xC1eEAnq5nng2blQ2R5/8Krq
         m7bJCuFsKkzwNZytRf2hVcfrpWKxDCyylapk8dBe3jWryEbVJq1JDnUbfHnsF0ml34xy
         TEmW8cCtnCQht17mLHWie8ZDOow8z6NkRZK2RfiOCWUr4zz4HSWNfxu7EcSHCKyslAkh
         qaONr+v03T02Ix63+101UsVNLk+E742KMODLK3dM1W1Fee6IhvGqHbX5/Bbm+THQI3KI
         8joWqo48rM17Bg0o41uC+6BCQ1fRNshduq5/GJByfyJIFTsEYsmJwLAlY48B7yaav9sW
         O+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589175; x=1763193975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KXlvIxBTzUi2fvQwFF5f1ABJZvc5EYR8EZzXkNvyLME=;
        b=P7mvFYnMzSfLS5ZTELJICL7gzq0mSAZLcEbeNwpE7evE/AKPDIWn5Nnt/+cgX1vdG5
         fQCrpnpqGdRn7J3h3RdboRsvXnaykS9VTnIOqi4zElRQk+d2zWb5tjwa2arcxHhiAHuJ
         f70KB7V6Y8/uqySsfgCL8ZjN/2LKPENTuTobu/eXAJ2dJe25fZ+ZW2X8VymgLYpIpf75
         cMKKHFaAtFbZRyGvRQgnZxhR1U0WfPnD/C2ahkY+lvgTaI27YzvMu5mBQl6Mbw+W9VIL
         rsqsui5gMoULmLaCv/7/KCOaJTcm2F8+8LGeAYl3fmKZ2fIk6SF25TYQdXUbZ05SfGOa
         Nu0A==
X-Gm-Message-State: AOJu0YydW8POnCB3CzsOqvQND5vuyWDEUKhJ91iAJurhEUo1OM5EOHy6
	YO7gtWpGJa5q2Tj4HJltaNJtaAjUMFpiCZGcF6baEHVri1Ihjart5qtbFQex/A==
X-Gm-Gg: ASbGnctI/LgzceZtAFrpaS3rwQo595X69r2z3xRShCbTbvs52sREv7pKLBsjCQqez9p
	qfUYze7U6vqA+yG7ng1tr6dH6TnVbYwVOG7WBxFAOeHbxDnuxiRrAIe2Vu3mzq1nbhtTpifyobM
	uubG25ttTV5I5fzKq/iv1XHH5fB0effVCzAdfEYJVu2MFL5JbBlJjjdw+D00nfLpKA7ogTO4M10
	cS3GkHixJPsJ0hO2PdQEn4SPStWFMTeHWsYW9th1ktTZt44Qzca+z5LXFhFXutYw6wgd8OMPFOm
	p2FDlcUYW+jfK9nQWNqwZ1XRiKKowj6BlzJyBqIgXfWkBm8SvNneA6NFmk8szn4G7LoaPnroXlY
	txyMhn1shBvPe92ENYHVKbQFN1cE3geSzHdkliXSkxwWYxmdt5VCZefx667LBVHDRyAZJ9ZuKE9
	mnWD12+G1thYr5T2Kml+ihFExh4+ppyn5YNgwfqTA3Vh/45Q==
X-Google-Smtp-Source: AGHT+IGD48yU+7r6eJf4t73UQMq9PCzXek9Pp9f1XAQMtlPt+4CKZ0imYX/Cbn2ZTgd9N+RvP0eTWA==
X-Received: by 2002:a05:6a00:4605:b0:7aa:81fc:a83a with SMTP id d2e1a72fcca58-7b225acd5b0mr2845940b3a.6.1762589175204;
        Sat, 08 Nov 2025 00:06:15 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9632e22sm5333782b3a.8.2025.11.08.00.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:14 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id BE10811388D5; Sat,  8 Nov 2025 17:06:12 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 08/13] x86/um/vdso: nommu: vdso memory update
Date: Sat,  8 Nov 2025 17:05:43 +0900
Message-ID: <a689fc371d0207ba83c9e0d2e9335be7095b73be.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_000616_049077_A174295E 
X-CRM114-Status: GOOD (  13.63  )
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
index 51a2b9f2eca9..0799b3fe7521 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -9,6 +9,7 @@
 #include <asm/page.h>
 #include <asm/elf.h>
 #include <linux/init.h>
+#include <os.h>
 
 unsigned long um_vdso_addr;
 static struct page *um_vdso;
@@ -20,18 +21,29 @@ static int __init init_vdso(void)
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
+	pr_info("vdso_start=%lx um_vdso_addr=%lx pg_um_vdso=%lx",
+	       (unsigned long)vdso_start, um_vdso_addr,
+	       (unsigned long)page_address(um_vdso));
+
 	return 0;
 }
 subsys_initcall(init_vdso);
 
+#ifdef CONFIG_MMU
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct vm_area_struct *vma;
@@ -53,3 +65,4 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
 }
+#endif
-- 
2.43.0


