Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE7DCE8E70
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 12:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L+dQEDzV5BXW5CQD2YjjjOC98NP59ek+WZkPOKB6bbk=; b=iD2f/5OuQ/3IQN5Zg7WU8AVI4x
	XQJHbxbzoKDd0Opa5ypEOUocRCA/bLxwQGQd4OpEXdbJYQDivqlj7F9pWmWheF7DG/0gwfxZ2h42+
	IQuv6pKCJFqMC7S06ywXFKDq3W61Hj7/5SFvtRLrFqlrgrpyQp/KSUrVPOUlUgUiYrbcZWRDOD33k
	d2x/sOmC/ka314cTPXEQHRFBfcYjTCoHJn5HXfFbkphRLqtZk9opi7ewEzSftPARCLy01DU3hPlHZ
	odDz9pHUL8cMHkN3KLeJuCOg/Egv6fWpCBFsoIiy02HQi0JAFtWXAyiVo0gzBsoyaJKjOGMGNhwH+
	HHgMs8eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wgV-00000000Is5-1wIO;
	Thu, 24 Oct 2024 12:11:23 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wfS-00000000IdD-3oSX
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 12:10:20 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-20e6981ca77so8025885ad.2
        for <linux-um@lists.infradead.org>; Thu, 24 Oct 2024 05:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729771817; x=1730376617; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+dQEDzV5BXW5CQD2YjjjOC98NP59ek+WZkPOKB6bbk=;
        b=kyO1zACUy5URNqlHqhLaNha7lB3kVgElbc8SVnv2XRNSTTZOeBgW8QMkV+3IFuC1IV
         B9Xxd3eRNK6xQvsu+41DEh38Xz/8/XbgCGIwzHjPyXTXWxUIryfpJzUCNunsBSLH3DwA
         ebu1u8BXpA3a7SEBlSdYKS8KZyHxl2CaRMcQfjdyaRZoWcV3kjxOAzxXS8Dd21QOJLoJ
         G4RPJOTnqgBPR2kAKEfd3w6WflyOmUryIOIS7LJw/Ch4jmFkZZ6aU/6U/aVgoHHWc/2y
         ZKn4Mu9lou9jfbCyF4iZUByD1fqu1IAmtlPdFIxiGpwtb5wpsEraQRAHPKuc/18LeLaj
         jIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771817; x=1730376617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+dQEDzV5BXW5CQD2YjjjOC98NP59ek+WZkPOKB6bbk=;
        b=WuhI/u++FOTEigTkbI8vdKXNXg+Do7V7aq5VM7ZdzYt+FBEkiNGyD3oHePVWPW/lm1
         2FrYORa6qciiRM4n7GI/AVtaTV4DV2KISoaMnFCLKQ20+xaTSYDIyY9OaS4cKSJLkdxX
         +9jfhRCwppe6NAfs2BX7Q7ym7ymPHRAUPh+TWJMWIbH2GPDCNM25vOe/K715lR1CjLWT
         rED/wF7FX16ihuKhhPPWv1USHinSDs21ozh9TQ+iQaqI9dKW4pcqAk2tvdMaCiOHMyej
         L9T/8zBeraArHm9kHjeWibYmzXmi3UHgmJuX0q7aGIACZBX54P08CgkWy/XFKaqZ9puw
         pmbA==
X-Gm-Message-State: AOJu0YybCgGlpOvNu++GnVj/zU3rEQJPHPG3dCVVL10hpvA/7vQn3594
	oSD1J+kzS7InzygRkDaf3KIp1xEJ316A3iVkncXoWpuf8hRPHX2W
X-Google-Smtp-Source: AGHT+IHdbzWUdt+iMrO2u96/fyGQo8nRtyjYtPHD2Yk+4bdXPrA5qTW1KkrERaGIRO5/e46RCUNmiA==
X-Received: by 2002:a17:903:2a8e:b0:20c:d428:adf4 with SMTP id d9443c01a7336-20fa9eb92b9mr84438085ad.38.1729771817439;
        Thu, 24 Oct 2024 05:10:17 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef08d29sm71405345ad.64.2024.10.24.05.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:10:16 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 28194D51257; Thu, 24 Oct 2024 21:10:15 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: thehajime@gmail.com,
	ricarkol@google.com
Subject: [RFC PATCH 08/13] x86/um/vdso: nommu: vdso memory update
Date: Thu, 24 Oct 2024 21:09:16 +0900
Message-ID: <18e83579370620b2b35d35b4ca1b7609d20fb8d3.1729770373.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_051018_976663_2A55DEC0 
X-CRM114-Status: GOOD (  14.57  )
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
 arch/x86/um/vdso/um_vdso.c | 20 ++++++++++++++++++++
 arch/x86/um/vdso/vma.c     | 16 +++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index cbae2584124f..eff3e6641a0e 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -23,10 +23,17 @@ int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
 {
 	long ret;
 
+#ifdef CONFIG_MMU
 	asm("syscall"
 		: "=a" (ret)
 		: "0" (__NR_clock_gettime), "D" (clock), "S" (ts)
 		: "rcx", "r11", "memory");
+#else
+	asm("call *%1"
+		: "=a" (ret)
+		: "0" ((unsigned long)__NR_clock_gettime), "D" (clock), "S" (ts)
+		: "rcx", "r11", "memory");
+#endif
 
 	return ret;
 }
@@ -37,10 +44,17 @@ int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
 	long ret;
 
+#ifdef CONFIG_MMU
 	asm("syscall"
 		: "=a" (ret)
 		: "0" (__NR_gettimeofday), "D" (tv), "S" (tz)
 		: "rcx", "r11", "memory");
+#else
+	asm("call *%1"
+		: "=a" (ret)
+		: "0" ((unsigned long)__NR_gettimeofday), "D" (tv), "S" (tz)
+		: "rcx", "r11", "memory");
+#endif
 
 	return ret;
 }
@@ -51,9 +65,15 @@ __kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
 {
 	long secs;
 
+#ifdef CONFIG_MMU
 	asm volatile("syscall"
 		: "=a" (secs)
 		: "0" (__NR_time), "D" (t) : "cc", "r11", "cx", "memory");
+#else
+	asm("call *%1"
+		: "=a" (secs)
+		: "0" ((unsigned long)__NR_time), "D" (t) : "cc", "r11", "cx", "memory");
+#endif
 
 	return secs;
 }
diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index f238f7b33cdd..36ac644147b6 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -9,6 +9,7 @@
 #include <asm/page.h>
 #include <asm/elf.h>
 #include <linux/init.h>
+#include <os.h>
 
 static unsigned int __read_mostly vdso_enabled = 1;
 unsigned long um_vdso_addr;
@@ -24,7 +25,9 @@ static int __init init_vdso(void)
 
 	BUG_ON(vdso_end - vdso_start > PAGE_SIZE);
 
+#ifdef CONFIG_MMU
 	um_vdso_addr = task_size - PAGE_SIZE;
+#endif
 
 	vdsop = kmalloc(sizeof(struct page *), GFP_KERNEL);
 	if (!vdsop)
@@ -40,16 +43,26 @@ static int __init init_vdso(void)
 	copy_page(page_address(um_vdso), vdso_start);
 	*vdsop = um_vdso;
 
+#ifndef CONFIG_MMU
+	/* this is fine with NOMMU as everything is accessible */
+	um_vdso_addr = (unsigned long)page_address(um_vdso);
+	os_protect_memory((void *)um_vdso_addr, vdso_end - vdso_start, 1, 1, 1);
+	pr_debug("vdso_start=%lx um_vdso_addr=%lx pg_um_vdso=%lx",
+	       (unsigned long)vdso_start, um_vdso_addr,
+	       (unsigned long)page_address(um_vdso));
+#endif
+
 	return 0;
 
 oom:
-	printk(KERN_ERR "Cannot allocate vdso\n");
+	pr_err("Cannot allocate vdso");
 	vdso_enabled = 0;
 
 	return -ENOMEM;
 }
 subsys_initcall(init_vdso);
 
+#ifdef CONFIG_MMU
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct vm_area_struct *vma;
@@ -74,3 +87,4 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
 }
+#endif
-- 
2.43.0


