Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87B6C3ABB6
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 16:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mNF0zCRcIiNbU6nF7Q0sCbeTu2kX+7Zgw99pirkdhr0=; b=P+H1OVmn72OkuET6ZCSRNJvorU
	6xyvfrUQKkTdJT7/pC7xdht8noIAuinButvspdjNH1+Tk3WU7yqIYIcBLkicThULDiKuwHSy86/Fn
	cj5K4OXmQnYDT/z//rXMI/ATfujwVByrl9euXxrPk1RW6nBnMcMvp1RrUWOEP3Zt4NPqxbq/EweDf
	thUvy4JDSURrmXaAN6mWeYjU5MsfsWD9i+Nr4e0n3bIBHO7RyEr1CswQjEa9fhJGaaE9MNro7j0xk
	W+a9Y40yD57sHtrUOkG9BqgronLS970EYZe/hHMdC3MStReTDdQWJ8Ya5VDvqJ9D0o3t6nfVzIhJl
	CVfCJdxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA9zW-0000000DO37-22xZ;
	Wed, 30 Apr 2025 16:08:58 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA9wx-0000000DNhf-12mG
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 16:06:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mNF0zCRcIiNbU6nF7Q0sCbeTu2kX+7Zgw99pirkdhr0=;
	t=1746029179; x=1747238779; b=giqEPeV8Jzf6k/DqcR9uYARvFY3+S5uKDn/nYXOVbLwx/dh
	YZAZnj4nVCleJEZrPyooia1Qad/Rxyh8lAjU74cFjTWGbvUAKv4DBOHF5nstXQ/oFaQKpu0F0ASQB
	/QmHTZzd+EVlFRH4kUAEGoqPfiVdFD84bqn6BE0tZf6JJb230sZuA1f31dmygvUEzhkfkLeIJRPb1
	cn9W19e7aHJl5+02rpOeas47XF7coxI+6CXRYFlSGazjRGxdyMd7FAe/WNwWOcmIt1kkY7Cg6KgoC
	/TvhH716dtvU8O+GMaw4Z0GlTGbUhsYaB9mVeu9+IEn8mzQGmE4/E6a/u9fv7xng==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uA9ws-0000000DxyX-2KJx;
	Wed, 30 Apr 2025 18:06:15 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Johannes Berg <johannes@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 6/8] um: Implement kernel side of SECCOMP based process handling
Date: Wed, 30 Apr 2025 18:04:11 +0200
Message-ID: <20250430160413.3250227-7-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430160413.3250227-1-benjamin@sipsolutions.net>
References: <20250430160413.3250227-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_090619_640382_B8D04172 
X-CRM114-Status: GOOD (  32.13  )
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

This adds the kernel side of the seccomp based process handling.

Co-authored-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v1:
- Fix FUTEX_WAIT EINTR handling
- Don't send fatal_sigsegv when waiting during child startup
---
 arch/um/include/shared/common-offsets.h    |   2 +
 arch/um/include/shared/os.h                |   2 +-
 arch/um/include/shared/skas/stub-data.h    |   5 +-
 arch/um/kernel/skas/mmu.c                  |   6 +-
 arch/um/kernel/skas/stub_exe.c             | 141 +++++++-
 arch/um/os-Linux/internal.h                |   5 +-
 arch/um/os-Linux/skas/mem.c                |  37 +-
 arch/um/os-Linux/skas/process.c            | 375 +++++++++++++++------
 arch/x86/um/shared/sysdep/kernel-offsets.h |   2 +
 arch/x86/um/tls_32.c                       |  23 +-
 10 files changed, 460 insertions(+), 138 deletions(-)

diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
index 93e7097a2922..8ca66a1918c3 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -16,3 +16,5 @@ DEFINE(UM_NSEC_PER_SEC, NSEC_PER_SEC);
 DEFINE(UM_NSEC_PER_USEC, NSEC_PER_USEC);
 
 DEFINE(UM_KERN_GDT_ENTRY_TLS_ENTRIES, GDT_ENTRY_TLS_ENTRIES);
+
+DEFINE(UM_SECCOMP_ARCH_NATIVE, SECCOMP_ARCH_NATIVE);
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 39a6828bf78a..32427f46084e 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -287,7 +287,7 @@ int unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len);
 
 /* skas/process.c */
 extern int is_skas_winch(int pid, int fd, void *data);
-extern int start_userspace(unsigned long stub_stack);
+extern int start_userspace(struct mm_id *mm_id);
 extern void userspace(struct uml_pt_regs *regs);
 extern void new_thread(void *stack, jmp_buf *buf, void (*handler)(void));
 extern void switch_threads(jmp_buf *me, jmp_buf *you);
diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 81ac2cd12112..675f1a0a1390 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -17,6 +17,8 @@
 #define FUTEX_IN_KERN 1
 
 struct stub_init_data {
+	int seccomp;
+
 	unsigned long stub_start;
 
 	int stub_code_fd;
@@ -24,7 +26,8 @@ struct stub_init_data {
 	int stub_data_fd;
 	unsigned long stub_data_offset;
 
-	unsigned long segv_handler;
+	unsigned long signal_handler;
+	unsigned long signal_restorer;
 };
 
 #define STUB_NEXT_SYSCALL(s) \
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 1e146a0f9549..87a18ae4da19 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -40,11 +40,9 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 		list_add(&mm->context.list, &mm_list);
 	}
 
-	new_id->pid = start_userspace(stack);
-	if (new_id->pid < 0) {
-		ret = new_id->pid;
+	ret = start_userspace(new_id);
+	if (ret < 0)
 		goto out_free;
-	}
 
 	/* Ensure the new MM is clean and nothing unwanted is mapped */
 	unmap(new_id, 0, STUB_START);
diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index 23c99b285e82..f40f2332b676 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -3,6 +3,9 @@
 #include <asm/unistd.h>
 #include <sysdep/stub.h>
 #include <stub-data.h>
+#include <linux/filter.h>
+#include <linux/seccomp.h>
+#include <generated/asm-offsets.h>
 
 void _start(void);
 
@@ -25,8 +28,6 @@ noinline static void real_init(void)
 	} sa = {
 		/* Need to set SA_RESTORER (but the handler never returns) */
 		.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO | 0x04000000,
-		/* no need to mask any signals */
-		.sa_mask = 0,
 	};
 
 	/* set a nice name */
@@ -35,6 +36,9 @@ noinline static void real_init(void)
 	/* Make sure this process dies if the kernel dies */
 	stub_syscall2(__NR_prctl, PR_SET_PDEATHSIG, SIGKILL);
 
+	/* Needed in SECCOMP mode (and safe to do anyway) */
+	stub_syscall5(__NR_prctl, PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+
 	/* read information from STDIN and close it */
 	res = stub_syscall3(__NR_read, 0,
 			    (unsigned long)&init_data, sizeof(init_data));
@@ -63,18 +67,133 @@ noinline static void real_init(void)
 	stack.ss_sp = (void *)init_data.stub_start + UM_KERN_PAGE_SIZE;
 	stub_syscall2(__NR_sigaltstack, (unsigned long)&stack, 0);
 
-	/* register SIGSEGV handler */
-	sa.sa_handler_ = (void *) init_data.segv_handler;
-	res = stub_syscall4(__NR_rt_sigaction, SIGSEGV, (unsigned long)&sa, 0,
-			    sizeof(sa.sa_mask));
-	if (res != 0)
-		stub_syscall1(__NR_exit, 13);
+	/* register signal handlers */
+	sa.sa_handler_ = (void *) init_data.signal_handler;
+	sa.sa_restorer = (void *) init_data.signal_restorer;
+	if (!init_data.seccomp) {
+		/* In ptrace mode, the SIGSEGV handler never returns */
+		sa.sa_mask = 0;
+
+		res = stub_syscall4(__NR_rt_sigaction, SIGSEGV,
+				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
+		if (res != 0)
+			stub_syscall1(__NR_exit, 13);
+	} else {
+		/* SECCOMP mode uses rt_sigreturn, need to mask all signals */
+		sa.sa_mask = ~0ULL;
+
+		res = stub_syscall4(__NR_rt_sigaction, SIGSEGV,
+				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
+		if (res != 0)
+			stub_syscall1(__NR_exit, 14);
+
+		res = stub_syscall4(__NR_rt_sigaction, SIGSYS,
+				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
+		if (res != 0)
+			stub_syscall1(__NR_exit, 15);
+
+		res = stub_syscall4(__NR_rt_sigaction, SIGALRM,
+				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
+		if (res != 0)
+			stub_syscall1(__NR_exit, 16);
+
+		res = stub_syscall4(__NR_rt_sigaction, SIGTRAP,
+				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
+		if (res != 0)
+			stub_syscall1(__NR_exit, 17);
+
+		res = stub_syscall4(__NR_rt_sigaction, SIGILL,
+				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
+		if (res != 0)
+			stub_syscall1(__NR_exit, 18);
+
+		res = stub_syscall4(__NR_rt_sigaction, SIGFPE,
+				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
+		if (res != 0)
+			stub_syscall1(__NR_exit, 19);
+	}
+
+	/*
+	 * If in seccomp mode, install the SECCOMP filter and trigger a syscall.
+	 * Otherwise set PTRACE_TRACEME and do a SIGSTOP.
+	 */
+	if (init_data.seccomp) {
+		struct sock_filter filter[] = {
+#if __BITS_PER_LONG > 32
+			/* [0] Load upper 32bit of instruction pointer from seccomp_data */
+			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
+				 (offsetof(struct seccomp_data, instruction_pointer) + 4)),
+
+			/* [1] Jump forward 3 instructions if the upper address is not identical */
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, (init_data.stub_start) >> 32, 0, 3),
+#endif
+			/* [2] Load lower 32bit of instruction pointer from seccomp_data */
+			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
+				 (offsetof(struct seccomp_data, instruction_pointer))),
+
+			/* [3] Mask out lower bits */
+			BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xfffff000),
+
+			/* [4] Jump to [6] if the lower bits are not on the expected page */
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, (init_data.stub_start) & 0xfffff000, 1, 0),
+
+			/* [5] Trap call, allow */
+			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_TRAP),
+
+			/* [6,7] Check architecture */
+			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
+				 offsetof(struct seccomp_data, arch)),
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,
+				 UM_SECCOMP_ARCH_NATIVE, 1, 0),
+
+			/* [8] Kill (for architecture check) */
+			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS),
+
+			/* [9] Load syscall number */
+			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
+				 offsetof(struct seccomp_data, nr)),
+
+			/* [10-14] Check against permitted syscalls */
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_futex,
+				 5, 0),
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, STUB_MMAP_NR,
+				 4, 0),
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_munmap,
+				 3, 0),
+#ifdef __i386__
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_set_thread_area,
+				 2, 0),
+#else
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_arch_prctl,
+				 2, 0),
+#endif
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_rt_sigreturn,
+				 1, 0),
+
+			/* [15] Not one of the permitted syscalls */
+			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS),
+
+			/* [16] Permitted call for the stub */
+			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
+		};
+		struct sock_fprog prog = {
+			.len = sizeof(filter) / sizeof(filter[0]),
+			.filter = filter,
+		};
+
+		if (stub_syscall3(__NR_seccomp, SECCOMP_SET_MODE_FILTER,
+				  SECCOMP_FILTER_FLAG_TSYNC,
+				  (unsigned long)&prog) != 0)
+			stub_syscall1(__NR_exit, 20);
 
-	stub_syscall4(__NR_ptrace, PTRACE_TRACEME, 0, 0, 0);
+		/* Fall through, the exit syscall will cause SIGSYS */
+	} else {
+		stub_syscall4(__NR_ptrace, PTRACE_TRACEME, 0, 0, 0);
 
-	stub_syscall2(__NR_kill, stub_syscall0(__NR_getpid), SIGSTOP);
+		stub_syscall2(__NR_kill, stub_syscall0(__NR_getpid), SIGSTOP);
+	}
 
-	stub_syscall1(__NR_exit, 14);
+	stub_syscall1(__NR_exit, 30);
 
 	__builtin_unreachable();
 }
diff --git a/arch/um/os-Linux/internal.h b/arch/um/os-Linux/internal.h
index 317fca190c2b..5d8d3b0817a9 100644
--- a/arch/um/os-Linux/internal.h
+++ b/arch/um/os-Linux/internal.h
@@ -2,6 +2,9 @@
 #ifndef __UM_OS_LINUX_INTERNAL_H
 #define __UM_OS_LINUX_INTERNAL_H
 
+#include <mm_id.h>
+#include <stub-data.h>
+
 /*
  * elf_aux.c
  */
@@ -16,5 +19,5 @@ void check_tmpexec(void);
  * skas/process.c
  */
 void wait_stub_done(int pid);
-
+void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys);
 #endif /* __UM_OS_LINUX_INTERNAL_H */
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index d7f1814b0e5a..31bf3a52047a 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -80,27 +80,32 @@ static inline long do_syscall_stub(struct mm_id *mm_idp)
 	int n, i;
 	int err, pid = mm_idp->pid;
 
-	n = ptrace_setregs(pid, syscall_regs);
-	if (n < 0) {
-		printk(UM_KERN_ERR "Registers - \n");
-		for (i = 0; i < MAX_REG_NR; i++)
-			printk(UM_KERN_ERR "\t%d\t0x%lx\n", i, syscall_regs[i]);
-		panic("%s : PTRACE_SETREGS failed, errno = %d\n",
-		      __func__, -n);
-	}
-
 	/* Inform process how much we have filled in. */
 	proc_data->syscall_data_len = mm_idp->syscall_data_len;
 
-	err = ptrace(PTRACE_CONT, pid, 0, 0);
-	if (err)
-		panic("Failed to continue stub, pid = %d, errno = %d\n", pid,
-		      errno);
-
-	wait_stub_done(pid);
+	if (using_seccomp) {
+		proc_data->restart_wait = 1;
+		wait_stub_done_seccomp(mm_idp, 0, 1);
+	} else {
+		n = ptrace_setregs(pid, syscall_regs);
+		if (n < 0) {
+			printk(UM_KERN_ERR "Registers -\n");
+			for (i = 0; i < MAX_REG_NR; i++)
+				printk(UM_KERN_ERR "\t%d\t0x%lx\n", i, syscall_regs[i]);
+			panic("%s : PTRACE_SETREGS failed, errno = %d\n",
+			      __func__, -n);
+		}
+
+		err = ptrace(PTRACE_CONT, pid, 0, 0);
+		if (err)
+			panic("Failed to continue stub, pid = %d, errno = %d\n",
+			      pid, errno);
+
+		wait_stub_done(pid);
+	}
 
 	/*
-	 * proc_data->err will be non-zero if there was an (unexpected) error.
+	 * proc_data->err will be negative if there was an (unexpected) error.
 	 * In that case, syscall_data_len points to the last executed syscall,
 	 * otherwise it will be zero (but we do not need to rely on that).
 	 */
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 5e4a38aea68d..8862eb2eb50a 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (C) 2021 Benjamin Berg <benjamin@sipsolutions.net>
  * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
  * Copyright (C) 2002- 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
@@ -25,8 +26,11 @@
 #include <registers.h>
 #include <skas.h>
 #include <sysdep/stub.h>
+#include <sysdep/mcontext.h>
+#include <linux/futex.h>
 #include <linux/threads.h>
 #include <timetravel.h>
+#include <asm-generic/rwonce.h>
 #include "../internal.h"
 
 int is_skas_winch(int pid, int fd, void *data)
@@ -142,6 +146,75 @@ void wait_stub_done(int pid)
 	fatal_sigsegv();
 }
 
+#ifdef CONFIG_UML_SECCOMP
+void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys)
+{
+	struct stub_data *data = (void *)mm_idp->stack;
+	int ret;
+
+	do {
+		if (!running) {
+			data->signal = 0;
+			data->futex = FUTEX_IN_CHILD;
+			CATCH_EINTR(syscall(__NR_futex, &data->futex,
+					    FUTEX_WAKE, 1, NULL, NULL, 0));
+		}
+
+		do {
+			/*
+			 * We need to check whether the child is still alive
+			 * before and after the FUTEX_WAIT call. Before, in
+			 * case it just died but we still updated data->futex
+			 * to FUTEX_IN_CHILD. And after, in case it died while
+			 * we were waiting (and SIGCHLD woke us up, see the
+			 * IRQ handler in mmu.c).
+			 *
+			 * Either way, if PID is negative, then we have no
+			 * choice but to kill the task.
+			 */
+			if (__READ_ONCE(mm_idp->pid) < 0)
+				goto out_kill;
+
+			ret = syscall(__NR_futex, &data->futex,
+				      FUTEX_WAIT, FUTEX_IN_CHILD,
+				      NULL, NULL, 0);
+			if (ret < 0 && errno != EINTR && errno != EAGAIN) {
+				printk(UM_KERN_ERR "%s : FUTEX_WAIT failed, errno = %d\n",
+				       __func__, errno);
+				goto out_kill;
+			}
+		} while (data->futex == FUTEX_IN_CHILD);
+
+		if (__READ_ONCE(mm_idp->pid) < 0)
+			goto out_kill;
+
+		running = 0;
+
+		/* We may receive a SIGALRM before SIGSYS, iterate again. */
+	} while (wait_sigsys && data->signal == SIGALRM);
+
+	if (data->mctx_offset > sizeof(data->sigstack) - sizeof(mcontext_t)) {
+		printk(UM_KERN_ERR "%s : invalid mcontext offset", __func__);
+		goto out_kill;
+	}
+
+	if (wait_sigsys && data->signal != SIGSYS) {
+		printk(UM_KERN_ERR "%s : expected SIGSYS but got %d",
+		       __func__, data->signal);
+		goto out_kill;
+	}
+
+	return;
+
+out_kill:
+	printk(UM_KERN_ERR "%s : failed to wait for stub, pid = %d, errno = %d\n",
+	       __func__, mm_idp->pid, errno);
+	/* This is not true inside start_userspace */
+	if (current_mm_id() == mm_idp)
+		fatal_sigsegv();
+}
+#endif
+
 extern unsigned long current_stub_stack(void);
 
 static void get_skas_faultinfo(int pid, struct faultinfo *fi)
@@ -185,14 +258,26 @@ static int userspace_tramp(void *stack)
 	int pipe_fds[2];
 	unsigned long long offset;
 	struct stub_init_data init_data = {
+		.seccomp = using_seccomp,
 		.stub_start = STUB_START,
-		.segv_handler = STUB_CODE +
-				(unsigned long) stub_segv_handler -
-				(unsigned long) __syscall_stub_start,
 	};
 	struct iomem_region *iomem;
 	int ret;
 
+	if (using_seccomp) {
+		init_data.signal_handler = STUB_CODE +
+					   (unsigned long) stub_signal_interrupt -
+					   (unsigned long) __syscall_stub_start;
+		init_data.signal_restorer = STUB_CODE +
+					   (unsigned long) stub_signal_restorer -
+					   (unsigned long) __syscall_stub_start;
+	} else {
+		init_data.signal_handler = STUB_CODE +
+					   (unsigned long) stub_segv_handler -
+					   (unsigned long) __syscall_stub_start;
+		init_data.signal_restorer = 0;
+	}
+
 	init_data.stub_code_fd = phys_mapping(uml_to_phys(__syscall_stub_start),
 					      &offset);
 	init_data.stub_code_offset = MMAP_OFFSET(offset);
@@ -325,8 +410,9 @@ int userspace_pid[NR_CPUS];
  *         when negative: an error number.
  * FIXME: can PIDs become negative?!
  */
-int start_userspace(unsigned long stub_stack)
+int start_userspace(struct mm_id *mm_id)
 {
+	struct stub_data *proc_data = (void *)mm_id->stack;
 	void *stack;
 	unsigned long sp;
 	int pid, status, n, err;
@@ -345,10 +431,13 @@ int start_userspace(unsigned long stub_stack)
 	/* set stack pointer to the end of the stack page, so it can grow downwards */
 	sp = (unsigned long)stack + UM_KERN_PAGE_SIZE;
 
+	if (using_seccomp)
+		proc_data->futex = FUTEX_IN_CHILD;
+
 	/* clone into new userspace process */
 	pid = clone(userspace_tramp, (void *) sp,
 		    CLONE_VFORK | CLONE_VM | SIGCHLD,
-		    (void *)stub_stack);
+		    (void *)mm_id->stack);
 	if (pid < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : clone failed, errno = %d\n",
@@ -356,29 +445,34 @@ int start_userspace(unsigned long stub_stack)
 		return err;
 	}
 
-	do {
-		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
-		if (n < 0) {
+	if (using_seccomp) {
+		wait_stub_done_seccomp(mm_id, 1, 1);
+	} else {
+		do {
+			CATCH_EINTR(n = waitpid(pid, &status,
+						WUNTRACED | __WALL));
+			if (n < 0) {
+				err = -errno;
+				printk(UM_KERN_ERR "%s : wait failed, errno = %d\n",
+				       __func__, errno);
+				goto out_kill;
+			}
+		} while (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGALRM));
+
+		if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)) {
+			err = -EINVAL;
+			printk(UM_KERN_ERR "%s : expected SIGSTOP, got status = %d\n",
+			       __func__, status);
+			goto out_kill;
+		}
+
+		if (ptrace(PTRACE_SETOPTIONS, pid, NULL,
+			   (void *) PTRACE_O_TRACESYSGOOD) < 0) {
 			err = -errno;
-			printk(UM_KERN_ERR "%s : wait failed, errno = %d\n",
+			printk(UM_KERN_ERR "%s : PTRACE_SETOPTIONS failed, errno = %d\n",
 			       __func__, errno);
 			goto out_kill;
 		}
-	} while (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGALRM));
-
-	if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)) {
-		err = -EINVAL;
-		printk(UM_KERN_ERR "%s : expected SIGSTOP, got status = %d\n",
-		       __func__, status);
-		goto out_kill;
-	}
-
-	if (ptrace(PTRACE_SETOPTIONS, pid, NULL,
-		   (void *) PTRACE_O_TRACESYSGOOD) < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "%s : PTRACE_SETOPTIONS failed, errno = %d\n",
-		       __func__, errno);
-		goto out_kill;
 	}
 
 	if (munmap(stack, UM_KERN_PAGE_SIZE) < 0) {
@@ -388,6 +482,8 @@ int start_userspace(unsigned long stub_stack)
 		goto out_kill;
 	}
 
+	mm_id->pid = pid;
+
 	return pid;
 
  out_kill:
@@ -401,7 +497,9 @@ extern unsigned long tt_extra_sched_jiffies;
 void userspace(struct uml_pt_regs *regs)
 {
 	int err, status, op, pid = userspace_pid[0];
-	siginfo_t si;
+	siginfo_t si_ptrace;
+	siginfo_t *si;
+	int sig;
 
 	/* Handle any immediate reschedules or signals */
 	interrupt_end();
@@ -434,104 +532,181 @@ void userspace(struct uml_pt_regs *regs)
 
 		current_mm_sync();
 
-		/* Flush out any pending syscalls */
-		err = syscall_stub_flush(current_mm_id());
-		if (err) {
-			if (err == -ENOMEM)
-				report_enomem();
+		if (using_seccomp) {
+			struct mm_id *mm_id = current_mm_id();
+			struct stub_data *proc_data = (void *) mm_id->stack;
+			int ret;
 
-			printk(UM_KERN_ERR "%s - Error flushing stub syscalls: %d",
-				__func__, -err);
-			fatal_sigsegv();
-		}
+			ret = set_stub_state(regs, proc_data, singlestepping());
+			if (ret) {
+				printk(UM_KERN_ERR "%s - failed to set regs: %d",
+				       __func__, ret);
+				fatal_sigsegv();
+			}
 
-		/*
-		 * This can legitimately fail if the process loads a
-		 * bogus value into a segment register.  It will
-		 * segfault and PTRACE_GETREGS will read that value
-		 * out of the process.  However, PTRACE_SETREGS will
-		 * fail.  In this case, there is nothing to do but
-		 * just kill the process.
-		 */
-		if (ptrace(PTRACE_SETREGS, pid, 0, regs->gp)) {
-			printk(UM_KERN_ERR "%s - ptrace set regs failed, errno = %d\n",
-			       __func__, errno);
-			fatal_sigsegv();
-		}
+			/* Must have been reset by the syscall caller */
+			if (proc_data->restart_wait != 0)
+				panic("Programming error: Flag to only run syscalls in child was not cleared!");
+
+			/* Mark pending syscalls for flushing */
+			proc_data->syscall_data_len = mm_id->syscall_data_len;
+			mm_id->syscall_data_len = 0;
+
+			proc_data->signal = 0;
+			proc_data->futex = FUTEX_IN_CHILD;
+			CATCH_EINTR(syscall(__NR_futex, &proc_data->futex,
+					    FUTEX_WAKE, 1, NULL, NULL, 0));
+			do {
+				ret = syscall(__NR_futex, &proc_data->futex,
+					      FUTEX_WAIT, FUTEX_IN_CHILD, NULL, NULL, 0);
+			} while ((ret == -1 && errno == EINTR) ||
+				 proc_data->futex == FUTEX_IN_CHILD);
+
+			sig = proc_data->signal;
+
+			if (sig == SIGTRAP && proc_data->err != 0) {
+				printk(UM_KERN_ERR "%s - Error flushing stub syscalls",
+				       __func__);
+				syscall_stub_dump_error(mm_id);
+				fatal_sigsegv();
+			}
 
-		if (put_fp_registers(pid, regs->fp)) {
-			printk(UM_KERN_ERR "%s - ptrace set fp regs failed, errno = %d\n",
-			       __func__, errno);
-			fatal_sigsegv();
-		}
+			ret = get_stub_state(regs, proc_data, NULL);
+			if (ret) {
+				printk(UM_KERN_ERR "%s - failed to get regs: %d",
+				       __func__, ret);
+				fatal_sigsegv();
+			}
 
-		if (singlestepping())
-			op = PTRACE_SYSEMU_SINGLESTEP;
-		else
-			op = PTRACE_SYSEMU;
+			if (proc_data->si_offset > sizeof(proc_data->sigstack) - sizeof(*si))
+				panic("%s - Invalid siginfo offset from child",
+				      __func__);
+			si = (void *)&proc_data->sigstack[proc_data->si_offset];
 
-		if (ptrace(op, pid, 0, 0)) {
-			printk(UM_KERN_ERR "%s - ptrace continue failed, op = %d, errno = %d\n",
-			       __func__, op, errno);
-			fatal_sigsegv();
-		}
+			regs->is_user = 1;
 
-		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED | __WALL));
-		if (err < 0) {
-			printk(UM_KERN_ERR "%s - wait failed, errno = %d\n",
-			       __func__, errno);
-			fatal_sigsegv();
-		}
+			/* Fill in ORIG_RAX and extract fault information */
+			PT_SYSCALL_NR(regs->gp) = si->si_syscall;
+			if (sig == SIGSEGV) {
+				mcontext_t *mcontext = (void *)&proc_data->sigstack[proc_data->mctx_offset];
 
-		regs->is_user = 1;
-		if (ptrace(PTRACE_GETREGS, pid, 0, regs->gp)) {
-			printk(UM_KERN_ERR "%s - PTRACE_GETREGS failed, errno = %d\n",
-			       __func__, errno);
-			fatal_sigsegv();
-		}
+				GET_FAULTINFO_FROM_MC(regs->faultinfo, mcontext);
+			}
+		} else {
+			/* Flush out any pending syscalls */
+			err = syscall_stub_flush(current_mm_id());
+			if (err) {
+				if (err == -ENOMEM)
+					report_enomem();
+
+				printk(UM_KERN_ERR "%s - Error flushing stub syscalls: %d",
+					__func__, -err);
+				fatal_sigsegv();
+			}
 
-		if (get_fp_registers(pid, regs->fp)) {
-			printk(UM_KERN_ERR "%s -  get_fp_registers failed, errno = %d\n",
-			       __func__, errno);
-			fatal_sigsegv();
-		}
+			/*
+			 * This can legitimately fail if the process loads a
+			 * bogus value into a segment register.  It will
+			 * segfault and PTRACE_GETREGS will read that value
+			 * out of the process.  However, PTRACE_SETREGS will
+			 * fail.  In this case, there is nothing to do but
+			 * just kill the process.
+			 */
+			if (ptrace(PTRACE_SETREGS, pid, 0, regs->gp)) {
+				printk(UM_KERN_ERR "%s - ptrace set regs failed, errno = %d\n",
+				       __func__, errno);
+				fatal_sigsegv();
+			}
 
-		UPT_SYSCALL_NR(regs) = -1; /* Assume: It's not a syscall */
+			if (put_fp_registers(pid, regs->fp)) {
+				printk(UM_KERN_ERR "%s - ptrace set fp regs failed, errno = %d\n",
+				       __func__, errno);
+				fatal_sigsegv();
+			}
 
-		if (WIFSTOPPED(status)) {
-			int sig = WSTOPSIG(status);
+			if (singlestepping())
+				op = PTRACE_SYSEMU_SINGLESTEP;
+			else
+				op = PTRACE_SYSEMU;
 
-			/* These signal handlers need the si argument.
-			 * The SIGIO and SIGALARM handlers which constitute the
-			 * majority of invocations, do not use it.
-			 */
-			switch (sig) {
-			case SIGSEGV:
-			case SIGTRAP:
-			case SIGILL:
-			case SIGBUS:
-			case SIGFPE:
-			case SIGWINCH:
-				ptrace(PTRACE_GETSIGINFO, pid, 0, (struct siginfo *)&si);
-				break;
+			if (ptrace(op, pid, 0, 0)) {
+				printk(UM_KERN_ERR "%s - ptrace continue failed, op = %d, errno = %d\n",
+				       __func__, op, errno);
+				fatal_sigsegv();
+			}
+
+			CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED | __WALL));
+			if (err < 0) {
+				printk(UM_KERN_ERR "%s - wait failed, errno = %d\n",
+				       __func__, errno);
+				fatal_sigsegv();
 			}
 
+			regs->is_user = 1;
+			if (ptrace(PTRACE_GETREGS, pid, 0, regs->gp)) {
+				printk(UM_KERN_ERR "%s - PTRACE_GETREGS failed, errno = %d\n",
+				       __func__, errno);
+				fatal_sigsegv();
+			}
+
+			if (get_fp_registers(pid, regs->fp)) {
+				printk(UM_KERN_ERR "%s -  get_fp_registers failed, errno = %d\n",
+				       __func__, errno);
+				fatal_sigsegv();
+			}
+
+			if (WIFSTOPPED(status)) {
+				sig = WSTOPSIG(status);
+
+				/* These signal handlers need the si argument
+				 * and SIGSEGV needs the faultinfo.
+				 * The SIGIO and SIGALARM handlers which constitute the
+				 * majority of invocations, do not use it.
+				 */
+				switch (sig) {
+				case SIGSEGV:
+					get_skas_faultinfo(pid,
+							   &regs->faultinfo);
+					fallthrough;
+				case SIGTRAP:
+				case SIGILL:
+				case SIGBUS:
+				case SIGFPE:
+				case SIGWINCH:
+					ptrace(PTRACE_GETSIGINFO, pid, 0,
+					       (struct siginfo *)&si_ptrace);
+					si = &si_ptrace;
+					break;
+				default:
+					si = NULL;
+					break;
+				}
+			} else {
+				sig = 0;
+			}
+		}
+
+		UPT_SYSCALL_NR(regs) = -1; /* Assume: It's not a syscall */
+
+		if (sig) {
 			switch (sig) {
 			case SIGSEGV:
-				get_skas_faultinfo(pid, &regs->faultinfo);
-
-				if (PTRACE_FULL_FAULTINFO)
-					(*sig_info[SIGSEGV])(SIGSEGV, (struct siginfo *)&si,
+				if (using_seccomp || PTRACE_FULL_FAULTINFO)
+					(*sig_info[SIGSEGV])(SIGSEGV,
+							     (struct siginfo *)si,
 							     regs, NULL);
 				else
 					segv(regs->faultinfo, 0, 1, NULL, NULL);
 
+				break;
+			case SIGSYS:
+				handle_syscall(regs);
 				break;
 			case SIGTRAP + 0x80:
 				handle_trap(pid, regs);
 				break;
 			case SIGTRAP:
-				relay_signal(SIGTRAP, (struct siginfo *)&si, regs, NULL);
+				relay_signal(SIGTRAP, (struct siginfo *)si, regs, NULL);
 				break;
 			case SIGALRM:
 				break;
@@ -541,7 +716,7 @@ void userspace(struct uml_pt_regs *regs)
 			case SIGFPE:
 			case SIGWINCH:
 				block_signals_trace();
-				(*sig_info[sig])(sig, (struct siginfo *)&si, regs, NULL);
+				(*sig_info[sig])(sig, (struct siginfo *)si, regs, NULL);
 				unblock_signals_trace();
 				break;
 			default:
diff --git a/arch/x86/um/shared/sysdep/kernel-offsets.h b/arch/x86/um/shared/sysdep/kernel-offsets.h
index 48de3a71f845..6fd1ed400399 100644
--- a/arch/x86/um/shared/sysdep/kernel-offsets.h
+++ b/arch/x86/um/shared/sysdep/kernel-offsets.h
@@ -4,7 +4,9 @@
 #include <linux/elf.h>
 #include <linux/crypto.h>
 #include <linux/kbuild.h>
+#include <linux/audit.h>
 #include <asm/mman.h>
+#include <asm/seccomp.h>
 
 /* workaround for a warning with -Wmissing-prototypes */
 void foo(void);
diff --git a/arch/x86/um/tls_32.c b/arch/x86/um/tls_32.c
index fbb129023080..21cbb70cf771 100644
--- a/arch/x86/um/tls_32.c
+++ b/arch/x86/um/tls_32.c
@@ -12,6 +12,7 @@
 #include <skas.h>
 #include <sysdep/tls.h>
 #include <asm/desc.h>
+#include <stub-data.h>
 
 /*
  * If needed we can detect when it's uninitialized.
@@ -21,13 +22,27 @@
 static int host_supports_tls = -1;
 int host_gdt_entry_tls_min;
 
-static int do_set_thread_area(struct user_desc *info)
+static int do_set_thread_area(struct task_struct* task, struct user_desc *info)
 {
 	int ret;
 	u32 cpu;
 
+	if (info->entry_number < host_gdt_entry_tls_min ||
+	    info->entry_number >= host_gdt_entry_tls_min + GDT_ENTRY_TLS_ENTRIES)
+		return -EINVAL;
+
+	if (using_seccomp) {
+		int idx = info->entry_number - host_gdt_entry_tls_min;
+		struct stub_data *data = (void *)task->mm->context.id.stack;
+
+		data->arch_data.tls[idx] = *info;
+		data->arch_data.sync |= BIT(idx);
+
+		return 0;
+	}
+
 	cpu = get_cpu();
-	ret = os_set_thread_area(info, userspace_pid[cpu]);
+	ret = os_set_thread_area(info, task->mm->context.id.pid);
 	put_cpu();
 
 	if (ret)
@@ -97,7 +112,7 @@ static int load_TLS(int flags, struct task_struct *to)
 		if (!(flags & O_FORCE) && curr->flushed)
 			continue;
 
-		ret = do_set_thread_area(&curr->tls);
+		ret = do_set_thread_area(current, &curr->tls);
 		if (ret)
 			goto out;
 
@@ -275,7 +290,7 @@ SYSCALL_DEFINE1(set_thread_area, struct user_desc __user *, user_desc)
 			return -EFAULT;
 	}
 
-	ret = do_set_thread_area(&info);
+	ret = do_set_thread_area(current, &info);
 	if (ret)
 		return ret;
 	return set_tls_entry(current, &info, idx, 1);
-- 
2.49.0


