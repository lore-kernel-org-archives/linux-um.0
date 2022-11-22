Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBE9C43219
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RE+ap2HEmuKbJucEGdTqlEXDDwiQF+5G//ib+awQZMg=; b=23fHYO2EdSCZsq
	ZAiCPo423Tig1C0N8GSVACjXXjb1Ck7Pt/jtnx1aYa8WZndw8L0xAuUFis3AbSba4O9GBwlx5vQP+
	BV7yBanjriXgBl8cg50Tx9rHeMpDpbUuVEHSn9xAop9aIdq8W/nyBc4B0G4/Q5Q8cd78GL5dmLNbN
	X3o3xBwZd9xrl3Itxe/GmKkTHUwKeIy96welgT7B7z4si5/TZOjaRLYLuByhclE9lDfB3DuVcLBpz
	lp6HoEWGfxeWjiqTiUIeJD2NpWisowux1O2Y5f16dTeuWkMX306jTTsLo157ZoJx/Ipwm93zAbyXN
	gMq/BdScPVZPa12JNzHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQFO-007g0C-9K; Tue, 22 Nov 2022 10:11:22 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF1-007feU-7e
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bl09+7qb9QLgVQS3yUfD8lsFAj/H068ZRSWIURWdnvQ=;
	t=1669111859; x=1670321459; b=a2/kI4s3FSTNqE3C6dlUCieK86AyQF9+iZPz9u7bGX816la
	bOfYpMC8HNW5xEmnWCf5otORDwWLqZzuJZj6Q3q9SIUVpgumD7OtN7+I3gt+DU0Tck5qGnPY1tLTS
	6UsltUrdW1f/cB/VTP3KjLi8Fq/M/tEjwoKCfAupz4tW0yVJRA/jxiFB8o4acdsUSrFiMfb4ZungR
	A/DwEtM6+dVyUPAEMEAUnSQSD2ieP/PDfb4W2S9xSobk6lJ1p4yD/G4/pdg1GHy4wWEEtDhq+jOwC
	fkbWQGQclabxbOklDPqOejbIPZaTd+K2E7mgbApMBCwcURj81lSmODGPvyX5aGaQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEp-006IGn-0e;
	Tue, 22 Nov 2022 11:10:47 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 11/28] um: Rely on PTRACE_SETREGSET to set FS/GS base registers
Date: Tue, 22 Nov 2022 11:07:42 +0100
Message-Id: <20221122100759.208290-12-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_021059_562369_5905A1E3 
X-CRM114-Status: GOOD (  25.51  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin@sipsolutions.net>

These registers are saved/restored together with the other general
registers using ptrace. In arch_set_tls we then just need to set the
register and it will be synced back normally.

Most of this logic was introduced in commit f355559cf7845 ("[PATCH] uml:
x86_64 thread fixes"). However, at least today we can rely on ptrace to
restore the base registers for us. As such, only the part of the patch
that tracks the FS register for use as thread local storage is actually
needed.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/os.h    |  3 --
 arch/x86/um/asm/elf.h          |  4 +--
 arch/x86/um/asm/processor_64.h |  3 --
 arch/x86/um/os-Linux/Makefile  |  1 -
 arch/x86/um/os-Linux/prctl.c   | 12 -------
 arch/x86/um/syscalls_64.c      | 62 +++++++---------------------------
 arch/x86/um/tls_64.c           |  2 +-
 7 files changed, 16 insertions(+), 71 deletions(-)
 delete mode 100644 arch/x86/um/os-Linux/prctl.c

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 0df646c6651e..aff8906304ea 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -323,9 +323,6 @@ extern void sigio_broken(int fd);
 extern int __add_sigio_fd(int fd);
 extern int __ignore_sigio_fd(int fd);
 
-/* prctl.c */
-extern int os_arch_prctl(int pid, int option, unsigned long *arg2);
-
 /* tty.c */
 extern int get_pty(void);
 
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index dcaf3b38a9e0..994bb0d5c1eb 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -168,8 +168,8 @@ do {								\
 	(pr_reg)[18] = (_regs)->regs.gp[18];			\
 	(pr_reg)[19] = (_regs)->regs.gp[19];			\
 	(pr_reg)[20] = (_regs)->regs.gp[20];			\
-	(pr_reg)[21] = current->thread.arch.fs;			\
-	(pr_reg)[22] = 0;					\
+	(pr_reg)[21] = (_regs)->regs.gp[21];			\
+	(pr_reg)[22] = (_regs)->regs.gp[22];			\
 	(pr_reg)[23] = 0;					\
 	(pr_reg)[24] = 0;					\
 	(pr_reg)[25] = 0;					\
diff --git a/arch/x86/um/asm/processor_64.h b/arch/x86/um/asm/processor_64.h
index 1ef9c21877bc..f90159508936 100644
--- a/arch/x86/um/asm/processor_64.h
+++ b/arch/x86/um/asm/processor_64.h
@@ -10,13 +10,11 @@
 struct arch_thread {
         unsigned long debugregs[8];
         int debugregs_seq;
-        unsigned long fs;
         struct faultinfo faultinfo;
 };
 
 #define INIT_ARCH_THREAD { .debugregs  		= { [ 0 ... 7 ] = 0 }, \
 			   .debugregs_seq	= 0, \
-			   .fs			= 0, \
 			   .faultinfo		= { 0, 0, 0 } }
 
 #define STACKSLOTS_PER_LINE 4
@@ -28,7 +26,6 @@ static inline void arch_flush_thread(struct arch_thread *thread)
 static inline void arch_copy_thread(struct arch_thread *from,
                                     struct arch_thread *to)
 {
-	to->fs = from->fs;
 }
 
 #define current_sp() ({ void *sp; __asm__("movq %%rsp, %0" : "=r" (sp) : ); sp; })
diff --git a/arch/x86/um/os-Linux/Makefile b/arch/x86/um/os-Linux/Makefile
index 253bfb8cb702..2859bbf0f3db 100644
--- a/arch/x86/um/os-Linux/Makefile
+++ b/arch/x86/um/os-Linux/Makefile
@@ -6,7 +6,6 @@
 obj-y = registers.o task_size.o mcontext.o
 
 obj-$(CONFIG_X86_32) += tls.o
-obj-$(CONFIG_64BIT) += prctl.o
 
 USER_OBJS := $(obj-y)
 
diff --git a/arch/x86/um/os-Linux/prctl.c b/arch/x86/um/os-Linux/prctl.c
deleted file mode 100644
index 8431e87ac333..000000000000
--- a/arch/x86/um/os-Linux/prctl.c
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * Copyright (C) 2007 Jeff Dike (jdike@{addtoit.com,linux.intel.com})
- * Licensed under the GPL
- */
-
-#include <sys/ptrace.h>
-#include <asm/ptrace.h>
-
-int os_arch_prctl(int pid, int option, unsigned long *arg2)
-{
-	return ptrace(PTRACE_ARCH_PRCTL, pid, (unsigned long) arg2, option);
-}
diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index 27b29ae6c471..6a00a28c9cca 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -16,60 +16,24 @@
 long arch_prctl(struct task_struct *task, int option,
 		unsigned long __user *arg2)
 {
-	unsigned long *ptr = arg2, tmp;
-	long ret;
-	int pid = task->mm->context.id.u.pid;
-
-	/*
-	 * With ARCH_SET_FS (and ARCH_SET_GS is treated similarly to
-	 * be safe), we need to call arch_prctl on the host because
-	 * setting %fs may result in something else happening (like a
-	 * GDT or thread.fs being set instead).  So, we let the host
-	 * fiddle the registers and thread struct and restore the
-	 * registers afterwards.
-	 *
-	 * So, the saved registers are stored to the process (this
-	 * needed because a stub may have been the last thing to run),
-	 * arch_prctl is run on the host, then the registers are read
-	 * back.
-	 */
-	switch (option) {
-	case ARCH_SET_FS:
-	case ARCH_SET_GS:
-		ret = restore_pid_registers(pid, &current->thread.regs.regs);
-		if (ret)
-			return ret;
-		break;
-	case ARCH_GET_FS:
-	case ARCH_GET_GS:
-		/*
-		 * With these two, we read to a local pointer and
-		 * put_user it to the userspace pointer that we were
-		 * given.  If addr isn't valid (because it hasn't been
-		 * faulted in or is just bogus), we want put_user to
-		 * fault it in (or return -EFAULT) instead of having
-		 * the host return -EFAULT.
-		 */
-		ptr = &tmp;
-	}
-
-	ret = os_arch_prctl(pid, option, ptr);
-	if (ret)
-		return ret;
+	long ret = -EINVAL;
 
 	switch (option) {
 	case ARCH_SET_FS:
-		current->thread.arch.fs = (unsigned long) ptr;
-		ret = save_registers(pid, &current->thread.regs.regs);
+		current->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)] =
+			(unsigned long) arg2;
+		ret = 0;
 		break;
 	case ARCH_SET_GS:
-		ret = save_registers(pid, &current->thread.regs.regs);
+		current->thread.regs.regs.gp[GS_BASE / sizeof(unsigned long)] =
+			(unsigned long) arg2;
+		ret = 0;
 		break;
 	case ARCH_GET_FS:
-		ret = put_user(tmp, arg2);
+		ret = put_user(current->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)], arg2);
 		break;
 	case ARCH_GET_GS:
-		ret = put_user(tmp, arg2);
+		ret = put_user(current->thread.regs.regs.gp[GS_BASE / sizeof(unsigned long)], arg2);
 		break;
 	}
 
@@ -83,10 +47,10 @@ SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 
 void arch_switch_to(struct task_struct *to)
 {
-	if ((to->thread.arch.fs == 0) || (to->mm == NULL))
-		return;
-
-	arch_prctl(to, ARCH_SET_FS, (void __user *) to->thread.arch.fs);
+	/*
+	 * Nothing needs to be done on x86_64.
+	 * The FS_BASE/GS_BASE registers are saved in the ptrace register set.
+	 */
 }
 
 SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
diff --git a/arch/x86/um/tls_64.c b/arch/x86/um/tls_64.c
index ebd3855d9b13..c51a613f6f5c 100644
--- a/arch/x86/um/tls_64.c
+++ b/arch/x86/um/tls_64.c
@@ -12,7 +12,7 @@ int arch_set_tls(struct task_struct *t, unsigned long tls)
 	 * If CLONE_SETTLS is set, we need to save the thread id
 	 * so it can be set during context switches.
 	 */
-	t->thread.arch.fs = tls;
+	t->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)] = tls;
 
 	return 0;
 }
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
