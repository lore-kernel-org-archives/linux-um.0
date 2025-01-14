Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67E8E77188
	for <linux-um@archiver.kernel.org>; Tue, 14 Jan 2025 11:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZADUv9zXGIH0MWe+tnEf4XyZS6DAOif0/DvfJvYKRBQ=; b=EmbjhBBeJc9KOj2pi+Q84yXbu6
	dqzAtyo9pNap0d9RXks0y/XPFiPGcRUIukQJZBfUb+ubJLIpHKOFpajRjBmVzZJEBsNGtVQzYWzB7
	9P9ZAICXhkOtspMNpkvZ/NxKz86v7AwxzFOUHFin5c/dEHKXJnwkdMFTvBT2P8/rcXBNBD2ciTBjR
	UJMrd9MGym1jjcAx9pL1FqaSil+VgtDGQhbUqrjnUsmTTd7+T9h+x6Wxu0eYZI5zJ/bUoFDjp9VU3
	qLtSN3btXe2wKbnWE7j2Cl8JL/OkSdmPW3FHgBT0JAgHjpGBEE/w32LP4YH8dPrg33pTP8E0AhpnX
	YbPEFlUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf9d-00000008GNT-1ooA;
	Tue, 14 Jan 2025 11:32:17 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf8j-00000008G81-03Wx
	for linux-um@lists.infradead.org;
	Tue, 14 Jan 2025 11:31:22 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so9283640a91.2
        for <linux-um@lists.infradead.org>; Tue, 14 Jan 2025 03:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736854280; x=1737459080; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZADUv9zXGIH0MWe+tnEf4XyZS6DAOif0/DvfJvYKRBQ=;
        b=EIhbWcTm8Cf6Bx3IcmFZR4n+3uwaXwJfwwIizxE6wPIffffwK8ZmV6Bw/JelJy7rYB
         7lDi7jIdiV76vPwx+HqoART4ya9Raj+xPoiivGtlHQ4FefwPTed3guaE9/z8nohBnnFU
         QQC8o+IZaGFFHhbM67lFi9oVdIxfBYjKzORAjv37rM1HwutQ9n484g1zTj2ETSRJE4XM
         c/XOijqIoTPFCcwGDcJLVefuXv3dJeTDJAqYLjBKWBztDJ1rBOTKVyqIa+wmqgrKYW/V
         aijhrmCWwFUQUQA0LIttnWbG3NV5e627gnJnb5y0Ey4ixjfki7TCJbuvdkQfyUvNCcap
         7c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736854280; x=1737459080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZADUv9zXGIH0MWe+tnEf4XyZS6DAOif0/DvfJvYKRBQ=;
        b=h/OzvjRMyCwHEX7Vo/K4t9UEvg0zggOEVVirzzNWXMZQn19JlOlk6OZiK8J2ggYJXu
         5ZJBK2pqwyDedXX4Za37rMDbYfGtmlXrBG/LO2FT3+nddWzVeWKxctgnV8ZNM/xUVl0V
         ee8c9Hi1f5NYJyhVfdaJ0p0W0heitYWiudVccml1CuTOySNqdeXHv5u/uu1gXzimCwe2
         4ZSAR/elOrcxtxWOV6Pi+W/pT9T50g3bznslTBxAXxxUNcDx2lrcFvLS4wsC16GqEkha
         8cxPxTxCQw3NRtKJECrq7I9ds+ScBFJZsuZ7FlDGpPfNfGrrYM4sCRpTQjxiAOhTrpcp
         BFIw==
X-Gm-Message-State: AOJu0Yy/kdgfvhJdSeWjMYdekfJ5KlKpYVEOYi/VRiL6c1F7nd6+M5hg
	MpRzXixy7ze3HcefLk/3lOk0fEEXRGKFqGa/kRIOFgLr0T4O6IxL
X-Gm-Gg: ASbGncudqZ8+o7sYxcvq+uhhpmVsocosF8nA/jCRwvqpeWhzQ6ACwI060GaGxvpczkt
	y3ddxaFV/JiWpZkFHY8o6BdkXa07Y0WY30r5ZfX4GTCNDj8vCgVLnm2aJWMsY35Pocb6UFJIAmY
	lMtVogb2Rs7dUuwgBcvC0BFAa6PzPyC4yeKCFArBxUMk4ERvI5VOi1L/2BA3stjjmJcxZa2wgVp
	K+2PHwmR/giCmUyYGQJZVf33Wvgsu5iMdA1NAim9ZkhUePwpHel4CDvV/6XVQsa2t3y3ue+1IYP
	yWh5wA/T1wmw1TcRUmvVD32ZXZQs
X-Google-Smtp-Source: AGHT+IF9GrNYRrG0VkMaauRnKUZxW8gX7ttnagKSVFefxLTpRAP8KPR8dCsfB5QUcKCwqL0aYSJ5tg==
X-Received: by 2002:a17:90b:250b:b0:2f6:f107:fae4 with SMTP id 98e67ed59e1d1-2f6f107fd61mr6870604a91.8.1736854280214;
        Tue, 14 Jan 2025 03:31:20 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a26aca2sm12593136a91.10.2025.01.14.03.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:31:19 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 493ACE1AB60; Tue, 14 Jan 2025 20:31:17 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v6 10/13] x86/um: nommu: signal handling
Date: Tue, 14 Jan 2025 20:30:48 +0900
Message-ID: <33c031261df405f1ad9539b3b6d32686c44ca4c1.1736853926.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736853925.git.thehajime@gmail.com>
References: <cover.1736853925.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_033121_055930_6924C7FF 
X-CRM114-Status: GOOD (  33.72  )
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
 arch/um/include/shared/kern_util.h    |   4 +
 arch/um/nommu/Makefile                |   2 +-
 arch/um/nommu/os-Linux/signal.c       |  13 ++
 arch/um/nommu/trap.c                  | 188 ++++++++++++++++++++++++++
 arch/um/os-Linux/signal.c             |  25 +++-
 arch/x86/um/nommu/os-Linux/mcontext.c |  11 ++
 arch/x86/um/shared/sysdep/mcontext.h  |   1 +
 arch/x86/um/signal.c                  |   7 +
 8 files changed, 243 insertions(+), 8 deletions(-)
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


