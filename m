Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF15C71157
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 01:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ihdFXWNIx+H443+kP6md5Dj55CMYh0h9g6RuQVPwAiE=; b=ltXAZa0yHKeFAb+jkScMcgva9M
	+OBR0qvSW8GpdWmO+wHWOAZ8jKAD98FSC7kgQvfOx7kWntuBVHq0ltIbEcv1ZFIbnL4GW4ckaS/BL
	YLOKrLzgXQcX3RxWayOgTTGgVxzZ4NJ19h0cZsdLaag4JWogsL3t1662/P7Uqa932QfxpODXmiryD
	AbzUzAOnrUU5Y0d5CXdiytzrdZp0oq8WD/y+rmST1/rIaE4De/GNxiMbWwSPMz8TWCEGTrXeY1EWW
	OfNPpVUJwiy3pbztVzglMFeIiEJbgbhL0ZTMldV7wTjF+PtloeaxX9ASZNC9nON5GpA+TeJPtRLRH
	Gu3FUFrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3i2-0000000Bgin-028S;
	Thu, 19 Jun 2025 01:04:54 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3hy-0000000Bgfh-3j3f
	for linux-um@lists.infradead.org;
	Thu, 19 Jun 2025 01:04:52 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-7487d2b524eso124522b3a.0
        for <linux-um@lists.infradead.org>; Wed, 18 Jun 2025 18:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750295090; x=1750899890; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihdFXWNIx+H443+kP6md5Dj55CMYh0h9g6RuQVPwAiE=;
        b=aJ/BnP/QVpyYeRn+GIbjvVEgL2YvgVmjAADdOt5L0E29kyPcQg3zKYOPTsY2L7EMyo
         EdsU81WF0rTyNpGb1r4krI9MXQLHK/8UWhh8H7HZ3j+OBTJgp0HmLUhY8fSo/+AbNNxI
         GZY5TUo0uGs63w4Qhw5Y5tR//VkxkNZlPJa9evxPYxrPBgAsjCPO4FgVV3zRPfo/rBOW
         SkXN3y3AOLg8V/vIdUgLoomJE3rrxWfelkijAqLnWFrfH+NXySYqV4DLMy0wCUK7yhyB
         IBhkyh6b397FfWuFGDkRK5FVhJsqT9oya3PLNDbFmJeO5fXQLeCedUYtq0LlqBdNbxRO
         eVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750295090; x=1750899890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihdFXWNIx+H443+kP6md5Dj55CMYh0h9g6RuQVPwAiE=;
        b=X04Vkak683LUnjiUgqPzjzEQ/z2RlnGl2kqD2a62o31ksb2QBCN5cx2mGIvcvLGJvY
         SbKXkm7/VsImuP3oPH9oZDzcIpr+XzPF5GFMg+ADTqxyOGYORY6xOP1u8O0D0jgcjDji
         WICZBI/fbKMO0n2wxGZJdeZcwWPOTDnQwDju/Km700WChPlYnUx46mujWzhC0C4lUv5J
         WaaWa3cKv+x9VnTTSmwQ6ufY0v1D/8vKOublp7hM1uLLcNUIf2Xx1JxK4mviSGe65jw2
         tX1zLZhUDkJLJ9UbX29j8qe7r3bc8RaRQM0XXknj0aAesJSfdyKuQs5313ebWNbCBOaD
         ZFbg==
X-Gm-Message-State: AOJu0YyLR9Tup4BbOQuXgX3OIbTgxRiX+xHGzajaDe4E7rY9asRWNK/0
	pIPMwUA1WArvPvOhpDksHtRWIhwCzhbb9PQ4z0s8YbPOP3O8xGLyBw+Q
X-Gm-Gg: ASbGncvIBugmy85AKJdYC6CKgWsG8TPVtskJG0dEPUY+80IT8qFUWoio6Jf3Bm4JJWd
	D4e9rz7KWzJ6J2kuR78sHoBG1wOOcC6kPXL8ddVjnPY3dsUQHWKj7/kiPtNSYWiaynFoOtr84q2
	GP6QgoRYp04f6k40QJKpYdrvoIsft+PreWqnuZisqMj7zowW6K0/v2+eRZiHlHF6Xv+kSCGpvFD
	vp5wmLlmZnHJspmQqK9tKHkMNgt9ZOiMX1Nm+Wexdu+g58fwg9+8NlY2rBMCj6rP6T7xukdBE2V
	oxPLHM5IzG5JPPg/0btXPQC0l+G5oVJFsogzGW+z5Me8rpj0Ro8VsQ+K2dQMi9f20sWFucU4Etc
	zvZwoJ4gpQh4f9VvRnubi6ae+dkDs1GV/
X-Google-Smtp-Source: AGHT+IGZ4bg7vYaVF4gGWT0CG08w6lmpULaJfwfanalAIWgpjTFJYjIFTJnjoOhko+Y0PjC8ljzkjQ==
X-Received: by 2002:a05:6a21:99a8:b0:1f5:535c:82dc with SMTP id adf61e73a8af0-21fbd668c44mr28761235637.42.1750295090022;
        Wed, 18 Jun 2025 18:04:50 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1691d7fsm11895294a12.69.2025.06.18.18.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 18:04:49 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 2EBD5ED6536; Thu, 19 Jun 2025 10:04:46 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 07/13] um: nommu: configure fs register on host syscall invocation
Date: Thu, 19 Jun 2025 10:04:11 +0900
Message-ID: <2863dab9b3f9d6536b73623398a3f39e4ae70957.1750294482.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750294482.git.thehajime@gmail.com>
References: <cover.1750294482.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250618_180450_953564_E58B94B8 
X-CRM114-Status: GOOD (  21.83  )
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


