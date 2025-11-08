Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F36CCFA18
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 08:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SVM2G4FP/w8QD00uu0HK9wDNN1nmcST3P93SXeGJtYY=; b=kRmPZhBc2m2QgxpPapi4Y+sLIF
	ZTxcFtwRKHCVsQMFQ/kvaszNoQMYOIVdvjZ9rcg3bTh4CLM4lo/NOuXRoRxXheja/cUD4VTGTjxwR
	Q0oEKdcx4t5XmjiMOVtjJ/bZ0/3bAOQBEKuZi5pnNmAbrOHen1Q45mrCfmQHkqGRT1DGu11nQdwdr
	08zr5HCjJU+u6umVtqQEQunBY3jlyQsFRTyu88UW4Q9xPwNJ8p8jLCBas6OF3oz1iAKtzEmHFlOYF
	Gyj2C2BPdJwQhkr+aXqtBmknh9yRA0G91fdy21qi340M4d7nUZTHASZ6IeG0ytAjtTvciNiHQT6Ya
	S+wEah6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxf-00000002iza-3FeS;
	Sat, 08 Nov 2025 08:06:15 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxd-00000002iyH-399q
	for linux-um@lists.infradead.org;
	Sat, 08 Nov 2025 08:06:14 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-b5579235200so1057020a12.3
        for <linux-um@lists.infradead.org>; Sat, 08 Nov 2025 00:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589173; x=1763193973; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVM2G4FP/w8QD00uu0HK9wDNN1nmcST3P93SXeGJtYY=;
        b=MLaAEJd8x81oxoeOwwZoCkJlw97TdfTgl3LSDu55MXDuVR7tOn8BmrywG2h3Nck9o3
         LkdZxdv5D7KRjbPbZlQ1xieFAYuQmaX9FBdaThD/p4IZdtmIGXCCjFgYU1ozhoX6AbF7
         m6GBNw6pc8MphPKjYdctgse1DwohLdFQsoQGqcksoner166K+y1g7zTaTBTzcte86rkj
         PXnO31U+1zfHWQo7hH8OC8pxs8SbM4X4B7L0Sj0f+TsX8Q2DsqHXKvNFmiZenJ8lNdxp
         dVFtRMCdFIQjgm3VI9BVa1zcSLO4adTax8Q0eqxYOQ0v8c4Ayiyk3UK+AtALQ8mC7Ltb
         mW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589173; x=1763193973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SVM2G4FP/w8QD00uu0HK9wDNN1nmcST3P93SXeGJtYY=;
        b=JeE34tT17kqWN8+D71YoHBRJnxSw71Z7OlX2IBGRVgrBVeiE1bhnPHJO7AEoCkhU7l
         7hhK28BGOg+DuyQPVEKoFx3pl0QoWqGvVnl4gaIg6n/zpkdZUfwzba3jp2J8dMrjGFr+
         3Mtn1akKRlShve635A0UuTitLGwctYdk4SVUzKjFrKstnlaoedqLIX3VgR7yL19fLHpU
         Aw5r9TDxF/NtJTTeqpX3DVGRXbqrs3y21LGfz3NMakFwjjBeXR1XJ0Dhb39z9E/6RCTl
         DvnkWnKHv3g9pV5in/V8ZRtQVPaVhvyLHdtBy4XgETk9PVO94vJzeXYMD5CRYgjfxFC+
         tKTw==
X-Gm-Message-State: AOJu0YzZiSSIs65d3QHtKX4oyX+42Dfospjhv8eFjQcPNO7jbPqIthl0
	oB0XF0FGL8cw8kkIm18WHpZNwz63/f87VjUJTkc2ffIDc0btAjy9NhA1pAYeqg==
X-Gm-Gg: ASbGncsTGieR1e7znqe63an792Rd6Me+PquPSmaYkNmyX5mT62M3ErP2nCIcoQ1IJxG
	PFmKaxeEi8OrHQlhZI84yVtQpFaqjzHzKNS5hPQvbkuvwY6V3YKu5vOGhGwlWjsM4znQCOc4ZMh
	yBZF4l6CNX4oTx7Qs1ZYZxWN/D5ndgbPG7G3mfGTevPE7ialpfPBIjsh2ABS/OAm7GgdUvST/cB
	fULHOks0JO++S/bKxa9X6H9/QM4bgpWnoz8ZzNqEbbU12r0Jszx8A7UV/HXep2r6wgcwb7Jr3Ym
	Ph+cAEX+ZbvsYIpaL+cN0y910BBB6FQWEFnM8rkqVuNcGYfGOMtdxij8VYv1NFcWiYgpd35hICE
	Azf8CWmOdR2qGqE4/Zjw/5L0Os5rH9HddefNX935GNx5jIfQgNxPE3dAw6lnDb7eZvOxQKR5u20
	8hbFyTRGqQzZoLz+Mo9nvp5oxXyZuA3WUvZgOFozt9LZbFRt6ELvu3HGwG
X-Google-Smtp-Source: AGHT+IGcrMW5bAkx8lKAGWdpQHmJ3n1S/JnVjYsLNXBmw+OKie6VvCjaORE4fhcWJKknP0Cu7jRe/w==
X-Received: by 2002:a17:902:e947:b0:267:a5df:9b07 with SMTP id d9443c01a7336-297e53e7303mr23827725ad.12.1762589173061;
        Sat, 08 Nov 2025 00:06:13 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccc19asm81307265ad.104.2025.11.08.00.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:12 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 8272C11388D3; Sat,  8 Nov 2025 17:06:10 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 07/13] um: nommu: configure fs register on host syscall invocation
Date: Sat,  8 Nov 2025 17:05:42 +0900
Message-ID: <5b4fab636ab8cbd1db025a0561fe9993990fc869.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_000613_810977_75083B7C 
X-CRM114-Status: GOOD (  21.27  )
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


