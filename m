Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9E4E7717F
	for <linux-um@archiver.kernel.org>; Sun,  8 Dec 2024 10:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vu50lXv4woP6IU7nnp1FzBlJv7AJlGGtZ0BwNqXpKeI=; b=3MXsOKmC/nyzqaEYng1UAmNbzC
	CzagYOzW/U14pV7kqfbXngFhU0nhiWk06pEWR2oZ1rlh73A5FawX6d/KgvGli3ehTtJTHmswj8spB
	VA4bdipwMrw09IJmHKE3lrLtECNIxuXBYQVlzE7nxLwFKnhuiyexWYh1srSECMPcjjA84gGR0K7Se
	5jDCvocmLvC9hRu2w0/s5CWqFf2ALbTQRFlHjC5bGt3HcIVg8UJA6Z97Pa1FQxdXfzSatnmqFcJV3
	NeKaHfzFegLtJVLiT5FoYcDfd96ZHhOA6wpLMFJ1A5dX2e+5KN8W5CRWcj8C+qbyhvv22TIBEcrQG
	oGT96sNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKw-000000057fr-3wis;
	Sun, 08 Dec 2024 10:16:26 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKu-000000057eo-1fGp
	for linux-um@lists.infradead.org;
	Sun, 08 Dec 2024 10:16:25 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-7fd21e4a9c0so2219271a12.3
        for <linux-um@lists.infradead.org>; Sun, 08 Dec 2024 02:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733652983; x=1734257783; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vu50lXv4woP6IU7nnp1FzBlJv7AJlGGtZ0BwNqXpKeI=;
        b=Wt3eEzhCjHEP3BTsR5Hd/GiGsHS3e96Y82rsdzxAWW73hcp77KiY+mM6QYILsifnPT
         O4byOTgJ73bEZ1c9Uri0FrmJIN+eI0nGK4XN4FUA1e5MtuBWA0nECQ++GvdXuvNyy2X6
         XK0F1zQIXxK6Z1ASFXtcC10Z6/uWcb89tWvBdqAw6HW/f4B0fkglANazAWEuj6UXF/bF
         QpYGsDiZMNJySENH8fJ/7XmwyjZUzlMjruYiWbzzIc184cEZCLwR/ULztpGNjpXXmt+I
         7vVmEovxxAsJNONJ8rtR48ZbDaqYiY4gvZ4VO9WwrjrLyhZicOE5I+P0ARvgpOOymTn1
         mGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733652983; x=1734257783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vu50lXv4woP6IU7nnp1FzBlJv7AJlGGtZ0BwNqXpKeI=;
        b=w8ISWpuu/y/d8U3sSsupA/2Aa5wo7YBXeOBrvjeXx2NbTZP64s+WLg8VwSZjdtEhFF
         ewsp/SD2POky5Pz0M6TFbfxjIg7wLB61J7Gve3KY3abvHIvyt9apH0gdKIEAq374GXXs
         SgCS8TZBRYPJxY4SUmEqpqHr/XOaihSzCeeS9Cnfp/br12X+LmuTQR7IEoHQ+x9g/wUD
         7YOLw05Sizngczv285JRKRbsPKVSRE1DkRxIIrEtqTAmhAiDIC6MpdpAfOAed5MXq+wR
         qy8odx9QvZbh4BVe1dX9suI29BuzSKPoY2aCEbMJoPo1ALA5oGnJS+ST4S/wVA858drV
         RSZw==
X-Gm-Message-State: AOJu0YyWr6fO/SH82dXPb8IxA6n+mtlFSiKzZgfy8gkg3s+kY9Q2LHk9
	Px0YJi4hRyejN8OgnHe+IsHuhkji6a/+zZP8V1Tk8ren4wq+3gKj
X-Gm-Gg: ASbGncvPAU6Sk9EGn5XSQScLsufS8+iN86FTNH+Tj8+f16DwmivfypQYO2jZabE4OuF
	I2tOP9XS61tC8DCxzar3tQ9P1jGuc7PjZjcdf/vQNS0B6AT103M8t34t7qK+mzyj8i18Ws7DcRz
	mL7c2hbnWlviMsFtp0UtXGayi2tqyjHDauHR2H+kW+pYHdHDoUED8IqRpzm+sNZPWFAgaOb7eEi
	DF+u9fFewTuvLNPWAnSDq9CzpE4m0evgauWt3owzmH5xOFIcqWUoX9VtU2vfL/MF5xfr4sbNjHk
	ijJVjmD1ubYSj2TVLwHt
X-Google-Smtp-Source: AGHT+IESV9Ie/kZZvj4wxeR62SsMM0i8TmUuT4t/qRO83A+kPRSamTmgyslsrvHRjwq8bzPd6I2G/A==
X-Received: by 2002:a17:90b:2f86:b0:2ee:d9f5:cfb4 with SMTP id 98e67ed59e1d1-2ef6aaddea6mr11454461a91.36.1733652983400;
        Sun, 08 Dec 2024 02:16:23 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ff86d9sm7964674a91.1.2024.12.08.02.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 02:16:22 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 969CDDDB032; Sun,  8 Dec 2024 19:16:20 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v4 10/13] x86/um: nommu: signal handling
Date: Sun,  8 Dec 2024 19:15:37 +0900
Message-ID: <aa935a0f32fec0ff4073fb004eab4b22f80ac750.1733652929.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733652929.git.thehajime@gmail.com>
References: <cover.1733652929.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_021624_437856_B1EDFADD 
X-CRM114-Status: GOOD (  33.98  )
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
environment. 1) the stack preparation for the signal handlers and
2) restoration of stack after rt_sigreturn(2) syscall.  Those are needed
as the stack usage on vfork(2) syscall is different.

It also adds the follow up routine for SIGSEGV as a signal delivery runs
in the same stack frame while we have to avoid endless SIGSEGV.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/nommu/Makefile                |   2 +-
 arch/um/nommu/trap.c                  | 188 ++++++++++++++++++++++++++
 arch/um/os-Linux/signal.c             |   6 +
 arch/x86/um/nommu/Makefile            |   2 +-
 arch/x86/um/nommu/os-Linux/mcontext.c |  11 ++
 arch/x86/um/nommu/signal.c            |  43 ++++++
 arch/x86/um/shared/sysdep/mcontext.h  |   1 +
 arch/x86/um/shared/sysdep/signal.h    |  22 +++
 arch/x86/um/signal.c                  |  17 ++-
 9 files changed, 289 insertions(+), 3 deletions(-)
 create mode 100644 arch/um/nommu/trap.c
 create mode 100644 arch/x86/um/nommu/signal.c
 create mode 100644 arch/x86/um/shared/sysdep/signal.h

diff --git a/arch/um/nommu/Makefile b/arch/um/nommu/Makefile
index baab7c2f57c2..096221590cfd 100644
--- a/arch/um/nommu/Makefile
+++ b/arch/um/nommu/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := os-Linux/
+obj-y := trap.o os-Linux/
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
index 97efdabe1e45..83e46c047f6c 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -50,6 +50,12 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 	(*sig_info[sig])(sig, si, &r);
 
 	errno = save_errno;
+
+#ifndef CONFIG_MMU
+	/* !MMU: force handle signals after rt_sigreturn() */
+	if (r.is_user && sig == SIGSEGV)
+		mc_set_regs_ip_relay(mc);
+#endif
 }
 
 /*
diff --git a/arch/x86/um/nommu/Makefile b/arch/x86/um/nommu/Makefile
index 03865bf1428e..068e44ad4c4d 100644
--- a/arch/x86/um/nommu/Makefile
+++ b/arch/x86/um/nommu/Makefile
@@ -5,4 +5,4 @@ else
 	BITS := 64
 endif
 
-obj-y = do_syscall_$(BITS).o entry_$(BITS).o process.o syscalls_$(BITS).o os-Linux/
+obj-y = do_syscall_$(BITS).o entry_$(BITS).o process.o signal.o syscalls_$(BITS).o os-Linux/
diff --git a/arch/x86/um/nommu/os-Linux/mcontext.c b/arch/x86/um/nommu/os-Linux/mcontext.c
index d05722307acb..2d5148848f88 100644
--- a/arch/x86/um/nommu/os-Linux/mcontext.c
+++ b/arch/x86/um/nommu/os-Linux/mcontext.c
@@ -6,6 +6,17 @@
 #include <sysdep/mcontext.h>
 #include <sysdep/syscalls.h>
 
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
 void mc_set_sigsys_hook(mcontext_t *mc)
 {
 	mc->gregs[REG_RSP] -= sizeof(unsigned long);
diff --git a/arch/x86/um/nommu/signal.c b/arch/x86/um/nommu/signal.c
new file mode 100644
index 000000000000..a94e9b86273a
--- /dev/null
+++ b/arch/x86/um/nommu/signal.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/syscalls.h>
+#include <linux/kernel.h>
+#include <asm/sigframe.h>
+
+#include <sysdep/signal.h>
+
+int arch_setup_signal_stack_si(struct rt_sigframe __user **frame,
+			       struct ksignal *ksig)
+{
+	int err = 0;
+
+	/*
+	 * we need to push handler address at top of stack, as
+	 * __kernel_vsyscall, called after this returns with ret with
+	 * stack contents, thus push the handler here.
+	 */
+	*frame = (struct rt_sigframe __user *) ((unsigned long) *frame -
+					       sizeof(unsigned long));
+	err |= __put_user((unsigned long)ksig->ka.sa.sa_handler,
+			  (unsigned long *)*frame);
+
+	return err;
+}
+
+struct rt_sigframe *arch_setup_rt_sigreturn(struct rt_sigframe *frame)
+{
+	/**
+	 * we enter here with:
+	 *
+	 * __restore_rt:
+	 *     mov $15, %rax
+	 *     syscall      ; => __kernel_vsyscall (hooked)
+	 *
+	 * (code is from musl libc)
+	 * so, stack needs to be popped of "call"ed address before
+	 * looking at rt_sigframe.
+	 */
+	frame = (struct rt_sigframe __user *)((unsigned long)frame + sizeof(long));
+
+	return frame;
+}
diff --git a/arch/x86/um/shared/sysdep/mcontext.h b/arch/x86/um/shared/sysdep/mcontext.h
index 3f2dc3a2995c..0e837f4b5757 100644
--- a/arch/x86/um/shared/sysdep/mcontext.h
+++ b/arch/x86/um/shared/sysdep/mcontext.h
@@ -9,6 +9,7 @@
 extern void get_regs_from_mc(struct uml_pt_regs *, mcontext_t *);
 #ifndef CONFIG_MMU
 extern void mc_set_sigsys_hook(mcontext_t *mc);
+extern void mc_set_regs_ip_relay(mcontext_t *mc);
 #endif
 
 #ifdef __i386__
diff --git a/arch/x86/um/shared/sysdep/signal.h b/arch/x86/um/shared/sysdep/signal.h
new file mode 100644
index 000000000000..78a55ed85c89
--- /dev/null
+++ b/arch/x86/um/shared/sysdep/signal.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __SYSDEP_X86_64_SIGNAL_H__
+#define __SYSDEP_X86_64_SIGNAL_H__
+
+#ifdef CONFIG_MMU
+static inline int arch_setup_signal_stack_si(struct rt_sigframe **frame,
+					     struct ksignal *ksig)
+{
+	return 0;
+}
+static inline struct rt_sigframe *arch_setup_rt_sigreturn(struct rt_sigframe *frame)
+{
+	return frame;
+}
+#else
+extern int arch_setup_signal_stack_si(struct rt_sigframe **frame,
+				      struct ksignal *ksig);
+extern struct rt_sigframe *arch_setup_rt_sigreturn(struct rt_sigframe *frame);
+#endif
+
+#endif
diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 75087e85b6fd..8d4cf7cc7c29 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -19,6 +19,8 @@
 #include <linux/regset.h>
 #include <asm/sigframe.h>
 
+#include <sysdep/signal.h>
+
 #ifdef CONFIG_X86_32
 struct _xstate_64 {
 	struct _fpstate_64		fpstate;
@@ -370,6 +372,13 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 	frame = (struct rt_sigframe __user *)
 		round_down(stack_top - sizeof(struct rt_sigframe), 16);
 
+#ifndef CONFIG_MMU
+	/*
+	 * the sig_frame on !MMU needs be aligned for SSE as
+	 * the frame is used as-is.
+	 */
+	math_size = round_down(math_size, 16);
+#endif
 	/* Add required space for math frame */
 	frame = (struct rt_sigframe __user *)((unsigned long)frame - math_size);
 
@@ -417,6 +426,8 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 		/* could use a vstub here */
 		return err;
 
+	/* fixup rt_sigframe for nommu */
+	err |= arch_setup_signal_stack_si(&frame, ksig);
 	if (err)
 		return err;
 
@@ -442,9 +453,13 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	unsigned long sp = PT_REGS_SP(&current->thread.regs);
 	struct rt_sigframe __user *frame =
 		(struct rt_sigframe __user *)(sp - sizeof(long));
-	struct ucontext __user *uc = &frame->uc;
+	struct ucontext __user *uc;
 	sigset_t set;
 
+	/* fixup rt_sigframe for nommu */
+	frame = arch_setup_rt_sigreturn(frame);
+	uc = &frame->uc;
+
 	if (copy_from_user(&set, &uc->uc_sigmask, sizeof(set)))
 		goto segfault;
 
-- 
2.43.0


