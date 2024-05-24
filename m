Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3258FC25B7D
	for <linux-um@archiver.kernel.org>; Fri, 24 May 2024 21:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BTrJhbPVlBiy5ph2B3QnLfTP8+4LcyClnEPuNUAvW8M=; b=SCc0c4pbHCnLwrP/n27zHqsW3n
	Fq24ycgEbLfCzdyT3xphiSew8V5rjOjwSKPZ083tooUSnITh7nekcQGkutKobuUyduRQtXKKCdNEU
	bQC/cluFhI8HnIbXFv+JVKnZadlWq2BOqdUo8qiLjiku1GWyKWSXXw3lpqhIFdzcYPjghePeaZJaE
	wXRBiFf4dBi4+rc05Gh2IlIQ2ly5XoLnlT9CXDKhljLXHX38WS6orLR4sx68RCStmgWg3j52+hcU5
	x6xZ9XBC9XWFxrYgZ8v+6lQwZ/MzwUqh8fws6Enrwal+1qAwUBbxol17KjLAUbfdpmvzqqSQ1z+jF
	vRGihJ/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAcf8-00000009wfj-3ba0;
	Fri, 24 May 2024 21:41:18 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAcf4-00000009wbf-0xOv
	for linux-um@lists.infradead.org;
	Fri, 24 May 2024 21:41:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BTrJhbPVlBiy5ph2B3QnLfTP8+4LcyClnEPuNUAvW8M=;
	t=1716586874; x=1717796474; b=qTgWEABAsYZJEyopTXr9oDzdgOeKX/xDlDTTH6pEJ1AHqqf
	YQb4jZzyyYCMvETloK9VOq8kk21jToTqbpDtfIbn5Hv/KpNq1bnLl5J5pRLH2yer/+9lZWRSQOBHG
	bnWRm5APt1Qks1ij6y25of86/smgiOJWpriO9gLz2v0RtbkplV73KUrfBXK42SwczDda/hC5pMTsf
	w273GHobmhE9DHaGQpXAWxW4l+y4EBJCkGqNC5Gwfavxs+sslPHt4y5ooJY+398tNxsDwe3vaZT3z
	5kmbgkSw7K0Jjc+ecrMGiDu526GR0fyU2pA5f+1QFIliQfFMxO1WRZEdXbP+ueIA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sAcf2-00000008ke7-0ecZ;
	Fri, 24 May 2024 23:41:12 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 06/12] um: remove LDT support
Date: Fri, 24 May 2024 23:37:12 +0200
Message-ID: <20240524213718.1757703-7-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524213718.1757703-1-benjamin@sipsolutions.net>
References: <20240524213718.1757703-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_144114_643172_20D68805 
X-CRM114-Status: GOOD (  31.40  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

The current LDT code has a few issues that mean it should be redone in a
different way once we always start with a fresh MM even when cloning.

In a new and better world, the kernel would just ensure its own LDT is
clear at startup. At that point, all that is needed is a simple function
to populate the LDT from another MM in arch_dup_mmap combined with some
tracking of the installed LDT entries for each MM.

Note that the old implementation was even incorrect with regard to
reading, as it copied out the LDT entries in the internal format rather
than converting them to the userspace structure.

Removal should be fine as the LDT is not used for thread-local storage
anymore.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/include/asm/mmu.h               |   6 -
 arch/um/include/shared/skas/stub-data.h |  21 +-
 arch/um/kernel/skas/mmu.c               |   8 -
 arch/um/kernel/skas/stub.c              |  11 -
 arch/um/os-Linux/start_up.c             |   1 +
 arch/x86/um/Makefile                    |   2 +-
 arch/x86/um/asm/mm_context.h            |  70 -----
 arch/x86/um/ldt.c                       | 367 ------------------------
 arch/x86/um/tls_32.c                    |   1 +
 9 files changed, 10 insertions(+), 477 deletions(-)
 delete mode 100644 arch/x86/um/asm/mm_context.h
 delete mode 100644 arch/x86/um/ldt.c

diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index a7555e43ed14..37eb6e89e79a 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -7,17 +7,11 @@
 #define __ARCH_UM_MMU_H
 
 #include <mm_id.h>
-#include <asm/mm_context.h>
 
 typedef struct mm_context {
 	struct mm_id id;
-	struct uml_arch_mm_context arch;
 } mm_context_t;
 
 extern void __switch_mm(struct mm_id * mm_idp);
 
-/* Avoid tangled inclusion with asm/ldt.h */
-extern long init_new_ldt(struct mm_context *to_mm, struct mm_context *from_mm);
-extern void free_ldt(struct mm_context *mm);
-
 #endif
diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 6ffa9fb5218c..6b8caf6b8283 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -20,23 +20,16 @@ enum stub_syscall_type {
 	STUB_SYSCALL_MMAP,
 	STUB_SYSCALL_MUNMAP,
 	STUB_SYSCALL_MPROTECT,
-	STUB_SYSCALL_LDT,
 };
 
 struct stub_syscall {
-	union {
-		struct {
-			unsigned long addr;
-			unsigned long length;
-			unsigned long offset;
-			int fd;
-			int prot;
-		} mem;
-		struct {
-			user_desc_t desc;
-			int func;
-		} ldt;
-	};
+	struct {
+		unsigned long addr;
+		unsigned long length;
+		unsigned long offset;
+		int fd;
+		int prot;
+	} mem;
 
 	enum stub_syscall_type syscall;
 };
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index b6b9679e6e11..d6183cfd51fe 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -45,13 +45,6 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 		goto out_free;
 	}
 
-	ret = init_new_ldt(to_mm, from_mm);
-	if (ret < 0) {
-		printk(KERN_ERR "init_new_context_skas - init_ldt"
-		       " failed, errno = %d\n", ret);
-		goto out_free;
-	}
-
 	return 0;
 
  out_free:
@@ -79,5 +72,4 @@ void destroy_context(struct mm_struct *mm)
 	os_kill_ptraced_process(mmu->id.u.pid, 1);
 
 	free_pages(mmu->id.stack, ilog2(STUB_DATA_PAGES));
-	free_ldt(mmu);
 }
diff --git a/arch/um/kernel/skas/stub.c b/arch/um/kernel/skas/stub.c
index 8773529b5048..5d52ffa682dc 100644
--- a/arch/um/kernel/skas/stub.c
+++ b/arch/um/kernel/skas/stub.c
@@ -45,17 +45,6 @@ static __always_inline int syscall_handler(struct stub_data *d)
 				return -1;
 			}
 			break;
-		case STUB_SYSCALL_LDT:
-			res = stub_syscall3(__NR_modify_ldt, sc->ldt.func,
-					    (unsigned long) &sc->ldt.desc,
-					    sizeof(sc->ldt.desc));
-			/* We only write, so the expected result is zero */
-			if (res) {
-				d->err = res;
-				d->syscall_data_len = i;
-				return -1;
-			}
-			break;
 		default:
 			d->err = -95; /* EOPNOTSUPP */
 			d->syscall_data_len = i;
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 8b0e98ab842c..1baabcc9bbd5 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -17,6 +17,7 @@
 #include <sys/wait.h>
 #include <sys/time.h>
 #include <sys/resource.h>
+#include <asm/ldt.h>
 #include <asm/unistd.h>
 #include <init.h>
 #include <os.h>
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 4559d2a693c4..17b85209c43d 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -9,7 +9,7 @@ else
 	BITS := 64
 endif
 
-obj-y = bugs_$(BITS).o delay.o fault.o ldt.o \
+obj-y = bugs_$(BITS).o delay.o fault.o \
 	ptrace_$(BITS).o ptrace_user.o setjmp_$(BITS).o signal.o \
 	stub_segv.o \
 	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
diff --git a/arch/x86/um/asm/mm_context.h b/arch/x86/um/asm/mm_context.h
deleted file mode 100644
index dc32dc023c2f..000000000000
--- a/arch/x86/um/asm/mm_context.h
+++ /dev/null
@@ -1,70 +0,0 @@
-/*
- * Copyright (C) 2004 Fujitsu Siemens Computers GmbH
- * Licensed under the GPL
- *
- * Author: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
- */
-
-#ifndef __ASM_LDT_H
-#define __ASM_LDT_H
-
-#include <linux/mutex.h>
-#include <asm/ldt.h>
-
-#define LDT_PAGES_MAX \
-	((LDT_ENTRIES * LDT_ENTRY_SIZE)/PAGE_SIZE)
-#define LDT_ENTRIES_PER_PAGE \
-	(PAGE_SIZE/LDT_ENTRY_SIZE)
-#define LDT_DIRECT_ENTRIES \
-	((LDT_PAGES_MAX*sizeof(void *))/LDT_ENTRY_SIZE)
-
-struct ldt_entry {
-	__u32 a;
-	__u32 b;
-};
-
-typedef struct uml_ldt {
-	int entry_count;
-	struct mutex lock;
-	union {
-		struct ldt_entry * pages[LDT_PAGES_MAX];
-		struct ldt_entry entries[LDT_DIRECT_ENTRIES];
-	} u;
-} uml_ldt_t;
-
-#define LDT_entry_a(info) \
-	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
-
-#define LDT_entry_b(info) \
-	(((info)->base_addr & 0xff000000) | \
-	(((info)->base_addr & 0x00ff0000) >> 16) | \
-	((info)->limit & 0xf0000) | \
-	(((info)->read_exec_only ^ 1) << 9) | \
-	((info)->contents << 10) | \
-	(((info)->seg_not_present ^ 1) << 15) | \
-	((info)->seg_32bit << 22) | \
-	((info)->limit_in_pages << 23) | \
-	((info)->useable << 20) | \
-	0x7000)
-
-#define _LDT_empty(info) (\
-	(info)->base_addr	== 0	&& \
-	(info)->limit		== 0	&& \
-	(info)->contents	== 0	&& \
-	(info)->read_exec_only	== 1	&& \
-	(info)->seg_32bit	== 0	&& \
-	(info)->limit_in_pages	== 0	&& \
-	(info)->seg_not_present	== 1	&& \
-	(info)->useable		== 0	)
-
-#ifdef CONFIG_X86_64
-#define LDT_empty(info) (_LDT_empty(info) && ((info)->lm == 0))
-#else
-#define LDT_empty(info) (_LDT_empty(info))
-#endif
-
-struct uml_arch_mm_context {
-	uml_ldt_t ldt;
-};
-
-#endif
diff --git a/arch/x86/um/ldt.c b/arch/x86/um/ldt.c
deleted file mode 100644
index c99fc23b1290..000000000000
--- a/arch/x86/um/ldt.c
+++ /dev/null
@@ -1,367 +0,0 @@
-/*
- * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
- */
-
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/syscalls.h>
-#include <linux/uaccess.h>
-#include <asm/unistd.h>
-#include <os.h>
-#include <skas.h>
-#include <sysdep/tls.h>
-#include <stub-data.h>
-
-static inline int modify_ldt (int func, void *ptr, unsigned long bytecount)
-{
-	return syscall(__NR_modify_ldt, func, ptr, bytecount);
-}
-
-static void write_ldt_entry(struct mm_id *mm_idp, int func,
-		     struct user_desc *desc)
-{
-	struct stub_syscall *sc;
-
-	sc = syscall_stub_alloc(mm_idp);
-	sc->syscall = STUB_SYSCALL_LDT;
-	sc->ldt.func = func;
-	memcpy(&sc->ldt.desc, desc, sizeof(*desc));
-}
-
-/*
- * In skas mode, we hold our own ldt data in UML.
- * Thus, the code implementing sys_modify_ldt_skas
- * is very similar to (and mostly stolen from) sys_modify_ldt
- * for arch/i386/kernel/ldt.c
- * The routines copied and modified in part are:
- * - read_ldt
- * - read_default_ldt
- * - write_ldt
- * - sys_modify_ldt_skas
- */
-
-static int read_ldt(void __user * ptr, unsigned long bytecount)
-{
-	int i, err = 0;
-	unsigned long size;
-	uml_ldt_t *ldt = &current->mm->context.arch.ldt;
-
-	if (!ldt->entry_count)
-		goto out;
-	if (bytecount > LDT_ENTRY_SIZE*LDT_ENTRIES)
-		bytecount = LDT_ENTRY_SIZE*LDT_ENTRIES;
-	err = bytecount;
-
-	mutex_lock(&ldt->lock);
-	if (ldt->entry_count <= LDT_DIRECT_ENTRIES) {
-		size = LDT_ENTRY_SIZE*LDT_DIRECT_ENTRIES;
-		if (size > bytecount)
-			size = bytecount;
-		if (copy_to_user(ptr, ldt->u.entries, size))
-			err = -EFAULT;
-		bytecount -= size;
-		ptr += size;
-	}
-	else {
-		for (i=0; i<ldt->entry_count/LDT_ENTRIES_PER_PAGE && bytecount;
-		     i++) {
-			size = PAGE_SIZE;
-			if (size > bytecount)
-				size = bytecount;
-			if (copy_to_user(ptr, ldt->u.pages[i], size)) {
-				err = -EFAULT;
-				break;
-			}
-			bytecount -= size;
-			ptr += size;
-		}
-	}
-	mutex_unlock(&ldt->lock);
-
-	if (bytecount == 0 || err == -EFAULT)
-		goto out;
-
-	if (clear_user(ptr, bytecount))
-		err = -EFAULT;
-
-out:
-	return err;
-}
-
-static int read_default_ldt(void __user * ptr, unsigned long bytecount)
-{
-	int err;
-
-	if (bytecount > 5*LDT_ENTRY_SIZE)
-		bytecount = 5*LDT_ENTRY_SIZE;
-
-	err = bytecount;
-	/*
-	 * UML doesn't support lcall7 and lcall27.
-	 * So, we don't really have a default ldt, but emulate
-	 * an empty ldt of common host default ldt size.
-	 */
-	if (clear_user(ptr, bytecount))
-		err = -EFAULT;
-
-	return err;
-}
-
-static int write_ldt(void __user * ptr, unsigned long bytecount, int func)
-{
-	uml_ldt_t *ldt = &current->mm->context.arch.ldt;
-	struct mm_id * mm_idp = &current->mm->context.id;
-	int i, err;
-	struct user_desc ldt_info;
-	struct ldt_entry entry0, *ldt_p;
-
-	err = -EINVAL;
-	if (bytecount != sizeof(ldt_info))
-		goto out;
-	err = -EFAULT;
-	if (copy_from_user(&ldt_info, ptr, sizeof(ldt_info)))
-		goto out;
-
-	err = -EINVAL;
-	if (ldt_info.entry_number >= LDT_ENTRIES)
-		goto out;
-	if (ldt_info.contents == 3) {
-		if (func == 1)
-			goto out;
-		if (ldt_info.seg_not_present == 0)
-			goto out;
-	}
-
-	mutex_lock(&ldt->lock);
-
-	write_ldt_entry(mm_idp, func, &ldt_info);
-	err = syscall_stub_flush(mm_idp);
-	if (err)
-		goto out_unlock;
-
-	if (ldt_info.entry_number >= ldt->entry_count &&
-	    ldt_info.entry_number >= LDT_DIRECT_ENTRIES) {
-		for (i=ldt->entry_count/LDT_ENTRIES_PER_PAGE;
-		     i*LDT_ENTRIES_PER_PAGE <= ldt_info.entry_number;
-		     i++) {
-			if (i == 0)
-				memcpy(&entry0, ldt->u.entries,
-				       sizeof(entry0));
-			ldt->u.pages[i] = (struct ldt_entry *)
-				__get_free_page(GFP_KERNEL|__GFP_ZERO);
-			if (!ldt->u.pages[i]) {
-				err = -ENOMEM;
-				/* Undo the change in host */
-				memset(&ldt_info, 0, sizeof(ldt_info));
-				write_ldt_entry(mm_idp, 1, &ldt_info);
-				err = syscall_stub_flush(mm_idp);
-				goto out_unlock;
-			}
-			if (i == 0) {
-				memcpy(ldt->u.pages[0], &entry0,
-				       sizeof(entry0));
-				memcpy(ldt->u.pages[0]+1, ldt->u.entries+1,
-				       sizeof(entry0)*(LDT_DIRECT_ENTRIES-1));
-			}
-			ldt->entry_count = (i + 1) * LDT_ENTRIES_PER_PAGE;
-		}
-	}
-	if (ldt->entry_count <= ldt_info.entry_number)
-		ldt->entry_count = ldt_info.entry_number + 1;
-
-	if (ldt->entry_count <= LDT_DIRECT_ENTRIES)
-		ldt_p = ldt->u.entries + ldt_info.entry_number;
-	else
-		ldt_p = ldt->u.pages[ldt_info.entry_number/LDT_ENTRIES_PER_PAGE] +
-			ldt_info.entry_number%LDT_ENTRIES_PER_PAGE;
-
-	if (ldt_info.base_addr == 0 && ldt_info.limit == 0 &&
-	   (func == 1 || LDT_empty(&ldt_info))) {
-		ldt_p->a = 0;
-		ldt_p->b = 0;
-	}
-	else{
-		if (func == 1)
-			ldt_info.useable = 0;
-		ldt_p->a = LDT_entry_a(&ldt_info);
-		ldt_p->b = LDT_entry_b(&ldt_info);
-	}
-	err = 0;
-
-out_unlock:
-	mutex_unlock(&ldt->lock);
-out:
-	return err;
-}
-
-static long do_modify_ldt_skas(int func, void __user *ptr,
-			       unsigned long bytecount)
-{
-	int ret = -ENOSYS;
-
-	switch (func) {
-		case 0:
-			ret = read_ldt(ptr, bytecount);
-			break;
-		case 1:
-		case 0x11:
-			ret = write_ldt(ptr, bytecount, func);
-			break;
-		case 2:
-			ret = read_default_ldt(ptr, bytecount);
-			break;
-	}
-	return ret;
-}
-
-static DEFINE_SPINLOCK(host_ldt_lock);
-static short dummy_list[9] = {0, -1};
-static short * host_ldt_entries = NULL;
-
-static void ldt_get_host_info(void)
-{
-	long ret;
-	struct ldt_entry * ldt;
-	short *tmp;
-	int i, size, k, order;
-
-	spin_lock(&host_ldt_lock);
-
-	if (host_ldt_entries != NULL) {
-		spin_unlock(&host_ldt_lock);
-		return;
-	}
-	host_ldt_entries = dummy_list+1;
-
-	spin_unlock(&host_ldt_lock);
-
-	for (i = LDT_PAGES_MAX-1, order=0; i; i>>=1, order++)
-		;
-
-	ldt = (struct ldt_entry *)
-	      __get_free_pages(GFP_KERNEL|__GFP_ZERO, order);
-	if (ldt == NULL) {
-		printk(KERN_ERR "ldt_get_host_info: couldn't allocate buffer "
-		       "for host ldt\n");
-		return;
-	}
-
-	ret = modify_ldt(0, ldt, (1<<order)*PAGE_SIZE);
-	if (ret < 0) {
-		printk(KERN_ERR "ldt_get_host_info: couldn't read host ldt\n");
-		goto out_free;
-	}
-	if (ret == 0) {
-		/* default_ldt is active, simply write an empty entry 0 */
-		host_ldt_entries = dummy_list;
-		goto out_free;
-	}
-
-	for (i=0, size=0; i<ret/LDT_ENTRY_SIZE; i++) {
-		if (ldt[i].a != 0 || ldt[i].b != 0)
-			size++;
-	}
-
-	if (size < ARRAY_SIZE(dummy_list))
-		host_ldt_entries = dummy_list;
-	else {
-		size = (size + 1) * sizeof(dummy_list[0]);
-		tmp = kmalloc(size, GFP_KERNEL);
-		if (tmp == NULL) {
-			printk(KERN_ERR "ldt_get_host_info: couldn't allocate "
-			       "host ldt list\n");
-			goto out_free;
-		}
-		host_ldt_entries = tmp;
-	}
-
-	for (i=0, k=0; i<ret/LDT_ENTRY_SIZE; i++) {
-		if (ldt[i].a != 0 || ldt[i].b != 0)
-			host_ldt_entries[k++] = i;
-	}
-	host_ldt_entries[k] = -1;
-
-out_free:
-	free_pages((unsigned long)ldt, order);
-}
-
-long init_new_ldt(struct mm_context *new_mm, struct mm_context *from_mm)
-{
-	struct user_desc desc;
-	short * num_p;
-	int i;
-	long page, err=0;
-
-
-	mutex_init(&new_mm->arch.ldt.lock);
-
-	if (!from_mm) {
-		memset(&desc, 0, sizeof(desc));
-		/*
-		 * Now we try to retrieve info about the ldt, we
-		 * inherited from the host. All ldt-entries found
-		 * will be reset in the following loop
-		 */
-		ldt_get_host_info();
-		for (num_p=host_ldt_entries; *num_p != -1; num_p++) {
-			desc.entry_number = *num_p;
-			write_ldt_entry(&new_mm->id, 1, &desc);
-		}
-		err = syscall_stub_flush(&new_mm->id);
-		new_mm->arch.ldt.entry_count = 0;
-
-		goto out;
-	}
-
-	/*
-	 * Our local LDT is used to supply the data for
-	 * modify_ldt(READLDT), if PTRACE_LDT isn't available,
-	 * i.e., we have to use the stub for modify_ldt, which
-	 * can't handle the big read buffer of up to 64kB.
-	 */
-	mutex_lock(&from_mm->arch.ldt.lock);
-	if (from_mm->arch.ldt.entry_count <= LDT_DIRECT_ENTRIES)
-		memcpy(new_mm->arch.ldt.u.entries, from_mm->arch.ldt.u.entries,
-		       sizeof(new_mm->arch.ldt.u.entries));
-	else {
-		i = from_mm->arch.ldt.entry_count / LDT_ENTRIES_PER_PAGE;
-		while (i-->0) {
-			page = __get_free_page(GFP_KERNEL|__GFP_ZERO);
-			if (!page) {
-				err = -ENOMEM;
-				break;
-			}
-			new_mm->arch.ldt.u.pages[i] =
-				(struct ldt_entry *) page;
-			memcpy(new_mm->arch.ldt.u.pages[i],
-			       from_mm->arch.ldt.u.pages[i], PAGE_SIZE);
-		}
-	}
-	new_mm->arch.ldt.entry_count = from_mm->arch.ldt.entry_count;
-	mutex_unlock(&from_mm->arch.ldt.lock);
-
-    out:
-	return err;
-}
-
-
-void free_ldt(struct mm_context *mm)
-{
-	int i;
-
-	if (mm->arch.ldt.entry_count > LDT_DIRECT_ENTRIES) {
-		i = mm->arch.ldt.entry_count / LDT_ENTRIES_PER_PAGE;
-		while (i-- > 0)
-			free_page((long) mm->arch.ldt.u.pages[i]);
-	}
-	mm->arch.ldt.entry_count = 0;
-}
-
-SYSCALL_DEFINE3(modify_ldt, int , func , void __user * , ptr ,
-		unsigned long , bytecount)
-{
-	/* See non-um modify_ldt() for why we do this cast */
-	return (unsigned int)do_modify_ldt_skas(func, ptr, bytecount);
-}
diff --git a/arch/x86/um/tls_32.c b/arch/x86/um/tls_32.c
index 66162eafd8e8..8d6a6656a5cf 100644
--- a/arch/x86/um/tls_32.c
+++ b/arch/x86/um/tls_32.c
@@ -11,6 +11,7 @@
 #include <os.h>
 #include <skas.h>
 #include <sysdep/tls.h>
+#include <asm/desc.h>
 
 /*
  * If needed we can detect when it's uninitialized.
-- 
2.45.1


