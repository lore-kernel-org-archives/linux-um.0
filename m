Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299DBC77B7F
	for <linux-um@archiver.kernel.org>; Sun, 22 Jun 2025 21:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=; b=fR4peRA9SKG3zg6zgqXI147PYd
	N8YslN45t982TxF8r98fslS9TcvhbBDw73Qlw0rm1e/S/Eh8aXd/oSYekHQ6i5Eeev35uTON5Xrpb
	nH1HB085HyAqmQlzH+KpPhLbTtHgGcXr09T/4GakCLoYvhooQ5ZH60Hw7K8P3kY189Q87MiH1jptZ
	57gndiSdkf3kZ4Ef9YxkGJKHCMmWuGxgYlpYMVTmt/gzaLUWg+rBEpFpx8a06PI99lHq1BZrt0bbu
	LY1SU/zImx6ufmUmpxLET4Fjsu39HlV1i2y1IbfnlQesZXNBTp4sUMnH0V9d3ovO8108u6mSFm59v
	VHTWCQcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSKH-00000001F5c-2fPZ;
	Sun, 22 Jun 2025 21:34:09 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSJk-00000001EuM-4BAj
	for linux-um@lists.infradead.org;
	Sun, 22 Jun 2025 21:33:38 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso2937199b3a.0
        for <linux-um@lists.infradead.org>; Sun, 22 Jun 2025 14:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750628016; x=1751232816; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=;
        b=EnNNRIN8tiHQZzRWEsc8PFOh8Yrbm7XeJwS1iZ9ZZPfu2+kRjEyt7aO3zvpUsYdNuZ
         AzCACZugfhn1n1i6RfVa/tO3ddt35YFEgvONsCgIRFyyc4HHNt29DAnOem5D07LPUaS8
         paIJFucCuG7WFmLRxN3VEcIi2/mqB50MBlOSm/I0qJQJupTJ6aZZfYEfYwm7XdVLemIu
         vIE+SdVDrD4gD/oDqKp/gUOGN688kEDEfsb5RscYnichL4kUJFJB95mBWdMdI0Bmvqz8
         MGTT+DBpg9QAzkL+/xthf1MDkJ/bP0MAcrTY3gFg8ukghu7AZ7I776zjcvs3/AUEexEz
         JDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750628016; x=1751232816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=;
        b=boOWpO+Efu/x4gwcnb8czH+4CPCMaUdXgMXY4lyLdLTBTxVA2rTLJzjA+Ng0j5Zy6r
         W/5JJ0zO7lCH0S5u5wONGpXBtPYYnbaUNB4DxrJtIjnGSja8bSBwB+jmRfTvOXDlUuUS
         FHQ2zTzSe6zwNFTTouaN3Ds9nk72noJmdyfq7uyaUtPqzPwJRTe5SXzSqnKP8a1d6mTD
         2kUucV5YrrGIAPWtRyRnSsqMmuC4s9fl4IaqDTrVohfsFRP0kvIhOqglfZU9l5FDSdqd
         lIHuDCEWDfPontygQtcbNBc277i9ue81xFXEyoUnt9aBgz+333jRaKK59DfJtH2g0CUN
         kauQ==
X-Gm-Message-State: AOJu0YwxoqYYp3TqNDBagSX0o1hMThsAwNU2zLgGmNkkaHQqNfiP9858
	L320p/MFhKo52KnQgvZVnb/QNbyejdzhMHmOvwtJEjshhcROTXXnm3bG
X-Gm-Gg: ASbGncvbJC7TXGfFClu+aZy/G+4uCKhlmBG4JTBorzphL46NouPDfCFS2b9mZDG3TY2
	Z5m6aIVTYfuJz94oz2OKjFjkhDmqEDbctZDIHhs5alpw92YsRxkoLZh3Bnn3D/JDKEl/KFm9QkP
	rFybNXLVAgvgH5W3PcTzxSh87ZOVKnPDCA/YfzXvIr3YXJEsnKZLl4mHRUdBjV2d+tAxjsTCDKr
	js/598oyW8+8OhU7YASWHp/qK2lhRm54OmWAxxpyCAUGtggEWFDV1DR08NZ3OZH7SxW1Rxe7FDQ
	i1wk2Gi0DxmfGEO9VAJD6nboemDBoXGQEmFdVYSkGVgO+BpPvlywN2R1VYQqUQZkjU2cwSWpUMz
	gEn6U8sKl8Umb+EW+d3wILZNY6g6Won9w
X-Google-Smtp-Source: AGHT+IHrrJwTveE1DrjrmwA8iNFWeSED2zb/Yvu8dxfkj2CbC/FxRJjNGr3E1Hy0RND7HchK71ZUmA==
X-Received: by 2002:a05:6a20:431d:b0:215:e818:9fe3 with SMTP id adf61e73a8af0-22026eb0730mr15937527637.27.1750628016251;
        Sun, 22 Jun 2025 14:33:36 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1241f20sm6274763a12.45.2025.06.22.14.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 14:33:35 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id DEBEDEF1EB4; Mon, 23 Jun 2025 06:33:32 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 08/13] x86/um/vdso: nommu: vdso memory update
Date: Mon, 23 Jun 2025 06:33:06 +0900
Message-ID: <0b7d3061a6053731b9499d6a1e373314ef9f12d0.1750594487.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750594487.git.thehajime@gmail.com>
References: <cover.1750594487.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_143337_046203_D8B46BFE 
X-CRM114-Status: GOOD (  13.91  )
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


