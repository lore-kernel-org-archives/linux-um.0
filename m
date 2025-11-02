Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB83BCCF9E3
	for <linux-um@archiver.kernel.org>; Sun,  2 Nov 2025 09:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SLnEdv1Aj+O6ghd8EMKGqBIoQpaMRjL7FrHMTz+k/js=; b=JpB/cJcpBnPDnQFXU4lw0oJFgh
	E1TYkG4ypV68jgis5mk3b5l2Y50OuvVKwzdheDKboOgwO21lO0+Z+pa834McuPU482ZBR6vuN7sFW
	fS64zJJF9hwxOLlE+neCbu6mgcnqj3BIXKgPcvPSy5eCB0WBAZPdzISg5LbuZzNOob2z2g7txrZQR
	0ikBK5Hyx+rEjwrjUohW+7xsN5RlsanSgltQJRUEswmZEIqCPb/tdesa1deYUGc3DkGMHDAzCh6nh
	VK1v3JNKrDpTdwHYT5b6ZFlXPDn4A56h0Xei+P+oP/WFt+qwxuwpcBqEFA9L+d+pCpMptDikiNBiY
	T9ofVaVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUin-00000008Rsz-1neF;
	Sun, 02 Nov 2025 09:50:01 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUik-00000008RpY-3HHB
	for linux-um@lists.infradead.org;
	Sun, 02 Nov 2025 09:50:00 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-7a74b13f4f8so2431369b3a.1
        for <linux-um@lists.infradead.org>; Sun, 02 Nov 2025 01:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762076998; x=1762681798; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLnEdv1Aj+O6ghd8EMKGqBIoQpaMRjL7FrHMTz+k/js=;
        b=Fxn/DpVpXeHoGFEMmkH90/xwbLvKFXHhhvcWCvGWnZxu9idfbwlwgsImEYFhWXXAf3
         iqFWlJAcgdHf9U534Ra4a0l9cHvtEiSTDrbrWasmhygRYyehGtJysZIggs+q7omzYRuK
         jqzVqFGk9DRqu+dcs1/UEZaDqfdXrjefRcvEqmfhdQVCkqZqn4OwLWfU8crBbLGiZMCt
         YGuPtKHKB1JdAroOvS3tc9BJhHMxPT7BFEjWC2qRLchNtiz8Ik8iYLeeKDIf1c7cwGYQ
         791AKj/YzXhSXzAp1tVx7ER7rlsfUnnlnJ2wsY042No5yWWm/NgRs7XkkMyVInWB5szN
         9LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762076998; x=1762681798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLnEdv1Aj+O6ghd8EMKGqBIoQpaMRjL7FrHMTz+k/js=;
        b=VrmS71cvhYrB6EzsjhYcHH4qYrtw9bQKUYSHkm8xI6+snhaj4+lA+o0D2DAHOv1Y8e
         xFxz7y4TwVsXLmmxZkNU/aZtGRspFaEOEnX+Ux+YOkm768Hjmv7QObrWBY3kcngYCgWe
         pFJhb6qvuE9BUplRcwz6Xp7s82xq1vC29hRs1yRDHSr3pBKSLzc8yhmVidzEDRPhu5mt
         KCm6YfJs6NN1YwOkSvwsKsLBaHKOX2uGh3+6TThd0gEtwi6hiPvtsKGkZ0eHwUAp8zms
         J6CK9x2yI9rM+AVUwXNwlyMYol9/EH5MtCEZWxV/UUfRv2npquz3kzhlqtpQNYuOrZAe
         aH3A==
X-Gm-Message-State: AOJu0YykkRS7WdtykkU8Qmsmt6Fw8RP5RtkJGElrHbWjJ78rl0aC3U5R
	o2Di1nGkAYu/TdkQzW3NAo1o6CL/aQDbcJYpeUdui6tK1FoCAaTEvTmf
X-Gm-Gg: ASbGncvqlucLDpHLaPnyfPNSO60pg5QMA7cSZxO04lMDwJtt84jrAWd+jrzRrEDMDUf
	poDCQg6uZlrt1tk+c1Bvbc9pU8FCWFSirTJAyEs/6ITsudmEVGf1RiZS0q+c0OFx5g9sbOPRtQJ
	bPd5C0y1+maa8IRse7mbKOJdsxd6N4RkQB/PSTcK1JMCzWU0liwIoxttlPrSm5Tu7I0vdGq5vDl
	MqHA62ExLDRX8B7QgH0lYjTUTJq6CI2xCm2v7/m9pUSQZeGR5r7nh3c+w6JTgDqC/unXZYJD1vs
	lGoEH1n3m4nq9ERKScy9mJezAas/2piYznVX9XUTCliDbgpixhFdQn8dUPNXiYu+YerrTD3rkvn
	TmDGvnZ0wEjSxVxQE1nOoYfa6dqATtwRhDUSfJ/vPsVbZMTJDC0E6snsasmcgA4TPmeC0V8JP4B
	fkQJ7VMmpOSRXI4uDd87ZakEo+YXnATXS0WnjlEVlgjif+9iUtFfGnvvXb
X-Google-Smtp-Source: AGHT+IGEB1oC5W8bqUi5NVnEQR/tZnvPiWF/2wnwqLC4TMuxSvT8HcXunME5KnODXeltaFD1eULcDg==
X-Received: by 2002:a05:6a00:6b95:20b0:781:16de:cc0c with SMTP id d2e1a72fcca58-7a778fdf49dmr9112560b3a.19.1762076998081;
        Sun, 02 Nov 2025 01:49:58 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8a76f00sm7452492b3a.12.2025.11.02.01.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:56 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 6AB251123807; Sun,  2 Nov 2025 18:49:49 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	Kenichi Yasukata <kenichi.yasukata@gmail.com>
Subject: [PATCH v12 05/13] um: nommu: seccomp syscalls hook
Date: Sun,  2 Nov 2025 18:49:30 +0900
Message-ID: <ad735edb645ba2b004fe68c4727e69f7beb8ea46.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_014958_839051_03886EDA 
X-CRM114-Status: GOOD (  24.75  )
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


