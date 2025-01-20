Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A8BC0218B
	for <linux-um@archiver.kernel.org>; Mon, 20 Jan 2025 06:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a4qzPlb3D9VCFUyuRjUxUUJ/e3JRyLtND6gaWf9vBJo=; b=GlUi2WHWghVEOpU2Q0YlQsc+HZ
	OxUqnU1MxN/yXQl2O/OkfK709Y8a3QbwtIMxhgL5w5SbMwsQYjmrw2ssEZo6Rd6VMxgvV+g/Zljj5
	jHBtfFKWs9GkmSDJ3wKHgqXRHTPgXpH8MsGC4pRYP+xoSCvYRkX5QVO6yxozQvarwiWLAff6Jk7M6
	IhM9eIDOsrpcVhqQAX/9JPXQ5STNDFzWwIeMfJfjHjDyvYddbcjLNn1K1fTCFNrC47CfFEXnKiNMx
	e+O0xPfxPmtWHma6tkczgMK37FJp7jq55yOHSWNN5BNivXrftfdPjQRoEptU7A2xJ4s5jacemDdYI
	378LPPYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkr0-00000004nNU-1yS4;
	Mon, 20 Jan 2025 06:01:42 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkpr-00000004nDI-1o3G
	for linux-um@lists.infradead.org;
	Mon, 20 Jan 2025 06:00:32 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so5332446a91.2
        for <linux-um@lists.infradead.org>; Sun, 19 Jan 2025 22:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737352830; x=1737957630; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4qzPlb3D9VCFUyuRjUxUUJ/e3JRyLtND6gaWf9vBJo=;
        b=aq9CN0c2EvPjY31i7EtwpYctDnn6Uy6za8M5Nulut9JZJ8Sp8Rsb/Wqx8Xt9URUfet
         VfBlgPE7I5goDS1rW/wYJL0on3vRKXkd66lBHYreUPPi+GWnS/xBtEAsl7zk1gF5Qs7R
         H+4SjrxGzECeeD3WCup0I0Sm2N6EAML5xqoWKTyGVuO/ARMY0Tj7KoH1XfGNgxGWYiBb
         l2UAPDo0rFlNI86ZA2NwS/jLdKTnHnyPIJaCKjDWFGE9bGhYXcRpHHaP7R3T4wI3b90n
         tQg8KQ9+CHrdsdMI8EAaUQZ8TmZHLVn4H+KrCuigcXex2KtVilso1zooFiot5PThVqea
         EZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737352830; x=1737957630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4qzPlb3D9VCFUyuRjUxUUJ/e3JRyLtND6gaWf9vBJo=;
        b=oa/uqdkYAtZPWo7svYmXnv3c4VpRYhsbhZg6o0TNk2nHWyDdYllJVk5gz+B62LnNzl
         EeI1gq29EYCyCl/r32+A8UXR8yXUB8AJ93yIJGRn3301snS5pce91HtixrXyjQ6SvMBj
         AH/vsJ08Vz5UoiN0bpAJ9w+70Xa9zcJOmJzCc9tyDsnwH++L2apalqRaiLqvN27j08ap
         kxsmCyn+TZFWYj3sg4aTbaJ7Gju0nDtAPUaUTzfSlFFqGWGPHO0xANQMn4bubR5bWKeq
         pDThVni0/hQ3K33xVi5AM7ox1FenSERNhm+Dlgj0fRbQ2xxeyzBmNpKwNE3IO6IGDZC4
         lfgg==
X-Gm-Message-State: AOJu0YzeHBCapya+K9Ni5nORm48H8aLFIMJBsoqil8PQ5F5V5ae8+WBs
	2kEDi5hx8rxakMLpGIEe4uVPHABNJrMCzooQUzGXLk3kduDaTzCr
X-Gm-Gg: ASbGncucECrvdOmkUE4NNTs0w87M4qzjDlE9YF5h2IShMLnfNxO88JXAfVfCUdbg7xC
	s+wYqawaR3FIMshgC7MlWTaL4WSIZB0fZ5bC9ay7MK1nWtvFXokEiN9i1DkevW7YLaXAOIG5kZQ
	r4X6iMFyqMvOkS8tJJkUyIjXevYsmhMn4xvKCtESjzpPLnBevGe17ATidrDExxq33SUQXitprOM
	caCIYg3pcKfv9ROJmPx8STcXbexS/iQ6pvtYaldas28M7dRi7us9EHAyG/R3QfwJmoSEemnkFHp
	okaGAm8Vt7Ed+nHZEYDKo588L1+JSSOo94K4JcvxRg==
X-Google-Smtp-Source: AGHT+IHAmFyWxrHXgNVL+g7u/Gu1x6pmyCgveivbVpr+dNwEZ/HcTI+QYgARkVEZXBtv3RmRTEIaVg==
X-Received: by 2002:a05:6a00:c92:b0:726:41e:b310 with SMTP id d2e1a72fcca58-72daf99edf9mr17393538b3a.12.1737352830420;
        Sun, 19 Jan 2025 22:00:30 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f190fsm6170788b3a.26.2025.01.19.22.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:00:29 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 2F157E2752A; Mon, 20 Jan 2025 15:00:27 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v7 04/13] um: nommu: memory handling
Date: Mon, 20 Jan 2025 15:00:06 +0900
Message-ID: <740b3b0f1a28115eeb709924b0c5cfc80bed52c7.1737348399.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737348399.git.thehajime@gmail.com>
References: <cover.1737348399.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250119_220031_481352_114AAD35 
X-CRM114-Status: GOOD (  16.00  )
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


