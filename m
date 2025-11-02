Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA590CCFA06
	for <linux-um@archiver.kernel.org>; Sun,  2 Nov 2025 09:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SVM2G4FP/w8QD00uu0HK9wDNN1nmcST3P93SXeGJtYY=; b=QGJ2bx7f1h+G4TkiTFPRyPs+6B
	0L2D9J0nUhB0WMIfEHqZUKYRcBB6z3HAL4Kh4Oc+oVtPP49REbeZrC3N4TLCXV6aX6rRLDdVuPDE0
	Jv9Ncb/6kNsb/5w1KQtuXmITbrD0zyM4PvN9Gj8JeC9q79WPXfJymt/PwwH1pl6JlKE1r391XKEd7
	vXq+T0uCPM7AWSSrY/CMF4G+GBlEogcEb3nsz48Lp0tnZeLVzWsPwAth8z3L5Vc1mlZFbfslaNVfA
	JM5EPX7fjPKwKXj+PMBgxOmoOhJGOJaLeTsrPToKeYmDPaHJp8WD9jZIf9iJpF721dtBkZKVD5XbN
	HFWAIuZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUio-00000008Ru7-2Dse;
	Sun, 02 Nov 2025 09:50:02 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUim-00000008RrX-1jH5
	for linux-um@lists.infradead.org;
	Sun, 02 Nov 2025 09:50:02 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-340ba29d518so954091a91.3
        for <linux-um@lists.infradead.org>; Sun, 02 Nov 2025 01:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762076999; x=1762681799; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVM2G4FP/w8QD00uu0HK9wDNN1nmcST3P93SXeGJtYY=;
        b=iir7pBWhBbwapMgzk1FSlANRecgA/XgsxL2cKRlUsLWrW45KVPrPLs1C8AmzkG2HFV
         4BHw5O0+oHjmy7FgEh2K01KftEZuWN499iNEDAdvAmsbUXNcapOcdG6bpCIxgCS/ztQn
         dnBrAm5FYGoVdFkWSu0wmCZ8Gkw1CIF+AzjMdPD2rkzPTUU8l5tEX2iz6/5hO6ag3aqF
         6wD8reTC/7KUm0B1o9YYmjo0TeRgk82RIswd8KM6xPkfJRQvms+96Zg2k1xkrult3p2a
         oiQ6XnYIx+MuSi0+VRJmXW9TsrGI+V3tFegHAHUFjcW/LqSp8CdyjsnxD1ZpWpFFtt42
         w1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762076999; x=1762681799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVM2G4FP/w8QD00uu0HK9wDNN1nmcST3P93SXeGJtYY=;
        b=tB6MSBNhQ3cQnmFeBzsc6LGrqbiYzfQrvZNw7TRcrYKAwsU83rdxHyWzwckR4QQjFh
         KVutSitBOtvzzo9DUZ8HQa9eSsd0QUzfX0mAlGaFQd4vbnhQdhzTRqElBq/r8/Mx5vp2
         72mE6PCXggaUpTCE6l8hfZvrc3OHptxuNNHrUn7ZjN+IxI5NH26+UMLBt12BXR11D1/C
         bTJ7dAgde3u4Dull+y2OU5Fy0n9DcXMuRMLTIaV1fhiNWB11lnrHVgYheGLL+QUna4Tr
         ge7oTFWbgHAibOeXMD5M+JxManGc9/nEWVg7PkBKdHkZ8x56zB6SQn7urAwlfIgKv7Mm
         XPPw==
X-Gm-Message-State: AOJu0Yyi/yuOdr8BqV3R1cqOE0pSodU/F72R1sWaD1Tz6JN432QsTJjE
	K8MD3orQk/5khZpt6fkYqyax4u70wtVsZoaSFdll4UwiJxOR8x9wPE6g
X-Gm-Gg: ASbGncvZfBtBALjSIEkvMZ9I5E0ov4ZcglWi0pHV1P+qcTStjD39n4pVwY5KdMQiR7P
	vHeLfwv+CAHq0vvBrg6iXgLA3HEasyby6nfI1A3cbkONW5go0sJYe4CzVDj9dC6fty8Bz1+6okq
	edItNXnehemIgTe/gjodxmNUnuXY2FOLfnv4E2keIQxJDcouqiBxM3inBW2wx5O7ikdiS/Easwr
	x0aGoZEaNP09sZcoY3pwY/yG1mzQSkipkgtjL6vtbSAa9Ktnn/7vMorrLEveE6ZIgQ3Y6qKn2TF
	ECe7wjlSPfGMEXmD/qWJvCyhkDgKCQSQqxLHxiJcCHCZD2L+wnIT7aQwAOtJ2ueDz5wNW+/YQVT
	3gkSsK80WVCSgjGPAraHCvXIjQuhRKJiZql7kiB3iurHCNXLQompyMjlxHVSf2/W9MlMIxCGkVU
	J3O8vH8/abEj87O9IDzXCSE8Jx+tL9po6bVwhMbB+5a2vVVMLDDWAO7Ma2
X-Google-Smtp-Source: AGHT+IEGAiub3al+B+1jEkCyOgGZofHqkuwFGRsJXjVCnAfatIVXeTAFwQSvpFLTzPP2lopemXTUgw==
X-Received: by 2002:a17:90b:2ccb:b0:340:f7d6:dc70 with SMTP id 98e67ed59e1d1-340f7d6e39fmr2375548a91.13.1762076999483;
        Sun, 02 Nov 2025 01:49:59 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340d1a4a587sm3387074a91.3.2025.11.02.01.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:56 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 5DC30112380B; Sun,  2 Nov 2025 18:49:52 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 07/13] um: nommu: configure fs register on host syscall invocation
Date: Sun,  2 Nov 2025 18:49:32 +0900
Message-ID: <86fc0b173ac530454a0f0e33f5100e0b60e37730.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_015000_470503_DB98B78B 
X-CRM114-Status: GOOD (  21.52  )
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
 arch/um/include/shared/os.h       |  6 +++
 arch/um/os-Linux/process.c        |  6 +++
 arch/um/os-Linux/start_up.c       | 21 +++++++++
 arch/x86/um/nommu/do_syscall_64.c | 37 ++++++++++++++++
 arch/x86/um/nommu/syscalls_64.c   | 71 +++++++++++++++++++++++++++++++
 5 files changed, 141 insertions(+)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 5451f9b1f41e..0ac87507e05e 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -189,6 +189,7 @@ extern void check_host_supports_tls(int *supports_tls, int *tls_min);
 extern void get_host_cpu_features(
 	void (*flags_helper_func)(char *line),
 	void (*cache_helper_func)(char *line));
+extern int host_has_fsgsbase;
 
 /* mem.c */
 extern int create_mem_file(unsigned long long len);
@@ -213,6 +214,11 @@ extern int os_protect_memory(void *addr, unsigned long len,
 extern int os_unmap_memory(void *addr, int len);
 extern int os_drop_memory(void *addr, int length);
 extern int can_drop_memory(void);
+extern int os_arch_prctl(int pid, int option, unsigned long *arg);
+#ifndef CONFIG_MMU
+extern long long host_fs;
+#endif
+
 
 void os_set_pdeathsig(void);
 
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index ddb5258d7720..dacf63ac33c8 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -18,6 +18,7 @@
 #include <sys/prctl.h>
 #include <sys/wait.h>
 #include <asm/unistd.h>
+#include <sys/syscall.h>   /* For SYS_xxx definitions */
 #include <linux/threads.h>
 #include <init.h>
 #include <longjmp.h>
@@ -179,6 +180,11 @@ int __init can_drop_memory(void)
 	return ok;
 }
 
+int os_arch_prctl(int pid, int option, unsigned long *arg2)
+{
+	return syscall(SYS_arch_prctl, option, arg2);
+}
+
 void init_new_thread_signals(void)
 {
 	set_handler(SIGSEGV);
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 33e039d2c1bf..c0afe5d8b559 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -20,6 +20,8 @@
 #include <sys/resource.h>
 #include <asm/ldt.h>
 #include <asm/unistd.h>
+#include <sys/auxv.h>
+#include <asm/hwcap2.h>
 #include <init.h>
 #include <os.h>
 #include <smp.h>
@@ -37,6 +39,8 @@
 #include <skas.h>
 #include "internal.h"
 
+int host_has_fsgsbase;
+
 static void ptrace_child(void)
 {
 	int ret;
@@ -460,6 +464,20 @@ __uml_setup("seccomp=", uml_seccomp_config,
 "    This is insecure and should only be used with a trusted userspace\n\n"
 );
 
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
+
 void __init os_early_checks(void)
 {
 	int pid;
@@ -488,6 +506,9 @@ void __init os_early_checks(void)
 	using_seccomp = 0;
 	check_ptrace();
 
+	/* probe fsgsbase instruction */
+	check_fsgsbase();
+
 	pid = start_ptraced_child();
 	if (init_pid_registers(pid))
 		fatal("Failed to initialize default registers");
diff --git a/arch/x86/um/nommu/do_syscall_64.c b/arch/x86/um/nommu/do_syscall_64.c
index 292d7c578622..9bc630995df9 100644
--- a/arch/x86/um/nommu/do_syscall_64.c
+++ b/arch/x86/um/nommu/do_syscall_64.c
@@ -2,10 +2,38 @@
 
 #include <linux/kernel.h>
 #include <linux/ptrace.h>
+#include <asm/fsgsbase.h>
+#include <asm/prctl.h>
 #include <kern_util.h>
 #include <asm/syscall.h>
 #include <os.h>
 
+static int os_x86_arch_prctl(int pid, int option, unsigned long *arg2)
+{
+	if (!host_has_fsgsbase)
+		return os_arch_prctl(pid, option, arg2);
+
+	switch (option) {
+	case ARCH_SET_FS:
+		wrfsbase(*arg2);
+		break;
+	case ARCH_SET_GS:
+		wrgsbase(*arg2);
+		break;
+	case ARCH_GET_FS:
+		*arg2 = rdfsbase();
+		break;
+	case ARCH_GET_GS:
+		*arg2 = rdgsbase();
+		break;
+	default:
+		pr_warn("%s: unsupported option: 0x%x", __func__, option);
+		break;
+	}
+
+	return 0;
+}
+
 __visible void do_syscall_64(struct pt_regs *regs)
 {
 	int syscall;
@@ -13,6 +41,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	syscall = PT_SYSCALL_NR(regs->regs.gp);
 	UPT_SYSCALL_NR(&regs->regs) = syscall;
 
+	/* set fs register to the original host one */
+	os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
+
 	if (likely(syscall < NR_syscalls)) {
 		unsigned long ret;
 
@@ -29,4 +60,10 @@ __visible void do_syscall_64(struct pt_regs *regs)
 
 	/* handle tasks and signals at the end */
 	interrupt_end();
+
+	/* restore back fs register to userspace configured one */
+	os_x86_arch_prctl(0, ARCH_SET_FS,
+		      (void *)(current->thread.regs.regs.gp[FS_BASE
+						     / sizeof(unsigned long)]));
+
 }
diff --git a/arch/x86/um/nommu/syscalls_64.c b/arch/x86/um/nommu/syscalls_64.c
index d56027ebc651..19d23686fc5b 100644
--- a/arch/x86/um/nommu/syscalls_64.c
+++ b/arch/x86/um/nommu/syscalls_64.c
@@ -13,8 +13,70 @@
 #include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include <registers.h>
 #include <os.h>
+#include <asm/thread_info.h>
+#include <asm/mman.h>
 #include "syscalls.h"
 
+/*
+ * The guest libc can change FS, which confuses the host libc.
+ * In fact, changing FS directly is not supported (check
+ * man arch_prctl). So, whenever we make a host syscall,
+ * we should be changing FS to the original FS (not the
+ * one set by the guest libc). This original FS is stored
+ * in host_fs.
+ */
+long long host_fs = -1;
+
+long arch_prctl(struct task_struct *task, int option,
+		unsigned long __user *arg2)
+{
+	long ret = -EINVAL;
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
+}
+
+SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
+{
+	return arch_prctl(current, option, (unsigned long __user *) arg2);
+}
+
 void arch_set_stack_to_current(void)
 {
 	current_top_of_stack = task_top_of_stack(current);
@@ -48,3 +110,12 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
 }
+
+static int __init um_nommu_setup_hostfs(void)
+{
+	/* initialize the host_fs value at boottime */
+	os_arch_prctl(0, ARCH_GET_FS, (void *)&host_fs);
+
+	return 0;
+}
+arch_initcall(um_nommu_setup_hostfs);
-- 
2.43.0


