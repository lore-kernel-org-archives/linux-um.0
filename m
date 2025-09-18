Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83731CAC5A8
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 07:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/LxuGmHlOoWlRMhiUJoe5t/Cd23uhaKelOnBHZQt6CI=; b=S+06iJ7K3BCLexnm1QHHsRmTR/
	DQ1Xn4oY5r8dez5RmyRrET2VQwktpOBBd0nmwkd55aGehchnAoNGvi+FHJDZcYtLHqKqlA2MDNisE
	Z8bjgbrRB+3Pv2Wn4oPz6h0JMNpfxheoNGvhSH0weD6BCbMQZwOeI2ChCuNpimWcnnD6tqpING/L6
	OnYoUgf2GZ2sbKHG/4RaWdQtTMAAJQJIsXaWW72jN+TBM3IOXccxVocJUu3hMdv2yOrT+8GH5H1BO
	yPuxziEVKYcEdiFNE6RVl1zx7QLwmBRR8ksHRAMqYcBYckbtY540z4bFpHkZRU2xg+ScYvwPQ7bER
	mfRBiZgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9En-0000000GZAj-0yoz;
	Thu, 18 Sep 2025 07:39:29 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Ej-0000000GZ78-2QpX
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 07:39:27 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-330469eb750so722459a91.2
        for <linux-um@lists.infradead.org>; Thu, 18 Sep 2025 00:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181165; x=1758785965; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LxuGmHlOoWlRMhiUJoe5t/Cd23uhaKelOnBHZQt6CI=;
        b=gDD5Z59soZysG62oHRk4zISPlMZbeIBJ16NP/zOY+FAzduaYtzbezSoRnIKoAuTSiO
         6KT041xurXG8wC8+I3f13JigjgJyUlXpWKpun6e09iSM7oBcC2vQESfBvua+mw2AumDX
         oph8qO7AkD8B9Q28iTIu/KRf9btKb2xcJ00KBa6IzjB4KSWH7wOXzjoEc9LC7fmYKfjM
         NUpD/AFa+ld1lIiDez0bQbd+IO6iZGIbAtlibz/B/46Bk9mneTwjBEDja8+68MCr1+H8
         pa7jUvn0xLwLQIFxTtGyr3gNNm0DsEcaDZrfWgJRxeysZ/GsbOsFMDTRvbWTKki87BEA
         8azQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181165; x=1758785965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LxuGmHlOoWlRMhiUJoe5t/Cd23uhaKelOnBHZQt6CI=;
        b=WvozdauQht08QcrAxA88PW33DA5Kh1bc49a/7jIbAPmx29fK78STO9d32cG9DJnBxI
         QBTyfk6Nsu0bhsQ568W1DpN0j0E60Ay+E+zNb26HcTITKSCA/iYV66Rq0Yx3r/QtRfYB
         2s+jLkNxOIbm6ibDehipkdyupqH78Dl+fGGxF1DkUI6By1VpmV3dIkDCBKu28xUmbeVk
         63VF/fA2xoObxg8Ce2zeeL5VnyCw3qMOYEJ+woVwb80dEJzM/BBBmj2/yP+pAU6FCG2e
         booIrmEMdUYsyQ0gLcPT8gD4AHU72s7H3DXaarrOLhDx4EUvUSSOGvNEq8TSu2PwE81h
         F/Hw==
X-Gm-Message-State: AOJu0YzJ4plalcDhjFkVCXHrMQ8c64RTEyAzrkpjerdO6/QMHaO62HrC
	EhJrvJPACiItO1srt4ot15U3m+fQmAwn+7gFcP2qJzZzIvwUIwBrjeJm
X-Gm-Gg: ASbGncvTdjKEPptnhsp0+B2otR+Dy31HynS0KEIsmnmS8Mzo/cza9njZVfUE2/GrATC
	VfQLjU2z4fsT7RSUIQi7FvYnIpm7Hhf8JEW3tFcQ4S+BFvhLkP+oengB1f6cwat6sYeexgaSMsW
	JbXGkByri2JnOjbZiAJgE3JpF1QNxHwgoqXF6CpJL4YDS7k7dMCfPF/OgTHb5Qz/F4S4J3yinLy
	P2ueQp74pKSaqptl9HTb0C3Stq6lt6LTDSCIvp1S1mh9/qG6/V3AoMIr0S78FMPFhrBiU/x7tsE
	bSb2nuiQjbGdyO0DCs/Qoz5oqU1iQgZr7/FCnGD/BO4tQhLbYmXQY9pio0HVrkEJs0JFu/u4Nbt
	AWePsj9Y3PeNl9/nStkPJvfx6xGo+0clEvGN2wW+WhYWjjPWyOs7UXAYeknSdv5btldk5mJ5enG
	H0Nk0qK+oX8xI=
X-Google-Smtp-Source: AGHT+IHjf+ft+15WeG7PNqgPVYcTsQiuOkBlrNQyjsBFDIHNYIS3zJGYte1TLc2nd5wBWXx4jfciFg==
X-Received: by 2002:a17:90a:d60c:b0:327:7334:403d with SMTP id 98e67ed59e1d1-32ee3f87ec1mr6370968a91.26.1758181164436;
        Thu, 18 Sep 2025 00:39:24 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed2685fc8sm4648398a91.4.2025.09.18.00.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:23 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id B241E1062104; Thu, 18 Sep 2025 16:39:22 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	Kenichi Yasukata <kenichi.yasukata@gmail.com>
Subject: [PATCH RESEND v11 05/13] um: nommu: seccomp syscalls hook
Date: Thu, 18 Sep 2025 16:39:00 +0900
Message-ID: <45ad2629815a908391762195e77d0fa7ccbe853f.1758181109.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758181109.git.thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_003925_675107_C1C21AEE 
X-CRM114-Status: GOOD (  24.55  )
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
index 00ca3e12fd9a..ec8ba1f13c58 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -66,6 +66,8 @@ extern void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs
 extern void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs,
 		  void *mc);
 extern void fatal_sigsegv(void) __attribute__ ((noreturn));
+extern void sigsys_handler(int sig, struct siginfo *si, struct uml_pt_regs *regs,
+			   void *mc);
 
 void um_idle_sleep(void);
 
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index b35cc8ce333b..1251f08e26d0 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -338,4 +338,14 @@ extern void um_trace_signals_off(void);
 /* time-travel */
 extern void deliver_time_travel_irqs(void);
 
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
index cfbbbf8500c3..e90b8744144a 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -426,6 +426,9 @@ void __init setup_arch(char **cmdline_p)
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
index 11f07f498270..53e276e81b37 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -20,6 +20,7 @@
 #include <um_malloc.h>
 #include <sys/ucontext.h>
 #include <timetravel.h>
+#include <linux/compiler_attributes.h>
 
 void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *, void *mc) = {
 	[SIGTRAP]	= relay_signal,
@@ -30,6 +31,7 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *, void *mc) =
 	[SIGSEGV]	= segv_handler,
 	[SIGIO]		= sigio_handler,
 	[SIGCHLD]	= sigchld_handler,
+	[SIGSYS]	= sigsys_handler,
 };
 
 static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
@@ -176,6 +178,11 @@ static void sigusr1_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
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
@@ -187,6 +194,7 @@ static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
 	[SIGILL] = sig_handler,
 	[SIGFPE] = sig_handler,
 	[SIGTRAP] = sig_handler,
+	[SIGSYS] = sig_handler,
 
 	[SIGIO] = sig_handler,
 	[SIGWINCH] = sig_handler,
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index a827c2e01aa5..4e1f05360c49 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -238,7 +238,7 @@ extern unsigned long *exec_fp_regs;
 
 __initdata static struct stub_data *seccomp_test_stub_data;
 
-static void __init sigsys_handler(int sig, siginfo_t *info, void *p)
+static void __init _sigsys_handler(int sig, siginfo_t *info, void *p)
 {
 	ucontext_t *uc = p;
 
@@ -273,7 +273,7 @@ static int __init seccomp_helper(void *data)
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


