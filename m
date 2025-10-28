Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DA0CCF9F0
	for <linux-um@archiver.kernel.org>; Tue, 28 Oct 2025 09:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s23a9Lw4NQpwPG2KyF7SnuyVJ7pKxcR7EU7g+DNSJGU=; b=Ph43QTgNxVMUDtu4W0jntDvqoM
	6UsV9wjs/hzsdq+zQyj7ZlvIkRJlrw/urR5YFjE9ZGTUzDnAkoanTr38/Qr+urYklOEng6X3JhVev
	RUhqNBpycEhFb9cP2UGX0mKw5sNIH61U+yJ5yIGevaC+RDFhyB9Bq67ao2JSeWifZhR1E3RVke7v2
	vswWEBLxB5mdLvlYl0k18C5nOnf7piZtnWmgXY2WTFobryMQORrcYREccn7eDvOU4k9a+d5ynLNRP
	HNw4N3b8vD8fvzOtHhX8QfQuthW0FRLJpR5OCoHJu7JSpD6tPK+qpHnjyJxLfLyoCZao9tFMOrQyg
	5LPYlZRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpb-0000000Fd8L-47vT;
	Tue, 28 Oct 2025 09:17:31 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpU-0000000Fd0X-2iK6
	for linux-um@lists.infradead.org;
	Tue, 28 Oct 2025 09:17:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643038;
	bh=vszDF/cx4qHYXXIt4CCpd4y86yZhshQ+o4PVe1g7Y50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g4iOmek2Pwb6uaHO9W+u8eso4VNQkDSU25wRqBElFVpQ8AW3A2IfvYY4xFaRdfeK6
	 zEYDZMZis6+oV/rFJ2NiXsUZGNdNOvetfhbmxtX9XJLFGpk9Pzfe6Yir6auEGfA+Be
	 3DzYkFALhdgDxn8UbMJq0+NthKJSN9gSw7gyLDRw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:15:40 +0100
Subject: [PATCH 05/10] x86/um: Drop gate area handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-5-e930063eff5f@weissschuh.net>
References: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
In-Reply-To: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kees Cook <kees@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=2787;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vszDF/cx4qHYXXIt4CCpd4y86yZhshQ+o4PVe1g7Y50=;
 b=o4JmUMvwtaLOa6D398C8FcQZo9AegfjrZ0mzUtV8o6ruPGtlXeeSvSB1/HNV+nBp+yjVHkJSq
 0+5+Nf0zAGFCVqYDRn7QlgelnwkKGaCgWpd/sXbvXYOnmwS3ORxXiCa
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_021726_007406_C319B040 
X-CRM114-Status: GOOD (  11.76  )
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

With the removal of the vDSO passthrough from the host,
FIXADDR_USER_START is always 0 and the gate area setup code is dead.

Remove it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/um/include/asm/page.h |  4 ----
 arch/x86/um/Makefile       |  4 ++--
 arch/x86/um/mem_32.c       | 50 ----------------------------------------------
 3 files changed, 2 insertions(+), 56 deletions(-)

diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 6f54254aaf44..2d363460d896 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -96,8 +96,4 @@ extern unsigned long uml_physmem;
 
 #endif	/* __ASSEMBLER__ */
 
-#ifdef CONFIG_X86_32
-#define __HAVE_ARCH_GATE_AREA 1
-#endif
-
 #endif	/* __UM_PAGE_H */
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 1767e6061b4d..f9ea75bf43ac 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -13,7 +13,7 @@ obj-y = bugs_$(BITS).o delay.o fault.o \
 	ptrace.o ptrace_$(BITS).o ptrace_user.o setjmp_$(BITS).o signal.o \
 	stub_segv.o \
 	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
-	mem_$(BITS).o subarch.o os-Linux/
+	subarch.o os-Linux/
 
 ifeq ($(CONFIG_X86_32),y)
 
@@ -26,7 +26,7 @@ subarch-y += ../kernel/sys_ia32.o
 
 else
 
-obj-y += syscalls_64.o vdso/
+obj-y += mem_64.o syscalls_64.o vdso/
 
 subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o \
 	../lib/memmove_64.o ../lib/memset_64.o
diff --git a/arch/x86/um/mem_32.c b/arch/x86/um/mem_32.c
deleted file mode 100644
index 29b2203bc82c..000000000000
--- a/arch/x86/um/mem_32.c
+++ /dev/null
@@ -1,50 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2011 Richard Weinberger <richrd@nod.at>
- */
-
-#include <linux/mm.h>
-#include <asm/elf.h>
-
-static struct vm_area_struct gate_vma;
-
-static int __init gate_vma_init(void)
-{
-	if (!FIXADDR_USER_START)
-		return 0;
-
-	vma_init(&gate_vma, NULL);
-	gate_vma.vm_start = FIXADDR_USER_START;
-	gate_vma.vm_end = FIXADDR_USER_END;
-	vm_flags_init(&gate_vma, VM_READ | VM_MAYREAD | VM_EXEC | VM_MAYEXEC);
-	gate_vma.vm_page_prot = PAGE_READONLY;
-
-	return 0;
-}
-__initcall(gate_vma_init);
-
-struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
-{
-	return FIXADDR_USER_START ? &gate_vma : NULL;
-}
-
-int in_gate_area_no_mm(unsigned long addr)
-{
-	if (!FIXADDR_USER_START)
-		return 0;
-
-	if ((addr >= FIXADDR_USER_START) && (addr < FIXADDR_USER_END))
-		return 1;
-
-	return 0;
-}
-
-int in_gate_area(struct mm_struct *mm, unsigned long addr)
-{
-	struct vm_area_struct *vma = get_gate_vma(mm);
-
-	if (!vma)
-		return 0;
-
-	return (addr >= vma->vm_start) && (addr < vma->vm_end);
-}

-- 
2.51.1.dirty


