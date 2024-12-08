Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35375E7717F
	for <linux-um@archiver.kernel.org>; Sun,  8 Dec 2024 10:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=msB9zOffZ3lDd9bZpieSmh3nfaD4tjZhkwzGohhg54U=; b=1tz0liBNqsc3lBKuiT3xtqw6GZ
	UuIsR+FkgoHaB5ypXov4NZAJNrQMGQflTiDrSl+FnGrbnd0AcPeauc6VClR9qywzuFb0DWyeJ5BY9
	TiiiQJxtBL+pGPvECY4WKOallskmXIPnws0foYIBCfLGcFVm8BrRrAw/ue6IvsvxB+V3Nm8iSfftK
	EnaSZCi1wOorOw9Y2qic/U60HgojKHhYOKYrHiCJLC0nTNrTD7yqAnZ1oWOVxg6WNH5C9zotZZtuJ
	JDn9TzF3lQI4v0GZiVNEkZ+d8DtLhLCy07Cl59lpM1sXEv2VpmTAgwHgEw4EinbyF/xpe6nd+eJ4d
	yI2dYN/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKb-000000057WO-3qYM;
	Sun, 08 Dec 2024 10:16:05 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKZ-000000057Ug-1AcU
	for linux-um@lists.infradead.org;
	Sun, 08 Dec 2024 10:16:04 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-215b4681c94so27731285ad.0
        for <linux-um@lists.infradead.org>; Sun, 08 Dec 2024 02:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733652962; x=1734257762; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msB9zOffZ3lDd9bZpieSmh3nfaD4tjZhkwzGohhg54U=;
        b=ktnDy4c+EzHg/OiJej3hka2mGa0L/oUlCOJexTlA/Lt5ZHwj5+QT13EQhNW1Bt7sHk
         RxXA9kTtET437SsVvwVlrABo1FXS1Qe01lBHa1r33kp/CxG+gHxAaPV/QkJfD/4YBZrw
         8ALA5wqBwecE/WQyXDiVubZKlgLM6qdf4TEW2IjKL0Ds5RDBmB+3zEOgMU1zcjeObPf6
         pMPrtTiy1kvfxmPmfeaxdRAw/m6/qrxOBX/z949rzNVhMbHc/PnaHS88/mk5sh1NHDUW
         TKyf5/ABf4j2REZ7dPxxcJbewSzXj5rv+AtWHir08BCOUhvPncB/3eUZMK7EokWK0ACc
         tPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733652962; x=1734257762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msB9zOffZ3lDd9bZpieSmh3nfaD4tjZhkwzGohhg54U=;
        b=xBHWjlocBpBkwpnd6Butv0LOTgGTzsr/rFJhWHGd3V1ZFHnOHOw9vE8Wsh/YVZW1L+
         PQGC1sHzV5STfF2R3nx5NXw8wgZ9wC8cTJIErUtos/noZWte1IXMrjFO/W452ABj80d1
         zW9H0VoSZW1Ny5T7/f8mfn/8EyK1xDFi5YP7HwRV1CgLL6ewQFCfpu5d9NwA/coujmpm
         FTMfKPY3eR/Uewm8I0XINUx1keEFeClCJRYSTVChL8lzUDnE2FWkj/BZi9vJu4CnARHS
         3pMgBVkiZ4fQqle9kmoOLUZojcVjm+Kw9PARQm+FhxGvU091us/lYqftQ6YcSLuld94b
         NIKw==
X-Gm-Message-State: AOJu0YzJvy+9Z/xPOP1iAKh1nGTgq3L6SmvzCiBQ/6dpk3anPVgeWbWM
	JHgzbTzK8mzlmTswAOAKyEPh3dWHTY7w/9SL5XCzCkQy12d2j5WoiOnvXA==
X-Gm-Gg: ASbGncv8QqpbK2u7esCqdWxhDY9HP/MRTL1JnKB2/KOdbYjAm5wuXNbUW35tfJj8Mfu
	zmOWv7b5NEFkGtlgCvAwB5qnMJqPgv+tHjLAjI0ByjCgWpjFhm6KRuIEtDs0rN9ytncVxZhFXDG
	pg0mWcjWvylDm/mPULxHH9U5NTIq2YJV5YmZ9xUUht5WOeDo/TzffwrK76GLKpOZXhlLfL4ALSb
	myDuBGZ/tK6RrTsVoEoMZbPzMEXXRVZUAv1QiduD4ma8rh2iWpSqI6Nf1HLQkFmVHNV1iqTcFvA
	/X8lkrrBQM3PDuwJ8CFC
X-Google-Smtp-Source: AGHT+IH0AzjlPm5t8MCbVlRCQTzO3/Cy9H/S2Cm1kXIBFckZ+QovB+fdP95KMTZx4dVyQjh5LuAz2A==
X-Received: by 2002:a17:903:11c3:b0:215:9d29:b440 with SMTP id d9443c01a7336-21614d33ae4mr126814275ad.17.1733652962360;
        Sun, 08 Dec 2024 02:16:02 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9f50sm54362965ad.156.2024.12.08.02.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 02:16:01 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 6ABF3DDB026; Sun,  8 Dec 2024 19:16:00 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v4 04/13] um: nommu: memory handling
Date: Sun,  8 Dec 2024 19:15:31 +0900
Message-ID: <25d592d7c437659cd1b2e57b73715df9de36395b.1733652929.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733652929.git.thehajime@gmail.com>
References: <cover.1733652929.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_021603_358171_D67B377E 
X-CRM114-Status: GOOD (  15.61  )
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
index e3a7ec32d6c7..f82f54bc6920 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -63,7 +63,8 @@ void __init mem_init(void)
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


