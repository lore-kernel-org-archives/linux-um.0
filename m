Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB9EC05027
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T7BE8F9Z+J0guliBKtWtRNuPHAvDdr1jh6jyyeU0wJ8=; b=fM4WbOWhNB0bc3
	r37VtkOPmnV6qQtO32jrNU91gBVmjhXKIztHOaGW5gvDuwnMgWzSLkpihq69cbB0SaPde9hiyAs2Y
	915Uizp0Ofmw9JEj6xdwqNS1NnnFZyZ+2Goo1F12Ruz4QwJXw3w6pGeFoB+YpphEl3xIzNL7pyF/z
	yQFGA8Y+cSH4OzL8KKCuJiLEOfHnllSuDfSCRPHIQnv5suVcjapxhIF5i3TjgxwE25NX6JXWvp0h3
	EOQz7hgdHYx2cmxlrBo9Bud5WTVD5UlCXYLhbA0jFadYFsCmq+30/32hABcGrwgpLS8oP82vpiZt4
	qabCG37sa0o3agoLGZeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJL-008M1X-01;
	Fri, 10 Nov 2023 11:04:27 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJI-008LwQ-08
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 11:04:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WdwOY9jks9cp9BDju2bazsV/9U4Wlw42c+a7tDbATns=;
	t=1699614263; x=1700823863; b=HjJB0BUkb5WTXf4bY7reFr63QjXwrF44V0sUlLq9hOF4S5Q
	J/hMFB/Dnsi8TPxv3Lvbzrk8KqPA9XHhqJArUmkr0gNKEpOb1AV613/f1yuo+ZzLJmu6hUojOn6A3
	rkbK6BSRrASppgPHi4zGcKR0shEEqGfXJUwpwlMcA0+Mn8Pb44UMKOqHjsre13Fx/wF3N2XDzma2l
	txQbh17DJ9Z1Co2PJ3cePbH1JQftRqJZc9tKCwCJ5iumA5Xjwa095Zp0geh1c8gvTjkoD0i5BnK4I
	BSaNPkmLLwo4U44UO3oU9W8PbJ+PJL4V/jPWl9146I+61AxKWVTe/M6HDrJP2P6w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1r1PJE-00000002xHc-1T3f;
	Fri, 10 Nov 2023 12:04:20 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v3 09/11] um: Rely on PTRACE_SETREGSET to set FS/GS base registers
Date: Fri, 10 Nov 2023 12:03:46 +0100
Message-ID: <20231110110348.1815612-10-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110110348.1815612-1-benjamin@sipsolutions.net>
References: <20231110110348.1815612-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_030424_246883_0784267F 
X-CRM114-Status: GOOD (  25.73  )
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
index 6523eb7c3bd1..6052200fe925 100644
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
index ae169125d03f..5249bbc30dcd 100644
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
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
