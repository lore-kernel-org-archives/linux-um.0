Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3AAC0218F
	for <linux-um@archiver.kernel.org>; Mon, 20 Jan 2025 06:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=exXQ4twzHhx+69VgkOasIACN9ZNsWPg08dNNqO76+Uk=; b=N0fnNIt0UR1i46wOSLcCn6w8TS
	lcF2EYDRhge7sfID8wwI3IMAPDsPaL+v6VFlCib45mfi7rU5tFSoTIYoKyAK9S7kHrS3JKXFpjV0j
	eO6oAGKQe26MEXwJ78s03IYonrSpP/vrPXiJOqhPHfqEeS/xTXBG/uCoO6wYIdPxvDXeVSA5XbW4e
	P5qpnIWfhRaQwDFMUSpv7Td1kqheI9Oylp4ujbjH/HjrFnHaoyqgm7jqEIghpFk4YWfb6w1nxELfv
	3Xu6GSq5bPiXJE3v8BVuPEKZQjgvrFOSbsC3wFDSQk6Qzx9rKzq3Y9oQ6zXfI/OEvTs7PQ2ALPydR
	G2nahmLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkr2-00000004nRR-42YF;
	Mon, 20 Jan 2025 06:01:44 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkpy-00000004nH2-4Bfe
	for linux-um@lists.infradead.org;
	Mon, 20 Jan 2025 06:00:40 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-21644aca3a0so93736875ad.3
        for <linux-um@lists.infradead.org>; Sun, 19 Jan 2025 22:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737352838; x=1737957638; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exXQ4twzHhx+69VgkOasIACN9ZNsWPg08dNNqO76+Uk=;
        b=mZjZGc6sxmiMJWDAJ7EYlzyH2Dl3SlSySuc4kUx0hle90iDEjhDHKByyFMtK8wII46
         n3bj0aHJI3QZjZS+9FxROHOivaluEyrvz5lsvW5gxWh3M4oCsXs13S7mdnvwrzTxwIA1
         Vly6OUDmoK5Jilgmi6Dv107p7eUgr++d2y94L3t2OGOQGZKs7a+E+wFfqo8zsaBvQIdp
         +MtbngIp0ZEe2OeArVXcTbUHqwywmSdM92jtUdf0fjtQtwvIOESURs9OZziaMvSLgG+3
         4OQSrS76CRvf4xUHhU0u31lVz/RXzIvO/jn3yCANqm7U5FKFFcPgqXP8Y91T+tUoKxVg
         kxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737352838; x=1737957638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exXQ4twzHhx+69VgkOasIACN9ZNsWPg08dNNqO76+Uk=;
        b=Yw+Inw17eGlPl+2E3XKEu3beLzlKCZAWQ4BzmbSQYUmWstQJOX/6r27sfoBuSXKvGy
         GWAM7UDdxBgXCL9i3pCo+g7ECzqwH5Bk96ZxvpCtz0YcveaQ7UKayanmBlKWw7nAvFea
         +DO6fMlLcL47SMkpiw0tyqaDzKWE6dvbUGk8nghvxDEGzFAMhwBMKyTpY9WDd48tuZ4c
         PyeR49e/wkPOgchnVwycF6M/bJI28cwkRzyVyq8m5ls3+mu/g9r5S5eeWtCvJ6uJj7P+
         KcsK934XIAi4yWRX6KuMpSHT+P/+5uP7LtDKcGBaX7jTYiftcdQzJFAKmgH+QMi0nHL/
         0Cnw==
X-Gm-Message-State: AOJu0YztFmLhu4MpLzIkKptx9yBvTh3g9WBXKN7YUhHhBuyvBC4Swhwo
	bGR156somR86+Ju/WoSsUKonAtV6JKRxKkvq7od4p0Bgiqk7dwqm
X-Gm-Gg: ASbGncsxiTYjsVFtgwUy+YlLE7IxzYXvrHRwpx9mTPqkZF/oBML3jbEVtUmIeD1dFI5
	STBKmMT/85sKGH6ayTFSA6Q6nHcNxxLc4kW9H3LNvZOG2dRQcAZaa4978/blzALXuYGmLYKBWti
	YV/vua8sf5aO4JlhDMriUJX9W1JBEebihGH58y0LdIs+yPCh9ML3ty6wggZTa9UD1uFMeGtjPJ4
	+qxHEirh+4bKd+KEimqP+Re10FFYNXN8T5CScLIq99S6TaNeOUWcr24BgqG7ySQv/z66pR8hrM8
	D/rYLP4TF7KrFTNG0HrzaolZgXjOmmmPjKQICgGcDA==
X-Google-Smtp-Source: AGHT+IFyIWzgsHnEVDx59DF1qbilzWIjcP1HD83GeFYUjVvT8aEuEFhTkM2emC8GPIbBEPAsO6V6gA==
X-Received: by 2002:a05:6a21:32a2:b0:1e1:bee3:50ea with SMTP id adf61e73a8af0-1eb214984b8mr16807891637.11.1737352837914;
        Sun, 19 Jan 2025 22:00:37 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab84998asm6245378b3a.83.2025.01.19.22.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:00:36 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 436C1E27532; Mon, 20 Jan 2025 15:00:35 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v7 08/13] um: nommu: configure fs register on host syscall invocation
Date: Mon, 20 Jan 2025 15:00:10 +0900
Message-ID: <9224eadacd49dcf0caa003fba6e23a764546c4b2.1737348400.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737348399.git.thehajime@gmail.com>
References: <cover.1737348399.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250119_220039_040475_B1638904 
X-CRM114-Status: GOOD (  20.36  )
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
 arch/um/os-Linux/start_up.c       | 20 +++++++++
 arch/x86/um/nommu/do_syscall_64.c | 37 ++++++++++++++++
 arch/x86/um/nommu/syscalls_64.c   | 71 +++++++++++++++++++++++++++++++
 5 files changed, 140 insertions(+)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index d29b967a009e..abb6f03414c5 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -190,6 +190,7 @@ extern void check_host_supports_tls(int *supports_tls, int *tls_min);
 extern void get_host_cpu_features(
 	void (*flags_helper_func)(char *line),
 	void (*cache_helper_func)(char *line));
+extern int host_has_fsgsbase;
 
 /* mem.c */
 extern int create_mem_file(unsigned long long len);
@@ -214,6 +215,11 @@ extern int os_unmap_memory(void *addr, int len);
 extern int os_drop_memory(void *addr, int length);
 extern int can_drop_memory(void);
 extern int os_mincore(void *addr, unsigned long len);
+extern int os_arch_prctl(int pid, int option, unsigned long *arg);
+#ifndef CONFIG_MMU
+extern long long host_fs;
+#endif
+
 
 void os_set_pdeathsig(void);
 
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 49aa8e92205e..9acb865e2399 100644
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
@@ -206,6 +207,11 @@ int os_mincore(void *addr, unsigned long len)
 	return ret;
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
diff --git a/arch/x86/um/nommu/do_syscall_64.c b/arch/x86/um/nommu/do_syscall_64.c
index 5d0fa83e7fdc..796beb0089fc 100644
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
@@ -17,6 +45,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 		 syscall, (unsigned long)current,
 		 (unsigned long)sys_call_table[syscall]);
 
+	/* set fs register to the original host one */
+	os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
+
 	if (likely(syscall < NR_syscalls)) {
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
@@ -34,4 +65,10 @@ __visible void do_syscall_64(struct pt_regs *regs)
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
diff --git a/arch/x86/um/nommu/syscalls_64.c b/arch/x86/um/nommu/syscalls_64.c
index c78c442aed1d..5bb6d55b4bb5 100644
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


