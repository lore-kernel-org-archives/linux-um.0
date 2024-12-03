Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75626E6C5F7
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 04:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BeGnDSGw9bk8JRMyfXOT4Pzj+UvbuAkFQVTFvSaLcHI=; b=J/4Zt3VM1JNnZBGOSvGcCi3Q1l
	jO219Uaag1qqmCYs7XxDm+dfJJpeF8o7VgK3HAzWXVawbYAqBWARFjmLsoTBIUwLL4vBC+tCiJs1g
	SN2GdipeqCRULZSBSTx3ShrODpy6TemvzF20BqmXQvi3GZpIIJLmFL9WqPqe1rq62qxcTsU4JD1bS
	oSb4tBM6jp1Xe9cIN/3iSVuFSrQXOwlE1aqjpbJFdZ3mEgmTxTaPt+/isbcAgCGBpxL/rdAO10r5O
	uTT08AadjivU/rQ3qZvVi4x2xHYuKTLNbDxHqlYjzl2sKKR16agvwbwerGZCPXWH8aaVpgv9OZHLX
	kQ+nTqGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKS3-00000008DSX-124Y;
	Tue, 03 Dec 2024 04:23:55 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKS0-00000008DRa-3dsu
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 04:23:53 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-215b13e9ccbso10031245ad.0
        for <linux-um@lists.infradead.org>; Mon, 02 Dec 2024 20:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733199832; x=1733804632; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeGnDSGw9bk8JRMyfXOT4Pzj+UvbuAkFQVTFvSaLcHI=;
        b=R8Wvdzb1bBOlPnBSvBraOE9mv7FauV76v/KtM/7rUX/ejnvckc0N+7dB2c0MkSqeN1
         VxA5Thdc0a9FwGx+CHHgx2ohgI1dhSmn8GBZF9jGOYLFJBmiHuBVEPUHp0I5KHlmgRiR
         ABm/97Pb3bnXlUX2GbQElh+1qDmUBjPvSFZKrYfiIi8e6se0k3mU1dF2Lm6IrRk3c1SU
         bi3oyrsd4Lbx+PtN9Ge7rYKFmFJ8Ad4uBJoE97yYGoFsUIdqb+ebbdA0Z+JHcugM5G22
         WKhTtrGhH4+a8lC31keLy8iuZDHW9XFEEPE18mStXXfCI475u7c0tb2wMQfTS31+sCmy
         WIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733199832; x=1733804632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeGnDSGw9bk8JRMyfXOT4Pzj+UvbuAkFQVTFvSaLcHI=;
        b=KN+RCTplamjG98CPIvGxY0k62QbbgBWCwYnfuKYgqRLGzP4ueFJyc6OGoAiE7D6CiU
         9+0FeTxD/1raEwSy/2v+aHZ7D0Qks4AGlIrWo6XOcx2bTd1Nx7eLZGlCbZWYG3Zc0PlY
         nX+4O/N7rNBEytabQwesxoPAbJtxFzg/PO9zgTnmpJfu4cJI4S8IhHvnBZnTAWfWlJtp
         xxxcETnx0wO4FMU++4k0jpvJ7feCrkGH6iDBxc2v5xhpBjkDL+EbWhWdN8Q1hCujSGxr
         9VXLM74spzBqgUt89c+LNakXlzSw9cQg4SwAYA3rFrL5xJhbAQwRnY/w8+tsX7L67NPV
         9aGw==
X-Gm-Message-State: AOJu0YziCcS/XUU/tu7Ml3k4cUzItavMcQa138urtdHLm+uOCvtFnrJ2
	wz9hUrMfdUb8Ny39kEhkDCDdtmjsWRotoj8GLbbkF1sUyHTHMTeN
X-Gm-Gg: ASbGnct35suvpBZ42gQOdt5STEV+EryiWSWmufKWA1stTLDLIV+LoiCptmOS0XhZBZU
	Qc5kI2sgo6SHgv6/gLvmGOX9BTQ6ktsvBqqU2k1Kn38BeRAxP86N9yUDzW5wK3SXwxrWqC6nE4s
	/9RIeRdOzt/y3W0yOBPL5f16kpRFB3SXYQOGu8SKKu3bHaBq7NbH1n6XjNeSAx1GgHjYEhOlbMF
	4EmvrDFe6flN6r6DBouArZC/8rV3Xz2BULlEdxoBoezUI9Mk8XKeG8ua2cIAByVZdOXoMOKhYTo
	A6FAh84TpyCu6CaaVDhB
X-Google-Smtp-Source: AGHT+IFECfr1nFfDI3iej8scakEerEDyRnv24GZE0M1SIx5CIsGfM+BIbcl0lWqaiEZKb3ae57rulQ==
X-Received: by 2002:a17:902:e743:b0:215:a2e2:53fe with SMTP id d9443c01a7336-215bd158584mr19285575ad.40.1733199832000;
        Mon, 02 Dec 2024 20:23:52 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2155da906f2sm50711515ad.87.2024.12.02.20.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:23:51 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 5F027DD3A07; Tue,  3 Dec 2024 13:23:48 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v3 08/13] um: nommu: configure fs register on host syscall invocation
Date: Tue,  3 Dec 2024 13:23:07 +0900
Message-ID: <e3d540d8a9c034a76d731714ba25bab0a7bc9b4d.1733199769.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_202352_908170_E0C0824E 
X-CRM114-Status: GOOD (  22.00  )
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
 arch/um/os-Linux/process.c  |  8 ++++++
 arch/um/os-Linux/start_up.c | 20 +++++++++++++
 arch/x86/um/do_syscall_64.c | 36 +++++++++++++++++++++++
 arch/x86/um/syscalls_64.c   | 57 +++++++++++++++++++++++++++++++++++++
 6 files changed, 129 insertions(+)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index c979a8b15434..f7f4da322906 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -190,6 +190,7 @@ extern void check_host_supports_tls(int *supports_tls, int *tls_min);
 extern void get_host_cpu_features(
 	void (*flags_helper_func)(char *line),
 	void (*cache_helper_func)(char *line));
+extern int host_has_fsgsbase;
 
 /* mem.c */
 extern int create_mem_file(unsigned long long len);
@@ -221,6 +222,8 @@ extern int os_drop_memory(void *addr, int length);
 extern int can_drop_memory(void);
 extern int os_mincore(void *addr, unsigned long len);
 #ifndef CONFIG_MMU
+extern long long host_fs;
+extern int os_arch_prctl(int pid, int option, unsigned long *arg);
 extern int os_setup_seccomp(void);
 #endif
 
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
index 51473b834497..346d297e89fe 100644
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
index 93fc82c01aba..dbab091892b3 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -19,6 +19,8 @@
 #include <sys/resource.h>
 #include <asm/ldt.h>
 #include <asm/unistd.h>
+#include <sys/auxv.h>
+#include <asm/hwcap2.h>
 #include <init.h>
 #include <os.h>
 #include <kern_util.h>
@@ -28,6 +30,8 @@
 #include <skas.h>
 #include "internal.h"
 
+int host_has_fsgsbase;
+
 static void ptrace_child(void)
 {
 	int ret;
@@ -278,6 +282,19 @@ void  __init get_host_cpu_features(
 	}
 }
 
+static void __init check_fsgsbase(void)
+{
+	unsigned long auxv = getauxval(AT_HWCAP2);
+
+	os_info("Checking FSGSBASE instructions...");
+	if (auxv & HWCAP2_FSGSBASE) {
+		host_has_fsgsbase = 1;
+		os_info("OK\n");
+	} else {
+		host_has_fsgsbase = 0;
+		os_info("disabled\n");
+	}
+}
 
 void __init os_early_checks(void)
 {
@@ -293,6 +310,9 @@ void __init os_early_checks(void)
 	 */
 	check_tmpexec();
 
+	/* probe fsgsbase instruction */
+	check_fsgsbase();
+
 	pid = start_ptraced_child();
 	if (init_pid_registers(pid))
 		fatal("Failed to initialize default registers");
diff --git a/arch/x86/um/do_syscall_64.c b/arch/x86/um/do_syscall_64.c
index ca468caff729..c7e48c74c7a5 100644
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
@@ -70,4 +100,10 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	/* force do_signal() --> is_syscall() */
 	set_thread_flag(TIF_SIGPENDING);
 	interrupt_end();
+
+	/* restore back fs register to userspace configured one */
+	os_x86_arch_prctl(0, ARCH_SET_FS,
+		      (void *)(current->thread.regs.regs.gp[FS_BASE
+						     / sizeof(unsigned long)]));
+
 }
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


