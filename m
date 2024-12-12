Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DB0E77182
	for <linux-um@archiver.kernel.org>; Thu, 12 Dec 2024 10:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vsYPvCmsoZs1Sko1MMm4L4p1PItFGeYJ1SaKpihuUjU=; b=aJybE1fJsA6kiHdsr7DYrQvYIe
	PzZsbyBdzBlYWz1pnE9Rk9dRj+sN4xJoqkKK71z+49tkPkvSD2dI7PZSKYN9ABJPkNEv3BV2pl5cF
	zoUDjKeBV3+4H8KPDIr1Oy72NYMRjwk8nZy9mA8GuxrTbVXolZm9xK3SY0MXaPtrWGDisbxR+PbOY
	EoLE0UTuNxOzOCn5/f747KkNnAAwSEIwJPBiI3EkSt/dLqGfB27Y0tp5n0oeOJ98SV3agLZAYJvur
	njo2QlXaTJcv4G6IhPZe2ZR0BRGIOpla2lNQD6sEosif/NhWM0P89lQXjuuy+Ut9ZSCT97r3N74wD
	mwwiADNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgDg-000000001Uj-37Uc;
	Thu, 12 Dec 2024 10:14:56 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgDQ-000000001MH-1Wno
	for linux-um@lists.infradead.org;
	Thu, 12 Dec 2024 10:14:41 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-801c081a652so40524a12.0
        for <linux-um@lists.infradead.org>; Thu, 12 Dec 2024 02:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733998479; x=1734603279; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsYPvCmsoZs1Sko1MMm4L4p1PItFGeYJ1SaKpihuUjU=;
        b=eAK/D2QwvFxq7J52UOr+datCfGhubhLazGcwTjIB+FsmYgBuhVCCip4G9Wl5ykY3uC
         U7So/suHZEjxpOsZeIDv8n7HBEyPjbk/DUrM2ivBSOAVboPX+a4viiOEdo/Fh2H4BQtS
         WbA/D017oTqhMWuaCNdGxtxA1yQKYhXX74wJed2xNnKcQDLbSk0+LqdnmCQ+PBGjFKtN
         E7gKt/oMNsDy5cwGQmRqqouAYYPQ+yMHm8Iq78rtGxWl90lNIT2Chb7649tNvapU5bLT
         44oGi5AQd6nctXIU0DyaNPsunDOyeROASaah5Gs+GLuP7qw/+sgPCVFSPb8cFeQqhNso
         HUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998479; x=1734603279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsYPvCmsoZs1Sko1MMm4L4p1PItFGeYJ1SaKpihuUjU=;
        b=UbXFKY/NQP2NDLDAyy2SBRr4gnRof7AMRK7Ck0GPTWIXdqQd5wizBc/CPYQH1Jp5B8
         rq8m0tM8sig/s84kTvEM+DXFto93ZQhcgsDiLAVdQtxq5bE421ZP52dNapG556jkTJ9p
         TUjAposc2RNQrLsCjn98F1aGnV3ZEPdAVPwMQCMo7syczgV/qXEV3GYt3ZfIL7KcZL6O
         32opghHw5KCTK52mzqK9ce9yL6EdZMF1p3vnfCWkbxhGiNKJ+U4ZyDBfmf6pNrGB753Y
         UyeVC6rIOH3NrolQSYzygdW4SISpxMeavIkpIwNmxeNgCp1RmKDkBBLzoez9afxSpn6N
         rlBg==
X-Gm-Message-State: AOJu0YzGctUShHWLVv7wxmss+jNJIiqS12ykFZQLzPvmPEIHcAaHiAsj
	0WKmpgUnfh4m0Um25CViHD0Z0JCpiqzdIHXf2WBeiWBVnEWtKqMSmjyTLw==
X-Gm-Gg: ASbGncsGOnvjRqgfUQ2HVXw6BEmz0fuvlH7EWkqLvui8Ojgl/lCFSfdIxzcMXxJ028l
	h/5V2f0YfgYas0WcmrD0GQbyXqA3mlHjCZRpWRK3G8ZG3LNNnpyPnQoaJ/yDN3m+FcX/2uzQK0n
	XD2jXCRVOYRMYyiCZbJNJo7hSqZYiWlaC8yxeVYPXOy4uypyx8Ds4Jk6ZkyVGFmJHftDdgI37Gv
	Laq4wfobg2sqGzQO5pCYEa5ndCZvfH6WzafggSi/2eRfDHlnkNCnG5PV9ryQJ54MJHie67JEeci
	ecJtnPoTZ3gU6fNhg/436SJUTr4=
X-Google-Smtp-Source: AGHT+IGyYyZoto+83YdCP5n2PfwcYK4wvPVYF5qQxdG4YRBq4yZAh1adgnPZylQXgMknK/WutQYqYQ==
X-Received: by 2002:a17:90a:ec8e:b0:2ee:cbd0:4910 with SMTP id 98e67ed59e1d1-2f13ab8de59mr4105654a91.1.1733998479341;
        Thu, 12 Dec 2024 02:14:39 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f12ccef74fsm1256896a91.1.2024.12.12.02.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:14:38 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id A7EF7DDEED0; Thu, 12 Dec 2024 19:14:36 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v5 10/13] x86/um: nommu: signal handling
Date: Thu, 12 Dec 2024 19:12:17 +0900
Message-ID: <87a110be37e25489f1016e5147f3f74e3966efa2.1733998168.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733998168.git.thehajime@gmail.com>
References: <cover.1733998168.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_021440_405304_20F8BDB5 
X-CRM114-Status: GOOD (  30.72  )
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

It also adds the follow up routine for SIGSEGV as a signal delivery runs
in the same stack frame while we have to avoid endless SIGSEGV.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/nommu/Makefile                |   2 +-
 arch/um/nommu/trap.c                  | 188 ++++++++++++++++++++++++++
 arch/um/os-Linux/signal.c             |   6 +
 arch/x86/um/nommu/os-Linux/mcontext.c |  11 ++
 arch/x86/um/shared/sysdep/mcontext.h  |   1 +
 arch/x86/um/signal.c                  |   7 +
 6 files changed, 214 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/nommu/trap.c

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
diff --git a/arch/x86/um/nommu/os-Linux/mcontext.c b/arch/x86/um/nommu/os-Linux/mcontext.c
index d74bc0726a28..cbb1cc4dabbb 100644
--- a/arch/x86/um/nommu/os-Linux/mcontext.c
+++ b/arch/x86/um/nommu/os-Linux/mcontext.c
@@ -6,6 +6,17 @@
 #include <sysdep/mcontext.h>
 #include <sysdep/syscalls.h>
 
+static void userspace_relay_signal(void)
+{
+	/* XXX: dummy syscall */
+	__asm__ volatile("call *%0" : : "r"(__kernel_vsyscall), "a"(39) :);
+}
+
+void mc_set_regs_ip_relay(mcontext_t *mc)
+{
+	mc->gregs[REG_RIP] = (unsigned long) userspace_relay_signal;
+}
+
 void mc_set_sigsys_hook(mcontext_t *mc)
 {
 	mc->gregs[REG_RCX] = mc->gregs[REG_RIP];
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
diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 75087e85b6fd..ea6b408e37d2 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -370,6 +370,13 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
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
 
-- 
2.43.0


