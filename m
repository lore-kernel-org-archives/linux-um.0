Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22F4E6C5FB
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 04:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9OXc5GevJFqmJH4Ems3oVffALittGri3wWBMP6OZ4zQ=; b=VIEnbagvuMSPuqcj15oKEgLVC0
	hOZareOAs0WsUbzlzxK2TBI9ZBA/OcMaoUXtU6Hj/xK0jHcjClhFzVc9S5sfAG2ClKVAZNOJNRO9E
	ZsxaCfefVxthvpnRxM5dQqtABqgnYMWQu+fS7NYdY2YSblZhHiNbC0DyF0UNhGIRnoDcjjjgu/waF
	ZHEcsS0IgxSFqgZX6G05x0VbESIf48ByI9TQF93UaNZkDhPf8ac0XD5c7HaF8cQZiz2p3IpakReXp
	UgqdzaO7C1yuWyVrVxvpd9/rgu90IoOwazwjUF7emVh4+oIrZYdPACN/kKG/2dLVSuH+RZFSydI1x
	5uOMynXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKRw-00000008DPE-1lFo;
	Tue, 03 Dec 2024 04:23:48 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKRt-00000008DO6-3LaZ
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 04:23:46 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-215b13e9ccbso10030575ad.0
        for <linux-um@lists.infradead.org>; Mon, 02 Dec 2024 20:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733199825; x=1733804625; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OXc5GevJFqmJH4Ems3oVffALittGri3wWBMP6OZ4zQ=;
        b=QaaCHJidYDRz9YkuaoJLQVd33MQ2k8H17KSjXgE0oYCdDcnA2U5bNk/Qhj23z9qWmA
         6PIPMAz/2y5ldp5ZrschTxkfBB+rL8f7EQKvy+GQ4Jk434rqhRPOq4kzhESFWrqpW2sX
         H7AGlY9XbQ/ADOoAS5KU1cNYoND5rHtRPOFyLJrsBrFpbkEexPHZ4pDN3zcaqcPq+1mt
         fijWYUSNHY+gyY6OVqSflqKbJQ3QWXyeIbcr1evYdEjSe11BaCIAOzDRcg0/JbABL1IK
         6apQeZ8YjEVxuOATWMJbdJOEDqe2WrGS7buF9XhNEPv6P9OGRgR5sd2M/PJiz2GyQUDG
         wNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733199825; x=1733804625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OXc5GevJFqmJH4Ems3oVffALittGri3wWBMP6OZ4zQ=;
        b=vRR48tlj/Y6+vvVnpXmnVeDHj8RYqwZljKStILQ/LFp9AP2Fe/SLpHUjV9MRG3s7Hi
         x4YWMTh5RuACgY4b3ugIUs4ywCYrtFmZb6d25fetF9eAo8VZm8b1SF7z7y6eCZe++q/u
         IrvAW6Z21vcbMXtvS3mygcDxzbz1fCJVaeM0DqBLkMddFzdG+pAPt+Tq7OBY2NKJWsVq
         vB9FJ1t6uI5XOzCFDP5ykbZ5pWVDiKjM40fcHQMenT39cfbmRstYUltyUMZXHbmfyGaZ
         80vLqcSOd0oolvEjb7ZmTbSZKQ+LBSRVkMZMrwfkSIzlBSmThiUjFBYpqwxRQ4OV2a2n
         hg1Q==
X-Gm-Message-State: AOJu0YxlXGIsu6sHalz17AWdixhazxAlmcis7cxjZEIz1qmgH1A5YIx7
	XSKqbqJ5kNbGBOfXtm0SXJpoIqci8y+SN0/i5noaznr2S7y45OAA6s640g==
X-Gm-Gg: ASbGncvhlMUk3bAiS5UympMU8HgyiP4rPhSunmLYllnBhp3oLMr9uerKCYiExO7ATzX
	99KT2etO90WmuyGAyMjB1MxoMFSvDVv2q8n+xOr0S7+hTz2ndHs+hjXVnTTPI9i6ZZrDB894V7X
	ThTVkjNwg3KzYuEyq/pLTPLNoad6ubUj/39qVJG45Sp0hNomIwZTRMUgCgsJOfNtQOSWAIt+GMx
	u1BegBomBzntTOJLFrxVpYNoaRfcsi7GtbXwTItR1MrDJLdAZHqlTNA+pmiRCE88vDBiHlFMKSA
	phZAyELy4KBoMCD3Z1u6
X-Google-Smtp-Source: AGHT+IFWlQizpIbmxQ38I/+/3nxfQawrERiTxbn58Bpidste/ob7Wr3ylhQ0khaUXfxtNf2GPRpR/w==
X-Received: by 2002:a17:902:ecc9:b0:215:931c:8fa7 with SMTP id d9443c01a7336-215bd0f88f6mr14967155ad.31.1733199824666;
        Mon, 02 Dec 2024 20:23:44 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2158f38c849sm28841665ad.104.2024.12.02.20.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:23:43 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 88F63DD3A03; Tue,  3 Dec 2024 13:23:42 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	Kenichi Yasukata <kenichi.yasukata@gmail.com>
Subject: [PATCH v3 06/13] um: nommu: syscalls handler from userspace by seccomp filter
Date: Tue,  3 Dec 2024 13:23:05 +0900
Message-ID: <f1aed0f9233f49880510e9506deddd52b33c2fc6.1733199769.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_202345_839470_501A5E45 
X-CRM114-Status: GOOD (  20.20  )
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

This commit adds syscall handlers with seccomp, which has two functions.

1) syscall hooks issues from userspace memory ($rip), and 2) prevent
syscall and report when zpoline is used as zpoline cannot translate
syscall/sysenter instructions by 1) dlopen-ed code containing syscall
instructions, or 2) JIT-generated code.

The SIGSYS signal is raised upon the execution from uml_reserved and
high_physmem, which locates userspace memory.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Kenichi Yasukata <kenichi.yasukata@gmail.com>
---
 arch/um/include/shared/kern_util.h   |  2 +
 arch/um/include/shared/os.h          |  6 +++
 arch/um/kernel/trap.c                | 12 +++++
 arch/um/kernel/um_arch.c             |  4 ++
 arch/um/os-Linux/process.c           | 78 ++++++++++++++++++++++++++++
 arch/um/os-Linux/signal.c            | 22 ++++++++
 arch/x86/um/os-Linux/mcontext.c      | 22 ++++++++
 arch/x86/um/shared/sysdep/mcontext.h |  4 ++
 arch/x86/um/zpoline.c                | 15 ++++++
 9 files changed, 165 insertions(+)

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index f21dc8517538..9b26386dd2ea 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -67,4 +67,6 @@ void um_idle_sleep(void);
 
 void kasan_map_memory(void *start, size_t len);
 
+extern void trap_sigsys(struct uml_pt_regs *regs);
+
 #endif
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 6874be0c38a8..c979a8b15434 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -220,6 +220,9 @@ extern int os_unmap_memory(void *addr, int len);
 extern int os_drop_memory(void *addr, int length);
 extern int can_drop_memory(void);
 extern int os_mincore(void *addr, unsigned long len);
+#ifndef CONFIG_MMU
+extern int os_setup_seccomp(void);
+#endif
 
 void os_set_pdeathsig(void);
 
@@ -252,6 +255,9 @@ extern void register_pm_wake_signal(void);
 extern void block_signals_hard(void);
 extern void unblock_signals_hard(void);
 extern void mark_sigio_pending(void);
+#ifndef CONFIG_MMU
+extern int um_zpoline_enabled;
+#endif
 
 /* util.c */
 extern void stack_protections(unsigned long address);
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index a7519b3de4bf..f23ba7f9a82d 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -310,3 +310,15 @@ void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 {
 	do_IRQ(WINCH_IRQ, regs);
 }
+
+void trap_sigsys(struct uml_pt_regs *regs)
+{
+	struct task_struct *tsk = current;
+
+	pr_info_ratelimited("%s%s[%d]: sigsys ip %p sp %p\n",
+			    task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG,
+			    tsk->comm, task_pid_nr(tsk),
+			    (void *)UPT_IP(regs), (void *)UPT_SP(regs));
+
+	force_sig(SIGSYS);
+}
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 62ddb865eb91..d89752bf5be0 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -432,6 +432,10 @@ void __init setup_arch(char **cmdline_p)
 		add_bootloader_randomness(rng_seed, sizeof(rng_seed));
 		memzero_explicit(rng_seed, sizeof(rng_seed));
 	}
+
+#ifndef CONFIG_MMU
+	os_setup_seccomp();
+#endif
 }
 
 void __init arch_cpu_finalize_init(void)
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index ef1a2f0aa06a..4e0b21b4b00c 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -17,7 +17,11 @@
 #include <asm/unistd.h>
 #include <init.h>
 #include <longjmp.h>
+#include <as-layout.h>
 #include <os.h>
+#include <sys/prctl.h>
+#include <linux/filter.h>
+#include <linux/seccomp.h>
 
 void os_alarm_process(int pid)
 {
@@ -209,3 +213,77 @@ void os_set_pdeathsig(void)
 {
 	prctl(PR_SET_PDEATHSIG, SIGKILL);
 }
+
+#ifndef CONFIG_MMU
+int os_setup_seccomp(void)
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
+		exit(-1);
+	}
+
+	set_handler(SIGSYS);
+
+	os_info("seccomp: filter syscalls in the range: 0x%lx-0x%lx\n",
+		__userspace_start, __userspace_end);
+
+	return 0;
+}
+#endif
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 9ea7269ffb77..c0d1fb1fc0c4 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -20,6 +20,25 @@
 #include <um_malloc.h>
 #include <sys/ucontext.h>
 #include <timetravel.h>
+#include <init.h>
+
+#ifndef CONFIG_MMU
+static void sigsys_handler(int sig, struct siginfo *si, mcontext_t *mc)
+{
+	struct uml_pt_regs r;
+
+	if (!um_zpoline_enabled) {
+		/* hook syscall via SIGSYS */
+		mc_set_sigsys_hook(mc);
+	} else {
+		/* trap SIGSYS to userspace */
+		get_regs_from_mc(&r, mc);
+		trap_sigsys(&r);
+		/* force handle signals after rt_sigreturn() */
+		mc_set_regs_ip_relay(mc);
+	}
+}
+#endif
 
 void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 	[SIGTRAP]	= relay_signal,
@@ -178,6 +197,9 @@ static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
 	[SIGILL] = sig_handler,
 	[SIGFPE] = sig_handler,
 	[SIGTRAP] = sig_handler,
+#ifndef CONFIG_MMU
+	[SIGSYS] = sigsys_handler,
+#endif
 
 	[SIGIO] = sig_handler,
 	[SIGWINCH] = sig_handler,
diff --git a/arch/x86/um/os-Linux/mcontext.c b/arch/x86/um/os-Linux/mcontext.c
index e80ab7d28117..d876e34a9c7a 100644
--- a/arch/x86/um/os-Linux/mcontext.c
+++ b/arch/x86/um/os-Linux/mcontext.c
@@ -4,6 +4,7 @@
 #include <asm/ptrace.h>
 #include <sysdep/ptrace.h>
 #include <sysdep/mcontext.h>
+#include <sysdep/syscalls.h>
 
 void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 {
@@ -31,3 +32,24 @@ void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 	regs->gp[CS / sizeof(unsigned long)] |= 3;
 #endif
 }
+
+#ifndef CONFIG_MMU
+static void userspace_sigreturn(void)
+{
+	__asm__ volatile("movq $15, %rax");
+	__asm__ volatile("call *%0" : : "r"(__kernel_vsyscall) :);
+}
+
+void mc_set_regs_ip_relay(mcontext_t *mc)
+{
+	mc->gregs[REG_RIP] = (unsigned long) userspace_sigreturn;
+}
+
+void mc_set_sigsys_hook(mcontext_t *mc)
+{
+	mc->gregs[REG_RSP] -= sizeof(unsigned long);
+	*((unsigned long *) (mc->gregs[REG_RSP])) = mc->gregs[REG_RIP];
+	mc->gregs[REG_RCX] = mc->gregs[REG_RIP];
+	mc->gregs[REG_RIP] = (unsigned long) __kernel_vsyscall;
+}
+#endif
diff --git a/arch/x86/um/shared/sysdep/mcontext.h b/arch/x86/um/shared/sysdep/mcontext.h
index b724c54da316..0e837f4b5757 100644
--- a/arch/x86/um/shared/sysdep/mcontext.h
+++ b/arch/x86/um/shared/sysdep/mcontext.h
@@ -7,6 +7,10 @@
 #define __SYS_SIGCONTEXT_X86_H
 
 extern void get_regs_from_mc(struct uml_pt_regs *, mcontext_t *);
+#ifndef CONFIG_MMU
+extern void mc_set_sigsys_hook(mcontext_t *mc);
+extern void mc_set_regs_ip_relay(mcontext_t *mc);
+#endif
 
 #ifdef __i386__
 
diff --git a/arch/x86/um/zpoline.c b/arch/x86/um/zpoline.c
index 97f5345ab314..6ec44233276b 100644
--- a/arch/x86/um/zpoline.c
+++ b/arch/x86/um/zpoline.c
@@ -14,6 +14,7 @@
 #include <sysdep/syscalls.h>
 #include <os.h>
 
+int um_zpoline_enabled;
 /* start of trampoline code area */
 static char *__zpoline_start;
 
@@ -111,6 +112,10 @@ int elf_arch_finalize_exec(struct elf_fdpic_params *exec_params,
 	int err = 0, count = 0;
 	struct mm_struct *mm = current->mm;
 
+	/* zpoline disabled */
+	if (!um_zpoline_enabled)
+		return 0;
+
 	if (down_write_killable(&mm->mmap_lock))
 		return -EINTR;
 
@@ -221,3 +226,13 @@ static int __init setup_zpoline_trampoline(void)
 	return 0;
 }
 arch_initcall(setup_zpoline_trampoline);
+
+static int __init zpoline_set(char *str)
+{
+	int val = 0;
+
+	get_option(&str, &val);
+	um_zpoline_enabled = val;
+	return 1;
+}
+__setup("zpoline=", zpoline_set);
-- 
2.43.0


