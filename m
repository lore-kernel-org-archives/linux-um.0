Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471AFC02186
	for <linux-um@archiver.kernel.org>; Tue, 14 Jan 2025 11:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a4qzPlb3D9VCFUyuRjUxUUJ/e3JRyLtND6gaWf9vBJo=; b=CWAQ84ECTC+Z6iVMTHR6Jc+F/p
	SINrJN7yrtP1o7EDru376o33QGOQlkgccOsfo1ZLO71XuUPcrNFhJG5PUPp3hokrt/ZbzAyAR/apY
	d+A3wgsyKU3Tx663URlsC7XuBsCqxoGfmMbiX0Iav1IQSNPh8ZOebZumQlZj5XJcVzvFtfAs8p7Wi
	YWT2a26DSBVohSWr55Ofd1bOF8mkMYOQKFqRgo3asq/553SjztEg09+ZdLrPmtTG9XfXzk3Jws2YI
	1uBLOCdgFyrrhmce8/lho/srBPB+myRd8Ba+aaIQMldxiW2K2ZljbGnLqguW7TZ/CIBpXdcXCZDV3
	bUItRBEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf9b-00000008GJz-0Ak6;
	Tue, 14 Jan 2025 11:32:15 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf8X-00000008G2t-0ejE
	for linux-um@lists.infradead.org;
	Tue, 14 Jan 2025 11:31:10 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2163bd70069so96334205ad.0
        for <linux-um@lists.infradead.org>; Tue, 14 Jan 2025 03:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736854268; x=1737459068; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4qzPlb3D9VCFUyuRjUxUUJ/e3JRyLtND6gaWf9vBJo=;
        b=TN3Ih4xBwq12imuQ3PJtI10w2JncFVrz3kDAyJ3Rs0y7wCY1o4njtCEM4j7o6lXVMv
         T9aUamvQcQBjkpDvxoVCak8xpNwZiCqh1SyIDyoNiqe5WmpRiv5GwPNhtx1pwvCcWQQ8
         jnd9fhnRB93Uk8RsmZP36Ohg8fPYOzaM0Qo3QFgzD7Zn4arGldJTcD+WCUCiJ9c0yM8X
         CMMw31JBXFOt0TnE2RLWhc2us9YhMzKMuwtP0WNXT2bg8S2QoofqTj/bjtxY+nv2sjZm
         nDnez9WgHtF8mK4qJFu9zEcaUZ7k6VpbbVXIYVHssYRgh6SYKONnGUwA3Aq5xzOZi9Wa
         2HIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736854268; x=1737459068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4qzPlb3D9VCFUyuRjUxUUJ/e3JRyLtND6gaWf9vBJo=;
        b=hQseeKvNkZpLERUPBeDVeKHUQOiGgalWd5qU1PxY72tBBC4jFsiNtCoXcBDCyU/ZfJ
         68fqP4daOWQ+ieFzfho81M7Fpf8tzS6TxWBTUqP0NdTKjfqv44MP+DLTb8/vUQ551vbm
         QQCkNVH7XTq4qrHfnZ39BrUZVIl3NW65oinWQSEXiJbRXaw0n8ed0PNQmtIV2f1PybT0
         pg3/l+LkDVt/Mm4G/G9bwsWvgbnG2STyFGDmBrc3OoOkHr8GTP3yJKS9LDblvyajTxPR
         q3G0rqnGCOBpZKz5CEZTWDVdY+5BVCtCnAUCgUWroDGnRhb4GJZ0YeIeutbFlO1kwRTH
         ACMA==
X-Gm-Message-State: AOJu0YyCT5eJZZPh3Jj0heiPKcLXziSUSMr8oBX89rXe/rJnQn1gzHuL
	PqiO1eEnfjMNX/Yydbrg7s0Ff+wS6S917lIuZ8W+15I/Vhs+SLQP
X-Gm-Gg: ASbGncsnuBr3ZlZGMrgO6xuzj8tsCinFqXhtyeAicMJ6FLVaDYShhwnP2NwPMMsKTh3
	w7g2neKXzmBxI6nnxKU5tXXtnwb++ifjGWYvqul2wjCvJBMkCgX0Uzvil8u1Pcg9ozL3rAq2fa9
	TvGBzkhF+YXk0kRgjio06VdDpCS2Xpg2qmrO0EgPFcSs6ENJy1viuYDgNivq7fXGGdaqI05cFAp
	C06mXUlt/rfiP168JQFxlRsTMGrp5exxA3498BI+fY5jFtku/nw9Bw+OKW4+/WMhOkftLEZ8k95
	INVnuAOlK5YuspBuNOqsZokdixpY
X-Google-Smtp-Source: AGHT+IE0QuYawLNCogBA64/LJltqIjKpuHT/KSyZidcToRYglT0fhktKjutvxT3Q66aGl88GXcTGwg==
X-Received: by 2002:a17:902:d2d2:b0:216:2bd7:1c4a with SMTP id d9443c01a7336-21a83f88f24mr367658565ad.26.1736854268370;
        Tue, 14 Jan 2025 03:31:08 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21b4c2sm66598325ad.137.2025.01.14.03.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:31:07 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 203AEE1AB54; Tue, 14 Jan 2025 20:31:05 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v6 04/13] um: nommu: memory handling
Date: Tue, 14 Jan 2025 20:30:42 +0900
Message-ID: <740b3b0f1a28115eeb709924b0c5cfc80bed52c7.1736853926.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736853925.git.thehajime@gmail.com>
References: <cover.1736853925.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_033109_195241_8EB3C6A4 
X-CRM114-Status: GOOD (  16.10  )
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

This commit adds memory operations on UML under !MMU environment.

Some part of the original UML code relying on CONFIG_MMU are excluded
from compilation when !CONFIG_MMU.  Additionally, generic functions such as
uaccess, futex, memcpy/strnlen/strncpy can be used as user- and
kernel-space share the address space in !CONFIG_MMU mode.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/Makefile                  | 4 ++++
 arch/um/include/asm/futex.h       | 4 ++++
 arch/um/include/asm/mmu.h         | 3 +++
 arch/um/include/asm/mmu_context.h | 2 ++
 arch/um/include/asm/uaccess.h     | 7 ++++---
 arch/um/kernel/mem.c              | 3 ++-
 arch/um/os-Linux/mem.c            | 4 ++++
 arch/um/os-Linux/process.c        | 4 ++--
 8 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 1d36a613aad8..fcf4bb915a31 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -46,6 +46,10 @@ ARCH_INCLUDE	:= -I$(srctree)/$(SHARED_HEADERS)
 ARCH_INCLUDE	+= -I$(srctree)/$(HOST_DIR)/um/shared
 KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/um
 
+ifneq ($(CONFIG_MMU),y)
+core-y += $(ARCH_DIR)/nommu/
+endif
+
 # -Dvmap=kernel_vmap prevents anything from referencing the libpcap.o symbol so
 # named - it's a common symbol in libpcap, so we get a binary which crashes.
 #
diff --git a/arch/um/include/asm/futex.h b/arch/um/include/asm/futex.h
index 780aa6bfc050..785fd6649aa2 100644
--- a/arch/um/include/asm/futex.h
+++ b/arch/um/include/asm/futex.h
@@ -7,8 +7,12 @@
 #include <asm/errno.h>
 
 
+#ifdef CONFIG_MMU
 int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr);
 int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 			      u32 oldval, u32 newval);
+#else
+#include <asm-generic/futex.h>
+#endif
 
 #endif
diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 01422b761aa0..d4087f9499e2 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -15,10 +15,13 @@ typedef struct mm_context {
 	unsigned long sync_tlb_range_from;
 	unsigned long sync_tlb_range_to;
 
+#ifndef CONFIG_MMU
+	unsigned long   end_brk;
 #ifdef CONFIG_BINFMT_ELF_FDPIC
 	unsigned long   exec_fdpic_loadmap;
 	unsigned long   interp_fdpic_loadmap;
 #endif
+#endif /* !CONFIG_MMU */
 } mm_context_t;
 
 #endif
diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 23dcc914d44e..033a70166066 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -36,11 +36,13 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	}
 }
 
+#ifdef CONFIG_MMU
 #define init_new_context init_new_context
 extern int init_new_context(struct task_struct *task, struct mm_struct *mm);
 
 #define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
+#endif
 
 #include <asm-generic/mmu_context.h>
 
diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index 1d4b6bbc1b65..9bfee12cb6b7 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -22,6 +22,7 @@
 #define __addr_range_nowrap(addr, size) \
 	((unsigned long) (addr) <= ((unsigned long) (addr) + (size)))
 
+#ifdef CONFIG_MMU
 extern unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n);
 extern unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n);
 extern unsigned long __clear_user(void __user *mem, unsigned long len);
@@ -33,9 +34,6 @@ static inline int __access_ok(const void __user *ptr, unsigned long size);
 
 #define INLINE_COPY_FROM_USER
 #define INLINE_COPY_TO_USER
-
-#include <asm-generic/uaccess.h>
-
 static inline int __access_ok(const void __user *ptr, unsigned long size)
 {
 	unsigned long addr = (unsigned long)ptr;
@@ -43,6 +41,9 @@ static inline int __access_ok(const void __user *ptr, unsigned long size)
 		(__under_task_size(addr, size) ||
 		 __access_ok_vsyscall(addr, size));
 }
+#endif
+
+#include <asm-generic/uaccess.h>
 
 /* no pagefaults for kernel addresses in um */
 #define __get_kernel_nofault(dst, src, type, err_label)			\
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 767b9b05d6bb..beab40bc9f30 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -62,7 +62,8 @@ void __init mem_init(void)
 	 * to be turned on.
 	 */
 	brk_end = (unsigned long) UML_ROUND_UP(sbrk(0));
-	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
+	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1,
+		   !IS_ENABLED(CONFIG_MMU));
 	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
 
diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index 72f302f4d197..4f5d9a94f8e2 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -213,6 +213,10 @@ int __init create_mem_file(unsigned long long len)
 {
 	int err, fd;
 
+	/* NOMMU kernel uses -1 as a fd for further use (e.g., mmap) */
+	if (!IS_ENABLED(CONFIG_MMU))
+		return -1;
+
 	fd = create_tmp_file(len);
 
 	err = os_set_exec_close(fd);
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 6df378639880..e2dc00fc84c0 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -70,8 +70,8 @@ int os_map_memory(void *virt, int fd, unsigned long long off, unsigned long len,
 	prot = (r ? PROT_READ : 0) | (w ? PROT_WRITE : 0) |
 		(x ? PROT_EXEC : 0);
 
-	loc = mmap64((void *) virt, len, prot, MAP_SHARED | MAP_FIXED,
-		     fd, off);
+	loc = mmap64((void *) virt, len, prot, MAP_SHARED | MAP_FIXED |
+		     (!IS_ENABLED(CONFIG_MMU) ? MAP_ANONYMOUS : 0), fd, off);
 	if (loc == MAP_FAILED)
 		return -errno;
 	return 0;
-- 
2.43.0


