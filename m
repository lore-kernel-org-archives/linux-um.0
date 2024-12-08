Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D294BE77173
	for <linux-um@archiver.kernel.org>; Sun,  8 Dec 2024 10:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BdNHiNkkdl0GAkNbTj7mVX00LJJb4zg3gw9ngaB48Xs=; b=AEiHu6219R144jtZxYcJnLzFKs
	cFC2/l1ltXrxOR3QjWrNIOl7gInnSgecvMqBo+5SnIZKpoks1kx7tLTdLjOIYEngiTgIMyYEuM1Ip
	xCZTUzw0IgKxFq0fUvZSwJdiF26hJsSMklwJ2CZoziXTVKH5Ec1NOl0T+kfXfWZmDRWgBZamFppJ4
	kT1dUxAXf8g/UEmw5dBqrK0LYv6nJQqUCFn9y7N7vAYo3lWopo/Y305Br9Ymq6IGJ3ShMW92qN4Xa
	Knyn5w+GaJe3xtsjxWNtmFvOGoPv4f3k0mqFg2STNIETDi5OCfdz0b3UROlW70BBavMfFg3TTSp26
	NmTjrn9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKk-000000057aW-2Pnh;
	Sun, 08 Dec 2024 10:16:14 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKh-000000057Zk-3gmY
	for linux-um@lists.infradead.org;
	Sun, 08 Dec 2024 10:16:13 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2ee51c5f000so2478912a91.0
        for <linux-um@lists.infradead.org>; Sun, 08 Dec 2024 02:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733652971; x=1734257771; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdNHiNkkdl0GAkNbTj7mVX00LJJb4zg3gw9ngaB48Xs=;
        b=Rsn5ZZ/4oT+ueNhYiqu7NOnwHOn4DiCXMbYv9a7+3Tjbekiaa/RuvDAHNd3Jy799M6
         9UnqAT4HfLutNxT3ArrNFiJzcA3gjMe5Y4+b3eAv7lh+ATuay03bQ5MoKHnfsmeH22x1
         f5b/ErEmZmxTFukkx1Pxf0D5CzLlSl4z5jrQ6IH1aeftvR/VtWsODV//TwfYwz5AVHp+
         Gqq34Hqdtn50R+K4/735yAIGtnjaAkX07ni+EcFOMV48GXnU/2aT5ObhBGvXWQYMSWBy
         sQk/1Hk/+Ee1UGFCUr+GD3AN9Du5C5n3284S839blQFrQYhbWziKRocLK8WxLdcXEdaR
         Gphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733652971; x=1734257771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdNHiNkkdl0GAkNbTj7mVX00LJJb4zg3gw9ngaB48Xs=;
        b=erLtT9ps+hm0nsbeyjb4wldaotE+Z/9QAU89oY86JHUQXel/syncqYfPIf8Frzhfsf
         /Ltyb1Cau7p/GvpTGCtFCThutoqb76dJYi63NH87W+NSBHYOTNmT24SHqX5gIzM3z9Cn
         j8t2u8Q4DgJjQw2hMx9K+4bTcM9/ra7hIaDbvpsi3uxuBe/xLXl2G0l24ORjsuNh+2Lm
         hTCglqFa9RIrd3YghUzZ5H3O8+/UORqOr5AbZUQ+r8Gmx8uTkeq/iWKgran48+eiwuOZ
         3k2TCTO7n+tBX8rsEqDcsePaz+tGPZalUqArWiGZCCUVkSJbeUrgSX4jXf234yjJ2EIw
         4zeA==
X-Gm-Message-State: AOJu0Yy2gO4flTRtNMYkYEB/WyRZeDz+Bk/HuXs8JnyhmWF2iR1IydIi
	9qYqCX+HkwJWI1GpYOkhFzKG6usQaKu922FczeVbZimLg408JoJMFagw3g==
X-Gm-Gg: ASbGnctjiESbOBQXl8P2G1H0LvdQ1tUNQ5DR5hjjJnZG8DiydkkTKs8ZYTQBc26E2pB
	ogcP1n7NyUe6UrjJPHKZ8ny2FAw0PLDitkzr09xE672KW5n/ylCXivsxbMa+YI0gfNtH9vXXxSR
	Xv0rFn0KreF9TkaFsyk5WDiWD4X1BWn84Kht6C05Y4SxWwDc4UFBo1N9Q2PRk67QsIasXxXekX4
	FPQ/hnuhQE+pYUNfPhkDALyOZVSwvKdkwo+FsoXtk1WT0S+FT7vxKf/UEdNMhCLz6nP1Dz29dEc
	D7rShVUyx9COAFLojxVL
X-Google-Smtp-Source: AGHT+IEtgXfxQZPDwEXVJr6lOubKCxjBHW9MOGg7P9gZWg5bBycNCYoqXxQKONJkgwY0YUrxl1t7Cw==
X-Received: by 2002:a17:90b:3f04:b0:2ee:c457:bf91 with SMTP id 98e67ed59e1d1-2ef69e15592mr13778533a91.10.1733652970937;
        Sun, 08 Dec 2024 02:16:10 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eeffb6035esm6404459a91.0.2024.12.08.02.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 02:16:10 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 146C6DDB02A; Sun,  8 Dec 2024 19:16:08 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	Kenichi Yasukata <kenichi.yasukata@gmail.com>
Subject: [PATCH v4 06/13] um: nommu: seccomp syscalls hook
Date: Sun,  8 Dec 2024 19:15:33 +0900
Message-ID: <8b0505273d16a5cfa9c022f94ed03a786d96ddbc.1733652929.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733652929.git.thehajime@gmail.com>
References: <cover.1733652929.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_021611_941957_626FD658 
X-CRM114-Status: GOOD (  20.30  )
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
(UML) kernel, then call the syscall entry point, __kernel_vsyscall, to
hook the original syscall instructions.

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
 arch/x86/um/nommu/os-Linux/mcontext.c | 15 +++++
 arch/x86/um/shared/sysdep/mcontext.h  |  3 +
 13 files changed, 169 insertions(+), 1 deletion(-)
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
index 000000000000..d05722307acb
--- /dev/null
+++ b/arch/x86/um/nommu/os-Linux/mcontext.c
@@ -0,0 +1,15 @@
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
+	mc->gregs[REG_RSP] -= sizeof(unsigned long);
+	*((unsigned long *) (mc->gregs[REG_RSP])) = mc->gregs[REG_RIP];
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


