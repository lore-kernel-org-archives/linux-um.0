Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA88D12D77
	for <linux-um@archiver.kernel.org>; Mon, 11 Nov 2024 06:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4z/4pzvJnEqsoNvP0yTw36MEBQUM24HSeydPm0quFZo=; b=TSB5J/5hcEzxKBx06vUYt31WEm
	gLmccAmmTL3PhG6uaSV4trV1v9XF4w7vsnRwDb/nG+U0olHkJeG1I5ixq61tE4jACUxgBu0/bzMIo
	2OWe0e2tCUlsrspSOZ2xPZ4BUANgjHO0DXXbRpGh2Wt3PwuIjrLJWIs3+uXVTlK5Rc1Z6eDM8wsJv
	+itp6NVtOIo7OfHBJlwjcyPlbSbZF9BHasmgfZ20oLz7KzQMCfGys0FialfP7p8BznQF5zhltfVtt
	V1ed0gPwimw50tJlSmi7WAGkQ3IAk++m19gZZ/3NUwHDpV4/VaIj6wICKipH+S1MkYIpUWr2iy7UB
	ndVocY7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tANuk-0000000GUIw-0y3I;
	Mon, 11 Nov 2024 06:28:42 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tANuh-0000000GUIY-3Jks
	for linux-um@lists.infradead.org;
	Mon, 11 Nov 2024 06:28:41 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2110a622d76so37024865ad.3
        for <linux-um@lists.infradead.org>; Sun, 10 Nov 2024 22:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731306519; x=1731911319; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4z/4pzvJnEqsoNvP0yTw36MEBQUM24HSeydPm0quFZo=;
        b=M7NCg25hKbMY34Xkm5riFEGwn0Qv/Q6cfVJ2BP8puHc4ViM/z/UvN1+dn6uo0kOLp2
         wxi6Yp8LYrctQp/tY8V8+Dig8rNDJJImxUY2w9Mpw+xvHI4lPzdvNtZ06RDNo1jyzKXw
         rYt7fo8sVW0SjL240RnmZcqhwvrkHnLz2kf4Z7gFTuLkY+VvOvI79YPlKn/m29m1DBz7
         8cncE1hKXR3/hHudtwFkEZZ1iOkZMdQ/sk1KIBG0rDM2ez8UZVPMIKupKl774J/RKyMn
         /mTNEG1cXHMh107qTqeYgme5n/Jv/G+G8Cn82RzF+C/0/vyqNTDI84VCF6IWZU3qBYzL
         No5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731306519; x=1731911319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4z/4pzvJnEqsoNvP0yTw36MEBQUM24HSeydPm0quFZo=;
        b=I+Kx4GRNP8iTbfAlwQ26m9+Ohf0qB39+TG18jLZa3sNwwgLE08It3c5cugeezcOdWi
         XzE+pnQ5uBTv86OtCxYTN0GfLdbsDDCLE2G8BgZaC7BGDWJJPunGvDPzbMrCAKRtPDM8
         TR+vTCqToyMZSuuCd3JerUisktyCDphDQ7CsDpPCgIdhAdDDuqNXHmGQi+plQKHOVEMU
         7Skcj2jd5Mtord2/CZwAvDkkM+lXfGSYUjiotc4cfss4l3TfhAJaKLIVfe0M96Kz5WRZ
         6BNCChDuDukGHweZEgYVTR0tinNknn3WHdQEDnbtxqPZ1FDf0IEU5YBa8qqXbBqyBvtC
         J6mQ==
X-Gm-Message-State: AOJu0YxVckitGapgSxEeWscV+56VuSP+V6HC7CHO3aio3AC8kxFCKt2R
	REEzgjotqV7HcraIqO9J6G88dyP77CESF8V+4MIrRBLXOs6v+erU
X-Google-Smtp-Source: AGHT+IFHQ9X7/TrAAs6WcCIqiWxX7A1Ig4cRMY+7UcKdQp/I9O9Vw7sY8/AkJSseFlp1roqehXanmg==
X-Received: by 2002:a17:902:f606:b0:20c:5cb1:ddf0 with SMTP id d9443c01a7336-21183c435fdmr159639215ad.10.1731306518872;
        Sun, 10 Nov 2024 22:28:38 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e58117sm69108265ad.172.2024.11.10.22.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:28:38 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 3CF88DBA924; Mon, 11 Nov 2024 15:28:36 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [RFC PATCH v2 09/13] x86/um/vdso: nommu: vdso memory update
Date: Mon, 11 Nov 2024 15:27:09 +0900
Message-ID: <a00a498ea9803ac3c6f2b933203a2675d1785208.1731290567.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731290567.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_222839_852243_5988422A 
X-CRM114-Status: GOOD (  12.49  )
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
 arch/x86/um/vdso/vma.c     | 14 ++++++++++++++
 2 files changed, 34 insertions(+)

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
index f238f7b33cdd..83c861e2a815 100644
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
@@ -40,6 +43,15 @@ static int __init init_vdso(void)
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
@@ -50,6 +62,7 @@ static int __init init_vdso(void)
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


