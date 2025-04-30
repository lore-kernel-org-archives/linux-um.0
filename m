Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3DAC369DC
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 04:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RhZelJwiTUJ/UkMrQlTULCdNhOyleWw7wnwmeZqJPjo=; b=2mjmO8CQkF9qDYEAzFZTvsKbQE
	E9JXQRUFg+6jlQZTfNGC34bCrL7YGaL6y9hHBE6A5ZWW27+ORjjHAXGAMCn80xIYRbMykrcr4iWqK
	tipQoCGe/LGMgEQOHWGfFktbzYt80u4cH4bcdReQD1p59KQLcfQ2E4yhl41OxC3PF3G57UjXYbWDk
	fAugGzmha8NR6D6mzGX/lcLsBwOEPLhKEKQMp+2yY4vzWM2EE98tf7nb9Q1c+3x0FXniPaYLGBBs+
	Y/CmiF6kN6WNNXTZyygpzF3MS6j25M6wGVpHKrLy6BZrZq/DHkR41wZM9VulNdrm5bUASsbeCZj0j
	px4aCq5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z4E-0000000BflN-1B3d;
	Wed, 30 Apr 2025 04:29:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z3P-0000000BfWx-1nkt
	for linux-um@bombadil.infradead.org;
	Wed, 30 Apr 2025 04:28:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=RhZelJwiTUJ/UkMrQlTULCdNhOyleWw7wnwmeZqJPjo=; b=jMu9acOT8S0sK8zSnEbhJ/4hSf
	VOzcZYuj9toNQNFLE2vxvOFfYPf3RPZX2YFrl4Ud7HNffJvMjzn1Gksly+FcYb4TM6/t0g06ncQhr
	u0aV6Mx6SHmsodvyhwybyFLUa6X7HQQJCrHqBg0N/wM2F7cEmpNGEJuAtdSnwNroU5wO8S2VGnx9z
	FdgmmQgk40rt51Rkav8XoW00ZU13GplB62H766GHNzVgJGS+Lmfk87+s6s5wPwHQZZzwpQ2dbZ25U
	AzMoLVJ9BBU84viGDycT51usi+qgnXfQWK8Au1eoIiCHhXnHEMP56wwTI6uMuuwwtJkWm5bbpvcu1
	IVkS0epg==;
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9z3A-0000000DgDM-2IOO
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 04:28:12 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3035858c687so5745160a91.2
        for <linux-um@lists.infradead.org>; Tue, 29 Apr 2025 21:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745987275; x=1746592075; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhZelJwiTUJ/UkMrQlTULCdNhOyleWw7wnwmeZqJPjo=;
        b=G8BdMI3hqxXoBzbViBZM550TmUQHGUw8zmFm7holw8qEExvAZs5iNfKX06kM+IS4+w
         C5DBWA/RqVF7SvSozV5q89RewMoh01CJhiYH2vmtzzdD4yiEvvt9SK35vMpG6dkqxJm7
         eDG/+MCBcM3K93/RtWCvOJ8KZJiTRpO34FGMXpHoK699lwneq5dn7saAg9i4LhIb70TM
         yStn/GBK47Fw7vSXbkTwk0bDj3Os5MNGy3vAzuvUXg/0MCa46kurY37BG6Q3WhoQU4Tg
         JvRKVKZmw7f/Uv5lBQ5nZq4Wy74z9lU9sRpAkWQpOpiypdde8eOiGEHZSOu4hBuKQWNE
         iqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745987275; x=1746592075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhZelJwiTUJ/UkMrQlTULCdNhOyleWw7wnwmeZqJPjo=;
        b=vZ0gg559hXkIaG2IPKH9AV8RXTJ0kfC+m1nSHVy0TsDU+ephFf8ZWplCEx0dumEYBn
         EijAPygo5BHvRe1VISIDPDdbb9/I+Zce5dMvC53fcyQvxxhhIi/7i71g71CipO7R03jL
         W/TuSVDS5fl+594/HzKCDYqmXYoJuMvSxYaC+0m5+v0+59yLbleVuWjlXWRfjYd9SJyJ
         s+Vv6gNVuaxxg2TDRC7BxClwCkcR8b5nJg7wKi6g3mcYMnykgDxglElxcbKSDOjeB27A
         ElP9nTiWFCn5ENlciLNILbtqjNObOSipLsVtwzW8QVALgWNk1r21FR8j+wuLJQaS/pzB
         o1jg==
X-Gm-Message-State: AOJu0YyKDxXt6kwieErjOXFC0raABkypMCJMBExJ6Wg3qVSzhHw8wCm1
	0JWrVAbnsCekk/7LeWXjYEed2lORQNPRjkQHaFssM6GnCcaWd//m
X-Gm-Gg: ASbGnctA1iQuDZQvQ+oIcGg/Nmrc7oVh1xwVAZhjmyMK7qwBaOetv9SxbjClPTmcXuu
	fgLL/L9JXb0vytAlqFvan5u+8wNY4fg4Idqvc+3b3yKZsFeqUpbf3ScJ/9J2Gw0mUi4Epmy67zo
	QSSbPEwm/mWZY09GOFuxXpg7eZuaFaq5WuStGto1ycpeWT40j2kxIW2AZ8j/RzoQx3J+4uQG2hY
	j7sYmrB74HrZ0kEiReofquvrybD+rDQgohw9n2+ANRZW7ogzIEyLOP5wkYC+3Z9sBeVfgNI/5LP
	Ra9tXrrq4l8M/r2bs/JsDhlbv+m4pWUgXrMPUNbI0IMOzartP1BQ9KkYecABy6eizW2i0H5WZBn
	BO7R4Ous8CD4=
X-Google-Smtp-Source: AGHT+IF7i/I3IdOLHAQ2T3n6rN/DkuQz7/uZDc2c33Jl4R9I8AWjlNgT7XTdUlU6shCJ7XEQ1alnEg==
X-Received: by 2002:a17:90b:6d0:b0:2fe:b9be:216 with SMTP id 98e67ed59e1d1-30a3336ba48mr2266861a91.31.1745987275453;
        Tue, 29 Apr 2025 21:27:55 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a349e3c2csm566258a91.2.2025.04.29.21.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 21:27:54 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id CFEAFE94820; Wed, 30 Apr 2025 13:27:52 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 07/12] um: nommu: configure fs register on host syscall invocation
Date: Wed, 30 Apr 2025 13:27:13 +0900
Message-ID: <3b21fc4fab514b550076b10e571a371dfee54a0d.1745980082.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745980082.git.thehajime@gmail.com>
References: <cover.1745980082.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_052802_182669_0C1103F0 
X-CRM114-Status: GOOD (  21.11  )
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
index 7f6703869dde..2e972ca55213 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -190,6 +190,7 @@ extern void check_host_supports_tls(int *supports_tls, int *tls_min);
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
index 3ac01881e905..7806b51e38b3 100644
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
@@ -155,6 +156,11 @@ int __init can_drop_memory(void)
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


