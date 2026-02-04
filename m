Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0569CE8B383
	for <linux-um@archiver.kernel.org>; Wed,  4 Feb 2026 02:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0L/5/J5t1GFM1WwQS1/l29QmS+JzOLR4lODWUcBj0lQ=; b=emNEltba4vKJJOvgYgbNvqAkpB
	OR+bqB33b5hdMvLU3wpuF+YejzMiJTJjEz5t6PcsgcQZYDKq46NCdIlFc8suR0UvSNWdmncFNGc17
	y6VHdVtc5ZohP+kYATOcLWR+sBDDWaDdbSAlRCDLRx7ERDdwr5rp8bbU1wk653OBLAA69HZUnerHP
	IfOOgM5bg02lGIiI6bjCco981rlCLTDKhnaRNdG/to+Exoqb+nKoe7ES4bzBlCzoYMtcdmPc5i+TK
	r3pdqohE8ipJV9kuusz3CYSndNMV87APs0ZWjfpzn6Eqy7MbWvVOxbEDsb2iRq3M00oIvNEImZMk+
	UNuE0Ntg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnScz-00000007m4w-3AiE;
	Wed, 04 Feb 2026 02:28:25 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnScx-00000007m2w-2HwJ
	for linux-um@lists.infradead.org;
	Wed, 04 Feb 2026 02:28:24 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-81c72659e6bso5529978b3a.0
        for <linux-um@lists.infradead.org>; Tue, 03 Feb 2026 18:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770172102; x=1770776902; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L/5/J5t1GFM1WwQS1/l29QmS+JzOLR4lODWUcBj0lQ=;
        b=PlBczd3bs8GussR3p867z5MbCeuY+xVV/9AF7wQ14xN7LzXdymKrloiPQoRFpq1L/8
         Idhe589h3Ln1ppgIpjkAV6B2xHkbO6+GhMMaqn0bAUzloM6iB9mUhjlDeTvjEj3mu55b
         yGyIFcOrfAxzp7krvk5IJO1crrc9pXoEz0TqDtvpY2cplg88/fQfd72qoahfivQ/s3Z0
         ++NdrZToAX6NHU1dNr3C3hv1Q9suXlSpqE73LvY+qin14F5cbqWtGFQNpoGx62gDMcW8
         jIu9YBYqvzTbe69Gyq1AOEQhwxCsn2hcqb6VSVEVxDTqovArUwdjITdp2R96bQaQgm6X
         4gMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770172102; x=1770776902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0L/5/J5t1GFM1WwQS1/l29QmS+JzOLR4lODWUcBj0lQ=;
        b=E67jGFEpgJcYLdbG4J4f1yPmOGmWGKN/szB5psk5ujBRmENEp5djoflTQ8gJJg2SuW
         B6il0VULoOeJJcix5JesDxIFqKrXY7Rws6iYu18B5WMwbUPP+9SQXX3UIEfTPhcZuxiZ
         1mW8TLGJQbGenmPHmZP7lRrffjosGnChj0NOgB5OHu+rAKWo5GfNLf67wjSQ1PZva56e
         7Hucgv5dsxjdKVKUvxg6NDeXLYDdazzZwfwTAU4N2hB7W8ZnyOqkfAAKkVC7ZUUl5oKU
         PJ+AqBvnS1kbY1Em4ZumxWsWAq74w91hu2oHCP2Ze6yYJxf3VGXnFGtwEwQ28YlGsRiR
         vyeQ==
X-Gm-Message-State: AOJu0YzA6N7U0wp+ywK3U2tOK1cl/s2NyLy4+Rlg/wwOu/yt3WG6rHlH
	kOy4ePL9Odnpzy1Dy2qnlUvGGdU1kQNJzeaezTP49aaIW/4GqdfzM70F
X-Gm-Gg: AZuq6aLPad9kAgY/h5m/92elrB59tga7TdDzz8mig/h488Ozsmc/FUJbW6mBxADoUg9
	IJoiXIJ6pQcv2fkauBZP+u1goc/YMnTztvc/Oh/Y7LDiuD1qjn+7I+W0PRgGLc54jo6h8sb3DeO
	DHJwUaCnWvIGoI4zQnY8LZLMGq9ZSaJOWoRSHsIJ63TsqKjhboc87nGXYcf3vg1nfGohLx31Sch
	E3Nc+OePpvIqOSg40QgpHyiHP1gluMrO6P99FkiuPgZi7FROcLM8SQg38BPp1ygnnIZFNzKfSQC
	4+q38Y8He0bTdDvOsItDB4ep+ANhynHBsxrD8yg9VwxXXFOy0uptA4UYIodedCXaOWLDukvyx1/
	+ycgUnjuw2bmRWXEIl+VZ+hSVjx8N7Tfi5Tl0VzK1xIkpDtBL46o88qnmkDOM1Pe00d1eUZZVtq
	7LPUzQFtOWaheNcd1J7uETcuD0lfY69RgcK4fL+lpnBdaa9gfMMX9LE5LIppRh7HZCKKm6b4AMm
	PBwGyainmwgG/HQ
X-Received: by 2002:a05:6a20:2452:b0:253:1e04:4e8 with SMTP id adf61e73a8af0-3937249cfe5mr1451449637.56.1770172102389;
        Tue, 03 Feb 2026 18:28:22 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93397ef6fsm6992595ad.95.2026.02.03.18.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:28:21 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id DDC2C1200C35; Wed,  4 Feb 2026 11:28:19 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v14 03/13] um: nommu: memory handling
Date: Wed,  4 Feb 2026 11:28:01 +0900
Message-ID: <0e06cec4e7b715cd3c0a3fa8bec7e00c4e4c27ec.1770170302.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770170302.git.thehajime@gmail.com>
References: <cover.1770170302.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_182823_595843_B15B4783 
X-CRM114-Status: GOOD (  17.09  )
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
index 721b652ffb65..5e9bf2a8aa6d 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -46,6 +46,10 @@ ARCH_INCLUDE	:= -I$(srctree)/$(SHARED_HEADERS)
 ARCH_INCLUDE	+= -I$(srctree)/$(HOST_DIR)/um/shared
 KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/um
 
+ifneq ($(CONFIG_MMU),y)
+core-y += $(ARCH_DIR)/nommu/
+endif
+
 # -Dstrrchr=kernel_strrchr (as well as the various in6addr symbols) prevents
 #  anything from referencing
 # libc symbols with the same name, which can cause a linker error.
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
index 0df9ea4abda8..031b357800b7 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -18,6 +18,7 @@
 #define __addr_range_nowrap(addr, size) \
 	((unsigned long) (addr) <= ((unsigned long) (addr) + (size)))
 
+#ifdef CONFIG_MMU
 extern unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n);
 extern unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n);
 extern unsigned long __clear_user(void __user *mem, unsigned long len);
@@ -29,9 +30,6 @@ static inline int __access_ok(const void __user *ptr, unsigned long size);
 
 #define INLINE_COPY_FROM_USER
 #define INLINE_COPY_TO_USER
-
-#include <asm-generic/uaccess.h>
-
 static inline int __access_ok(const void __user *ptr, unsigned long size)
 {
 	unsigned long addr = (unsigned long)ptr;
@@ -63,5 +61,8 @@ do {									\
 	barrier();							\
 	current->thread.segv_continue = NULL;				\
 } while (0)
+#endif
+
+#include <asm-generic/uaccess.h>
 
 #endif
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index f3258680bfbe..e599b637c5fb 100644
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
index 734d143417c8..b338a89ecf1e 100644
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


