Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF59E77187
	for <linux-um@archiver.kernel.org>; Thu, 12 Dec 2024 10:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bo9Gtzd2WAkYZxq0ZjtLa1K659fmyLVoVdU/3PYJdNI=; b=b7Hne3fEf3YJg1YvMG+cQxuQQa
	tVIkBF45CWoJBJ188qnbtOscwDx4Aie/qzuvN1RdB0blrFaxmIGI/HZZ+H5zDYOsAAdZ250mb3jhn
	7x0uTIIgtaFVI2abXVI1s3080IBa5qxj3Lry28LiWp19a15MVqsFkUXNDVmdcoHq2LV6QMX5FOYmR
	X5djA3uskfukW61UwcYQ+7t3lgrjfUUj+JIoSVBh+fAbh3KjSHV0PYVV8D1EnLVDmE45V3+nD3qez
	XbdUMXIOw+w8WirMo5HwYUT17q4uI6WhD1w5+kgShcUYtu+JXgneXaVPpv68psLtU//SjylRil/09
	GLAV4lJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgDe-000000001Qz-415Q;
	Thu, 12 Dec 2024 10:14:54 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgDF-000000001J4-3526
	for linux-um@lists.infradead.org;
	Thu, 12 Dec 2024 10:14:31 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-21675fd60feso4584015ad.2
        for <linux-um@lists.infradead.org>; Thu, 12 Dec 2024 02:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733998469; x=1734603269; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bo9Gtzd2WAkYZxq0ZjtLa1K659fmyLVoVdU/3PYJdNI=;
        b=kDD0i0xNICWIe2PIu1lNUdWyW28KYPWgtrcLDewG8YgY+7vjU9UCMOn4nqxa3dXLcx
         CCdiOuEi0m4hOe5neD3Ed2iy2AICvR3K1yPIz2wrwao6s3kcWr6A3Sy3nrOZRmEOVh5M
         nEKH6b7AHdS01Qo5FJbnTi2FItkl1/Bb0ntyI6y3G4twNnO6JCap+k7HR+VP8pmodmwg
         nN8CfGBpc2L5zDIf9vSR3gCTKonEUUXqDqc0lxEoFfxGdJn9IyR+kNuYZG2RBf5syV6k
         DWjljbcg7L8xnHxf+1/QQs0dA7R/USxYo3/leDQDUHQILnca/MFlZ+sUrKZlhfUg9AGr
         2GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998469; x=1734603269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bo9Gtzd2WAkYZxq0ZjtLa1K659fmyLVoVdU/3PYJdNI=;
        b=FlKLAzd8vlZcj207ZXrPPSM6tEI+JDNYL3BKifl4YkVYn3iahPD94WtZASGE778DJs
         RQ9JmzjQ4EqXWIHnescpQ+RZ3JsT0I6iAtyd7wfcyCZdy+t2SMt+MKPtGPu6EELZHENZ
         HOvqaUH3GkRtjaKbhluRFfYLJ2iQGWI0+vNr5/FFA1s2PN5ak9C26ALUR9GZ7o3a3YIQ
         G6Ikuqcu/wTVcsaxOEGsYxKP9SK51d3m34zVY3s7TZrbv5lycq2LYgCoX/YZf7jGcmfh
         3tSxVyaTbpOTbDRlHt1o+2lEqIYUQ8TRwsShl28pM2lC3dGYjMNiGpWoTgBdyumK/F9v
         5WSQ==
X-Gm-Message-State: AOJu0Ywp1eaIz9o/TkgL9v0nIrBZXRCuFZ+KZ0h4qdvh/Yng0peG5zbJ
	qsTqTPmXwF26Kp8nZOrYPXXeWRvpZdLkBGHqc2shfpjgzU6n8vxNO4dpYA==
X-Gm-Gg: ASbGncu/Bm8Xf3bw7cofWWoy4pEfXWyDaBliApDurG+xylyN7FyVKnsa0lRj+qfSCOL
	U8fp9zD4KunZ+ll6hbaLWGCCDIFoNNdfHSaECYKLv8CPhLL4nOdWm0Lc3VJHzKv03ePyEJPAa7v
	uZ0VBVscgN5wYWuDOR0UNnm1WeYnhLKLtyOIlWvANejQ0I8aA8XiRdECIWGXZSvy9tXNGQZ4oVo
	blk27jBRLa6fO+u9hAjXP2Cwtf6e3tDDsRheLKX7AvelFRckVgaBCStarG49jM9Ugg9HE2sQ0k7
	/mM6/LqBbhruQUbCJihTpdK1pdk=
X-Google-Smtp-Source: AGHT+IFd4e/1zpqLskzS7PKJXa5HD9weMbPD2DtV7mtTkdAf3GdYXKoDoQDlFHqj49Qbr4zxJ7RRyg==
X-Received: by 2002:a17:90b:394a:b0:2ee:53b3:3f1c with SMTP id 98e67ed59e1d1-2f13925ad16mr5244173a91.5.1733998468718;
        Thu, 12 Dec 2024 02:14:28 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142de7ddfsm889993a91.26.2024.12.12.02.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:14:28 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id BA008DDEEC8; Thu, 12 Dec 2024 19:14:26 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	Kenichi Yasukata <kenichi.yasukata@gmail.com>
Subject: [PATCH v5 06/13] um: nommu: seccomp syscalls hook
Date: Thu, 12 Dec 2024 19:12:13 +0900
Message-ID: <9d50f8e485077bd00b95937644db55cbe4ba2ace.1733998168.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733998168.git.thehajime@gmail.com>
References: <cover.1733998168.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_021429_775932_27595AAE 
X-CRM114-Status: GOOD (  20.31  )
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

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Kenichi Yasukata <kenichi.yasukata@gmail.com>
---
 arch/um/include/shared/kern_util.h    |  8 +++
 arch/um/include/shared/os.h           | 10 +++
 arch/um/kernel/um_arch.c              |  3 +
 arch/um/nommu/Makefile                |  3 +
 arch/um/nommu/os-Linux/Makefile       |  7 +++
 arch/um/nommu/os-Linux/signal.c       | 15 +++++
 arch/um/os-Linux/Makefile             |  5 ++
 arch/um/os-Linux/seccomp.c            | 87 +++++++++++++++++++++++++++
 arch/um/os-Linux/signal.c             |  6 ++
 arch/x86/um/nommu/Makefile            |  2 +-
 arch/x86/um/nommu/os-Linux/Makefile   |  6 ++
 arch/x86/um/nommu/os-Linux/mcontext.c | 13 ++++
 arch/x86/um/shared/sysdep/mcontext.h  |  3 +
 13 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/nommu/Makefile
 create mode 100644 arch/um/nommu/os-Linux/Makefile
 create mode 100644 arch/um/nommu/os-Linux/signal.c
 create mode 100644 arch/um/os-Linux/seccomp.c
 create mode 100644 arch/x86/um/nommu/os-Linux/Makefile
 create mode 100644 arch/x86/um/nommu/os-Linux/mcontext.c

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index f21dc8517538..1dd3d02c4e39 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -67,4 +67,12 @@ void um_idle_sleep(void);
 
 void kasan_map_memory(void *start, size_t len);
 
+#ifdef CONFIG_MMU
+static inline void arch_sigsys_handler(int sig, struct siginfo *si, void *mc)
+{
+}
+#else
+extern void arch_sigsys_handler(int sig, struct siginfo *si, void *mc);
+#endif
+
 #endif
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 5babad8c5f75..d29b967a009e 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -334,4 +334,14 @@ extern void um_trace_signals_off(void);
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
index 62ddb865eb91..f56f14eaefc5 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -432,6 +432,9 @@ void __init setup_arch(char **cmdline_p)
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
index 000000000000..68833c576437
--- /dev/null
+++ b/arch/um/nommu/os-Linux/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y := signal.o
+USER_OBJS := $(obj-y)
+
+include $(srctree)/arch/um/scripts/Makefile.rules
+USER_CFLAGS+=-I$(srctree)/arch/um/os-Linux
diff --git a/arch/um/nommu/os-Linux/signal.c b/arch/um/nommu/os-Linux/signal.c
new file mode 100644
index 000000000000..844f6c840902
--- /dev/null
+++ b/arch/um/nommu/os-Linux/signal.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <signal.h>
+#include <kern_util.h>
+#include <os.h>
+#include <sysdep/mcontext.h>
+#include <sys/ucontext.h>
+
+void arch_sigsys_handler(int sig, struct siginfo *si, void *ptr)
+{
+	mcontext_t *mc = (mcontext_t *) ptr;
+
+	/* hook syscall via SIGSYS */
+	mc_set_sigsys_hook(mc);
+}
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 331564888400..6bfdfec8cbcc 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -21,4 +21,9 @@ USER_OBJS := $(user-objs-y) elf_aux.o execvp.o file.o helper.o irq.o \
 	main.o mem.o process.o registers.o sigio.o signal.o start_up.o time.o \
 	tty.o umid.o util.o
 
+ifneq ($(CONFIG_MMU),y)
+obj-y += seccomp.o
+USER_OBJS += seccomp.o
+endif
+
 include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/um/os-Linux/seccomp.c b/arch/um/os-Linux/seccomp.c
new file mode 100644
index 000000000000..d1cfa6e3d632
--- /dev/null
+++ b/arch/um/os-Linux/seccomp.c
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
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 9ea7269ffb77..97efdabe1e45 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -172,12 +172,18 @@ void register_pm_wake_signal(void)
 	set_handler(SIGUSR1);
 }
 
+static void sigsys_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
+{
+	arch_sigsys_handler(sig, unused_si, mc);
+}
+
 static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
 	[SIGSEGV] = sig_handler,
 	[SIGBUS] = sig_handler,
 	[SIGILL] = sig_handler,
 	[SIGFPE] = sig_handler,
 	[SIGTRAP] = sig_handler,
+	[SIGSYS] = sigsys_handler,
 
 	[SIGIO] = sig_handler,
 	[SIGWINCH] = sig_handler,
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
index 000000000000..d74bc0726a28
--- /dev/null
+++ b/arch/x86/um/nommu/os-Linux/mcontext.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/ucontext.h>
+#define __FRAME_OFFSETS
+#include <asm/ptrace.h>
+#include <sysdep/ptrace.h>
+#include <sysdep/mcontext.h>
+#include <sysdep/syscalls.h>
+
+void mc_set_sigsys_hook(mcontext_t *mc)
+{
+	mc->gregs[REG_RCX] = mc->gregs[REG_RIP];
+	mc->gregs[REG_RIP] = (unsigned long) __kernel_vsyscall;
+}
diff --git a/arch/x86/um/shared/sysdep/mcontext.h b/arch/x86/um/shared/sysdep/mcontext.h
index b724c54da316..3f2dc3a2995c 100644
--- a/arch/x86/um/shared/sysdep/mcontext.h
+++ b/arch/x86/um/shared/sysdep/mcontext.h
@@ -7,6 +7,9 @@
 #define __SYS_SIGCONTEXT_X86_H
 
 extern void get_regs_from_mc(struct uml_pt_regs *, mcontext_t *);
+#ifndef CONFIG_MMU
+extern void mc_set_sigsys_hook(mcontext_t *mc);
+#endif
 
 #ifdef __i386__
 
-- 
2.43.0


