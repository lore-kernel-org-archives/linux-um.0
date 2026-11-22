Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACCE606A32A
	for <linux-um@archiver.kernel.org>; Sun, 22 Nov 2026 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qeOQGG8e;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tpUms9/x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:References:In-Reply-To:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FqYRG8athWDQGcrzbQj9mPlYTIYqm2X5Q1hJTrOJil0=; b=qeOQGG8eFkTZ7zotVqdfP6RCXz
	gL1hHag7T3Tuu95Xuag1o/B9qlI2dz/RB/KQYLiHbQ6ZQa+NYug3lJ07h01IuUDWkDDR7/Z63fHmS
	Hkxf6Wy6vggVHR9w+4j0B1CanxZOqRXD6o+hWNh74Wuvtt353HuT1IUe4U8TPzvzu2tJiQO0Lqbv1
	H31i0KtHVmUdlS/Uny2XyQAf/CTasNFDrk0IZS2YPm4sd87PwCd1PlvSfRZtu7bZAryFCNncadgCG
	5IYxXWm0TkY2Hqa2v8WIilRjG4ZlevxGyL24Am4crzWCF/jXuDF9KGyQi+M9aA6GBWJX4b+X6pW2B
	C2M79Lmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV7qH-000000019pi-0wTu;
	Sun, 22 Nov 2026 13:42:53 +0000
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV7q6-000000019f1-3Ccx
	for linux-um@lists.infradead.org;
	Sun, 22 Nov 2026 13:42:49 +0000
Received: by mail-yx1-xb131.google.com with SMTP id 956f58d0204a3-67921b515a7so2483903d50.2
        for <linux-um@lists.infradead.org>; Sun, 22 Nov 2026 05:42:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795354962; cv=none;
        d=google.com; s=arc-20260327;
        b=iiad0/tKG0Y1vH4t0l6dMvK/+C0Ggi3CdLBvlZSeMSYbjfI4LXupnieVbqPrcoqcRX
         rEBrpLbrcF+bKfgRV1sxvcMXguWZk5fREnVQs08jw5nRYxYUhJPJPmgdpwrlGd3sqqSr
         KSOIUWfPUgrWCOO8uQtKbC7ru0z2y5KNee49o+dZtxIXaNQrP6/RUmmZvEykYDElEycq
         EykvJIwpkdAir85PS0gY/Y8hkd3unovRteuk6W7mu+EInG1ggEOiOrkyYoy0ozn56Nfq
         dSw5UtZ+dp9nuUFh9ecW1VOa8dqIwYWqO1y+rgJt8kSwwkgrKwuULfB6MAWTI/LL6AEA
         RKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=FqYRG8athWDQGcrzbQj9mPlYTIYqm2X5Q1hJTrOJil0=;
        fh=/gBKL856m721509318RIdz8U4fuFWBADYUOnmaP+UV8=;
        b=JZIIaaX8zbdVLzKhcLwsbuAolXYiLiGkHPWvdLXd7TKuqz3AOScb0TPlY+uwSa/UX6
         4vpvBcrqUVzU0kdB8wGuqB20OWnFgn1ly5KXHNr/J/k+pScmTh/xVB6Ir3Ae5SeADo6i
         LrtE1dZwUpWWcXieBY/gAPlJdkbsHVmlmBmDFq3lm1E0szOONHNJwPQmTaQ6mi7JXB0Y
         3MLdMKxt1E3VHlqMyE4FJW1YGNi1RyMLGI0L+BFI9p7XK4r2FzMKVjUKXL/KxaccEoa1
         8+Ij2HspHOqpT2Lx3tAwj/AP8KfQGScKh3rzt3AqvtrU4jLu5KM/sVVh1qxUmCRTjiF7
         QJsQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795354962; x=1795959762; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FqYRG8athWDQGcrzbQj9mPlYTIYqm2X5Q1hJTrOJil0=;
        b=tpUms9/x8JZl8zSDpb/xjNcowRYPSX28gRyGAGkXeGm43aB06fPoUj/wc27AZEV7RG
         XSJZnyXv/0LK9QdAv86rPte9Atz7/+BqppuP5nzykyiFEaScGihGfSL/tn+3OaZNwVZ6
         ujk0qj8cPaAXJC4gwLZbk0Ht0SonoU+8DHbFVk2qFsENka0wdjn1aE4nh9jy9i+RuBJq
         lra2ZoCQwPrBU9Fxl4QekuqhjGQ7R09qf1+c4HvSqa20g3q6HFRqpWK5GVq5lhgMEnKB
         tnw7d857fb3Cic7bSqCW+yMdHzIT+PGIrOQzqCFnBiYrX1cW//CkqzzL9UZ5cwq4H80n
         qaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795354962; x=1795959762;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FqYRG8athWDQGcrzbQj9mPlYTIYqm2X5Q1hJTrOJil0=;
        b=kKUeTQILPLpgOS/2on06K6GGEVSkHd994BEqby3RbN374HQa+BnJz1xiLhiIYo5PYg
         jgrzSoZpti5JeaN7tH+smc1B09itRcbooJy9nT3ac4hAZGchBS6tcITVQoMGdr8dCmNM
         OxQ/Vl0UN2MT/OU8m58HME572rmha8PE4mDrCkdjKiAtw+tCdPaJb2iroQMxVdAap60r
         ZBc35Gd61tpsBR6yzfOicoSYM7ccYGi/K3+fgBgpsS7ICXRsADE3tu7Q4UUnf2dKsHMY
         uGifrXKnSin/sXvamEoLaBb2RvwhkdfCEnQQIz0/fsKMKl4dYd/h0AXXPc++ezDhLk4I
         E9Qw==
X-Gm-Message-State: APuU4Z80UxSz+jI+muRGpUzFdbGTGxGA4EBGn9eyi6u0rzYz0Ws8AtJK
	Nnj5yZBnj3EW+z611fcAyFaA8/g8tADOe20jLAJDDRLzCE2bv0W3UHobu2qioNZ5j1FUuO7BTAl
	lZObV3IHY38vi3faL5nyTt5PvOi6u3kH7oSSkGtw=
X-Gm-Gg: AZFdTZeQzdkQnxYyrX2BKi/Maorffazmt0OlGsMEhJIc0QLsEA7xrH40RGwo5QXKYWH
	e0wZiO/2bl/Ot/deLOvQjiEl1Aieb6eVXGjVI8Ir6Gq1mwanNTvrGQ2fD/rYxy66an8umPUa23T
	5gNGwmDJv1yme6k2gWPZKhMShHgvecsOP4MwuZ2OhOBjPJypQM4Jh+7JqXGbIy50vEQJTWoMX1s
	6NuLu4aBkWCxPINBZy+kjJ4wcie7uoasDv5gUVU71wks5maO84wFWZP31AkLYSEgW4rXYrrORs0
	yzmCx1yIsmu/bzurmM5J1WFFRjsJKKe6B40Y7YcuKPfTkN8q4/tDCZUxlOJbF1zffIfbDWgGvBV
	F/c9deu97/JpzG5kkccwJhLLLNtC+I8musQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:690e:e85:b0:67d:bd3b:1e7f with SMTP id
 956f58d0204a3-67df44add28mr3440651d50.109.1795354961578; Sun, 22 Nov 2026
 05:42:41 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 22 Nov 2026 13:42:41 +0000
In-Reply-To: <CAB2K5aBaXG7Jhi+0UyVfpGan+5XXch5zOg3tM3=kqnO1+8F=fA@mail.gmail.com>
References: <CAB2K5aBaXG7Jhi+0UyVfpGan+5XXch5zOg3tM3=kqnO1+8F=fA@mail.gmail.com>
From: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
Date: Sun, 22 Nov 2026 13:42:41 +0000
X-Gm-Features: Aa3M54pf8IK7nDXCdxi-BApsVV8evf4D34961b_cWr3vofLpMMXN-IqUAejcE5E
Message-ID: <CAB2K5aAxeboDh7155trq=fNxVfsDN9jHEXLaixEwKdL5__aesA@mail.gmail.com>
Subject: [PATCH 5/5] um: vdso: wire up the vvar mapping, layout and build (MMU only)
To: linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261122_054247_756040_407A7338 
X-CRM114-Status: GOOD (  25.45  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Map a 4-page [vvar] below the [vdso] text and install it with
vdso_install_vvar_mapping(), grow [vdso] from a single page to as
many pages as the text needs, and lay the vvar out in the linker
script (VDSO_VVAR_SYMS, __VDSO_PAGES=4, adapted from
arch/x86/entry/vdso/common/vdso-layout.lds.S). Export clock_getres
and switch the vDSO objects from um_vdso.o to vclock_gettime.o on
MMU builds, adding -I$(srctree) -D__DISABLE_EXPORTS -DBUILD_VDSO
to the vDSO compile flags.

The vvar mapping and the generic vDSO object are MMU-only:
arch_setup_additional_pages() (which installs the [vvar] mapping)
is already inside #ifdef CONFIG_MMU, and the Makefile now builds
vclock_gettime.o only when CONFIG_MMU=y, keeping um_vdso.o (the
syscall shim) for NOMMU. NOMMU therefore needs no vvar page and
its build is untouched by this patch.

Signed-off-by: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
---
 arch/x86/um/vdso/Makefile          | 14 ++++-
 arch/x86/um/vdso/vdso-layout.lds.S | 28 ++++++++++
 arch/x86/um/vdso/vdso.lds.S        |  2 +
 arch/x86/um/vdso/vma.c             | 83 ++++++++++++++++++++++++------
 4 files changed, 109 insertions(+), 18 deletions(-)

diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 7664cbedb..5d4ee9142 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -4,7 +4,15 @@
 #

 # files to link into the vdso
-vobjs-y := vdso-note.o um_vdso.o
+vobjs-y := vdso-note.o
+# The generic vDSO (vclock_gettime.o) is MMU-only; NOMMU keeps the
+# syscall-shim vDSO (um_vdso.o), which needs none of the generic
+# vDSO framework.
+ifeq ($(CONFIG_MMU),y)
+vobjs-y += vclock_gettime.o
+else
+vobjs-y += um_vdso.o
+endif

 # files to link into kernel
 obj-y += vdso.o vma.o
@@ -35,7 +43,8 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 #
 CFL := $(PROFILING) -mcmodel=small -fPIC -O2
-fasynchronous-unwind-tables -m64 \
        $(filter -g%,$(KBUILD_CFLAGS)) -fno-stack-protector \
-       -fno-omit-frame-pointer -foptimize-sibling-calls
+       -fno-omit-frame-pointer -foptimize-sibling-calls \
+       -I$(srctree) -D__DISABLE_EXPORTS -DBUILD_VDSO

 $(vobjs): KBUILD_CFLAGS += $(CFL)

@@ -44,6 +53,7 @@ $(vobjs): KBUILD_CFLAGS += $(CFL)
 #
 CFLAGS_REMOVE_vdso-note.o = -pg -fprofile-arcs -ftest-coverage
 CFLAGS_REMOVE_um_vdso.o = -pg -fprofile-arcs -ftest-coverage
+CFLAGS_REMOVE_vclock_gettime.o = -pg -fprofile-arcs -ftest-coverage

 #
 # The DSO images are built using a special linker script.
diff --git a/arch/x86/um/vdso/vdso-layout.lds.S
b/arch/x86/um/vdso/vdso-layout.lds.S
index 439b790df..754d004b5 100644
--- a/arch/x86/um/vdso/vdso-layout.lds.S
+++ b/arch/x86/um/vdso/vdso-layout.lds.S
@@ -3,10 +3,32 @@
  * Linker script for vDSO.  This is an ELF shared object prelinked to
  * its virtual address, and with only one read-only segment.
  * This script controls its layout.
+ *
+ * Adapted from arch/x86/entry/vdso/common/vdso-layout.lds.S: same
+ * layout, without the pvclock/hvclock vclock pages (UML has none).
+ * The vvar (4 pages, __VDSO_PAGES) is placed before the vDSO text:
+ * VDSO_VVAR_SYMS is evaluated while '.' is the base of the PT_LOAD
+ * segment (VDSO_PRELINK), so vdso_u_data == text base - 4 pages, and
+ * the kernel maps [vvar] exactly there. Only the relative offset
+ * matters (the code is PIC), but it must match the kernel mapping.
  */

+#include <asm/vdso/vsyscall.h>
+#include <vdso/datapage.h>
+#include <vdso/page.h>	/* PAGE_SIZE for VDSO_VVAR_SYMS (asm mode) */
+
 SECTIONS
 {
+	/*
+	 * User/kernel shared data is before the vDSO.  This may be a little
+	 * uglier than putting it after the vDSO, but it avoids issues with
+	 * non-allocatable things that dangle past the end of the PT_LOAD
+	 * segment.
+	 */
+	. = VDSO_PRELINK;
+
+	VDSO_VVAR_SYMS
+
 	. = VDSO_PRELINK + SIZEOF_HEADERS;

 	.hash		: { *(.hash) }			:text
@@ -45,6 +67,12 @@ SECTIONS
 	. = ALIGN(0x100);

 	.text		: { *(.text*) }			:text	=0x90909090
+
+	/DISCARD/ : {
+		*(.discard)
+		*(.discard.*)
+		*(__bug_table)
+	}
 }

 /*
diff --git a/arch/x86/um/vdso/vdso.lds.S b/arch/x86/um/vdso/vdso.lds.S
index 401600eff..fcc99934e 100644
--- a/arch/x86/um/vdso/vdso.lds.S
+++ b/arch/x86/um/vdso/vdso.lds.S
@@ -24,6 +24,8 @@ VERSION {
 		__vdso_gettimeofday;
 		time;
 		__vdso_time;
+		clock_getres;
+		__vdso_clock_getres;
 	local: *;
 	};
 }
diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index 8e1f5ee44..d36336266 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -1,38 +1,77 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2011 Richard Weinberger <richrd@nod.at>
+ *
+ * vDSO + vvar setup for UML.
+ *
+ * Layout at the top of the address space (um_vdso_addr stays the
+ * base of the vDSO *text*, so AT_SYSINFO_EHDR is unchanged):
+ *
+ *   um_vdso_addr - VDSO_NR_PAGES * PAGE_SIZE ... [vvar] (4 pages,
+ *       TIME/TIMENS/RNG/ARCH, installed via vdso_install_vvar_mapping)
+ *   um_vdso_addr ...                            [vdso] text, N pages
  */

 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/vdso_datastore.h>
+#include <vdso/datapage.h>
 #include <asm/page.h>
 #include <asm/elf.h>
 #include <linux/init.h>
 #include <os.h>

 unsigned long um_vdso_addr;
-static struct page *um_vdso;
+/* NULL-terminated array of the vDSO text pages (special_mapping_fault
+ * walks it by pgoff, so the terminator is required).
+ */
+static struct page **um_vdso_pages;
+static unsigned long um_vdso_text_pages;

 extern unsigned long task_size;
 extern char vdso_start[], vdso_end[];

 static int __init init_vdso(void)
 {
-	BUG_ON(vdso_end - vdso_start > PAGE_SIZE);
+	unsigned long size = vdso_end - vdso_start;
+	unsigned long offset;
+	unsigned long i;
+
+	um_vdso_text_pages = DIV_ROUND_UP(size, PAGE_SIZE);
+
+	/* +1 for the NULL terminator used by special_mapping_fault(). */
+	um_vdso_pages = kmalloc_array(um_vdso_text_pages + 1,
+				      sizeof(*um_vdso_pages), GFP_KERNEL);
+	if (!um_vdso_pages)
+		panic("Cannot allocate vdso page array\n");

-	um_vdso = alloc_page(GFP_KERNEL);
-	if (!um_vdso)
-		panic("Cannot allocate vdso\n");
+	for (i = 0; i < um_vdso_text_pages; i++) {
+		um_vdso_pages[i] = alloc_page(GFP_KERNEL);
+		if (!um_vdso_pages[i])
+			panic("Cannot allocate vdso\n");
+	}
+	um_vdso_pages[um_vdso_text_pages] = NULL;

-	copy_page(page_address(um_vdso), vdso_start);
+	for (offset = 0; offset < size; offset += PAGE_SIZE) {
+		unsigned long chunk = min(PAGE_SIZE, size - offset);
+		char *dst = page_address(um_vdso_pages[offset / PAGE_SIZE]);
+
+		memcpy(dst, vdso_start + offset, chunk);
+		/* Zero the tail of a partial last page (alloc_page does
+		 * not zero).
+		 */
+		if (chunk < PAGE_SIZE)
+			memset(dst + chunk, 0, PAGE_SIZE - chunk);
+	}

 #ifdef CONFIG_MMU
-	um_vdso_addr = task_size - PAGE_SIZE;
+	um_vdso_addr = task_size - um_vdso_text_pages * PAGE_SIZE;
 #else
 	/* this is fine with NOMMU as everything is accessible */
-	um_vdso_addr = (unsigned long)page_address(um_vdso);
-	os_protect_memory((void *)um_vdso_addr, vdso_end - vdso_start, 1, 0, 1);
+	um_vdso_addr = (unsigned long)page_address(um_vdso_pages[0]);
+	for (i = 0; i < um_vdso_text_pages; i++)
+		os_protect_memory(page_address(um_vdso_pages[i]), PAGE_SIZE, 1, 0, 1);
 #endif

 	return 0;
@@ -44,21 +83,33 @@ int arch_setup_additional_pages(struct
linux_binprm *bprm, int uses_interp)
 {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
+	unsigned long vvar_addr = um_vdso_addr - VDSO_NR_PAGES * PAGE_SIZE;
 	static struct vm_special_mapping vdso_mapping = {
 		.name = "[vdso]",
-		.pages = &um_vdso,
 	};
+	int ret = 0;

 	if (mmap_write_lock_killable(mm))
 		return -EINTR;

-	vma = _install_special_mapping(mm, um_vdso_addr, PAGE_SIZE,
-		VM_READ|VM_EXEC|
-		VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
-		&vdso_mapping);
+	/* [vvar] first (below the text), then [vdso]. */
+	vma = vdso_install_vvar_mapping(mm, vvar_addr);
+	if (IS_ERR(vma)) {
+		ret = PTR_ERR(vma);
+		goto out;
+	}

-	mmap_write_unlock(mm);
+	vdso_mapping.pages = um_vdso_pages;
+	vma = _install_special_mapping(mm, um_vdso_addr,
+				       um_vdso_text_pages * PAGE_SIZE,
+				       VM_READ | VM_EXEC |
+				       VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
+				       &vdso_mapping);
+	if (IS_ERR(vma))
+		ret = PTR_ERR(vma);

-	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
+out:
+	mmap_write_unlock(mm);
+	return ret;
 }
 #endif /* CONFIG_MMU */
-- 
2.43.0

