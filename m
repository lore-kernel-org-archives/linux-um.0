Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4401E8B38B
	for <linux-um@archiver.kernel.org>; Wed,  4 Feb 2026 02:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EozC+O+V6UtpPMZ43xTGpDpBr5Y3IUusGEEQ6C8VmaE=; b=B35ynh2+j+hhXLz+ISKCnIuSNv
	MloT40ap/XZttf2tUbmNKhm0gNjeQ7wyX36JRwo8DgQaDOWTd/uqS7H/IJb+Tt0AJ/3OHfVOatQsM
	F8l68zPLVBh4HY4011Dyp6ze1SqKzjVXhp2rR82iJrev5PYJ0T2HS6sLhpDtJTduBBVQu/+bZ0d+z
	5R//oqm9Uye3fhI/NQpcPNRTWehSrrcKLlDGTxkaP/T3G5/hIz/xv4p2gve8n+R7t+CVioo3z3fsn
	7/M8A1s0egVC1okOMyNgJ6CQWBuoXvg7Ivx+8cjBsBHHyzqNa5Q9BGyq+CRwKPZQ+GGvSZUFNGKn1
	jSXkXjgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnSd7-00000007mC5-2Tzo;
	Wed, 04 Feb 2026 02:28:33 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnSd4-00000007m8j-03SQ
	for linux-um@lists.infradead.org;
	Wed, 04 Feb 2026 02:28:32 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-352dda4a34eso2579971a91.1
        for <linux-um@lists.infradead.org>; Tue, 03 Feb 2026 18:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770172109; x=1770776909; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EozC+O+V6UtpPMZ43xTGpDpBr5Y3IUusGEEQ6C8VmaE=;
        b=R+TtEaeKPWEpMZtQ/lkdP7vZ3n9vWAL+wi6+VjexPIV3CwEeiAU4FApaPvyWq18EsG
         f9jKsfoDKZX3DE8I1KBYKLbFVpXL5/Y17IAKDnNiKcoBEXGq0Ek0leZLDiLMRNJhfe6H
         mWSb8FPXM1YZ5C3yqkA3/PKT96l1i+BxAIwcnuQnYvBGBZXhYsfg2z42lZ2GsX91TCF3
         EP/TsjRSmzqy5575UHaNzQzBbghL62XzZvss5B5VKNWskw3hLg58ucv3AJ1NlrPVlea2
         nf8fy7V8HgDbHieddDCaRvkteq+ve7B7oSIeNwW3N7qOUzOpFQqD43xrbkVPKEopPuu7
         SCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770172109; x=1770776909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EozC+O+V6UtpPMZ43xTGpDpBr5Y3IUusGEEQ6C8VmaE=;
        b=wwOBBlQSQG3vphvI83kGajYPMZjJMG1P1s8jr+OPj9tvSK+Ajf4G7IM/uvQajJQMNA
         zCz5NDCpYcRnwFxmHifu8XQg7L4kEaTJA5rg9lsMMnTH8+CRCIKT7L+se8+9nWLlE3aP
         oeqNcv6QK8TMxvgIOn7wrkG7iTpm60GqhNMX6f4YqQeKq/EMwLG+RpcySK3MU3H6Be7I
         XpU/21K+CExdn3oGhBV7oeWixmdFa55hN6LXiUaoFdx5pKCsft6YX1mrqO6PzEhmjiDH
         vQSqQO6LNya+8WuWKtUEEnhhtAJyE3xjHT5uFDLTMeJLY1EaJWrYVCbfIya6LmEoecy0
         3Mlw==
X-Gm-Message-State: AOJu0Yz4pJytytoPVsEJLdLbTVldvSMovR2BFGQqVaN+pc8eJiWPKDd7
	3vuv5HlZ00mYsekkM9MsV2gtGvz5rtSer9ax+vgfSzjdpOi77Wq+B7hn
X-Gm-Gg: AZuq6aLqk9Acj06Hf26AIXYoGS4pkCZvvcSU4s4TC+qCOdQetqWFvKsBOEF5eOiTP2y
	CcYOlPeHYpVqP2X8I4qo4zHSgjHdLvpa4cyNi4uFtPYRmPYw8HqLDlXDbbfnYdcaL/wOZr2VpXH
	Q+qKh0opuYX8YoxdLbqSQaTuHi8hCnw6DjWu7Pz0cmOW2grUP9lnZf9V3H0nXckI53OyIt24pto
	OgGKa8t2J6tS2nW5ehL6o0EJYm1Tk4ISCqDT76B0SuO/gz5VKDHu2BJ40i6VE6RHicDHjqWQnEO
	EjHec6VSfwZk9cWF+hhyOQlq3oyjdl4dWBV0LX+jwDt9/bBKwaDKNtvi16ZapLTlsmt1pUkbUZh
	A3EUigAFqeRBSpRU5OVZW5AQZGZr4cUJ8ZYTQU+9wT4THy60AgRZkixON1aOkJsy1dZOwquTwKz
	PpdZkurrcGBiINMLtqoI5v6dsh12QI4foF+2W80jscwrkp3GWVNqKgd5s2/NZA/fthT9birmkuJ
	WiBR5RT1jEW99St
X-Received: by 2002:a17:90b:3884:b0:340:4abf:391d with SMTP id 98e67ed59e1d1-35487125d82mr1194529a91.16.1770172109005;
        Tue, 03 Feb 2026 18:28:29 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35485da24a4sm874683a91.1.2026.02.03.18.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:28:26 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 52A6A1200C3D; Wed,  4 Feb 2026 11:28:25 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v14 07/13] um: nommu: configure fs register on host syscall invocation
Date: Wed,  4 Feb 2026 11:28:05 +0900
Message-ID: <6cbe7389d6f8250a22afe2213c90a6ceaf721a97.1770170302.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770170302.git.thehajime@gmail.com>
References: <cover.1770170302.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_182830_089781_288A1182 
X-CRM114-Status: GOOD (  23.46  )
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
 arch/um/include/shared/os.h       |  6 ++++
 arch/um/os-Linux/process.c        |  6 ++++
 arch/um/os-Linux/start_up.c       | 21 ++++++++++++++
 arch/x86/um/nommu/do_syscall_64.c | 11 +++++++
 arch/x86/um/nommu/syscalls.h      |  1 +
 arch/x86/um/nommu/syscalls_64.c   | 48 ++++++++++++++++++++++++++++++-
 6 files changed, 92 insertions(+), 1 deletion(-)

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
index b338a89ecf1e..4f30a389c530 100644
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
index 292d7c578622..c08ae4e0edec 100644
--- a/arch/x86/um/nommu/do_syscall_64.c
+++ b/arch/x86/um/nommu/do_syscall_64.c
@@ -4,7 +4,9 @@
 #include <linux/ptrace.h>
 #include <kern_util.h>
 #include <asm/syscall.h>
+#include <asm/prctl.h>
 #include <os.h>
+#include "syscalls.h"
 
 __visible void do_syscall_64(struct pt_regs *regs)
 {
@@ -13,6 +15,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	syscall = PT_SYSCALL_NR(regs->regs.gp);
 	UPT_SYSCALL_NR(&regs->regs) = syscall;
 
+	/* set fs register to the original host one */
+	os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
+
 	if (likely(syscall < NR_syscalls)) {
 		unsigned long ret;
 
@@ -29,4 +34,10 @@ __visible void do_syscall_64(struct pt_regs *regs)
 
 	/* handle tasks and signals at the end */
 	interrupt_end();
+
+	/* restore back fs register to userspace configured one */
+	os_x86_arch_prctl(0, ARCH_SET_FS,
+		      (void *)(current->thread.regs.regs.gp[FS_BASE
+						     / sizeof(unsigned long)]));
+
 }
diff --git a/arch/x86/um/nommu/syscalls.h b/arch/x86/um/nommu/syscalls.h
index ce16bf8abd59..4b9e3c85cf3a 100644
--- a/arch/x86/um/nommu/syscalls.h
+++ b/arch/x86/um/nommu/syscalls.h
@@ -13,6 +13,7 @@
 extern long current_top_of_stack;
 extern long current_ptregs;
 
+int os_x86_arch_prctl(int pid, int option, unsigned long *arg2);
 void arch_set_stack_to_current(void);
 
 #endif
diff --git a/arch/x86/um/nommu/syscalls_64.c b/arch/x86/um/nommu/syscalls_64.c
index 3b1610280110..25fb11a8b7a4 100644
--- a/arch/x86/um/nommu/syscalls_64.c
+++ b/arch/x86/um/nommu/syscalls_64.c
@@ -10,11 +10,48 @@
 #include <linux/sched/mm.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <asm/fsgsbase.h>
 #include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include <registers.h>
 #include <os.h>
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
+int os_x86_arch_prctl(int pid, int option, unsigned long *arg2)
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
 void arch_set_stack_to_current(void)
 {
 	current_top_of_stack = task_top_of_stack(current);
@@ -35,6 +72,15 @@ void arch_switch_to(struct task_struct *to)
 		return;
 
 	/* this changes the FS on every context switch */
-	arch_prctl(to, ARCH_SET_FS,
+	os_x86_arch_prctl(0, ARCH_SET_FS,
 		   (void __user *) to->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)]);
 }
+
+static int __init um_nommu_setup_hostfs(void)
+{
+	/* initialize the host_fs value at boottime */
+	os_x86_arch_prctl(0, ARCH_GET_FS, (void *)&host_fs);
+
+	return 0;
+}
+arch_initcall(um_nommu_setup_hostfs);
-- 
2.43.0


