Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6F0D12D77
	for <linux-um@archiver.kernel.org>; Mon, 11 Nov 2024 06:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pN5CuG6WF+TQ5+fRPMrqHbPBVi3cfYGsR4fmOv8Ey5Y=; b=q7KhXbyeNHq46L28CjPSR8vzH5
	8e18rbsHk+dXUwPopJ3soW7jPFOG1IVxubDQlDiMO4LSSXolAP8bWrgVOep5Qa+OZ/VbJmL/Qqwr+
	+u5FPDelyYa+++kIGTfkNw8tTgEfyzn7dV2CvapxCXiF4Ivb2ojatJeKDUnZ446qMO9/nDhsSMwg8
	jPKt6tvposusnCQVMk8HXl3/Z7w9CLqteGzQmhMbmwWk2cB0iZRLA9D8Jv3q4LHCfwhhb5ZubXHiX
	3nPTNHdzZAy+ne7PWO7oozLEK1H5FLteoie6mqdpVYKRR9mYal0gZssFoeQD2IQ5IDDFYq+FTVYVd
	xs3mxdpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tANuc-0000000GUHh-1xrA;
	Mon, 11 Nov 2024 06:28:34 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tANua-0000000GUH3-0ItG
	for linux-um@lists.infradead.org;
	Mon, 11 Nov 2024 06:28:33 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-720be27db27so3306359b3a.2
        for <linux-um@lists.infradead.org>; Sun, 10 Nov 2024 22:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731306511; x=1731911311; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN5CuG6WF+TQ5+fRPMrqHbPBVi3cfYGsR4fmOv8Ey5Y=;
        b=aWa6rniLWvaw47hdDrNM0SJxRZ3g3XKHrXsnc2kteRrON905JoeC39bmRPs150lDl5
         zREzxYjJkrdRX5kV2kO1tpW+Db3oWcxbVpDYyKfawASKga6geztw3h/9JB2oNGgFSgEN
         ltbbhqgMXatUz+vIHUeW6bKWljdJtGDUNunwQy/JR64uyep6LijRaUKEJYsVtfgxsvfK
         B0eeZ7zpqWV/OmYq+5G3D3z1utE1/+32zuYJrOi7e1VQryTYch6Km7Kgb/vDSda+9jNy
         iNLo33BHghltvQhPnx1Z7aPpMxxYzD/4iLEqh3rL6UD+iWWPP5NtM/EoCSbRQsedMW0t
         9XiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731306511; x=1731911311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pN5CuG6WF+TQ5+fRPMrqHbPBVi3cfYGsR4fmOv8Ey5Y=;
        b=GWT65w+e71AeK91nMGIOAflOS1dEaxt6Hl69q7y37wABUCbJ4X9OVfep4aUmVIGU/H
         6LxFxRdmUUCU0TnY/gsYcsrY6YE16K6fKM1AoxthH2rqG7OKK9HLzXEPyMksrH/aStbc
         /Y6nwyZ2A7azy6A1yIInQQuSZ46URp5u28PjDbWl2rO3K1SyCZDqYreG/95p9yer6bJe
         XMGXmslN6IWr++w+osDf7dp+pKjKWPiTX5vKDgT/UWg7zdIQl31NMMWO+PtixzRh6KWa
         DfAVirZQbVjemtUY3tueElMKb8uKPFwfYtkB0fvnVVH4yf/6aYplwmiLU/jacAVy608i
         C6kw==
X-Gm-Message-State: AOJu0YwpLylbK0bb93c7JO2qvUJX83lipZmX0INu2sRKwP2oW9f65slS
	2SSCKJc/wuGxvPsymG4ZNVzndGJL+qI8zgrtuTHEI2PFwy0RpkSs1lgidA==
X-Google-Smtp-Source: AGHT+IHIE/l9dDw1fdeL3b0/UPQXxNz7NqKNUPhpYAcMTt/x0bA1w8jw4aORSXBxWUAjHqBdzyMUiQ==
X-Received: by 2002:a05:6a00:851:b0:71e:3b8f:926 with SMTP id d2e1a72fcca58-724133a169cmr16411712b3a.22.1731306511200;
        Sun, 10 Nov 2024 22:28:31 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a4177sm8267587b3a.99.2024.11.10.22.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:28:30 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id B4B16DBA922; Mon, 11 Nov 2024 15:28:28 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [RFC PATCH v2 08/13] um: nommu: configure fs register on host syscall invocation
Date: Mon, 11 Nov 2024 15:27:08 +0900
Message-ID: <894d17f7924e7d31bfd5d6595ee84158f7411e47.1731290567.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731290567.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_222832_142001_C5E59481 
X-CRM114-Status: GOOD (  29.77  )
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

As userspace on UML/!MMU also need to configure %fs register when it is
running to correctly access thread structure, host syscalls implemented
in os-Linux drivers may be puzzled when they are called.  Thus it has to
configure %fs register via arch_prctl(SET_FS) on every host syscalls.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/include/shared/os.h |  5 ++++
 arch/um/os-Linux/Makefile   |  4 +--
 arch/um/os-Linux/cpu.c      | 50 ++++++++++++++++++++++++++++++++
 arch/um/os-Linux/internal.h |  5 ++++
 arch/um/os-Linux/main.c     |  5 ++++
 arch/um/os-Linux/process.c  |  8 ++++++
 arch/um/os-Linux/start_up.c |  3 ++
 arch/x86/um/do_syscall_64.c | 35 +++++++++++++++++++++++
 arch/x86/um/syscalls_64.c   | 57 +++++++++++++++++++++++++++++++++++++
 9 files changed, 170 insertions(+), 2 deletions(-)
 create mode 100644 arch/um/os-Linux/cpu.c

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 5a6722f254d5..69a7854f5f87 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -136,6 +136,9 @@ static inline struct openflags of_cloexec(struct openflags flags)
 	return flags;
 }
 
+/* cpu.c */
+extern int host_has_fsgsbase;
+
 /* file.c */
 extern int os_stat_file(const char *file_name, struct uml_stat *buf);
 extern int os_stat_fd(const int fd, struct uml_stat *buf);
@@ -221,6 +224,8 @@ extern int os_drop_memory(void *addr, int length);
 extern int can_drop_memory(void);
 extern int os_mincore(void *addr, unsigned long len);
 #ifndef CONFIG_MMU
+extern long long host_fs;
+extern int os_arch_prctl(int pid, int option, unsigned long *arg);
 extern int os_setup_seccomp(void);
 #endif
 
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 20ff8d5971db..af7c5f4373bc 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -8,7 +8,7 @@ KCOV_INSTRUMENT                := n
 
 obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
-	umid.o user_syms.o util.o drivers/ skas/
+	umid.o user_syms.o util.o cpu.o drivers/ skas/
 
 CFLAGS_signal.o += -Wframe-larger-than=4096
 
@@ -18,7 +18,7 @@ obj-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
 
 USER_OBJS := $(user-objs-y) elf_aux.o execvp.o file.o helper.o irq.o \
 	main.o mem.o process.o registers.o sigio.o signal.o start_up.o time.o \
-	tty.o umid.o util.o
+	tty.o umid.o util.o cpu.o
 
 include $(srctree)/arch/um/scripts/Makefile.rules
 CFLAGS_process.o=-g -O0
diff --git a/arch/um/os-Linux/cpu.c b/arch/um/os-Linux/cpu.c
new file mode 100644
index 000000000000..49b6d8b4d65d
--- /dev/null
+++ b/arch/um/os-Linux/cpu.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <string.h>
+#include <signal.h>
+#include <setjmp.h>
+#include <init.h>
+#include "internal.h"
+
+int host_has_fsgsbase;
+/* those definitions can be pulled from os.h but if we include this
+ * it shows conflicts of jmp_buf definitions in longjmp.h (UM) and
+ * host one.  thus we declared here instead.
+ */
+void os_info(const char *fmt, ...);
+void os_warn(const char *fmt, ...);
+
+/**
+ * get_host_cpu_features() return true with X86_FEATURE_FSGSBASE even
+ * if the kernel is older and disabled using fsgsbase instruction.
+ * thus detection is based on whether SIGILL is raised or not.
+ */
+static jmp_buf jmpbuf;
+static void sigill(int sig, siginfo_t *si, void *ctx_void)
+{
+	siglongjmp(jmpbuf, 1);
+}
+
+void __init check_fsgsbase(void)
+{
+	unsigned long fsbase;
+	struct sigaction sa;
+
+	/* Probe FSGSBASE */
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = sigill;
+	sa.sa_flags = SA_SIGINFO | SA_RESETHAND;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGILL, &sa, 0))
+		os_warn("sigaction");
+
+	os_info("Checking FSGSBASE instructions...");
+	if (sigsetjmp(jmpbuf, 0) == 0) {
+		asm volatile("rdfsbase %0" : "=r" (fsbase) :: "memory");
+		host_has_fsgsbase = 1;
+		os_info("OK\n");
+	} else {
+		host_has_fsgsbase = 0;
+		os_info("disabled\n");
+	}
+}
diff --git a/arch/um/os-Linux/internal.h b/arch/um/os-Linux/internal.h
index 317fca190c2b..60220b8b8843 100644
--- a/arch/um/os-Linux/internal.h
+++ b/arch/um/os-Linux/internal.h
@@ -2,6 +2,11 @@
 #ifndef __UM_OS_LINUX_INTERNAL_H
 #define __UM_OS_LINUX_INTERNAL_H
 
+/*
+ * cpu.c
+ */
+void check_fsgsbase(void);
+
 /*
  * elf_aux.c
  */
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 0afcdeb8995b..aecf63d3db79 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -17,6 +17,7 @@
 #include <kern_util.h>
 #include <os.h>
 #include <um_malloc.h>
+#include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include "internal.h"
 
 #define PGD_BOUND (4 * 1024 * 1024)
@@ -158,6 +159,10 @@ int __init main(int argc, char **argv, char **envp)
 	change_sig(SIGPIPE, 0);
 	ret = linux_main(argc, argv, envp);
 
+#ifndef CONFIG_MMU
+	os_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
+#endif
+
 	/*
 	 * Disable SIGPROF - I have no idea why libc doesn't do this or turn
 	 * off the profiling time, but UML dies with a SIGPROF just before
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 5acf6d41a4c2..5a3b09096f92 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -221,6 +221,14 @@ void os_set_pdeathsig(void)
 }
 
 #ifndef CONFIG_MMU
+#include <unistd.h>
+#include <sys/syscall.h>   /* For SYS_xxx definitions */
+
+int os_arch_prctl(int pid, int option, unsigned long *arg2)
+{
+	return syscall(SYS_arch_prctl, option, arg2);
+}
+
 int os_setup_seccomp(void)
 {
 	int err;
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 93fc82c01aba..88164893cbec 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -293,6 +293,9 @@ void __init os_early_checks(void)
 	 */
 	check_tmpexec();
 
+	/* probe fsgsbase instruction */
+	check_fsgsbase();
+
 	pid = start_ptraced_child();
 	if (init_pid_registers(pid))
 		fatal("Failed to initialize default registers");
diff --git a/arch/x86/um/do_syscall_64.c b/arch/x86/um/do_syscall_64.c
index 203bacc4cb3c..75326acc931b 100644
--- a/arch/x86/um/do_syscall_64.c
+++ b/arch/x86/um/do_syscall_64.c
@@ -3,6 +3,8 @@
 //#define DEBUG 1
 #include <linux/kernel.h>
 #include <linux/ptrace.h>
+#include <asm/fsgsbase.h>
+#include <asm/prctl.h>
 #include <kern_util.h>
 #include <sysdep/syscalls.h>
 #include <os.h>
@@ -34,6 +36,31 @@ static void vfork_restore_stack(void *stack_copy)
 	       stack_copy, 8);
 }
 
+static int os_x86_arch_prctl(int pid, int option, unsigned long *arg2)
+{
+	if (host_has_fsgsbase) {
+		switch (option) {
+		case ARCH_SET_FS:
+			wrfsbase(*arg2);
+			break;
+		case ARCH_SET_GS:
+			wrgsbase(*arg2);
+			break;
+		case ARCH_GET_FS:
+			*arg2 = rdfsbase();
+			break;
+		case ARCH_GET_GS:
+			*arg2 = rdgsbase();
+			break;
+		}
+		return 0;
+	} else {
+		return os_arch_prctl(pid, option, arg2);
+	}
+
+	return 0;
+}
+
 __visible void do_syscall_64(struct pt_regs *regs)
 {
 	int syscall;
@@ -49,6 +76,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	if (syscall == __NR_vfork)
 		stack_copy = vfork_save_stack();
 
+	/* set fs register to the original host one */
+	os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
+
 	if (likely(syscall < NR_syscalls)) {
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
@@ -63,6 +93,11 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	set_thread_flag(TIF_SIGPENDING);
 	interrupt_end();
 
+	/* restore back fs register to userspace configured one */
+	os_x86_arch_prctl(0, ARCH_SET_FS,
+		      (void *)(current->thread.regs.regs.gp[FS_BASE
+						     / sizeof(unsigned long)]));
+
 	/* execve succeeded */
 	if (syscall == __NR_execve && regs->regs.gp[HOST_AX] == 0)
 		userspace(&current->thread.regs.regs);
diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index edb17fc73e07..d56df936a2d7 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -12,11 +12,26 @@
 #include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include <registers.h>
 #include <os.h>
+#include <asm/thread_info.h>
+#include <asm/mman.h>
+
+#ifndef CONFIG_MMU
+/*
+ * The guest libc can change FS, which confuses the host libc.
+ * In fact, changing FS directly is not supported (check
+ * man arch_prctl). So, whenever we make a host syscall,
+ * we should be changing FS to the original FS (not the
+ * one set by the guest libc). This original FS is stored
+ * in host_fs.
+ */
+long long host_fs = -1;
+#endif
 
 long arch_prctl(struct task_struct *task, int option,
 		unsigned long __user *arg2)
 {
 	long ret = -EINVAL;
+#ifdef CONFIG_MMU
 
 	switch (option) {
 	case ARCH_SET_FS:
@@ -38,6 +53,48 @@ long arch_prctl(struct task_struct *task, int option,
 	}
 
 	return ret;
+#else
+
+	unsigned long *ptr = arg2, tmp;
+
+	switch (option) {
+	case ARCH_SET_FS:
+		if (host_fs == -1)
+			os_arch_prctl(0, ARCH_GET_FS, (void *)&host_fs);
+		ret = 0;
+		break;
+	case ARCH_SET_GS:
+		ret = 0;
+		break;
+	case ARCH_GET_FS:
+	case ARCH_GET_GS:
+		ptr = &tmp;
+		break;
+	}
+
+	ret = os_arch_prctl(0, option, ptr);
+	if (ret)
+		return ret;
+
+	switch (option) {
+	case ARCH_SET_FS:
+		current->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)] =
+			(unsigned long) arg2;
+		break;
+	case ARCH_SET_GS:
+		current->thread.regs.regs.gp[GS_BASE / sizeof(unsigned long)] =
+			(unsigned long) arg2;
+		break;
+	case ARCH_GET_FS:
+		ret = put_user(current->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)], arg2);
+		break;
+	case ARCH_GET_GS:
+		ret = put_user(current->thread.regs.regs.gp[GS_BASE / sizeof(unsigned long)], arg2);
+		break;
+	}
+
+	return ret;
+#endif
 }
 
 SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
-- 
2.43.0


