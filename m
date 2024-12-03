Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB540E6C5F7
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 04:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nagiCt5mWA5GX5pqysKkXUfyEfAfDG/eL2r4mfE2Lhg=; b=m550KLuV+0QIEnHzgYII9tqF5/
	48vMIHujm8XmBTJgpSQHzVkWFD9XGiGmKGdKMJtCsdYH84cyK3PiTJnEPm7ZHN023jiBhZt9AFtHO
	zGpEAS08Q0vdsRTH56sPEmO2OYT7uhSBE3+pvU6wDenQ/fE2fseZf/F7eD97fXTuG6Rhqi5/ssTJL
	AlLoKwN81quzTD/f5knzc/NWVsAZmutHFfPuuMnyETd3vcUMjTfj5+ZzSjRnX7VURNukpLiqdYBHB
	gQV20lyEsUYs9cIM82WiOj4sEGLhHaaUZ5BUuRVsfgulBraHbt0/rEv2qyl5kRvnSEL+t3BLcGWc3
	LabvqMGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKS6-00000008DUA-2EeD;
	Tue, 03 Dec 2024 04:23:58 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKS4-00000008DSu-1C4e
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 04:23:57 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-7250844b0ecso4197848b3a.1
        for <linux-um@lists.infradead.org>; Mon, 02 Dec 2024 20:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733199835; x=1733804635; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nagiCt5mWA5GX5pqysKkXUfyEfAfDG/eL2r4mfE2Lhg=;
        b=jx7DzuBjE5Q9rSmhFRjZaIbAAbEFvD76GpUflM06elRGupzTOz+ri9FnI/cMZyt+PQ
         ZhjHltlqrpoP7mraxH1Zxz+eoQIMsCh0R/EKpdipr76iFS1h49Pc5IJh1+FD06mHb+7y
         w39G4bm3OoP2lj1OMDzMrFRvJ9uSxQdrUK8FDHTIlnzwsr+IQHGc8GJY+KR7si8NuwaR
         OmuEXP2DFM6J0aKRIZWrdYhqW0Hjmjc33WybmAo9jxSEXolZ/yTJkVahqKwn97yuRDK1
         NM9CbIRznJVJPWgzQFPQcevRYz/5ytLUa9vmgMCohp3+7jOZzVa/5GuJaMdzvoK/S2XS
         ho8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733199835; x=1733804635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nagiCt5mWA5GX5pqysKkXUfyEfAfDG/eL2r4mfE2Lhg=;
        b=Pd63vFc8O6sjE9ECKo+941bEB3S/it4hZkVxYEsBHcT6CqlfVDyevNCQ9DzhLUeOPq
         jFPAE/gf0RfyT3CJnYcTQuC38acwEiFmtg51Acy0jXL+57+OD1z6Pjyan6dDQqM89Iqa
         FB1IHsepsH2mpiaOIigBw5UAJUmg6t76i/ReHCGaSuEOmPLXsZBBLDUfUfN0u6AiRQ6j
         TGwSSkWmB8+lgQvh0wjsc3WnPd+ifYdLViywYq8hiEI1QSuYhvem3711Whybyd9k/nC7
         EiZiSfXc5+6qQ3/swLrEjGgyzcKr6A2pJagPPY2GF5MhASw8i/55gezXEz8cZrk1MZ/y
         k34w==
X-Gm-Message-State: AOJu0YwVQWmhXkMtqzmzVEA7UChC9aYSxGSQhLjSUfVuiYTMkZ6uAEU3
	kQRWg++fHe5TIVNgzRPrZ5IKI50EYERrVnn9jb9CVjerHduleUu1
X-Gm-Gg: ASbGncucdcgxT5nnalALMWWK4kz/u6ZEcg7aUUeYsJtAKOzJ3w0h3DG4C8DpdwFRNGB
	7pjdR1busxJ0+Rd7QnknHF5DQGd1e0s6Fd5uRkCBFHfUcQLuquLIySvKR/BT2zXgJAGj4EVnK7Y
	D4MXONlJ4GHa7qs2nDmHP4cqEvJpZyVptGQZPW/L3lyKLW+BShrQ7middZI2lteK1eFIv9aGMu8
	uwq+iEioZKTkZo8dBG/0heCummS6G4U71WvgJRnqDh/Ijb4btdhKAie5iRfemsegyvJeMZNAoL4
	ZoNyCzHP/akRmrWB8dyv
X-Google-Smtp-Source: AGHT+IGn1JVSRYVHcAfz3QIvqLNFTt+ReV7SsVdi7RpPa438WYqEcCjJez3+Ix0mRGypjqvFlWfhxg==
X-Received: by 2002:a05:6a00:3c8c:b0:71e:f4:dbc with SMTP id d2e1a72fcca58-7257fcced2cmr1475023b3a.25.1733199835235;
        Mon, 02 Dec 2024 20:23:55 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541761453sm9389880b3a.37.2024.12.02.20.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:23:54 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 6B705DD3A09; Tue,  3 Dec 2024 13:23:51 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v3 09/13] x86/um/vdso: nommu: vdso memory update
Date: Tue,  3 Dec 2024 13:23:08 +0900
Message-ID: <303a5869c8688b15a757516b082a80e1258f35de.1733199769.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_202356_323698_188DCC48 
X-CRM114-Status: GOOD (  13.89  )
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
 arch/x86/um/vdso/um_vdso.c | 41 +++++++++++++++++++++++++-------------
 arch/x86/um/vdso/vma.c     | 14 +++++++++++++
 2 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index cbae2584124f..a78d095655f1 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -19,15 +19,35 @@ int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
 __kernel_old_time_t __vdso_time(__kernel_old_time_t *t);
 long __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
 
+#ifdef CONFIG_MMU
+#define __VDSO_SYSCALL1(sysnr, ret, a0)		\
+	asm("syscall"				\
+	    : "=a" (ret)			\
+	    : "0" (sysnr), "D" (a0)		\
+	    : "rcx", "r11", "memory")
+#define __VDSO_SYSCALL2(sysnr, ret, a0, a1)		\
+	asm("syscall"					\
+	    : "=a" (ret)				\
+	    : "0" (sysnr), "D" (a0), "S" (a1)		\
+	    : "rcx", "r11", "memory")
+#else
+#define __VDSO_SYSCALL1(sysnr, ret, a0)		\
+	asm("call *%%rax"				\
+	    : "=a" (ret)			\
+	    : "a" (sysnr), "D" (a0)	\
+	    : "rcx", "r11", "memory")
+#define __VDSO_SYSCALL2(sysnr, ret, a0, a1)		\
+	asm("call *%%rax"					\
+	    : "=a" (ret)				\
+	    : "a" (sysnr), "D" (a0), "S" (a1)	\
+	    : "rcx", "r11", "memory")
+#endif
+
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
 {
 	long ret;
 
-	asm("syscall"
-		: "=a" (ret)
-		: "0" (__NR_clock_gettime), "D" (clock), "S" (ts)
-		: "rcx", "r11", "memory");
-
+	__VDSO_SYSCALL2(__NR_clock_gettime, ret, clock, ts);
 	return ret;
 }
 int clock_gettime(clockid_t, struct __kernel_old_timespec *)
@@ -37,11 +57,7 @@ int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
 	long ret;
 
-	asm("syscall"
-		: "=a" (ret)
-		: "0" (__NR_gettimeofday), "D" (tv), "S" (tz)
-		: "rcx", "r11", "memory");
-
+	__VDSO_SYSCALL2(__NR_gettimeofday, ret, tv, tz);
 	return ret;
 }
 int gettimeofday(struct __kernel_old_timeval *, struct timezone *)
@@ -51,10 +67,7 @@ __kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
 {
 	long secs;
 
-	asm volatile("syscall"
-		: "=a" (secs)
-		: "0" (__NR_time), "D" (t) : "cc", "r11", "cx", "memory");
-
+	__VDSO_SYSCALL1(__NR_time, secs, t);
 	return secs;
 }
 __kernel_old_time_t time(__kernel_old_time_t *t) __attribute__((weak, alias("__vdso_time")));
diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index f238f7b33cdd..093fed27ad49 100644
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
+	os_protect_memory((void *)um_vdso_addr, vdso_end - vdso_start, 1, 0, 1);
+	pr_info("vdso_start=%lx um_vdso_addr=%lx pg_um_vdso=%lx",
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


