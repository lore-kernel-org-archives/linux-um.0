Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A054CE8E71
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=12JqcDulVs4YHv7o/2VAiTMOfhasWFqy2nrAfbx0pj4=; b=K7TysYwcfOZg7lqwn8KGpgTozO
	XOsrRduklGl5ceru4KdT6KcPQ3Ufk+icdM1apbmcWnsj7zpN3LNvRZQlDcgGzmmbxcffahMx1zjTa
	AdSRyOv2E/GNHEKBis8ya/I2ffjqHfoW/s5Hv1euViqkEeR0yV8hACc++qDJe0fLB1IuxTJOJaOEg
	ii7O519Pp/QPyePCCIsQd7oOwTfSpTVn/lbGOVF7zp+17h/IirAFgeiwKv+eELL27VE2iQTFTdSxl
	+9DwS0HuyUooNT9b26JNXwz+gdMCJ9uqyoaNynKC/cvU/csqaUnzaivCkER/4gL065oaY+JWTdC0p
	rlvk7REw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wgU-00000000Ir5-3rLl;
	Thu, 24 Oct 2024 12:11:22 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wfP-00000000Icn-0T5V
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 12:10:16 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2e2e050b1c3so1357089a91.0
        for <linux-um@lists.infradead.org>; Thu, 24 Oct 2024 05:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729771814; x=1730376614; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12JqcDulVs4YHv7o/2VAiTMOfhasWFqy2nrAfbx0pj4=;
        b=lUtjExdDfoIdUDozL7wsoBeOoyvahA7TA+UxvqMPDFrX+9GILLSugKCcOu/pI9heVp
         LOnr8QbE5hQv/F7Z9Gz5ON0DUnPot+u5kwrTbEAl4682Oh7d5ns3BdDuG6vzt5xDVVIO
         0XXUxXXniZksDf9kR/ht8XJyYzdlROKiWSr2dikOaChMnsJju9qWXoFgmssTjTw2eDWD
         VA3EbkgeOp+RHCiw8HTCCrm8/vUZCRzfrpb7VDN9pCpftE8Ppy8V/KiO8jk+9D8lSABE
         LfUxHiNvyz/7HAc8vfg1MhkAvOAjQ5P2HlQP6JiqtOCQDvG+DVQtNy/8Tm4vdZ7DNOI4
         bqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771814; x=1730376614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12JqcDulVs4YHv7o/2VAiTMOfhasWFqy2nrAfbx0pj4=;
        b=Y4IxAaRFiEIuqvLoWFCW1QXcaaOxLz3rt/r4Xnsku2v1j+hzfoILgwCjfIY7z0Dtye
         wSwm+ZphR7duiMpDyaq4M0I2/4uw8sNCmyS3CSH4VawUIAUtBahm6SQ1NqhPNtaaewRs
         0g68b/Q5H+lTAPa7nUaJJ+EDHPqiFXstH2yEiRNkUlqyY2STIYH0JLfa+A3szd98llwN
         hGd/Sjt+04R4EhTtBA+oNddCMxqhktEFJpUwPIqYWQKITKguLFh38krauQPusuJ/YMna
         wnGYJ37yJJxi4JIK3Qy4YV3HH7D/L+xXn1KgPxMCBELcjCtBy/59zthxTEJXbgPzzSRt
         RrqA==
X-Gm-Message-State: AOJu0YzZGXioOYyqVhZ3HmpQ/EoRdM8DW0zu9Q0kZqkt6uzv+wNjCL+t
	v6Xcwqa191RvdyZNUIlAd8Yz5yl0tf/jL3OFT/HItLtW9OxfrHCh
X-Google-Smtp-Source: AGHT+IEY61Mya4wL4a3M0ZhSkml8zov2khlCq9PEob6dO9i5KMDbBLn7c9CUtVPxc60XRSzII979tA==
X-Received: by 2002:a17:90a:5e06:b0:2e2:7f8f:3ad5 with SMTP id 98e67ed59e1d1-2e77e58e608mr2980381a91.2.1729771814431;
        Thu, 24 Oct 2024 05:10:14 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76df2aa71sm3329605a91.7.2024.10.24.05.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:10:13 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id D4C49D51255; Thu, 24 Oct 2024 21:10:11 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: thehajime@gmail.com,
	ricarkol@google.com
Subject: [RFC PATCH 07/13] um: nommu: configure fs register on host syscall invocation
Date: Thu, 24 Oct 2024 21:09:15 +0900
Message-ID: <de4b12980873dac3074d591ab4ee0241d81c691b.1729770373.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_051015_179992_520EA409 
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

As userspace on UML/!MMU also need to configure %fs register when it is
running to correctly access thread structure, host syscalls implemented
in os-Linux drivers may be puzzled when they are called.  Thus it has to
configure %fs register via arch_prctl(SET_FS) on every host syscalls.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/include/shared/os.h |  3 ++
 arch/um/os-Linux/main.c     |  5 ++++
 arch/um/os-Linux/process.c  | 11 ++++++++
 arch/um/os-Linux/start_up.c | 47 +++++++++++++++++++++++++++++++
 arch/um/os-Linux/time.c     |  3 +-
 arch/x86/um/do_syscall_64.c | 35 +++++++++++++++++++++++
 arch/x86/um/syscalls_64.c   | 55 +++++++++++++++++++++++++++++++++++++
 7 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index f6d3f3d7eade..ba95e882f7e6 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -191,6 +191,7 @@ extern void check_host_supports_tls(int *supports_tls, int *tls_min);
 extern void get_host_cpu_features(
 	void (*flags_helper_func)(char *line),
 	void (*cache_helper_func)(char *line));
+extern int os_has_fsgsbase(void);
 
 /* mem.c */
 extern int create_mem_file(unsigned long long len);
@@ -225,6 +226,8 @@ extern int os_unmap_memory(void *addr, int len);
 extern int os_drop_memory(void *addr, int length);
 extern int can_drop_memory(void);
 extern int os_mincore(void *addr, unsigned long len);
+extern long long host_fs;
+extern int os_arch_prctl(int pid, int option, unsigned long *arg);
 
 /* execvp.c */
 extern int execvp_noalloc(char *buf, const char *file, char *const argv[]);
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index f98ff79cdbf7..8e5c7361bac1 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -16,6 +16,7 @@
 #include <kern_util.h>
 #include <os.h>
 #include <um_malloc.h>
+#include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include "internal.h"
 
 #define PGD_BOUND (4 * 1024 * 1024)
@@ -142,6 +143,10 @@ int __init main(int argc, char **argv, char **envp)
 	change_sig(SIGPIPE, 0);
 	ret = linux_main(argc, argv);
 
+#ifndef CONFIG_MMU
+	os_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
+#endif
+
 	/*
 	 * Disable SIGPROF - I have no idea why libc doesn't do this or turn
 	 * off the profiling time, but UML dies with a SIGPROF just before
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index f08bb20d95ec..0be8f4ac5f70 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -296,3 +296,14 @@ void init_new_thread_signals(void)
 	set_handler(SIGIO);
 	signal(SIGWINCH, SIG_IGN);
 }
+
+#ifndef CONFIG_MMU
+
+#include <unistd.h>
+#include <sys/syscall.h>   /* For SYS_xxx definitions */
+
+int os_arch_prctl(int pid, int option, unsigned long *arg2)
+{
+	return syscall(SYS_arch_prctl, option, arg2);
+}
+#endif
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 93fc82c01aba..80dce242e67a 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -12,6 +12,7 @@
 #include <sched.h>
 #include <signal.h>
 #include <string.h>
+#include <longjmp.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
@@ -278,6 +279,49 @@ void  __init get_host_cpu_features(
 	}
 }
 
+/**
+ * get_host_cpu_features() return true with X86_FEATURE_FSGSBASE even
+ * if the kernel is older and disabled using fsgsbase instruction.
+ * thus detection is based on whether SIGILL is raised or not.
+ */
+static jmp_buf jmpbuf;
+static int has_fsgsbase;
+
+static void sigill(int sig, siginfo_t *si, void *ctx_void)
+{
+	longjmp(jmpbuf, 1);
+}
+
+static int __init check_fsgsbase(void)
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
+	if (setjmp(jmpbuf) == 0) {
+		asm volatile("rdfsbase %0" : "=r" (fsbase) :: "memory");
+		has_fsgsbase = 1;
+		os_info("OK\n");
+	} else {
+		has_fsgsbase = 0;
+		os_info("disabled\n");
+	}
+
+	return 0;
+}
+
+int os_has_fsgsbase(void)
+{
+	return has_fsgsbase;
+}
 
 void __init os_early_checks(void)
 {
@@ -293,6 +337,9 @@ void __init os_early_checks(void)
 	 */
 	check_tmpexec();
 
+	/* probe fsgsbase instruction */
+	check_fsgsbase();
+
 	pid = start_ptraced_child();
 	if (init_pid_registers(pid))
 		fatal("Failed to initialize default registers");
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 4d5591d96d8c..1ed14c6b67c4 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -89,7 +89,8 @@ long long os_nsecs(void)
 {
 	struct timespec ts;
 
-	clock_gettime(CLOCK_MONOTONIC,&ts);
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+
 	return timespec_to_ns(&ts);
 }
 
diff --git a/arch/x86/um/do_syscall_64.c b/arch/x86/um/do_syscall_64.c
index 7af6e881ad58..594248f7319c 100644
--- a/arch/x86/um/do_syscall_64.c
+++ b/arch/x86/um/do_syscall_64.c
@@ -2,12 +2,38 @@
 
 #include <linux/kernel.h>
 #include <linux/ptrace.h>
+#include <asm/fsgsbase.h>
+#include <asm/prctl.h>
 #include <kern_util.h>
 #include <sysdep/syscalls.h>
 #include <os.h>
 
 #ifndef CONFIG_MMU
 
+static int os_x86_arch_prctl(int pid, int option, unsigned long *arg2)
+{
+	if (os_has_fsgsbase()) {
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
+	} else
+		return os_arch_prctl(pid, option, arg2);
+
+	return 0;
+}
+
 __visible void do_syscall_64(struct pt_regs *regs)
 {
 	int syscall;
@@ -19,6 +45,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 		 syscall, (unsigned long)current,
 		 (unsigned long)sys_call_table[syscall]);
 
+	/* set fs register to the original host one */
+	os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
+
 	if (likely(syscall < NR_syscalls)) {
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
@@ -29,6 +58,11 @@ __visible void do_syscall_64(struct pt_regs *regs)
 
 	PT_REGS_SYSCALL_RET(regs) = regs->regs.gp[HOST_AX];
 
+	/* restore back fs register to userspace configured one */
+	os_x86_arch_prctl(0, ARCH_SET_FS,
+		      (void *)(current->thread.regs.regs.gp[FS_BASE
+						     / sizeof(unsigned long)]));
+
 	/* force do_signal() --> is_syscall() */
 	set_thread_flag(TIF_SIGPENDING);
 	interrupt_end();
@@ -39,4 +73,5 @@ __visible void do_syscall_64(struct pt_regs *regs)
 			current_thread_info()->aux_fp_regs);
 	}
 }
+
 #endif
diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index 8abf2a679578..5a1b1b3efab2 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -12,11 +12,24 @@
 #include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include <registers.h>
 #include <os.h>
+#include <asm/thread_info.h>
+#include <asm/mman.h>
+
+/*
+ * The guest libc can change FS, which confuses the host libc.
+ * In fact, changing FS directly is not supported (check
+ * man arch_prctl). So, whenever we make a host syscall,
+ * we should be changing FS to the original FS (not the
+ * one set by the guest libc). This original FS is stored
+ * in host_fs.
+ */
+long long host_fs = -1;
 
 long arch_prctl(struct task_struct *task, int option,
 		unsigned long __user *arg2)
 {
 	long ret = -EINVAL;
+#ifdef CONFIG_MMU
 
 	switch (option) {
 	case ARCH_SET_FS:
@@ -38,6 +51,48 @@ long arch_prctl(struct task_struct *task, int option,
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


