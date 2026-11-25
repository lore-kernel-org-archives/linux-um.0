Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08384606A321
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JJt7IMhC;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jPE6Hz9/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FqYRG8athWDQGcrzbQj9mPlYTIYqm2X5Q1hJTrOJil0=; b=JJt7IMhCosJtelkWk3QsSW5B67
	UexqXF1OaP450b3AzqUvJN3lmt9H511/mW8yVj9zY4Zyg+/Y7LxWk8wQJRwlm/rcyjJU7pow3BbDJ
	zZjEt/wye5NpSucENA+TqHt/+Au+7pM3uK+g7SuUdrH9v2JtbTxmww6ZsJz+9LFQMsPjn3T+giHEy
	+mSYD+SVZKJXNFpwUqHhoW49cv7qtwY+ZsFZrob+TEfJXnABnp9xObvXvvcvFBSJVaA2nBavKhWkT
	2pwG56L8kVgOOafVRzvBPXc5QqLf/GCv20DFA2R3XNjuNj4nZBn0UGBWcfQBY2YOX7hdF+a/Ephno
	xMpKJ/6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9SF-00000009Kyh-31Oq;
	Wed, 25 Nov 2026 09:38:19 +0000
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9SA-00000009Kvh-0XCs
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 09:38:18 +0000
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-9495e8ae23aso470508885a.2
        for <linux-um@lists.infradead.org>; Wed, 25 Nov 2026 01:38:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795599493; cv=none;
        d=google.com; s=arc-20260327;
        b=pIWB2zH5cDzltIDL1IdRR2JgfTYsENTcHB/s+U397nSusRxvpWsoAa3E1PN5xDyJXo
         yqwxPD+exz+MT9p0NlYAdrb2avF9Ux5KxAIKoIsVil/XAESC3Bb2zPFbaIgHMImFTM0u
         quLo64+VR++XPTHbswKjFsvyTZ9wWaugSMzX+6CWKJjvIVJhy3i3OzEAaOejAnTcIBGx
         EAdFfkzpKg9bAi26l6nFUKvLJzH8wk96rWIMzZz9UistEt1TOPtJ85ZhLIv2O9D8QrKJ
         MlLbx/FolQ5REwe6aGmlBDrs1AarKwkGRlBeiW5lYkBVpe/eCbc14DxwQQLPBTw0L510
         UQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=FqYRG8athWDQGcrzbQj9mPlYTIYqm2X5Q1hJTrOJil0=;
        fh=/gBKL856m721509318RIdz8U4fuFWBADYUOnmaP+UV8=;
        b=K7C5t/j/P0IvlmliJOGgJTwItlrzPwzNda/01CZPx1MR5ag2mdw9j9qWVMmZOMMbaj
         a+Lqqnkygo98QztCO+FT50JljoqsROl6zTIccOwO2UtZb4sdUPmDkV15VanaTLscUFUW
         I17bdx4nXBi1WHR7iWfLxc69GiVUGQw0e/RyhuK/tiEzjdxk68xsNy9FThSEGlt5daBs
         jeg/BhLH96D+MmvgkB3x3fgsZ8EGL56kP4mVK89PqWtnF/e6/Uhpq/O7peuPD/FBLTKA
         //cCDL2Z7Oyu9BC4qhIh+YhcZmPfelCyez9AyTaInle1TrjIJsh+9kYyac/KmYo9Vu0U
         pyIg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795599493; x=1796204293; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FqYRG8athWDQGcrzbQj9mPlYTIYqm2X5Q1hJTrOJil0=;
        b=jPE6Hz9/iuP5yYBA3JJgN0lffqoXp44F8agkMVP+mo2knFBkbgoHE6xifikXiizQ+H
         WDrt6M7+pQMgGzxigHPzLmjm2SdyEkUonvVB7+78Rvs5t12q7S3cx90Yix9jiKrkQDOH
         ryuOlkhB6RXC+aAcMH85bWf0EfUDehMvQiP1Rb13MR4SeY2j/xk54ZVuZ96/u+VhU7Wq
         kS8dNnumpVKCfMYiRbouSi7ck88csynebJX0qDhFJGpp0KCGdznNIZDbEFW8cLolaG8f
         DSeYJ/mvrFi9peg/soe3+GKWuXWnQqJMNgCEgyAsDGsJMrCJlc/q2iFj4cdRbz2FF8vn
         j0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599493; x=1796204293;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FqYRG8athWDQGcrzbQj9mPlYTIYqm2X5Q1hJTrOJil0=;
        b=GBpXdJFCoYEZS9Z/g7gBivukGuBjZhfuK/W0vn4lmSPDRBr8aJrdIUD21vktFwIOMl
         oElPQdER4g3CH4pB42kpw6WoDd+fXJ7Fq1cI6ttyuFOsQU6vFQGMBetwR2Q1mQC9f5uP
         FnrB1wIukCXjj9fTv/unurglJKtUgf2DSeVsy00QV5E4hz+C/CP/DZkSZNB8/XV2I2y5
         BqLdL2EqPl/Q9IqIeaCgmHGjqemObh8lzumpoMuYuUYlJ7jj1gxA+yIN4Rn7zvloTOWq
         QSWowziX9cF++dPlQepNo+nGV+usqmlfmmQrv4lNq+pndmvllLQAa57CwLdLDRFn5A90
         fAOw==
X-Gm-Message-State: APuU4Z8bVEg+JDEJqRl7dwfO3oTWFezUWfjhCSmQR9emff7c7NZNURF2
	DU2hyb+kpipNjZM82gMCjL6Kdz9R0EvfJdxunRuwK7d/WJkeAMHEZ5r/KTIMiOtc3m3uFSPzSt1
	yDDKrFlpZz+hVuBGK6m5LWYEPGEfAI2WLo4nI
X-Gm-Gg: AZFdTZepqmzPcIBJcKLXJU4wRGjr3OC28llqwILAjIY0TtD1SWhCX0MG34LiDKf+26B
	Na1FPC9HRlp9czv8xBdlnFbuyYRWDj63dH99XrDZPa4R3ChGABHDw/cGSgdDI2vc5FZlWAdTwaH
	fpctaEHywHKVdJd7sk33Z6yB2omOC3dehz/0VfmwoghurspG71+bgeg5kwYfhHNDY6qrZlgtMv8
	jEk5UKEFhw+b2SrjTBgVoKnpSCj8lT7tBviAyANVKmZtaw7m+XfyaypzVl+8Q1+DgePJVJXbE5e
	qwImOd+gI2O5xhg0n6waUnueIsDmsUR/fBE22abFVoKdusVnbmkGbhW3hIemPxSBSnjLrqsYvu9
	NBqDjzxvD1qCmOMbER9kM9SaAihoP2mwbxLPaB7J9hUq5+qYneenR9YX/
X-Received: by 2002:a05:620a:2681:b0:943:faab:aabd with SMTP id
 af79cd13be357-949bab3e45bmr2713886485a.52.1795599492647; Wed, 25 Nov 2026
 01:38:12 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Nov 2026 04:38:11 -0500
From: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
In-Reply-To: <CAB2K5aCdEWKvsCUWeHWR0FDVqQ2263PaDQX8VWnma5pF4HwG8Q@mail.gmail.com>
References: <CAB2K5aCdEWKvsCUWeHWR0FDVqQ2263PaDQX8VWnma5pF4HwG8Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Nov 2026 04:38:11 -0500
X-Gm-Features: Aa3M54o-hrUU5EhOymBp13t4SwDMoj1U_VSDk8StNPOU-1r8HJVwEsxSCO965DU
Message-ID: <CAB2K5aCFBUsFjJ-iu+zU3Jygzi5ODeWJhsoj6wfX3oCbyTWayQ@mail.gmail.com>
Subject: [PATCH v2 5/5] um: vdso: wire up the vvar mapping, layout and build
 (MMU only)
To: linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_013814_211989_5F6E3B97 
X-CRM114-Status: GOOD (  26.70  )
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

