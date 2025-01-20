Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613E1C02185
	for <linux-um@archiver.kernel.org>; Mon, 20 Jan 2025 06:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zy+Mc/gJKL6K+o+rtmKIA1T9GMWoIPlWWZqLcbIP8ls=; b=Uh0VwiAzPuZarZhjiwAoBP8rZR
	bNffMjiAsyFHA/npXby0ibUMYQVA+USi1LQvj6VxHXm2E7JkU3+svGaiq+NO9XC0pRXpTkcQT3Xii
	k9iKsi4GCCqBoBIKU2gtGBqrRDc9XHxmRLaAACS/hPgsDt4nqnfay1EG6HaH1WexcckPVs/LlaMHa
	GTad+YV4PV0/oW0PSqQ7p2rJVt9NX9Hbxvz2MMRbwS3rv1TlG9SHUk34/YyJKpnFbdZqcPXgk+qW0
	q4atJexrD9w7son8IOfiCtmkXqb2mfVfWvbMIHYaw2Ze46bWUVqfFDuYNbe+Fz+kfsEcBMqdYWY/D
	ZXL4dS6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkr3-00000004nTb-3x9K;
	Mon, 20 Jan 2025 06:01:45 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkq2-00000004nIK-3MF6
	for linux-um@lists.infradead.org;
	Mon, 20 Jan 2025 06:00:44 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-216426b0865so69612075ad.0
        for <linux-um@lists.infradead.org>; Sun, 19 Jan 2025 22:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737352842; x=1737957642; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy+Mc/gJKL6K+o+rtmKIA1T9GMWoIPlWWZqLcbIP8ls=;
        b=AeKtXKTiCa0MmRAgs580UOMpbL5tkBCzFwn3YIF3dtNAVdwkX0vuuxHYquiGEQ1e97
         Q6UawCFk1yl0m3uIc0J8espNYVNXBQi8neJPVEr7RbhlURGFu6ce1dkziILUP2YEFWgl
         1Dsh74YKBDGr7GkkjME1WY6aW0nbbdfY+81St5p5g7k3w+SO61A6bkMPXlnS6aM2fNHk
         8R8C5tFiNrIGSoXu8lV92FwiYo2U+cL+pYp2LjvcE9atsqoE0d83HHyeNzvR+yM3jQjP
         T3ulXezdbVZMJ7mHWdLudvDIsftskIHBdVn3ihkqt2KDv9GYmZL3XvDu8go7Yjx9VxcH
         VvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737352842; x=1737957642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy+Mc/gJKL6K+o+rtmKIA1T9GMWoIPlWWZqLcbIP8ls=;
        b=tgSaVthWM+95R7tetmRb5+Uw/jDY4bWE4iQBTOaeHj7PD8oiknbqPeEA3QO3+LgoTo
         c/eL8948GDCuE2r1VBucIgo13Mj7IcPW0CUPYLr/9LSQ0J7rHxIW6PynTD2ICwBagiYU
         ev0wgTQd6hwCb11S80yiqY0+kxsg74GAYt3uqNtPP/6awdRwfGlf6WZ1/uUX9LQm8AIt
         HRqbOVe4Js5Q6PfjjH8YAEJUafYo00bg6OQfWc9D0s70mbV/jpWRaqAtR0IXj2EZFHp+
         Rn+LLsikiBeiWve4S5MwEEvX+/zYJn5ttIEUumxA9uaYsdQoc+CA+5QmYbWn96+iDdsP
         pPpg==
X-Gm-Message-State: AOJu0Yx7xy90l3QOqTAsBACS3bXw3SdvguJ+0TlFaT/u5K+kQlJ4ZZ5Y
	ZPhyp8VX8rQLUUrjTCSF65WK9EkuK+4fwc/qqc8AV9Jyo/namWOs5LINIg==
X-Gm-Gg: ASbGncsxsfOqHTZGF6qCo6cxVZF8+Ewfybi/eTAAkErqNsEONmN3GkOhc/xq6xNAzgC
	NAHGlhga01c8aEZd787KvbQw9PY6w07fV14DppVmlXu4DXV18eij1fWAnSlj20zMbgzP1bfe9uX
	AVZX1SImaBnSBX7DSkFmmSULPMO8I8P0kUVklXZuDbZKOwvfuyP+Lah+aYSuKyIWs5MjEr3hoqq
	bS7DQZrpweGZTo+NuBvRQrvm5ZQVg+BCNVPiam0CZ4PZbBhquhzCXChl5IoMsaQkTh0TQO74ijW
	r9B+4cZ7rgAcnn2kwWHOwdoVT4vtWYNmlzCUDi5CCA==
X-Google-Smtp-Source: AGHT+IEStbMiKQZNxZkUHLNND7GJ2eLKYudVgUkAMFxRCjWvI5RoCDKkvB6yKe6/a/9gOFxCtr1dhQ==
X-Received: by 2002:a05:6a21:6da9:b0:1db:e536:158e with SMTP id adf61e73a8af0-1eb214da8c6mr19569309637.22.1737352841823;
        Sun, 19 Jan 2025 22:00:41 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab84998asm6245529b3a.83.2025.01.19.22.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:00:41 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 76A43E27537; Mon, 20 Jan 2025 15:00:39 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v7 10/13] x86/um: nommu: signal handling
Date: Mon, 20 Jan 2025 15:00:12 +0900
Message-ID: <7714247990d673226ce0f42ca838d8ec338cf882.1737348400.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737348399.git.thehajime@gmail.com>
References: <cover.1737348399.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250119_220043_036790_C8FBD3F5 
X-CRM114-Status: GOOD (  34.44  )
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
 arch/um/nommu/trap.c                  | 188 ++++++++++++++++++++++++++
 arch/um/os-Linux/signal.c             |  25 +++-
 arch/x86/um/nommu/do_syscall_64.c     |   6 +
 arch/x86/um/nommu/os-Linux/mcontext.c |  11 ++
 arch/x86/um/shared/sysdep/mcontext.h  |   1 +
 arch/x86/um/shared/sysdep/ptrace.h    |   2 +-
 9 files changed, 243 insertions(+), 9 deletions(-)
 create mode 100644 arch/um/nommu/trap.c

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 1dd3d02c4e39..3569ca1603a8 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -71,8 +71,12 @@ void kasan_map_memory(void *start, size_t len);
 static inline void arch_sigsys_handler(int sig, struct siginfo *si, void *mc)
 {
 }
+static inline void arch_sigsegv_handler(int sig, struct siginfo *unused_si, void *mc)
+{
+}
 #else
 extern void arch_sigsys_handler(int sig, struct siginfo *si, void *mc);
+extern void arch_sigsegv_handler(int sig, struct siginfo *si, void *mc);
 #endif
 
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
index 1674962e509d..b9e3070f2c36 100644
--- a/arch/um/nommu/os-Linux/signal.c
+++ b/arch/um/nommu/os-Linux/signal.c
@@ -5,6 +5,7 @@
 #include <os.h>
 #include <sysdep/mcontext.h>
 #include <sys/ucontext.h>
+#include <as-layout.h>
 
 void arch_sigsys_handler(int sig, struct siginfo *si, void *ptr)
 {
@@ -13,3 +14,15 @@ void arch_sigsys_handler(int sig, struct siginfo *si, void *ptr)
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
index 000000000000..cda71ecb1115
--- /dev/null
+++ b/arch/um/nommu/trap.c
@@ -0,0 +1,188 @@
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
+void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
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
+	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
+}
+
+/*
+ * We give a *copy* of the faultinfo in the regs to segv.
+ * This must be done, since nesting SEGVs could overwrite
+ * the info in the regs. A pointer to the info then would
+ * give us bad data!
+ */
+unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
+		   struct uml_pt_regs *regs)
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
+void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
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
+void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
+{
+	do_IRQ(WINCH_IRQ, regs);
+}
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 97efdabe1e45..3997d827bf4c 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -37,12 +37,6 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 	int save_errno = errno;
 
 	r.is_user = 0;
-	if (sig == SIGSEGV) {
-		/* For segfaults, we want the data from the sigcontext. */
-		get_regs_from_mc(&r, mc);
-		GET_FAULTINFO_FROM_MC(r.faultinfo, mc);
-	}
-
 	/* enable signals if sig isn't IRQ signal */
 	if ((sig != SIGIO) && (sig != SIGWINCH))
 		unblock_signals_trace();
@@ -177,8 +171,25 @@ static void sigsys_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
 	arch_sigsys_handler(sig, unused_si, mc);
 }
 
+static void sigsegv_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
+{
+	struct uml_pt_regs r;
+	int save_errno = errno;
+
+	r.is_user = 0;
+
+	/* For segfaults, we want the data from the sigcontext. */
+	get_regs_from_mc(&r, mc);
+	GET_FAULTINFO_FROM_MC(r.faultinfo, mc);
+
+	segv_handler(sig, unused_si, &r);
+	arch_sigsegv_handler(sig, unused_si, mc);
+
+	errno = save_errno;
+}
+
 static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
-	[SIGSEGV] = sig_handler,
+	[SIGSEGV] = sigsegv_handler,
 	[SIGBUS] = sig_handler,
 	[SIGILL] = sig_handler,
 	[SIGFPE] = sig_handler,
diff --git a/arch/x86/um/nommu/do_syscall_64.c b/arch/x86/um/nommu/do_syscall_64.c
index 796beb0089fc..48b3d29e2db1 100644
--- a/arch/x86/um/nommu/do_syscall_64.c
+++ b/arch/x86/um/nommu/do_syscall_64.c
@@ -48,6 +48,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	/* set fs register to the original host one */
 	os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
 
+	/* save fp registers */
+	asm volatile("fxsaveq %0" : "=m"(*(struct _xstate *)regs->regs.fp));
+
 	if (likely(syscall < NR_syscalls)) {
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
@@ -66,6 +69,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	set_thread_flag(TIF_SIGPENDING);
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
index 15e9ff287021..0efe5ddf95af 100644
--- a/arch/x86/um/shared/sysdep/mcontext.h
+++ b/arch/x86/um/shared/sysdep/mcontext.h
@@ -9,6 +9,7 @@
 extern void get_regs_from_mc(struct uml_pt_regs *, mcontext_t *);
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


