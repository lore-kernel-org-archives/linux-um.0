Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53531C7EE33
	for <linux-um@archiver.kernel.org>; Sun, 22 Jun 2025 21:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HWYis9XY/qzyLWLxXYbKTNJnR2A9tZ/PpUFIrifE6jQ=; b=yjrAehkQ0LTwJG1DesWW7R3p8o
	tkSYO2KF+fWLX4ROZ4sTO2Pw7bBbJhxVheTm++T2rboonCqaHuZrd+6J5542NbW5CWj/g3oeuktS8
	rOIbES2pV65LBO73yFiO+l5Q3N2z3x2YldpDSJQQKlFbCBj9nZ2r33CbfTpl9r4zDVlz1Xuf9kFGa
	QKpno5/Kz2IRBhcPquBRR6s/g1LhLFso39djRVERoiAfK3dPfzMvKvJLHwhpZNFsLAygNGczo0wZO
	6TFTAuZ9yhrlEPEEmMG7gZMV6gsbE2aqvvCKCaWnVYfRUlSwfo2HaKkUQNaVbgbGuC1rl7jaDIwhC
	JADAmC1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSKH-00000001F6J-3ylc;
	Sun, 22 Jun 2025 21:34:09 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSJm-00000001EvU-1XJx
	for linux-um@lists.infradead.org;
	Sun, 22 Jun 2025 21:33:39 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-748d982e97cso3103956b3a.1
        for <linux-um@lists.infradead.org>; Sun, 22 Jun 2025 14:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750628017; x=1751232817; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWYis9XY/qzyLWLxXYbKTNJnR2A9tZ/PpUFIrifE6jQ=;
        b=Ryjd2hCfRZS0BlzovbVeKllMd1B5bgAIwUdhYMdt6ZpfVJyICAUSWKplRrhQdM0KXm
         VDNVM5qXnKSCCni5ldnIymaU8A7F8EtxILkhdKVMrFp5AcuHpStJGrBR4XIEAG8RrTv/
         c3afhs57YWspfwBI1MqKT5f8Xs5uqWeBRgYeMfQL8FeJBpTanCr6g41XSU6l67zzYEpA
         8emeXJjc3swWo7zYCBMLoS9K1XmE63KzEZRT+hTTxjQ9h9OIZ3GDqeda95JejjCaoE2Y
         /o62gMkvER4TtHnZ+t845HJaqz+zeW+peM9fcFlR4hr7cPeASaRuk3gfGh47I3IEi7sj
         0cyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750628017; x=1751232817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWYis9XY/qzyLWLxXYbKTNJnR2A9tZ/PpUFIrifE6jQ=;
        b=MH0MjhHyjm5q4Z+ecrdjffpX9Zp/EaYUP1vF4vZ0hd8puqDfMZNJtEZsosxbvficg2
         aIHOp2+Chc8y83S9U31NIQdSfAfKif5UguIB2EdqIAkGIxEclmeR/O8RY7aNgQEqNNG7
         aUeyHZqsz7UgV0gaMPEphJVApddDt2cPl1Tjd3nEKMGN5z/ufNLUb2gd8p4RQwZG3Iu0
         L5JG3rLaoBZlO8pDvEY6CASb01k6FIVtPgTK/hFn9/vIG8gVPgw3O01xVTQU2r6bXWlk
         j6TGueN97xE+VC2iPdWS/UNx+4HPGcEpO79MzFJ+txOzp+/tx6Hi5uB3fdluz+3E9TUb
         N2Cg==
X-Gm-Message-State: AOJu0YxmEB/DJowlWJ+UI/mqdsehdF+50rqvQCATBVof728jSKGB4LFH
	ZTJWHoy0caqDYjyDMmn0LHAqmrmw7wdpXKdvFRzC6BYZtF5d/67Oaq0d
X-Gm-Gg: ASbGncvFGm8r9SqTd7TpvaajM0J+Igi9GCQutg7SPTL6n4a8yX9MB+JWrD4RocLzi5o
	yl4CIEg5zqeyt1PHmft1qrsB+vI8Iv3fPwZvU2JUiBKpLwA3i0BMIOCQTI2wy7SUnJyZIQ/zqqe
	yjp3XCOlOwSlW3CO9vHZZC2dP2C4Z156aL2dTtCSBTHLi4ZndNJZbtAOA8TZgAEIBQ0Z6I3+5fe
	2BYDTEcb5P+pbpxicXnWTN5gPCegHBhf6NnvGIYPNHE2I9e48a+a2AwxoZNWDQEcjejlOqzJYQc
	23tff8s6Jngz8oJkeF+JN5pmqxdfrEYthiqL0eQD/YaAH8FZaPNwTK30X201sm4EHm5nOGZuAlp
	Eo5KRaj83KFMLUe+e6Y1RolTRrAtKHcmE
X-Google-Smtp-Source: AGHT+IGq0uPvfQN/by2MTlJphZLjSS2FAmQmME8fkve20GVLlwC4kH6GbiBFeD62y0KfiugCRlcrhw==
X-Received: by 2002:a05:6a20:918b:b0:1f5:9330:29fe with SMTP id adf61e73a8af0-22026e6ddb2mr15546602637.17.1750628017530;
        Sun, 22 Jun 2025 14:33:37 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6891a4sm6764586b3a.147.2025.06.22.14.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 14:33:36 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id BB6B1EF1EB6; Mon, 23 Jun 2025 06:33:34 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 09/13] x86/um: nommu: signal handling
Date: Mon, 23 Jun 2025 06:33:07 +0900
Message-ID: <548dcef198b79a4f8eb166481e39abe6e13ed2e3.1750594487.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750594487.git.thehajime@gmail.com>
References: <cover.1750594487.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_143338_408970_9C89A4FB 
X-CRM114-Status: GOOD (  33.28  )
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

This commit updates the behavior of signal handling under !MMU
environment. It adds the alignment code for signal frame as the frame
is used in userspace as-is.

floating point register is carefully handling upon entry/leave of
syscall routine so that signal handlers can read/write the contents of
the register.

It also adds the follow up routine for SIGSEGV as a signal delivery runs
in the same stack frame while we have to avoid endless SIGSEGV.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/include/shared/kern_util.h    |   4 +
 arch/um/nommu/Makefile                |   2 +-
 arch/um/nommu/os-Linux/signal.c       |  13 ++
 arch/um/nommu/trap.c                  | 194 ++++++++++++++++++++++++++
 arch/x86/um/nommu/do_syscall_64.c     |   6 +
 arch/x86/um/nommu/os-Linux/mcontext.c |  11 ++
 arch/x86/um/shared/sysdep/mcontext.h  |   1 +
 arch/x86/um/shared/sysdep/ptrace.h    |   2 +-
 8 files changed, 231 insertions(+), 2 deletions(-)
 create mode 100644 arch/um/nommu/trap.c

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index ec8ba1f13c58..f559943b52cb 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -73,4 +73,8 @@ void um_idle_sleep(void);
 
 void kasan_map_memory(void *start, size_t len);
 
+#ifndef CONFIG_MMU
+extern void arch_sigsegv_handler(int sig, struct siginfo *si, void *mc);
+#endif
+
 #endif
diff --git a/arch/um/nommu/Makefile b/arch/um/nommu/Makefile
index baab7c2f57c2..096221590cfd 100644
--- a/arch/um/nommu/Makefile
+++ b/arch/um/nommu/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := os-Linux/
+obj-y := trap.o os-Linux/
diff --git a/arch/um/nommu/os-Linux/signal.c b/arch/um/nommu/os-Linux/signal.c
index 19043b9652e2..b2cd0470b67c 100644
--- a/arch/um/nommu/os-Linux/signal.c
+++ b/arch/um/nommu/os-Linux/signal.c
@@ -5,6 +5,7 @@
 #include <os.h>
 #include <sysdep/mcontext.h>
 #include <sys/ucontext.h>
+#include <as-layout.h>
 
 void sigsys_handler(int sig, struct siginfo *si,
 		    struct uml_pt_regs *regs, void *ptr)
@@ -14,3 +15,15 @@ void sigsys_handler(int sig, struct siginfo *si,
 	/* hook syscall via SIGSYS */
 	set_mc_sigsys_hook(mc);
 }
+
+void arch_sigsegv_handler(int sig, struct siginfo *si, void *ptr)
+{
+	mcontext_t *mc = (mcontext_t *) ptr;
+
+	/* !MMU specific part; detection of userspace */
+	if (mc->gregs[REG_RIP] > uml_reserved &&
+	    mc->gregs[REG_RIP] < high_physmem) {
+		/* !MMU: force handle signals after rt_sigreturn() */
+		set_mc_userspace_relay_signal(mc);
+	}
+}
diff --git a/arch/um/nommu/trap.c b/arch/um/nommu/trap.c
new file mode 100644
index 000000000000..2053a3b5071b
--- /dev/null
+++ b/arch/um/nommu/trap.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/mm.h>
+#include <linux/sched/signal.h>
+#include <linux/hardirq.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/sched/debug.h>
+#include <asm/current.h>
+#include <asm/tlbflush.h>
+#include <arch.h>
+#include <as-layout.h>
+#include <kern_util.h>
+#include <os.h>
+#include <skas.h>
+
+/*
+ * Note this is constrained to return 0, -EFAULT, -EACCES, -ENOMEM by
+ * segv().
+ */
+int handle_page_fault(unsigned long address, unsigned long ip,
+		      int is_write, int is_user, int *code_out)
+{
+	/* !MMU has no pagefault */
+	return -EFAULT;
+}
+
+static void show_segv_info(struct uml_pt_regs *regs)
+{
+	struct task_struct *tsk = current;
+	struct faultinfo *fi = UPT_FAULTINFO(regs);
+
+	if (!unhandled_signal(tsk, SIGSEGV))
+		return;
+
+	pr_warn_ratelimited("%s%s[%d]: segfault at %lx ip %p sp %p error %x",
+			    task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG,
+			    tsk->comm, task_pid_nr(tsk), FAULT_ADDRESS(*fi),
+			    (void *)UPT_IP(regs), (void *)UPT_SP(regs),
+			    fi->error_code);
+}
+
+static void bad_segv(struct faultinfo fi, unsigned long ip)
+{
+	current->thread.arch.faultinfo = fi;
+	force_sig_fault(SIGSEGV, SEGV_ACCERR, (void __user *) FAULT_ADDRESS(fi));
+}
+
+void fatal_sigsegv(void)
+{
+	force_fatal_sig(SIGSEGV);
+	do_signal(&current->thread.regs);
+	/*
+	 * This is to tell gcc that we're not returning - do_signal
+	 * can, in general, return, but in this case, it's not, since
+	 * we just got a fatal SIGSEGV queued.
+	 */
+	os_dump_core();
+}
+
+/**
+ * segv_handler() - the SIGSEGV handler
+ * @sig:	the signal number
+ * @unused_si:	the signal info struct; unused in this handler
+ * @regs:	the ptrace register information
+ *
+ * The handler first extracts the faultinfo from the UML ptrace regs struct.
+ * If the userfault did not happen in an UML userspace process, bad_segv is called.
+ * Otherwise the signal did happen in a cloned userspace process, handle it.
+ */
+void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs,
+		  void *mc)
+{
+	struct faultinfo *fi = UPT_FAULTINFO(regs);
+
+	/* !MMU specific part; detection of userspace */
+	/* mark is_user=1 when the IP is from userspace code. */
+	if (UPT_IP(regs) > uml_reserved && UPT_IP(regs) < high_physmem)
+		regs->is_user = 1;
+
+	if (UPT_IS_USER(regs) && !SEGV_IS_FIXABLE(fi)) {
+		show_segv_info(regs);
+		bad_segv(*fi, UPT_IP(regs));
+		return;
+	}
+	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs, mc);
+
+	/* !MMU specific part; detection of userspace */
+	arch_sigsegv_handler(sig, unused_si, mc);
+}
+
+/*
+ * We give a *copy* of the faultinfo in the regs to segv.
+ * This must be done, since nesting SEGVs could overwrite
+ * the info in the regs. A pointer to the info then would
+ * give us bad data!
+ */
+unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
+		   struct uml_pt_regs *regs, void *mc)
+{
+	int si_code;
+	int err;
+	int is_write = FAULT_WRITE(fi);
+	unsigned long address = FAULT_ADDRESS(fi);
+
+	if (!is_user && regs)
+		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
+
+	if (current->mm == NULL) {
+		show_regs(container_of(regs, struct pt_regs, regs));
+		panic("Segfault with no mm");
+	} else if (!is_user && address > PAGE_SIZE && address < TASK_SIZE) {
+		show_regs(container_of(regs, struct pt_regs, regs));
+		panic("Kernel tried to access user memory at addr 0x%lx, ip 0x%lx",
+		       address, ip);
+	}
+
+	if (SEGV_IS_FIXABLE(&fi))
+		err = handle_page_fault(address, ip, is_write, is_user,
+					&si_code);
+	else {
+		err = -EFAULT;
+		/*
+		 * A thread accessed NULL, we get a fault, but CR2 is invalid.
+		 * This code is used in __do_copy_from_user() of TT mode.
+		 * XXX tt mode is gone, so maybe this isn't needed any more
+		 */
+		address = 0;
+	}
+
+	if (!err)
+		goto out;
+	else if (!is_user && arch_fixup(ip, regs))
+		goto out;
+
+	if (!is_user) {
+		show_regs(container_of(regs, struct pt_regs, regs));
+		panic("Kernel mode fault at addr 0x%lx, ip 0x%lx",
+		      address, ip);
+	}
+
+	show_segv_info(regs);
+
+	if (err == -EACCES) {
+		current->thread.arch.faultinfo = fi;
+		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
+	} else {
+		WARN_ON_ONCE(err != -EFAULT);
+		current->thread.arch.faultinfo = fi;
+		force_sig_fault(SIGSEGV, si_code, (void __user *) address);
+	}
+
+out:
+	if (regs)
+		current->thread.segv_regs = NULL;
+
+	return 0;
+}
+
+void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs,
+		  void *mc)
+{
+	int code, err;
+
+	if (!UPT_IS_USER(regs)) {
+		if (sig == SIGBUS)
+			pr_err("Bus error - the host /dev/shm or /tmp mount likely just ran out of space\n");
+		panic("Kernel mode signal %d", sig);
+	}
+
+	arch_examine_signal(sig, regs);
+
+	/* Is the signal layout for the signal known?
+	 * Signal data must be scrubbed to prevent information leaks.
+	 */
+	code = si->si_code;
+	err = si->si_errno;
+	if ((err == 0) && (siginfo_layout(sig, code) == SIL_FAULT)) {
+		struct faultinfo *fi = UPT_FAULTINFO(regs);
+
+		current->thread.arch.faultinfo = *fi;
+		force_sig_fault(sig, code, (void __user *)FAULT_ADDRESS(*fi));
+	} else {
+		pr_err("Attempted to relay unknown signal %d (si_code = %d) with errno %d\n",
+		       sig, code, err);
+		force_sig(sig);
+	}
+}
+
+void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs,
+	   void *mc)
+{
+	do_IRQ(WINCH_IRQ, regs);
+}
diff --git a/arch/x86/um/nommu/do_syscall_64.c b/arch/x86/um/nommu/do_syscall_64.c
index 74d5bcc4508d..d77e69e097c1 100644
--- a/arch/x86/um/nommu/do_syscall_64.c
+++ b/arch/x86/um/nommu/do_syscall_64.c
@@ -44,6 +44,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	/* set fs register to the original host one */
 	os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
 
+	/* save fp registers */
+	asm volatile("fxsaveq %0" : "=m"(*(struct _xstate *)regs->regs.fp));
+
 	if (likely(syscall < NR_syscalls)) {
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
@@ -54,6 +57,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	/* handle tasks and signals at the end */
 	interrupt_end();
 
+	/* restore fp registers */
+	asm volatile("fxrstorq %0" : : "m"((current->thread.regs.regs.fp)));
+
 	/* restore back fs register to userspace configured one */
 	os_x86_arch_prctl(0, ARCH_SET_FS,
 		      (void *)(current->thread.regs.regs.gp[FS_BASE
diff --git a/arch/x86/um/nommu/os-Linux/mcontext.c b/arch/x86/um/nommu/os-Linux/mcontext.c
index c4ef877d5ea0..955e7d9f4765 100644
--- a/arch/x86/um/nommu/os-Linux/mcontext.c
+++ b/arch/x86/um/nommu/os-Linux/mcontext.c
@@ -6,6 +6,17 @@
 #include <sysdep/mcontext.h>
 #include <sysdep/syscalls.h>
 
+static void __userspace_relay_signal(void)
+{
+	/* XXX: dummy syscall */
+	__asm__ volatile("call *%0" : : "r"(__kernel_vsyscall), "a"(39) :);
+}
+
+void set_mc_userspace_relay_signal(mcontext_t *mc)
+{
+	mc->gregs[REG_RIP] = (unsigned long) __userspace_relay_signal;
+}
+
 void set_mc_sigsys_hook(mcontext_t *mc)
 {
 	mc->gregs[REG_RCX] = mc->gregs[REG_RIP];
diff --git a/arch/x86/um/shared/sysdep/mcontext.h b/arch/x86/um/shared/sysdep/mcontext.h
index 9a0d6087f357..479fd923ff1d 100644
--- a/arch/x86/um/shared/sysdep/mcontext.h
+++ b/arch/x86/um/shared/sysdep/mcontext.h
@@ -19,6 +19,7 @@ extern int set_stub_state(struct uml_pt_regs *regs, struct stub_data *data,
 
 #ifndef CONFIG_MMU
 extern void set_mc_sigsys_hook(mcontext_t *mc);
+extern void set_mc_userspace_relay_signal(mcontext_t *mc);
 #endif
 
 #ifdef __i386__
diff --git a/arch/x86/um/shared/sysdep/ptrace.h b/arch/x86/um/shared/sysdep/ptrace.h
index 8f7476ff6e95..7d553d9f05be 100644
--- a/arch/x86/um/shared/sysdep/ptrace.h
+++ b/arch/x86/um/shared/sysdep/ptrace.h
@@ -65,7 +65,7 @@ struct uml_pt_regs {
 	int is_user;
 
 	/* Dynamically sized FP registers (holds an XSTATE) */
-	unsigned long fp[];
+	unsigned long fp[] __attribute__((aligned(16)));
 };
 
 #define EMPTY_UML_PT_REGS { }
-- 
2.43.0


