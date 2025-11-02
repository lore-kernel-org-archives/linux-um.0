Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14123CCFA02
	for <linux-um@archiver.kernel.org>; Sun,  2 Nov 2025 09:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dLVWDe27CxuFua8732sg2A25U9KjI/ik4lvuwLmfhJ4=; b=E/YNjfvg83ZMQEJTCVqS+CF1Li
	D971kNQGj5PLGHLew173vErjbwEU0y8VURyxfSxe5WTAfX60g2iAV+F97XBzFIpi+IR9Fdf8+r3aJ
	ZQXZcAp3J89KJifGhTkOP1RNFkMflxOT2nTdmR7U13EJLQ5OEojncXBut0iOMELN5IdG5IiVfdeky
	jJjDeZ2sLScPqyzTmM4GgYzkaDoVXoAdABfAVIQq68Jm2MBMnF4Kh7hn6Q/LOtMER3ctgjCIxijQo
	9tOpujfo7lf9PRT3Vaa2BpMUvBCh2puGk6ZNE6d6U6JJwRjYvGZJIlAMZisXcB748R8MUQ+3b7taB
	tZd3PPhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUik-00000008Rpe-3NK5;
	Sun, 02 Nov 2025 09:49:58 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUii-00000008Rnw-3uBv
	for linux-um@lists.infradead.org;
	Sun, 02 Nov 2025 09:49:58 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-34029c5beabso3224512a91.1
        for <linux-um@lists.infradead.org>; Sun, 02 Nov 2025 01:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762076996; x=1762681796; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLVWDe27CxuFua8732sg2A25U9KjI/ik4lvuwLmfhJ4=;
        b=CQWzLeEpowvOSYHeyyaP5iQiLDyMoR9hQBzIOwCFAYfaicIAja6JE9YsEiPHd8bccw
         jeYJY4HGp1lu+su6t3D1u5F3TvpcV3C707U8r+bCqJX9CXp5Ann3i8s/pYod92Y9o+1v
         7BlTA32pdSjNubXYZbejZ+OUOWU9fs2XPJuknAlyGuKYH3AUFN3kNcQFh2e1Z2ydkkQR
         ztBKgFDwd/XgSs4k51obLpYTrR0hl47cKR4jNwPdi07mR3KB4+Th2DKwbK7mLWdupOOC
         LN40fbHvUISWvyBEQ4f3LUebd+wJgyuaSIZKVlDQkE2IjPhDZs4LAUy2OYYJlS9JP1z8
         DSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762076996; x=1762681796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLVWDe27CxuFua8732sg2A25U9KjI/ik4lvuwLmfhJ4=;
        b=NQ0HY3LJtYK/KPsZrmz+n7ch2UODlAcDV9I7ootrjlxUOo0d1NdkkyLXTxL0uNqZV4
         RTTfy88LXf3wqS1wiEA/5gCMQ0XP5ctT5GCoDNNtmXAw9KQYNHqQCVca7JHH2KQlAZcm
         wfO4XpDSBFNpsrc3fD6v8Xu7woy8tiflr2xjVz4Qr8kNU+JH4iMtycKeeao43uXlqziL
         P8SSxUe90WbmxKYHj7pJcjxMeMvyWzVpXH0YdM1zU1SWFeeSwi9PnOEJKRQh1j8HHiCl
         LSLity0YoZWi8ACV7++pHnSu/2kZkM0/UFy3nGVAiXOtiBHFRJ1qR34PnQH82RSZoFd/
         R0Bw==
X-Gm-Message-State: AOJu0Yy2tWQXPnAN5k57X2pwxHIqsUtd3ax+RwDpsjDSpzS2zJmH/ATx
	3Y73PpNA0P++j1Zc2AkfzxQsp6OxBJL8GWpxZGNx3k+vyyaN3f3BnX7G
X-Gm-Gg: ASbGncsFqvh5pCSqXqZFg/cXTfcEX6g3NzX4sbyAfWP2RI3v2MsKJOnD8nw8f9kjtO9
	Moo1GpyNkGSEX5yxIMcPga9uhGwU7rf775jjgE+J4vaONuC1+6oo2jW8hArbh46p7xm8ShH55Fi
	F+6Yi4WiZ9R0qUYzDjzxpNehI3iPseJIivLe95i3RoezIthSi4L6aP13mCsVy5ZscUbHw2SGfYx
	Ep7bXV4gPViOrRZgRojDDiDZCpC+YrtepdOnnxoxt9qMS5oj59NK++bGUh6t3+Pbx8X+zpvZuQs
	Aco6NJA9E3Xz1EeFzC7suXZSlr/pj/S7MKK7K+Klg1yfevXVntUXIA1neDhRXW5sy7+6MU2ZI49
	WAwBaozixc+sFu5pHWE5pVfEOjt+Y88x6d5whwI4mFIhuTNgeqYvbL8PZjjalndrlbJGomxcegh
	mE+W3D0ZRz3LEekfZLDfNpbnaVZJPQfg4zsYQu0X4/TfFhsuihBR9hc8QM
X-Google-Smtp-Source: AGHT+IGzGeGnGZ1p4XL3AbmXtABYfDo2QjDzgeG3Xh1EPclKdLYIizv0aT8x/i0qH9w4Wj7HzH+eoQ==
X-Received: by 2002:a17:90b:548e:b0:340:bfcd:6af3 with SMTP id 98e67ed59e1d1-340bfcd73e0mr5203014a91.33.1762076996088;
        Sun, 02 Nov 2025 01:49:56 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b9b8f2b5403sm812590a12.17.2025.11.02.01.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:54 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 7CB341123803; Sun,  2 Nov 2025 18:49:46 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 03/13] um: nommu: memory handling
Date: Sun,  2 Nov 2025 18:49:28 +0900
Message-ID: <ca690557be98a0b11744fc8aa664933552742266.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_014957_125351_8A40CFFE 
X-CRM114-Status: GOOD (  16.28  )
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
index 7be0143b5ba3..5371c9a1b11e 100644
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
index 82a919132aff..c0b9ce3215c4 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -22,10 +22,13 @@ typedef struct mm_context {
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
 
 #define INIT_MM_CONTEXT(mm)						\
diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index c727e56ba116..528b217da285 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -18,11 +18,13 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 {
 }
 
+#ifdef CONFIG_MMU
 #define init_new_context init_new_context
 extern int init_new_context(struct task_struct *task, struct mm_struct *mm);
 
 #define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
+#endif
 
 #include <asm-generic/mmu_context.h>
 
diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index 1c6e0ae41b0c..b9677758e759 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -23,6 +23,7 @@
 #define __addr_range_nowrap(addr, size) \
 	((unsigned long) (addr) <= ((unsigned long) (addr) + (size)))
 
+#ifdef CONFIG_MMU
 extern unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n);
 extern unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n);
 extern unsigned long __clear_user(void __user *mem, unsigned long len);
@@ -34,9 +35,6 @@ static inline int __access_ok(const void __user *ptr, unsigned long size);
 
 #define INLINE_COPY_FROM_USER
 #define INLINE_COPY_TO_USER
-
-#include <asm-generic/uaccess.h>
-
 static inline int __access_ok(const void __user *ptr, unsigned long size)
 {
 	unsigned long addr = (unsigned long)ptr;
@@ -70,5 +68,8 @@ do {									\
 	barrier();							\
 	current->thread.segv_continue = NULL;				\
 } while (0)
+#endif
+
+#include <asm-generic/uaccess.h>
 
 #endif
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 52cd906e3896..1b9e7c62412d 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -71,7 +71,8 @@ void __init arch_mm_preinit(void)
 	 * to be turned on.
 	 */
 	brk_end = PAGE_ALIGN((unsigned long) sbrk(0));
-	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
+	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1,
+		   !IS_ENABLED(CONFIG_MMU));
 	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
 	min_low_pfn = PFN_UP(__pa(uml_reserved));
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
index c50fa865d8c7..ddb5258d7720 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -100,8 +100,8 @@ int os_map_memory(void *virt, int fd, unsigned long long off, unsigned long len,
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


