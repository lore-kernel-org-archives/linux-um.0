Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C803BCAC5A7
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 05:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uT1O8FBsm0dVNsun14WInwimP6kWv851HnymaaK7agg=; b=eC3qgSi3+v1eY7XNdxOapfXaEC
	IpW8fG3HdChmOurfMF4G96aoa1QZaVJ/ciUSb8DO4X+/jCsMB/CGeA4isMK4kXDzdkgKUMrhhXGDT
	jSV29uH1yNnfmDpYtjBmkMw9L3ChWdvOMNgwCURYRGR1q7q4XOYhMbhSoP4Qkv1l8SaXEZdvVTnJE
	bPAJ5Lu8NLw0Qek365WsRk5KfCM8PLfxIWfADH2r5cpTqCClQbYdtLq4qi0Z/iQr1qAyApGHJTwFT
	fywqkkpiVmXmMrF+rsaTcnMyeebtlum0HwNHRhwOmgtsRgantNjTvAQIJiIWaeLy6WXfFNH97E99B
	5iqFnkww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70m-0000000GIMV-2IjY;
	Thu, 18 Sep 2025 05:16:52 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70i-0000000GIGw-16dW
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 05:16:50 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2681660d604so5187305ad.0
        for <linux-um@lists.infradead.org>; Wed, 17 Sep 2025 22:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172607; x=1758777407; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uT1O8FBsm0dVNsun14WInwimP6kWv851HnymaaK7agg=;
        b=A4otS2XctY6Y7IuJ4HNZ6VdU6k7KLanMOxk05O4yyec/CooV2XYRfeagn4SVylhosw
         VelU6tlg28OGuzQFhB8V4+3OjQj3JH/io3xMkQPwg4ntJMH5qyDcFlyxOE91C5bYKUzM
         S8q0C2F2BuwKqHlioKHRRzU8k7yd/TbgB8MnqxjSSY7yU8icMRURDdbf0K4S3jWVsHvj
         o0UCqDP1v5HPwFhU7SHnOx5KjkMMgAOv/lmmem3kjHv2n8d28YfYP/YNDbna3lFOTojq
         TTtT8qxZ+9NVrd0vWQt3r0k7j5CuakJ0qxIdo0k0ey97VIbWIDa80lCB4VSZ1kf5SrZ2
         HrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172607; x=1758777407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uT1O8FBsm0dVNsun14WInwimP6kWv851HnymaaK7agg=;
        b=UMbx7CT0j8c8Cia7W+ed5J0GG3y2wgXKQBmo2335f5gegX08NXV0ahr7zf0YwHNf4A
         YHbg915fZlcU+fh/zKTHcQKTr1pLlg9gT41IKN8c9qBVgzTa5bh8ED70mMthbuy8s3oT
         W+SCjXs6zwtKX32tANkQEgJSA5JmGhAdWHBZoasuwmd2dgR3LFWM2y0+mdxCnlem9vcx
         TadrvkNxIQ57g2oJuE/u50jplOGZfPLdcQaY8VXGu0if/ua6Gf0KOKRzMyigkTjp7avq
         x+ed0xLxrIZVpNj3k2Xi22eNLp6/z1pDvTEoKQ+HWJA0afoxedvhrgC0fLHjKwRDqooY
         Kxxg==
X-Gm-Message-State: AOJu0Yybo5MxGWVyyuK7sB4J1k9reOKGvudlNm0HGlS/7ozVfNmekInx
	cKHZyFsvM25Cb6+DBa2wBjs8obM9SJCR2x1h++T+Pi2aWvLOKTtbrwZE
X-Gm-Gg: ASbGncue16LQPx43ir82Kee+fHflytCTReEPmvhy4+95Bo22BVC5zKzxgv5H0SGanZo
	zTNKs8tk1OiFgjjhsZJZDPw+xyFRNTz/3tKkJ7VPZmuuXNazwt6/eVZWEBBAunsi7sdmARo5A1D
	LxxapFYnf1HBqIWj2hf3MBUyBMJYSOwgOm0TzgTnFKDywWltFgHO2nMa+nOxjygecB1O5ovBsas
	Cvedcvnf8oB2zJ4WZ+cJxme7GzUwCaCfrzOkHn1Jbmvbb2nLSUDeca+EGft8uqU9ScRG/JMgqoA
	MxWkigawax/4Cw+qRG+2P5uZ5t9dZPm1SdXgxNuMCasiCAXANUFGp/3DeTTOWaF87tq9IAleaHB
	Ny9yKp++BKDKsFhcTJdIpDsuaziiQNm77JnMnTM6h62kgXljJfzRkElMpS6dSilccE8ag3tzhkt
	PhxQRpbe92iYA=
X-Google-Smtp-Source: AGHT+IGPjeWatpTtLaGVXEChqNNUpovLoAeNkNeMj9KxkDXsx5I4+56t+qwLzW6GwqvrTUSB8i0ejA==
X-Received: by 2002:a17:903:2ad0:b0:263:e664:7a6b with SMTP id d9443c01a7336-2681218baeamr54735905ad.25.1758172607170;
        Wed, 17 Sep 2025 22:16:47 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfe66916csm1074320b3a.51.2025.09.17.22.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:46 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 48CE01061EF5; Thu, 18 Sep 2025 14:16:45 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 10/14] x86/um: nommu: signal handling
Date: Thu, 18 Sep 2025 14:16:03 +0900
Message-ID: <0b79247275299dd9fc1e20d037d855e7e7f01595.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_221648_312872_2305A081 
X-CRM114-Status: GOOD (  35.32  )
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
index ec8ba1f13c58..7f55402b6385 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -73,4 +73,8 @@ void um_idle_sleep(void);
 
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
index 53e276e81b37..67dcd88b45b1 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -40,9 +40,10 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
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


