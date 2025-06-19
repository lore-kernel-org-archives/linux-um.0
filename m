Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCD1C71157
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 01:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nJZY7fSdjsRmE94xDQ9kPtMR3Ats2B2OoNFvSkK6k9U=; b=g60rg8apJZjGclwmlphj8A0CaU
	S2ARjhj+WojgFamqJEQkpyo0UBnX/Su3xTpMgWoCSqS/5dH+WlKoanL34ijA2x158WfpYmwA5hnfe
	XbKySACyUHPRGTU5b9hyYhxl2RpMoK842ouOf/V9ClyVq40qDhaa4weZGeRczleLKXehfALh6ZPd8
	g7TVlQbtQUdlZrS6kdLiewUUxDbq3MOZAQ+EEeAjoqhtTSyKfDrwSDQ4GDpjAtB21+h4QqezsCOpo
	os7rgyP9P6P7l22vAyV4nz011yu9PsBKLDagKLtl5JEw8tb3jCqY9h4yDAsITDG8861VP4cg9mcwB
	EnERNuog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3hs-0000000BgYz-3NhE;
	Thu, 19 Jun 2025 01:04:44 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3hq-0000000BgXf-1OTF
	for linux-um@lists.infradead.org;
	Thu, 19 Jun 2025 01:04:43 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso114309a91.1
        for <linux-um@lists.infradead.org>; Wed, 18 Jun 2025 18:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750295081; x=1750899881; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJZY7fSdjsRmE94xDQ9kPtMR3Ats2B2OoNFvSkK6k9U=;
        b=Kn/LL8cq71LB8DuY+HBFceC7PY7gBYQ4anz1kFG/YaSTuh+gY22i52RHJNLO76/yTd
         n/iaE82hUqZAdZq+A4qMGqFq+8yVzID4e7Tds4YsOOIIOYwzEhK7rg5RC5au+wlDBfrI
         hC+JDzFSbJKKV/zLM4MzQ9AAIqy4OK1a7ytL7vtLSpDxfSAm7m1wEq2ic18+VX1DdMYR
         ueRrG19SeQP+MjRoDwXT0eC8rfWsWV+cn23GWAFDvnOyAZAIKJ7zqaXGHHCVkGzloGA3
         Olrz9hq0g/Fz7YPFYlaA1SAjX1jUchBEO5A+JoCIaDTfzbqCeAOq3SbAOgWC83cs5C4Y
         24BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750295081; x=1750899881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJZY7fSdjsRmE94xDQ9kPtMR3Ats2B2OoNFvSkK6k9U=;
        b=vi/kIjD/Ammh/Gee/M9vhTmwsA0w51267LC2b8EajzGnLYyyvlPGbeuFdhUrJa8CJ9
         pM8E4woTDp39M1Ee0rDBqY75Kcc9Up1VtT8i2tAHArERC5bM9ywbW/4GUGg5fIND5wzK
         iwWSuI/1cA8joUwDQa2WKySoCMN7HunGvHzpkFlQQLrPXGwAo42zWbldETxG1WxoNM+G
         geO+mw4lyLAvt0MBmHiChlo4luoIOpId4wAFktBeqCGL9aw+bU+g7sZYG3Sbai1AQ41w
         1Tq8EGZWjaNYXJJe6Q3sdK/QlH+BX80rmx4SkE2gGnIG6jgCVbF0aqIpApuQZo3HgETd
         tABA==
X-Gm-Message-State: AOJu0YxxXNWgY7cH9c+RGPwRGeuLzB6p5RaAtqoh3kgBBKcN9BHrbYbM
	U2Li5E/KbHFbhJ+qP2Rtqrl8FN4Jgt8JkqWzh8QDrZ583xepJ84dLRc2
X-Gm-Gg: ASbGnct/ewOaBnZ4F+uUyvKuKfUFD5lAhWXmMXgaEOl9+PY3RfVF7f+9gDl4W3Jw2/N
	wEhrKPWeWQQWULo7kZ/hYfAVuNa1CuqhPrRYTzx9ZElwCuwgb8pQPE9suSKTpETGOd6C9bD3ujo
	Lr7Kg9jIdPKex1ljz6BLi33y+RDGExuTRhcwQ+h+FNpQRDGhpfoRZsYkMEMviP5W4wpt6Gi4ISB
	ZfmEWL/zKVLsP6a4/G5FN2LK5Kwgb2OvGPM+E65dIfVcrKTgzDJNPzb6x1fRrteWkTpcdfOGtNK
	1cI6FHqTvZD59cNpOcOBQt2rXHZfBAqaxoPbigP4hSqFkkFUZYMzd1tMD8j3xHRPwraOkHpua+J
	dVZdjAR2nDCrapTGmg3IswU0hiVQ45oyK
X-Google-Smtp-Source: AGHT+IH4uU1pGplG19mmCzAP1mwEmJG8BFCTlYV0YGKJFwD9XSBO3JUptsHATvAeeZW9CGCCDm0fGw==
X-Received: by 2002:a17:90b:528f:b0:312:2bb:aa89 with SMTP id 98e67ed59e1d1-313f1d50e08mr27014989a91.20.1750295081409;
        Wed, 18 Jun 2025 18:04:41 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a318673sm821989a91.34.2025.06.18.18.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 18:04:40 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id D7147ED652E; Thu, 19 Jun 2025 10:04:35 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 03/13] um: nommu: memory handling
Date: Thu, 19 Jun 2025 10:04:07 +0900
Message-ID: <c2fd350b2bb88b28c75f552e7335594e101e9dea.1750294482.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750294482.git.thehajime@gmail.com>
References: <cover.1750294482.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250618_180442_374713_F524DA6A 
X-CRM114-Status: GOOD (  16.62  )
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
index e9661846b4a3..9f30c69e5278 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -18,10 +18,13 @@ typedef struct mm_context {
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
index 106a2f85ab5c..4be1cf240d71 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -64,7 +64,8 @@ void __init arch_mm_preinit(void)
 	 * to be turned on.
 	 */
 	brk_end = (unsigned long) UML_ROUND_UP(sbrk(0));
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
index 4eb7e137ef4b..8a1ab59a089f 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -99,8 +99,8 @@ int os_map_memory(void *virt, int fd, unsigned long long off, unsigned long len,
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


