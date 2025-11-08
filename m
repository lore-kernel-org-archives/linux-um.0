Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE43CCFA1E
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 08:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SLnEdv1Aj+O6ghd8EMKGqBIoQpaMRjL7FrHMTz+k/js=; b=qqSVK1/ZwZijm8Qh3xHTA9mr5a
	s46nio3dVS4kua9HGGckGu4TKE8OROD5bX89sjVBMQmAmD51elZDZ88gx9iOm/bTig7Di7GHzK+8R
	mApygf8K/9rGMamoWFBmpJ6wdbHZEjWeVlCSz4xGsRRPyR+pUwZ+lq5SOEc2RcQUBbxaD/0mgSSQA
	sHaXKxn0z1FKndUfqlVWWM18ZSGX8LzGJRxgV+0QHnTsqJO+JoDrkvn7Ja6UEaAs445sW9rCde35u
	odq0VFznhWJ9+rujpzzRz7usi/VGhAefWPLjRpRnjiGxw5Fy5k7dD4at0G8r/E0Vy+c4ig4O4+DSH
	q9inERig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxb-00000002ixO-45sd;
	Sat, 08 Nov 2025 08:06:11 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxZ-00000002iug-0tdk
	for linux-um@lists.infradead.org;
	Sat, 08 Nov 2025 08:06:10 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-3436d6bdce8so528314a91.3
        for <linux-um@lists.infradead.org>; Sat, 08 Nov 2025 00:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589168; x=1763193968; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLnEdv1Aj+O6ghd8EMKGqBIoQpaMRjL7FrHMTz+k/js=;
        b=V5098tD3D1ArNigTmp6f8//eslOJ6EnGW2mCJHwxOwsyp7hvvlRjVSbuUH38RLRCDn
         pci1FlcOIuITXJ8u21UvFs6OMsLRviLm6EX3fCjdg8if1E5+hSRp14vkkjDGuJT8Aj/q
         f2T/+ePuznPFc+4mn4Zhcv8jyTvh4gt9TErgrAk/Du+qPDFJGQ4BilqAnBX2rjXTzW5K
         QtQTQyLzfCfpjIinu4VmqLmcwNXeNCaIQ/oixaN9pFt7lk9IsB4tUifOEdgrvRwspq4j
         pTK1/YlfBVfn0lsrdz3Nuby/5r3jdSuH/X1lxxj4s+VTgJqL0peFIGgYl0+QeSU10lWg
         rSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589168; x=1763193968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SLnEdv1Aj+O6ghd8EMKGqBIoQpaMRjL7FrHMTz+k/js=;
        b=WUSejJUNXbeRNEG39ipEluEzF6WbT3sYBjz2mr5E3iJ2N8w93G4VMytEBxgaAjKVLJ
         z7pSAAHBacb2kg/Td5KiPooZ1i0QvuuimelTZzSAwAxfnwBbf3O3jWll7/mVHwnDqmHX
         g0uqo3O3mgfi5lgwnRK/BjjbAGx93IuzGFitYyMQtNHxybZi2lUfQdgUtVT8p/A/VcFj
         MQhbCG4pbUu1+vQKl1rHsg6H3ncWy10GIWYw7BEJXYspukt8JSg+wU8/xek4ckTv+fab
         eGfG8luHYh0JCvuQeegy8ZXV+VrA7ekMDBL6x+1GNpOUIINlIaseRxAi9w09nAdyks2m
         EFug==
X-Gm-Message-State: AOJu0YwjDcwd5y1I7USaOB/X8XReqRKQDP8+RqFgNrL+NgXrvtqBkgvg
	HIHhM3wfTiPkykKGH16qwZ8tRKwb5FAbxraAnSIPHWs0kyyezyQB+ZJL
X-Gm-Gg: ASbGnctfXK+hoce6X/tzzW+ArmUL2GJd7G1Q23Sr/Dza0XYqLbgFx1/xDcNQz7RCMV9
	yGTk8gzrFymoZp06H5QqJrIB49eNlPhki9Og1riAR+xjQYIFD9xWnZKWSgpkqdzo8MJO+sDG/uG
	uMXJanej3T17wBpj1pggCCic7R1FgaENo0xMLZx/PoG4Kc5gGx4kZcgxRZ4w5MoSojmdZKICfQp
	7fG6JepCCsgG/dNEymAZ3/TZ1VtadfvbytC/WezutzDckhDd2FlJt2FPKUSt5FELy4MACF1KgJD
	U2NV2XFW37RUUgb7ATkInOmMoKZrWeJrPdsT2c23X5FC/Yt13qyLkWP/rvFess01eDuNxX3vpQy
	get+pgfE8i7xY+MGF0pAUNXuLO5yMtDXWcFKjhgzNyKd3b31s0VKFbG8GOGFQ3Lt2rtzUNx9mMF
	D6MWlvAUq1OyxjRMy0t7nXku8prUzXaKozfsuwblglyy2mxQ==
X-Google-Smtp-Source: AGHT+IF/0KZ5RiX7F5gJWW1n/1VeDv21BdI+XAZBghbXnkRhZxzi65ZsXJm5TsGevPqoLSCwHlvJAA==
X-Received: by 2002:a17:90b:3f0b:b0:32e:a5ae:d00 with SMTP id 98e67ed59e1d1-3436cb9833fmr2369527a91.13.1762589168273;
        Sat, 08 Nov 2025 00:06:08 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a69b33c7sm11409199a91.18.2025.11.08.00.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:07 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id D220D11388CF; Sat,  8 Nov 2025 17:06:05 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	Kenichi Yasukata <kenichi.yasukata@gmail.com>
Subject: [PATCH v13 05/13] um: nommu: seccomp syscalls hook
Date: Sat,  8 Nov 2025 17:05:40 +0900
Message-ID: <9e3438cf6d6c26a708c428267375b102b434d5d6.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_000609_265021_A78F7570 
X-CRM114-Status: GOOD (  24.59  )
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

This commit adds syscall hook with seccomp.

Using seccomp raises SIGSYS to UML process, which is captured in the
(UML) kernel, then jumps to the syscall entry point, __kernel_vsyscall,
to hook the original syscall instructions.

The SIGSYS signal is raised upon the execution from uml_reserved and
high_physmem, which locates userspace memory.

It also renames existing static function, sigsys_handler(), in
start_up.c to avoid name conflicts between them.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Kenichi Yasukata <kenichi.yasukata@gmail.com>
---
 arch/um/include/shared/kern_util.h    |  2 +
 arch/um/include/shared/os.h           | 10 +++
 arch/um/kernel/um_arch.c              |  3 +
 arch/um/nommu/Makefile                |  3 +
 arch/um/nommu/os-Linux/Makefile       |  7 +++
 arch/um/nommu/os-Linux/seccomp.c      | 87 +++++++++++++++++++++++++++
 arch/um/nommu/os-Linux/signal.c       | 16 +++++
 arch/um/os-Linux/signal.c             |  8 +++
 arch/um/os-Linux/start_up.c           |  4 +-
 arch/x86/um/nommu/Makefile            |  2 +-
 arch/x86/um/nommu/os-Linux/Makefile   |  6 ++
 arch/x86/um/nommu/os-Linux/mcontext.c | 15 +++++
 arch/x86/um/shared/sysdep/mcontext.h  |  4 ++
 13 files changed, 164 insertions(+), 3 deletions(-)
 create mode 100644 arch/um/nommu/Makefile
 create mode 100644 arch/um/nommu/os-Linux/Makefile
 create mode 100644 arch/um/nommu/os-Linux/seccomp.c
 create mode 100644 arch/um/nommu/os-Linux/signal.c
 create mode 100644 arch/x86/um/nommu/os-Linux/Makefile
 create mode 100644 arch/x86/um/nommu/os-Linux/mcontext.c

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 38321188c04c..7798f16a4677 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -63,6 +63,8 @@ extern void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs
 extern void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs,
 		  void *mc);
 extern void fatal_sigsegv(void) __attribute__ ((noreturn));
+extern void sigsys_handler(int sig, struct siginfo *si, struct uml_pt_regs *regs,
+			   void *mc);
 
 void um_idle_sleep(void);
 
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index b26e94292fc1..5451f9b1f41e 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -356,4 +356,14 @@ static inline void os_local_ipi_enable(void) { }
 static inline void os_local_ipi_disable(void) { }
 #endif /* CONFIG_SMP */
 
+/* seccomp.c */
+#ifdef CONFIG_MMU
+static inline int os_setup_seccomp(void)
+{
+	return 0;
+}
+#else
+extern int os_setup_seccomp(void);
+#endif
+
 #endif
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index e2b24e1ecfa6..27c13423d9aa 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -423,6 +423,9 @@ void __init setup_arch(char **cmdline_p)
 		add_bootloader_randomness(rng_seed, sizeof(rng_seed));
 		memzero_explicit(rng_seed, sizeof(rng_seed));
 	}
+
+	/* install seccomp filter */
+	os_setup_seccomp();
 }
 
 void __init arch_cpu_finalize_init(void)
diff --git a/arch/um/nommu/Makefile b/arch/um/nommu/Makefile
new file mode 100644
index 000000000000..baab7c2f57c2
--- /dev/null
+++ b/arch/um/nommu/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y := os-Linux/
diff --git a/arch/um/nommu/os-Linux/Makefile b/arch/um/nommu/os-Linux/Makefile
new file mode 100644
index 000000000000..805e26ccf63b
--- /dev/null
+++ b/arch/um/nommu/os-Linux/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y := seccomp.o signal.o
+USER_OBJS := $(obj-y)
+
+include $(srctree)/arch/um/scripts/Makefile.rules
+USER_CFLAGS+=-I$(srctree)/arch/um/os-Linux
diff --git a/arch/um/nommu/os-Linux/seccomp.c b/arch/um/nommu/os-Linux/seccomp.c
new file mode 100644
index 000000000000..d1cfa6e3d632
--- /dev/null
+++ b/arch/um/nommu/os-Linux/seccomp.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <signal.h>
+#include <sys/prctl.h>
+#include <sys/syscall.h>   /* For SYS_xxx definitions */
+#include <init.h>
+#include <as-layout.h>
+#include <os.h>
+#include <linux/filter.h>
+#include <linux/seccomp.h>
+
+int __init os_setup_seccomp(void)
+{
+	int err;
+	unsigned long __userspace_start = uml_reserved,
+		__userspace_end = high_physmem;
+
+	struct sock_filter filter[] = {
+		/* if (IP_high > __userspace_end) allow; */
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer) + 4),
+		BPF_JUMP(BPF_JMP + BPF_JGT + BPF_K, __userspace_end >> 32,
+			 /*true-skip=*/0, /*false-skip=*/1),
+		BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_ALLOW),
+
+		/* if (IP_high == __userspace_end && IP_low >= __userspace_end) allow; */
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer) + 4),
+		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, __userspace_end >> 32,
+			 /*true-skip=*/0, /*false-skip=*/3),
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer)),
+		BPF_JUMP(BPF_JMP + BPF_JGE + BPF_K, __userspace_end,
+			 /*true-skip=*/0, /*false-skip=*/1),
+		BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_ALLOW),
+
+		/* if (IP_high < __userspace_start) allow; */
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer) + 4),
+		BPF_JUMP(BPF_JMP + BPF_JGE + BPF_K, __userspace_start >> 32,
+			 /*true-skip=*/1, /*false-skip=*/0),
+		BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_ALLOW),
+
+		/* if (IP_high == __userspace_start && IP_low < __userspace_start) allow; */
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer) + 4),
+		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, __userspace_start >> 32,
+			 /*true-skip=*/0, /*false-skip=*/3),
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer)),
+		BPF_JUMP(BPF_JMP + BPF_JGE + BPF_K, __userspace_start,
+			 /*true-skip=*/1, /*false-skip=*/0),
+		BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_ALLOW),
+
+		/* other address; trap  */
+		BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_TRAP),
+	};
+	struct sock_fprog prog = {
+		.len = ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	err = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	if (err)
+		os_warn("PR_SET_NO_NEW_PRIVS (err=%d, ernro=%d)\n",
+		       err, errno);
+
+	err = syscall(SYS_seccomp, SECCOMP_SET_MODE_FILTER,
+		      SECCOMP_FILTER_FLAG_TSYNC, &prog);
+	if (err) {
+		os_warn("SECCOMP_SET_MODE_FILTER (err=%d, ernro=%d)\n",
+		       err, errno);
+		exit(1);
+	}
+
+	set_handler(SIGSYS);
+
+	os_info("seccomp: setup filter syscalls in the range: 0x%lx-0x%lx\n",
+		__userspace_start, __userspace_end);
+
+	return 0;
+}
+
diff --git a/arch/um/nommu/os-Linux/signal.c b/arch/um/nommu/os-Linux/signal.c
new file mode 100644
index 000000000000..19043b9652e2
--- /dev/null
+++ b/arch/um/nommu/os-Linux/signal.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <signal.h>
+#include <kern_util.h>
+#include <os.h>
+#include <sysdep/mcontext.h>
+#include <sys/ucontext.h>
+
+void sigsys_handler(int sig, struct siginfo *si,
+		    struct uml_pt_regs *regs, void *ptr)
+{
+	mcontext_t *mc = (mcontext_t *) ptr;
+
+	/* hook syscall via SIGSYS */
+	set_mc_sigsys_hook(mc);
+}
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 327fb3c52fc7..2f6795cd884c 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -20,6 +20,7 @@
 #include <um_malloc.h>
 #include <sys/ucontext.h>
 #include <timetravel.h>
+#include <linux/compiler_attributes.h>
 #include "internal.h"
 
 void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *, void *mc) = {
@@ -31,6 +32,7 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *, void *mc) =
 	[SIGSEGV]	= segv_handler,
 	[SIGIO]		= sigio_handler,
 	[SIGCHLD]	= sigchld_handler,
+	[SIGSYS]	= sigsys_handler,
 };
 
 static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
@@ -182,6 +184,11 @@ static void sigusr1_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
 	uml_pm_wake();
 }
 
+__weak void sigsys_handler(int sig, struct siginfo *unused_si,
+			   struct uml_pt_regs *regs, void *mc)
+{
+}
+
 void register_pm_wake_signal(void)
 {
 	set_handler(SIGUSR1);
@@ -193,6 +200,7 @@ static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
 	[SIGILL] = sig_handler,
 	[SIGFPE] = sig_handler,
 	[SIGTRAP] = sig_handler,
+	[SIGSYS] = sig_handler,
 
 	[SIGIO] = sig_handler,
 	[SIGWINCH] = sig_handler,
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 054ac03bbf5e..33e039d2c1bf 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -239,7 +239,7 @@ extern unsigned long *exec_fp_regs;
 
 __initdata static struct stub_data *seccomp_test_stub_data;
 
-static void __init sigsys_handler(int sig, siginfo_t *info, void *p)
+static void __init _sigsys_handler(int sig, siginfo_t *info, void *p)
 {
 	ucontext_t *uc = p;
 
@@ -274,7 +274,7 @@ static int __init seccomp_helper(void *data)
 			sizeof(seccomp_test_stub_data->sigstack));
 
 	sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
-	sa.sa_sigaction = (void *) sigsys_handler;
+	sa.sa_sigaction = (void *) _sigsys_handler;
 	sa.sa_restorer = NULL;
 	if (sigaction(SIGSYS, &sa, NULL) < 0)
 		exit(2);
diff --git a/arch/x86/um/nommu/Makefile b/arch/x86/um/nommu/Makefile
index d72c63afffa5..ebe47d4836f4 100644
--- a/arch/x86/um/nommu/Makefile
+++ b/arch/x86/um/nommu/Makefile
@@ -5,4 +5,4 @@ else
 	BITS := 64
 endif
 
-obj-y = do_syscall_$(BITS).o entry_$(BITS).o
+obj-y = do_syscall_$(BITS).o entry_$(BITS).o os-Linux/
diff --git a/arch/x86/um/nommu/os-Linux/Makefile b/arch/x86/um/nommu/os-Linux/Makefile
new file mode 100644
index 000000000000..4571e403a6ff
--- /dev/null
+++ b/arch/x86/um/nommu/os-Linux/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y = mcontext.o
+USER_OBJS := mcontext.o
+
+include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/x86/um/nommu/os-Linux/mcontext.c b/arch/x86/um/nommu/os-Linux/mcontext.c
new file mode 100644
index 000000000000..b62a6195096f
--- /dev/null
+++ b/arch/x86/um/nommu/os-Linux/mcontext.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/ucontext.h>
+#define __FRAME_OFFSETS
+#include <asm/ptrace.h>
+#include <sysdep/ptrace.h>
+#include <sysdep/mcontext.h>
+
+extern long __kernel_vsyscall(int64_t a0, int64_t a1, int64_t a2, int64_t a3,
+			      int64_t a4, int64_t a5, int64_t a6);
+
+void set_mc_sigsys_hook(mcontext_t *mc)
+{
+	mc->gregs[REG_RCX] = mc->gregs[REG_RIP];
+	mc->gregs[REG_RIP] = (unsigned long) __kernel_vsyscall;
+}
diff --git a/arch/x86/um/shared/sysdep/mcontext.h b/arch/x86/um/shared/sysdep/mcontext.h
index 6fe490cc5b98..9a0d6087f357 100644
--- a/arch/x86/um/shared/sysdep/mcontext.h
+++ b/arch/x86/um/shared/sysdep/mcontext.h
@@ -17,6 +17,10 @@ extern int get_stub_state(struct uml_pt_regs *regs, struct stub_data *data,
 extern int set_stub_state(struct uml_pt_regs *regs, struct stub_data *data,
 			  int single_stepping);
 
+#ifndef CONFIG_MMU
+extern void set_mc_sigsys_hook(mcontext_t *mc);
+#endif
+
 #ifdef __i386__
 
 #define GET_FAULTINFO_FROM_MC(fi, mc) \
-- 
2.43.0


