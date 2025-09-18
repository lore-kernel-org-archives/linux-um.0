Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0CECAC5A9
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 07:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5v5kFFhzG2vuvgO+enxcsWpy0aeKbEC/zaWFYDqr9sQ=; b=k8udkvCXessVIQx/hFxOaUaveY
	SjQ/DtqlVy27p7smgTfcuFirLnfkX5E8djavLbL53c+zYO0P6kAMYT/0IclZt6pLfDb28MxU2sht/
	BFrebBiOqEQcMxulx+EY8IPtpYumFGE+ohefJeMBhx6goH466AAFU8AxJ0Ilo/VEyPetojxVOJ3Pm
	Gg8hrZq78BxY2NDDZ1ZS0fK3mzp9UiqSmAiOIBwtOaorwwtdEgMJ6l2vNXhcvVep+PxJoTEeK+3ib
	KGQLA3f0al5dj4qJhAzelTkarOStix+7CxH+dgNDmHfv1n6ok8rUU0dH0+oMBJe383W9BRUkSqXVF
	hoX0htMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Ei-0000000GZ6K-2b0O;
	Thu, 18 Sep 2025 07:39:24 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Eg-0000000GZ3L-39YY
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 07:39:23 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-26799bf6a2eso6527155ad.3
        for <linux-um@lists.infradead.org>; Thu, 18 Sep 2025 00:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181162; x=1758785962; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5v5kFFhzG2vuvgO+enxcsWpy0aeKbEC/zaWFYDqr9sQ=;
        b=dPXENN6Z39XRYezibi4TBijDpyiyrFVLkZbE1CuGi2Cll8aOaG1DfecYDPP5wgHxfV
         SAHgRKvqfTBAhkWD/na9qIGg02Nmq2qMT8LoD/MQFu9/kxm9lo3tPALLNktHYq+yPAGk
         hXWfZO+a0nDiEC/6V2WZkw7VRvK5R0QDsGUdpXKB5+vIU1oJtSlMpliMOZU7M+YDNQ8v
         VqcSErnSyIoWecF+ig19lq4UqDqSCnarsV0ZnpJ+gKnworsKcDKTXdzDSvAfy9QniQbL
         WP/pNxcAtGa2znSi2AFxIZDn+XJVZngtRVtLD9YN0iEt12IT7Zic2f1cWAx6ghMTmI3Z
         k9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181162; x=1758785962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5v5kFFhzG2vuvgO+enxcsWpy0aeKbEC/zaWFYDqr9sQ=;
        b=QblAunrcUWAlEF6gKq2yWc1y68P+NaotViLeYeZZx6KvXanigv1CDIzwBW3/CHUTyZ
         nTsWSln86tyRMUWGONsw//ZqX4+F2XoOpcYHHJkIzZgASKWIAnbJaZQZGCpuIwuYvDRW
         bflApPxtAAyB3NsIBMbGGzXDaBSuXR5hv8Xkz7Rvu6LUWJi3u4v1G82rYEBAko0/pYUP
         DGC4wHbnnJUkbuZhLf41AKes8xKw6HwPyoMm+GyE1ou7vNnJl21oFxIUKjuWxFVI1XeU
         sEsJ2RlkxmLwM8fIqOZ2MDVAYs8Xj33oseRFYCwr8lz2YZYnUclLzaXKhS8s2uwEjGn7
         oTmg==
X-Gm-Message-State: AOJu0YxXPj4JKoSVha5tugesI3OpXOzn6tQ2A97v7atiAw3kxAfj2nOh
	zTu5EFG092TNTbRzo9TlzDFotLE36kfIvKPYggNtV1KIoFeLhOFUqh+v+AUnfA==
X-Gm-Gg: ASbGncssICahjnAtCavS+YnK6sfu9tz7vMcJxBPqfB79iFSEYFb+Q6z+EKMjSXhV8Sn
	sFQpFLjQOTMIOwYr4v7LexEZNYW3M3NgSHW+PsVcuU4vfNzVBmCWvEqqLaqx10tPPQxkpqHqhTX
	IAKHVWP76+MFRb0x44yliD7+/tK8lbGJy9Vf3IcQaA3TFVsCvq2LsCVbvJ9meXIV9tk0QNG6rbd
	6zPXFLObPE9qaTAKEKt1xm4qkF5/gIad+awcTs52G1MNiwoHaTmhJ0mmyQ66i0FzUKSv2C6GbY6
	lHCQUEHMPNXk43Mi4LPMd/A0sEADklG1Of+lkxSVrTfAFPp7B8oLDXWHXXiHJBvW0QRyaT3tsPQ
	llLc8lbRigQxgV+cPlE3cYcassG6gtBCjklovgcwkz8aH7a1yOs3LYb5LxBLGRgKYQm+pdw7g2C
	mcE7c1CisfwGA=
X-Google-Smtp-Source: AGHT+IG6ytpLYdQrX/2pjjExkFEIINfv8kAcyaa95KwBKwyJzJzySBkChQImoYTUSwTSO6F65yBwsA==
X-Received: by 2002:a17:902:cccc:b0:24c:6125:390a with SMTP id d9443c01a7336-268118b95cdmr53455325ad.10.1758181161806;
        Thu, 18 Sep 2025 00:39:21 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053201sm17187505ad.17.2025.09.18.00.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:20 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 09DA81062100; Thu, 18 Sep 2025 16:39:19 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v11 03/13] um: nommu: memory handling
Date: Thu, 18 Sep 2025 16:38:58 +0900
Message-ID: <5b248fc7351c6228f2a2bb9a4d33fddf3f1744ed.1758181109.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758181109.git.thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_003922_788216_73422222 
X-CRM114-Status: GOOD (  16.70  )
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
index d000907ec796..bc598e661ec6 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -98,8 +98,8 @@ int os_map_memory(void *virt, int fd, unsigned long long off, unsigned long len,
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


