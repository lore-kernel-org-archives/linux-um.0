Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAFCC02190
	for <linux-um@archiver.kernel.org>; Mon, 20 Jan 2025 06:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VxwQVsybhdKNONI5OZ03CW9Pb9uuYQgJfh4piPN+9Hg=; b=xIp30F7rH0ByqqkMuzsi3zEobW
	fufp7CFiWlq5TP5BbPPgFRlzPbqasojtxr+V/woMW/BQ/qORXWGIQns8SGR7buMoo91fIxIlo7ec2
	D3LahYkkM+GheUp7KJDb/VOrmklK/elB3FjyxKpn8pWWypqufswHlIfosS5t+61hgq3ePDxxDYHZj
	DqLNLeKDH/2Ofzlg8dT75fnuNW1VWBikde5FmUofdPd5jYyQSdQgHRiJuf+v2lU37l/XBGECnDkzJ
	pwUL/i1pnBLXCp6PuIR7ECSBITnHG4IgT2688QVFv/aCtNZPE+ObnMw22Y7VLx2NTI3eTf2/LHB9O
	LbnanY3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkr3-00000004nSe-1wG5;
	Mon, 20 Jan 2025 06:01:45 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkq2-00000004nIL-3kwg
	for linux-um@lists.infradead.org;
	Mon, 20 Jan 2025 06:00:44 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-215770613dbso51878835ad.2
        for <linux-um@lists.infradead.org>; Sun, 19 Jan 2025 22:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737352842; x=1737957642; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxwQVsybhdKNONI5OZ03CW9Pb9uuYQgJfh4piPN+9Hg=;
        b=U+BdYPbP805gCN4OiZ9jv2uDMvGSUeMLCpk0NNNyh1JOZF1PxSKqr50AO2Gjyz5obX
         N3gKj9Pd0aYgxH1YR3dCkhNDfaOupfIgDOfJfVLZHE1Laeb8X0GSe4wypoQ4bZ4/wVB6
         NrmBEho7hm/Pi3sIgXHKnim3q1PBPpS/LyEHzWoL+A5LrqIscCTxRRz/OFBr5G8bIhoV
         NLTqH7++jWxBoI/mv9nIpOeVwnOfr6ptS/siJtdD1zQDL6d9J3KsBN7YLNT0UdSb7R7A
         q53yT4+WXyBQF+l2KbKLca2Fkmo9N1PpzTwzOKgd2aUsCEsYty94hEXB+oHzowaczNDg
         bd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737352842; x=1737957642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxwQVsybhdKNONI5OZ03CW9Pb9uuYQgJfh4piPN+9Hg=;
        b=hzCK692SxRNnf9SQCeTATfc+CfehB6M0z7XbdY7IP0QNX0CktYtPPQAEVD4uZDO0XA
         eavWIkoBYH+wzLflM97GQSJf39CSiem4uRF8Z6YDlXGsS3mG30RQ99PSmLYIx05jq8aO
         D9RsQuOsJtYP36SJFEXrqnoE29w1Lqmsxupux0b97VkoCyFyX1GvBU2THzvJdDNjgjUT
         YGq/MD/Na4EZ41Ryfd54RUy0xl+H1QTs2rWL2rVONXiouOe8YWh3VxjW5M09eJg9cCCp
         ziHJu7v5yVEbRXxyyCJ9hlfBQWjHMYZiuuV9QpebFKqxdBaofjxtdUtfKyWZrs7k9bfz
         +3Cw==
X-Gm-Message-State: AOJu0YyIChRNGkflVWSFU9kKjqQavoPtsuMB7eEOqct1KWKV0cqZbnNy
	YVQZWLfqiB4tC8haSBywD+eNzX23VBEME2me+NmECjgweg1r7x82rzjdaw==
X-Gm-Gg: ASbGncsugbvLWUNt2Mwu2szzCWYjQg5Eh5jT/5NVuet0aBPxsOJRw3JbzKydXlUK1gy
	+XJAd4fo2W8if5DmN9cja4wibJjs2GfKtSnmQHFgsc0IiFJ9FZnvExxBwzI9Ff6fJE/1uAq0gJS
	9wfokKYAoyMAhDgvoI5f24PIdIdHiIOfAFOnjSp+mH4Eh/od5RXoA/tN04pm7Lt+Ohq0BGS+FjM
	s1D3j3F+heXH+qIt+eyZNx0LUiUgzxvPzL8QWNbTFndu+xFpo70xUJX9MbBCbmpVUpSSszduouz
	cD/S5H4nOZdIo3YvJSN9JjRMgC4U9pGudhau1hlk4w==
X-Google-Smtp-Source: AGHT+IHj8lmDNXSdAQE3D4VePTTOUKDrcumLiv6mXaBVu2lBrW1NFLR6vI/Fy+8MP6DRF0gYlnjM2Q==
X-Received: by 2002:a05:6a00:a883:b0:725:a78c:6c31 with SMTP id d2e1a72fcca58-72daf9bd027mr19081051b3a.3.1737352840431;
        Sun, 19 Jan 2025 22:00:40 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabab64e0sm6349720b3a.173.2025.01.19.22.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:00:39 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 56294E27534; Mon, 20 Jan 2025 15:00:37 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v7 09/13] x86/um/vdso: nommu: vdso memory update
Date: Mon, 20 Jan 2025 15:00:11 +0900
Message-ID: <781f39e0d3ae2ec9bc1ac50f7d725e6bcf5e4fa9.1737348400.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737348399.git.thehajime@gmail.com>
References: <cover.1737348399.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250119_220043_034939_E34C1BE8 
X-CRM114-Status: GOOD (  13.50  )
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


