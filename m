Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EB8CCFA18
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 08:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sZpI4L1Kh98JdhM/QsHv9mwFGGWJGOR2fxfWgHIsbW8=; b=i/Ogg3NEiShSqmC5OjA5STv05i
	DYsNiUsef+wO+jpXC8SZthBgIp7qZvknnFZbt3i+mJ1eJ0sX8HE4wkvMfUXrJ0H4zZmstND7UzccA
	xm9W5BWSabIq6KN5XCnptX7vMi58aeptzklw9LKAM/N3Q+TbEO3wlsfgXXkPdxDZLj5//cxhC9Ujk
	WZ6uHuu+E1ZkR6NaqalbRl2rLBMjAP0eYn6snpQYaoAENUZybpGmfKtdxzLSCNYfNtAW3YdJAl+KW
	AHTXl/8KlEl84ffMrGZunvgqw/Az3/Va4naMejPiHnBuv+FjQnkrbbQOBNj7u1Wefa4zcHbjT1GQc
	wmj9leew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxl-00000002j4I-2jEz;
	Sat, 08 Nov 2025 08:06:21 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxi-00000002j1P-1SEP
	for linux-um@lists.infradead.org;
	Sat, 08 Nov 2025 08:06:19 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-7afd7789ccdso1458346b3a.2
        for <linux-um@lists.infradead.org>; Sat, 08 Nov 2025 00:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589177; x=1763193977; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZpI4L1Kh98JdhM/QsHv9mwFGGWJGOR2fxfWgHIsbW8=;
        b=Cvky0bjwqSWGwJSyqJMzaZkytZvXG7tYLBHxeUuqz4bHwkvryaFn+/D14wSVQvxBuW
         pxGCmnV3Ty807jI3YFetu826dtWKFmtyzckOMCEcUCIVFLSjKTp0Z9K3JzoodLMHswpq
         KoLUTx8Vhfg4ToZY5Nzp/2m0SDhMEoSB2sTQn/ZDCJ9QuYlQAEDdaptrEkRd8WHu2iE6
         UJH08X3TeQSJzw6tfQ34a97BAVLktct4zlll+xRRUBFR40F2pJ3BryEZmYLD1SFPQNqU
         DUu4+mezFD9qjgY+gvHvbPG6QxAwbV6Th2x3YrqCtCBz8YV5yRUBmJinCNAlLNgtT49l
         RnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589177; x=1763193977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sZpI4L1Kh98JdhM/QsHv9mwFGGWJGOR2fxfWgHIsbW8=;
        b=t/XCKz/FssjytZJAPZH2HUmPgRzyspbHkrnkdfVIEIyU1y+rdbqUYhCjIqeKVlzkbk
         nzskGU+M1x5CDV2fQV69AXi8TczUylps1zOHlMWCUs4WGzexoK+7qPjUND0h5AyRKpgZ
         bSNU0JH2NrcoxCOIEu25TH1WRyaMhF8JD6tsmRE6Gjw4gqjcI5EFVtQl/V7N43cgPeV8
         vsgTkgIMkrkRqizM4L1ejAtDw7QCemKSrd0VIFWoHs6rQ2Ok6eRWsvwu1/L+XlU3BsmJ
         S1fbURWx89TicA0/CPGyn+32vpo5C3CNKmncLiAkXmfLNm5qpw6/WxlyuyX+v86nPyl9
         EY/w==
X-Gm-Message-State: AOJu0YzO2go1j4jP5hwVOuERBnvvvzbn0cjBfmAhFDKijqvWRIjd81GN
	1o/h+ndkYcrXNXVjtaObYC3jKrhxrIX7XQ7bJVnh/HTziq51aslOM313
X-Gm-Gg: ASbGncsGPFfAOxk471DO8nYhqeZkoXJ1W5gNFWoXKQ5B2EuUU+8h9KxTaRuYiNMaykb
	6MN3Lo2HcV+MBRUMoUj48/24xFkhft5LKiqHGGtx0RZEnsS2SaJjNbY5SaVy1BN/gPzaEUSqStL
	Pjw3vcbe9g3IIm2YPVFDDQlllfz/VGtYTnt2S/0dOCe84yX9rx/0ofzSPO6s+25w8JlT5axR4AF
	GxRgqjPBY0h2pEhQMpIvb09EGAtORtx6DZgNVwaGIsG6gFrvlabRUJFUZi9EhZrOHlGjWd8f7vt
	URofbji3tFwQEs1cUaNYxBWLAQLg91novz201GwiaLL/xlZEtJg+w/l3AGvI67Qfh7Xa/PDGLlP
	KtidziXuyT+xgFBLyMXz0ryLe1dobijYVW2qqNe1ps4YKTUF9W5WMiAkqRf5G8dD9wKvJiWS2vS
	R3d+k75OeExAO3zioKNhvs9uOel97FKPyyc+4NKtZlJa2CTV5G7KwYRQas
X-Google-Smtp-Source: AGHT+IEtQahKb/xhxpS9blrirl5D/G2IB7a8vh9pAl760xoGpH+7uMEuvrcbi80xszZ6UIWdzZ2HYQ==
X-Received: by 2002:a05:6a20:9144:b0:350:fa56:3f45 with SMTP id adf61e73a8af0-353a335664dmr2653669637.35.1762589177334;
        Sat, 08 Nov 2025 00:06:17 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba9024e6e17sm7053523a12.34.2025.11.08.00.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:16 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id EB81211388D7; Sat,  8 Nov 2025 17:06:14 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 09/13] x86/um: nommu: signal handling
Date: Sat,  8 Nov 2025 17:05:44 +0900
Message-ID: <c3d41609286993562214359a6158997e9de06551.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_000618_433225_E06B16C5 
X-CRM114-Status: GOOD (  34.69  )
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
 arch/um/nommu/os-Linux/signal.c       |   8 +
 arch/um/nommu/trap.c                  | 201 ++++++++++++++++++++++++++
 arch/um/os-Linux/signal.c             |   3 +-
 arch/x86/um/nommu/do_syscall_64.c     |   6 +
 arch/x86/um/nommu/os-Linux/mcontext.c |  11 ++
 arch/x86/um/shared/sysdep/mcontext.h  |   1 +
 arch/x86/um/shared/sysdep/ptrace.h    |   2 +-
 9 files changed, 235 insertions(+), 3 deletions(-)
 create mode 100644 arch/um/nommu/trap.c

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 7798f16a4677..46c8d6336ca1 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -70,4 +70,8 @@ void um_idle_sleep(void);
 
 void kasan_map_memory(void *start, size_t len);
 
+#ifndef CONFIG_MMU
+extern void nommu_relay_signal(void *ptr);
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
index 19043b9652e2..6febb178dcda 100644
--- a/arch/um/nommu/os-Linux/signal.c
+++ b/arch/um/nommu/os-Linux/signal.c
@@ -5,6 +5,7 @@
 #include <os.h>
 #include <sysdep/mcontext.h>
 #include <sys/ucontext.h>
+#include <as-layout.h>
 
 void sigsys_handler(int sig, struct siginfo *si,
 		    struct uml_pt_regs *regs, void *ptr)
@@ -14,3 +15,10 @@ void sigsys_handler(int sig, struct siginfo *si,
 	/* hook syscall via SIGSYS */
 	set_mc_sigsys_hook(mc);
 }
+
+void nommu_relay_signal(void *ptr)
+{
+	mcontext_t *mc = (mcontext_t *) ptr;
+
+	set_mc_relay_signal(mc);
+}
diff --git a/arch/um/nommu/trap.c b/arch/um/nommu/trap.c
new file mode 100644
index 000000000000..430297517455
--- /dev/null
+++ b/arch/um/nommu/trap.c
@@ -0,0 +1,201 @@
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
+	relay_signal(sig, unused_si, regs, mc);
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
+	/* !MMU specific part; detection of userspace */
+	/* mark is_user=1 when the IP is from userspace code. */
+	if (UPT_IP(regs) > uml_reserved && UPT_IP(regs) < high_physmem)
+		regs->is_user = 1;
+
+	if (!UPT_IS_USER(regs)) {
+		if (sig == SIGBUS)
+			pr_err("Bus error - the host /dev/shm or /tmp mount likely just ran out of space\n");
+		panic("Kernel mode signal %d", sig);
+	}
+	/* if is_user==1, set return to userspace sig handler to relay signal */
+	nommu_relay_signal(mc);
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
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 2f6795cd884c..28754f56c42b 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -41,9 +41,10 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 	int save_errno = errno;
 
 	r.is_user = 0;
+	if (mc)
+		get_regs_from_mc(&r, mc);
 	if (sig == SIGSEGV) {
 		/* For segfaults, we want the data from the sigcontext. */
-		get_regs_from_mc(&r, mc);
 		GET_FAULTINFO_FROM_MC(r.faultinfo, mc);
 	}
 
diff --git a/arch/x86/um/nommu/do_syscall_64.c b/arch/x86/um/nommu/do_syscall_64.c
index 9bc630995df9..cf5a347ee9b1 100644
--- a/arch/x86/um/nommu/do_syscall_64.c
+++ b/arch/x86/um/nommu/do_syscall_64.c
@@ -44,6 +44,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	/* set fs register to the original host one */
 	os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
 
+	/* save fp registers */
+	asm volatile("fxsaveq %0" : "=m"(*(struct _xstate *)regs->regs.fp));
+
 	if (likely(syscall < NR_syscalls)) {
 		unsigned long ret;
 
@@ -61,6 +64,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	/* handle tasks and signals at the end */
 	interrupt_end();
 
+	/* restore fp registers */
+	asm volatile("fxrstorq %0" : : "m"((current->thread.regs.regs.fp)));
+
 	/* restore back fs register to userspace configured one */
 	os_x86_arch_prctl(0, ARCH_SET_FS,
 		      (void *)(current->thread.regs.regs.gp[FS_BASE
diff --git a/arch/x86/um/nommu/os-Linux/mcontext.c b/arch/x86/um/nommu/os-Linux/mcontext.c
index b62a6195096f..afa20f1e235a 100644
--- a/arch/x86/um/nommu/os-Linux/mcontext.c
+++ b/arch/x86/um/nommu/os-Linux/mcontext.c
@@ -4,10 +4,21 @@
 #include <asm/ptrace.h>
 #include <sysdep/ptrace.h>
 #include <sysdep/mcontext.h>
+#include <os.h>
+#include "../syscalls.h"
 
 extern long __kernel_vsyscall(int64_t a0, int64_t a1, int64_t a2, int64_t a3,
 			      int64_t a4, int64_t a5, int64_t a6);
 
+void set_mc_relay_signal(mcontext_t *mc)
+{
+	/* configure stack and userspace returning routine as
+	 * instruction pointer
+	 */
+	mc->gregs[REG_RSP] = (unsigned long) current_top_of_stack;
+	mc->gregs[REG_RIP] = (unsigned long) userspace;
+}
+
 void set_mc_sigsys_hook(mcontext_t *mc)
 {
 	mc->gregs[REG_RCX] = mc->gregs[REG_RIP];
diff --git a/arch/x86/um/shared/sysdep/mcontext.h b/arch/x86/um/shared/sysdep/mcontext.h
index 9a0d6087f357..82a5f38b350f 100644
--- a/arch/x86/um/shared/sysdep/mcontext.h
+++ b/arch/x86/um/shared/sysdep/mcontext.h
@@ -19,6 +19,7 @@ extern int set_stub_state(struct uml_pt_regs *regs, struct stub_data *data,
 
 #ifndef CONFIG_MMU
 extern void set_mc_sigsys_hook(mcontext_t *mc);
+extern void set_mc_relay_signal(mcontext_t *mc);
 #endif
 
 #ifdef __i386__
diff --git a/arch/x86/um/shared/sysdep/ptrace.h b/arch/x86/um/shared/sysdep/ptrace.h
index 572ea2d79131..6ed6bb1ca50e 100644
--- a/arch/x86/um/shared/sysdep/ptrace.h
+++ b/arch/x86/um/shared/sysdep/ptrace.h
@@ -53,7 +53,7 @@ struct uml_pt_regs {
 	int is_user;
 
 	/* Dynamically sized FP registers (holds an XSTATE) */
-	unsigned long fp[];
+	unsigned long fp[] __attribute__((aligned(16)));
 };
 
 #define EMPTY_UML_PT_REGS { }
-- 
2.43.0


