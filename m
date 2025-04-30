Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87386C3ABAA
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 04:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OCuYr2KP3wBxDodLMaPRY+onEFYkqYFG8HFmFD5AH3Q=; b=TBv85Z1h7PyiGfFXoQdaNfZWny
	tjaCXgL8JIGzkCxrq5ZbYkQUmf4psd6lKL5JyqAVfrR6lFiF80YuI7npEuVgN1YHjG7nmQg4+5Nzd
	1IkHg2uxpLy2oBL44an6JssDOvyTUNefOpNOid/YjBE8hW9Uwput0FxSfP2OUZ74m1ReX0/y5qbW4
	a5nss2jaqgL9mBpaUbOI2fUMbEVJzXdK4hy51Ctj919EMiqyMH9nuUwqWQ+uuFXvoN0lpoLzRyImU
	htYipdAOtBuzonHm1F1Qcjvp8h7rnAj+wmXL5kPywEjB01j/Mvogl85tzLC8c7pYaUr4gd2jYF9Ld
	1twgGV4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z4C-0000000BfhA-0TxX;
	Wed, 30 Apr 2025 04:29:04 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z36-0000000BfSg-1FcH
	for linux-um@bombadil.infradead.org;
	Wed, 30 Apr 2025 04:27:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=OCuYr2KP3wBxDodLMaPRY+onEFYkqYFG8HFmFD5AH3Q=; b=c2sI6HbbAOLQDZDJEDgFXoKSVc
	PMA6j8B9+OvRp0z8XAAxL+btJiPYMVYVRQPv/49MqgeW8OPYkq9MQdiRZX+ByCQ5S3mejFBu3Xwof
	JM2sEyOkx9RKjjXMId41a+TMJ/e+7ipB4MZ52g907q5j3TCPY3PPEnagqqVtSRJAFX5X0qCx0SgJM
	B1Lm72X+r8mUcoHGNytRaQo0FDVeLBwCNzxMWsCY5NRZh9ZuBugjqdXJNnObtVmNFNaJMA3Q9QL6x
	e4suTUvgkWKLb6MfpkNEGJz+rdR1tPzR2NHDUIa6BOtYmrGhxZ4o2zo9wULcszGeo1KWAwkp44vxf
	uE1vykVA==;
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9z2y-0000000DgC2-2BOd
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 04:27:50 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-7396f13b750so7548930b3a.1
        for <linux-um@lists.infradead.org>; Tue, 29 Apr 2025 21:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745987265; x=1746592065; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCuYr2KP3wBxDodLMaPRY+onEFYkqYFG8HFmFD5AH3Q=;
        b=Y17HiTd1g9y2gtvBk9/Mwn29rcAcDxzTOrw7vrtN909Va4yE13UlzUWuFYjlSDm1zo
         wg0ydRKIF1FunMOnlbNvsfBnsiTh0qCHh9RZT73/Mf0KFqQv2p8sokdbGHTVz7dhIowW
         VJNLkvYYtdqD72sguP8tTDmogU1cd6HSLpEHpwybH1jezCU6g1EYorSEdXgqObGuVkzJ
         41xOeVBUJ6tZoZf96/ohXstHQtrzy1iPpbfRyf08SJRSN4hGiDx9KVjgu+wWIvKYV9zm
         f69kQ8qus3Eblnvv4u+/eYzaFOPWeFSmuZi/Ac1aA/LaSaHg2UccAwJW/Txdat6hiMMK
         6jGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745987265; x=1746592065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCuYr2KP3wBxDodLMaPRY+onEFYkqYFG8HFmFD5AH3Q=;
        b=ITt1ElGyxso2Bdv9xwEdQ5fPn/EcjMa/bc6RVEgKNoz/ue8ZrsqHfzHOV8IOFnSBiA
         hHI3IJ8oLVCZTI2Wj/X7MI/89i1wrM33EFnNELdSjMzJqF+GRHPBCHjgmJDy9KPsvSky
         XDH3VnDu50zhX4X2ggaYZofQbuQta130521DEBWSoRTb4vgOPKWWNP4ZzftsVgP5OfIX
         JareT8OQ2nrOjY86TqibwZKzIoj86F4D7TlttoLJ30htK/qDCS0gr0u7W7Xd6P3jDFWj
         zMdlHt3i72HqDAul6Uf9vZFIJpEkCLBrNmsfoQf9ckUsUjnuL+StqCNXSpYvfm26lwqp
         UnXg==
X-Gm-Message-State: AOJu0YyYGQdHS/267L5gk1/dfcctj+pW0kVujIAylqSne+jGD5R+Es+c
	1gaEsvSWZ50n1MAPE5unq/qi7v+bhPKWiwDc5ZEV0mwJ4inPDGyC
X-Gm-Gg: ASbGnctQDQeykwyxxCg9KJj1JGmG3/V/QPgDsyt3PFEGTPIANCgvIJHCBTqqN8s3Y5/
	JY7L6ovJnyOL3AIN+OBK+5VbUIWjP4CzLDoyPgcczAf+XAqlB4f9X1cTW9CyxmW+9B/f0Q+rAKK
	M9H7EWZx3/SwAtoqi5F5Nps2LYSf9/LwyqkQ/E0F1mBVfMUiYdW7oGi/qgN28SZJVh8S/F4+bZc
	VZU+5qYQ9MzBEZZrDi4TYDyqNxq0lmALGwYD3wz1jl6r7ZHrVBWRhJJrJHECkapQUo6ep7M6Lf5
	jDTtlovoZMSV9/sLh7h0oRB5DRuC1OyRyHu+rfGr0peLP4katnJXmP8R4r4bnkBrwkP0h89XBrf
	UjBmLEPiX82o=
X-Google-Smtp-Source: AGHT+IH0FbwVRr3MAmvHuDKfwKvFcYAl32DVyoxymDr2Jear3LyL+Hz5Wp7hXom+GZQca10gjxHCUA==
X-Received: by 2002:a05:6a00:130e:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-74038a85c28mr2474451b3a.19.1745987264935;
        Tue, 29 Apr 2025 21:27:44 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62bfdsm628293b3a.142.2025.04.29.21.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 21:27:44 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 2BA51E94818; Wed, 30 Apr 2025 13:27:42 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/12] um: nommu: memory handling
Date: Wed, 30 Apr 2025 13:27:09 +0900
Message-ID: <2598e5207a53e4ec1f2077b5c5a9f03fc3782506.1745980082.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745980082.git.thehajime@gmail.com>
References: <cover.1745980082.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_052748_801870_41EC7A81 
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
index 3a08f9029a3f..eb9b7d577062 100644
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
@@ -68,5 +66,8 @@ do {									\
 	put_unaligned(*((type *)src), (type *)(dst));			\
 	current->thread.segv_continue = NULL;				\
 } while (0)
+#endif
+
+#include <asm-generic/uaccess.h>
 
 #endif
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index cbe8b9d03d8c..1e18384381e2 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -64,7 +64,8 @@ void __init mem_init(void)
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
index 2331e32c4898..8a615875d1a1 100644
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


