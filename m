Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F76CCFA1E
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 08:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lm2scelwojVCxczz2ObXlffF/4mE69mJL29qxONKAeE=; b=05F1uH2BvG/eW4R/QubCgtKuNn
	pZwP2Y5QSAsZOrMEgM5ILfTs7VLoVd9/QNIV7JO/CN+irwSdrnsyLqzuFOMYhfERJzRVJD1rRiqrO
	biwjOc4kr6nsgHnZz699HhejqHD/wvmnJjTZky7JFncC/7bw3OXjqx8pHI3+2prTWrXIJg1QKDDDz
	dQOthoe34BD9fIlqTBh6GMIWsiIQJqe7H/dk6566Gr+jBv4rJgWbLno+AQms/H8PtNCgKPGvYLlO7
	S8yy8v9yPZhbXsi4ckFx7cfsvzAe1K8rnFdGGrL4HIpKd2vFS3MVFRKPzJ3lfG/a18TIUUVAK92dV
	HUA0As4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxX-00000002ite-1LU7;
	Sat, 08 Nov 2025 08:06:07 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxU-00000002iro-2AGn
	for linux-um@lists.infradead.org;
	Sat, 08 Nov 2025 08:06:05 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-7a4c202a30aso1235901b3a.2
        for <linux-um@lists.infradead.org>; Sat, 08 Nov 2025 00:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589164; x=1763193964; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lm2scelwojVCxczz2ObXlffF/4mE69mJL29qxONKAeE=;
        b=l/kzDgRZp5rl6Hfm12RO0CODbvvp8IbMlMQB6PB0Ndf+Us5zlclIT+VTaAOAk7OfA/
         VuK9J3JHWomhmLOvlaXyI3fgT66Rp0hR2+dfgakkbf1kHaxouxNH/hmWbKnUnbgJ34p+
         WwGaG1fCEzJ1c7G7H3HsJ1hP2w9wtZFF/IvOzLJKqmwpqoZpePlf0u3yooKAQa7yX/8J
         R7OxETBNMez0rdurANa5QPv1WRboDNqud+nLATUGTHrdeMWDi3dIJyjrfrra4/jSCEjs
         GFIKBEKwZmySX/lNT1gYWjT6TIQoSiR2OjcmJSJ4nspyg5Hmn8odJQURez7XX2OYIz39
         175g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589164; x=1763193964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lm2scelwojVCxczz2ObXlffF/4mE69mJL29qxONKAeE=;
        b=u6XCb/S4whx9O0s+FsWr/9xS9CbgaeT4+v1UkqhFHmCibgJox8OTfcnaENBeQj0ZeO
         OouRTnHb32iitdSpxaZoGMiD77/g58CjAfrmn2tNXfrLFZREOFSG4nzyd8I9iZe3CJPo
         Vjbzx2GR1v2ZKs1G+lsD7LqWr113bCFt6sWZUAq7nbBXQ7sxiigC434fwst2rPpdevzE
         aHxinw5CLkgZSon8TGiK3GlToup18RJx+XWSGZpVwy6P2m3rfqoC6cpOhkqj7bEiHQGR
         XbuXseTCm2+SXOvNeVWbBnHLcaGZ9WA9ZzSaxo68/MkK2EvoNxLZ2Shcj7CJT+rs8z93
         pV1Q==
X-Gm-Message-State: AOJu0Ywy4oACZaxZVUkMBsQiIhsOJ6PwnNaQm9nEfrEdLGNlQv+cwbAv
	XAUwes12SWQ1X3wApEowagMrCiPJx2bhYmtxGYZjaXOuPbNdcYfztU0J
X-Gm-Gg: ASbGncuYKAwxLMKe6qKE/PhJurEphhhIfYIa5giaG65d/1jFtL3pE4VgxGsTtWWq9Uj
	wkrSkI5x6bJf1x63Lw5auoXrOrIjWC692NB2mZpZma2AmHA6o4trHWc3ybN8bZjx1VWOw3QgDdG
	0QkjqNDn1MUKYffLv9sAtfh34rQdqkqyTfeY7NeY/scQ6b7giuZcgi4eJHs929I9pi6ZKugVOlX
	dD+wVlHuTnZPvAVdc4eA6IrRzfQO4DvHBN26wwtaPH6gEnDcKRqOCftgi8+7/wJZeFPCDOlRHnj
	KI5NV72e6v/Wxlxn++OIv1Eq+NbqsmyIOLuTz196j7qFEPMIQ0JZl586GiWUmJhkJDvBs8ofEmo
	jJTWKLjVjPrp40dbV6+nMdhvNvVTTq12A9GzsQlOzXx1wRbxLnNe6bHbDrK8ILaEg6QXc//d/zu
	x1eMSRj3YIiouf6iFQHrUhphKVoCiFhY94xGxjcD0hrcoamg==
X-Google-Smtp-Source: AGHT+IGu/het2cVRieRqiXorkhj+THkOqiM2xkhG3vmOKrA/bzZOZb+7OfPVwqzTvt7adsqHGGOymQ==
X-Received: by 2002:a05:6a20:729d:b0:334:8a8e:6576 with SMTP id adf61e73a8af0-353a314c69fmr2474816637.29.1762589163524;
        Sat, 08 Nov 2025 00:06:03 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff8538sm5219197b3a.28.2025.11.08.00.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:02 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 95CE511388CB; Sat,  8 Nov 2025 17:06:01 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 03/13] um: nommu: memory handling
Date: Sat,  8 Nov 2025 17:05:38 +0900
Message-ID: <28512370a78b53783655667300bc4464fd338029.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_000604_563246_26C6982E 
X-CRM114-Status: GOOD (  15.94  )
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


