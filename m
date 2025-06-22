Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B17C77B7C
	for <linux-um@archiver.kernel.org>; Sun, 22 Jun 2025 21:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=imZ2VRtA0KRhDqFvVOmvCgQSiKBob6JpuoHz1j3Ovlw=; b=PMEqQJf1XBJuKWqBrbAV8UQzJi
	79dsGzkEWrW4HPNHs4/rCi6ypKXxdy7Zg0vgoY6qFWWHDv3Xp1D8VO1AnQmZsxQoqp2xyssc6Gs0p
	DzSFOBHusFbWJ9ttxEEZs6ZzJeH9OStZ08qAhYjIrscVSGO9QAQtAfnYWn+Ah8KwFCs5D/wACuEmD
	50uFys7CukuopsFCdbrOoxlothgGSnC6HpjSlGh9JSebhUtBNNJ+H54Vscj45iypsutzl3cqtw8sk
	2iRk9Gm+96ImKlzhd7Uz8yZPxtb+C4oJ8etljePARrSmxogkrZBcju+bder/q2/uEe7Smp7K3yz6H
	IcjnhHTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSKH-00000001F5J-1LFI;
	Sun, 22 Jun 2025 21:34:09 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSJj-00000001Etn-3uOv
	for linux-um@lists.infradead.org;
	Sun, 22 Jun 2025 21:33:37 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-236377f00easo41161595ad.1
        for <linux-um@lists.infradead.org>; Sun, 22 Jun 2025 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750628015; x=1751232815; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imZ2VRtA0KRhDqFvVOmvCgQSiKBob6JpuoHz1j3Ovlw=;
        b=iTW+db81lKn5H//jqyIMg06rG5YTKBrtOnTNYZchm69Ny8TW94cntoSGi9XX5wQxCr
         H2A/xUo/FdD/OQMhsSgnvim1wYjuNzQMUbNZq14A2YRJIAsQ5m5gDWPQsqyhMAVY6Bwh
         9UpppEozijIeNM6+NybqrgRk+tXVz6qDT+KP/ZqEddgx/yTeEGdpgI5BObWd/f7OdKv/
         QrH6vdSwL4ZVa9sq8R7erkVlAYJLvCmoQTVRNfhb8PlLsn/zKqTk5WXRfybUBE7zHQfN
         AD37+oBOtH95LiIrudsgr5JxY34CNC5GyeHOJ6GYBGZn60pOp7jX3VrflmG8XH4qo+0M
         jR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750628015; x=1751232815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imZ2VRtA0KRhDqFvVOmvCgQSiKBob6JpuoHz1j3Ovlw=;
        b=h1xB4EHuHOygH4czgsd+S61iwBAM5xtX1UqI+mb7jdTYzEJfw+y6UlOBRDQc8/O5xM
         fKAq59/1WesKNeiIAvgSfudb/8xB/qFsjNVRqU8c0X1oY3zo276PQWteyEap5M3br6mY
         f3wMAz634ojkIDrignURI2F1Aaz5h5h1nJ3xhmpqJFgHJBdhHVsEzeqYJAPSRfyIrr2S
         camBoPW4AJJ0LhuAMZ3QQRo9O9hMplG4Vqw7Pl4jY8pnyJjdDGQH1xq3O0A1FiEhXVX6
         98mMaV9rpCnBz9wrL5AJubrD8zJ64YCKGcoi7/lsk897+cJSuqdOgPCDg9HKOiy/kgto
         4WwA==
X-Gm-Message-State: AOJu0YzIaGaPXgMRvMZeX7/fLhLkjZ2pNB1Mci5heHiGC+CU26tbAE71
	5XZwfwcDE3GZMOy7ju0AIEwqaufQ4sNhDMKp76NsyDZjqycsbZqlS8O9
X-Gm-Gg: ASbGnctf6WsAkAHLOWGHLgA7tURg5FnzOdzROg2z9tWmR2Rm8wTBqvMVzavPm9YG1ee
	i6gLIqkKdKDL1+isZCxYf2dfOeaLc0DTNkLT5HiFSsW2BHm5V2BHhO1V2gsctr0377qx6Qs1yth
	6O3GW+3M1gZaRcZ8binbPdlYsBkkBMnVrWfv2iLxidTG0i5+OpTB9akwlM7qUwMdVavx/H93NFm
	lj+BysuLpgziCpI3jr2vvG7bKqIDbN1ZOB4mAjB3VHaKMe17DoxdS3+CK2Gz3zFxiO55ok425+J
	j7eLmOSUN1W5PcreTGeqID6SvjYKtv22p0a20fUt47oqQWO7IKEx0BqPgXPQdNHhUZCFI4QtmG1
	p3V9uP9rzJDU6jgW3IvhlbVA13HRDeHvZ
X-Google-Smtp-Source: AGHT+IHUJSJk6kFL23Nwi5JQiUdKibcLCw4cz/mxoOvNKkEO/EWyf7iBCMF7YwsmUB2xpRLlmwLjtA==
X-Received: by 2002:a17:903:4b2b:b0:234:a139:11f0 with SMTP id d9443c01a7336-237d980d949mr156889965ad.7.1750628015092;
        Sun, 22 Jun 2025 14:33:35 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8673d1asm67144255ad.172.2025.06.22.14.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 14:33:33 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 92951EF1EB2; Mon, 23 Jun 2025 06:33:30 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 07/13] um: nommu: configure fs register on host syscall invocation
Date: Mon, 23 Jun 2025 06:33:05 +0900
Message-ID: <30ea8e4c251b15349f370302b98ceb70f4572180.1750594487.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750594487.git.thehajime@gmail.com>
References: <cover.1750594487.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_143335_973475_2905F5ED 
X-CRM114-Status: GOOD (  21.50  )
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
index 1251f08e26d0..7c6a8bc0447c 100644
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
index 8a1ab59a089f..3a6d34ccd12b 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -16,6 +16,7 @@
 #include <sys/prctl.h>
 #include <sys/wait.h>
 #include <asm/unistd.h>
+#include <sys/syscall.h>   /* For SYS_xxx definitions */
 #include <linux/threads.h>
 #include <init.h>
 #include <longjmp.h>
@@ -178,6 +179,11 @@ int __init can_drop_memory(void)
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
index 4e1f05360c49..55dd92bd2a0b 100644
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
 #include <kern_util.h>
@@ -36,6 +38,8 @@
 #include <skas.h>
 #include "internal.h"
 
+int host_has_fsgsbase;
+
 static void ptrace_child(void)
 {
 	int ret;
@@ -459,6 +463,20 @@ __uml_setup("seccomp=", uml_seccomp_config,
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
@@ -484,6 +502,9 @@ void __init os_early_checks(void)
 	using_seccomp = 0;
 	check_ptrace();
 
+	/* probe fsgsbase instruction */
+	check_fsgsbase();
+
 	pid = start_ptraced_child();
 	if (init_pid_registers(pid))
 		fatal("Failed to initialize default registers");
diff --git a/arch/x86/um/nommu/do_syscall_64.c b/arch/x86/um/nommu/do_syscall_64.c
index 6b08daab6afe..74d5bcc4508d 100644
--- a/arch/x86/um/nommu/do_syscall_64.c
+++ b/arch/x86/um/nommu/do_syscall_64.c
@@ -2,10 +2,38 @@
 
 #include <linux/kernel.h>
 #include <linux/ptrace.h>
+#include <asm/fsgsbase.h>
+#include <asm/prctl.h>
 #include <kern_util.h>
 #include <sysdep/syscalls.h>
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
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
@@ -22,4 +53,10 @@ __visible void do_syscall_64(struct pt_regs *regs)
 
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
index e88e93e9d80a..f213251c5e35 100644
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
 void arch_switch_to(struct task_struct *to)
 {
 	/*
@@ -42,3 +104,12 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 
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


