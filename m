Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF291C02188
	for <linux-um@archiver.kernel.org>; Mon, 20 Jan 2025 06:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9nlvluS4ccE9tRZULPw8Ah8AuWKOOepgswJjzjFXV1o=; b=bKwc4f5j+8vQeVNp2DStfxE6SQ
	HfpS2TkRX2kfEWDUVCiX5h3vAMrdiThskKVn7RjdHRDpwiayf0F5ue3GBUOu4JgTbRwZVdWT3aEXN
	95kkN4sdm+Yylt2LKhy3akS67ESxXIkY9G/mm6IbXbpkjvWUdXVW1/4qV5Zbp5aB5P0F+3sGjYR/k
	hraulrlN37xL5sNpJt8j+3Xvjo5ct7tnZ+1aOA0t47pbJBgmyZmnqTjjOcDQoWgyae2iBJCXbNfEJ
	063VsJLzzVEp7f+/Sgnxq8n6xzygqnPWWoQzBrfzagLkzvli0ajpEYlCdjKhlPouFPA5NMz1NWCJp
	K4zFaoTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkr1-00000004nPK-25Ob;
	Mon, 20 Jan 2025 06:01:43 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkpv-00000004nFt-25tX
	for linux-um@lists.infradead.org;
	Mon, 20 Jan 2025 06:00:36 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so5186150a91.3
        for <linux-um@lists.infradead.org>; Sun, 19 Jan 2025 22:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737352834; x=1737957634; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nlvluS4ccE9tRZULPw8Ah8AuWKOOepgswJjzjFXV1o=;
        b=W38uuBjQyDUOtVTWr2FjT5qYmlq8IJOdKJk5krSSCdhC1OyKIlfLxeX8tu4Dc1Bk4L
         4R/IX7ALsSbiE3MOxDKWzznZGaN1mK+BruWqUSwY8S8fZlJsW5qLbmA53mcVPNOcYqjF
         cAj1Qp++gK3S8MJIN+f0mkXXH1Zw4IBlabvt6O7bjfZxYMNWH6ACPnSGuQziJMYAkXD5
         5voROdqj4fpQYtzgoJExm1qb+Oos5Fk1Rnd0CTTBva2vYQ5HG2FGZwt2IsuDgnKzs9fZ
         xHn73RcL88JtNqcXKY2r1j5hG3cFOHhROhqc0gzs4jDGty9M1cUu0X1tgmfZcVWVZ8wx
         62wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737352834; x=1737957634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nlvluS4ccE9tRZULPw8Ah8AuWKOOepgswJjzjFXV1o=;
        b=fSAq1Ijzj9ha7tH3XCPY7QdBuh/81wUNSFyl2PLcqnO8z9Yg+xrms8Cy3e0kAlcwH8
         z/Sliou6zLTaZgDmF7veGuIw87TnFWE27SqK5fEJdwCA0RiMg7FD9DuCIIGYTacJ1yjc
         /CP4x88TsmKW/xzjU4Wvzeic4oCcu0MEyL5AgvNOpOtGhS5ZN8VpvAM7bDJdU6XVaBYO
         jK6J0demC2uoZq558ywY7GPVlI2WdOKHZuZLpsZbg+ic0fcAjCDDpSVz0giftm0bZdmu
         0cdq9h9kzkBuuRtaV6rsb/HmGfTNbWFD8V4hYUt13IfRAP+maTjNn3n94l7tmVjIFELy
         9x1A==
X-Gm-Message-State: AOJu0YzfPrZpt9kegQG2S8aNzaPM+6cbgtTPM6ClycZukD7ahVSbHioe
	w1Ve2L4zmhm5SGbBeFgZ3dTa2dv6S0NrWbRHfhg6qWGF7WNm80Eg
X-Gm-Gg: ASbGncvpQmxIMw5RzEnRMvPz/1Kd+9Qn1/TLuwmz+poZ/lyb8vrwpijSB7CqTeDifmP
	AfBdrydT9JDfO1s3iU1OrZgj5l4nxlbBOuEGlVZq6apSZNQTBCM1zvdeQkIeVUr93EDCgob6y6E
	EtAAdXxIxRDwwDJii0k0wtuyQa+Pa84Il8fEVPPgKjUiBZAb9Td1MjzLURdaYdF3MdpneHMuPbc
	k3w6sb/x0SwI/k7eb6zg+TbxgwiO4YZw0Vlgc+LeBB2fXIrally719Uaj63dHTCvpbL1V1t8jah
	ApNNZwtqgqDRDTj5KencA93vkd8dS0nNxENG1kNzDQ==
X-Google-Smtp-Source: AGHT+IEUJaMV+IkiWrK8vtCBtgTFnELiFY/pQrttNNoKjKfuLJ4UNZS5689APxo7s0NcNUns8qxdbA==
X-Received: by 2002:a05:6a00:240b:b0:728:b601:86df with SMTP id d2e1a72fcca58-72daf953cf5mr16381270b3a.10.1737352834422;
        Sun, 19 Jan 2025 22:00:34 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9c8d8esm6097964b3a.117.2025.01.19.22.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:00:33 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 4125DE2752E; Mon, 20 Jan 2025 15:00:31 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	Kenichi Yasukata <kenichi.yasukata@gmail.com>
Subject: [PATCH v7 06/13] um: nommu: seccomp syscalls hook
Date: Mon, 20 Jan 2025 15:00:08 +0900
Message-ID: <de41ec27f004033ed7fec94d4c910e2b1121b0ff.1737348399.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737348399.git.thehajime@gmail.com>
References: <cover.1737348399.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250119_220035_540875_39449621 
X-CRM114-Status: GOOD (  20.43  )
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
index 79ea97d4797e..dc7efccbcb63 100644
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
index 000000000000..1674962e509d
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
+	set_mc_sigsys_hook(mc);
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
index 000000000000..c4ef877d5ea0
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
+void set_mc_sigsys_hook(mcontext_t *mc)
+{
+	mc->gregs[REG_RCX] = mc->gregs[REG_RIP];
+	mc->gregs[REG_RIP] = (unsigned long) __kernel_vsyscall;
+}
diff --git a/arch/x86/um/shared/sysdep/mcontext.h b/arch/x86/um/shared/sysdep/mcontext.h
index b724c54da316..15e9ff287021 100644
--- a/arch/x86/um/shared/sysdep/mcontext.h
+++ b/arch/x86/um/shared/sysdep/mcontext.h
@@ -7,6 +7,9 @@
 #define __SYS_SIGCONTEXT_X86_H
 
 extern void get_regs_from_mc(struct uml_pt_regs *, mcontext_t *);
+#ifndef CONFIG_MMU
+extern void set_mc_sigsys_hook(mcontext_t *mc);
+#endif
 
 #ifdef __i386__
 
-- 
2.43.0


