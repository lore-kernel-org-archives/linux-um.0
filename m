Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF5EFA372E
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 08:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BdWFblR7TKx3b8NRM15QRtJW33lGjnHWv0IzK27DUsA=; b=RYvaWL+fcR4r5gvrrdxyilDW4q
	56HCu2+kSzQx+slgATlKgJxjIcQ1mEfwLo0efV24O5E3oydioA0ml4XsErHop4bEjtHrYaRK8fJvy
	u3Oz/J6XpA5li1jnqyT9mZCMkAfc+bDMAp4uiJCGqp1T2pLeqqPrZ+JoojbWK05qWUXMXs7zJQcKT
	xJxO79EdSA8xohmesKQShI2H9vxJlmYvudj2MPdL+RLzJ++v81bONQgdHf3GC0aLPhyR4twIgWTr/
	rian6DxYH0LX9eW5dVBU9nTx3t72XpwiuxEaegVBfZtxcLhlGWOjztuTMJi3IzwSed0ihX2Mt16+h
	e2mPkLxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp1a3-0000000FK2u-2CeQ;
	Fri, 13 Sep 2024 08:23:03 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp1a0-0000000FK2L-2qxb
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 08:23:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=BdWFblR7TKx3b8NRM15QRtJW33lGjnHWv0IzK27DUsA=; t=1726215778; x=1727425378; 
	b=o+5nQgYsAt5hTth/7JRbUUfRB+ubKRiG6LUwaMt5XkfeQNx6kz6KquPTgxli/Jt0MwObC+6JrnA
	OQLXWCi9/eDhyvAeO16B/ivZ9tjWrCdOJv7DHSFCIu6TegNIh8eMU1sdAgsXKgLUrfIjmNjeNjXmm
	sNpJs6h5PJjFUbfJzHvhlhCnLJl+rK2XPrz+BzDU4ChpUCNMxIU0/FxZIR4/+qZwRWYCusiTqvyU2
	u15UNcK12Nw7xvc/P42W2XOOrY9Cs2hUcMUiFdiGkw4WbNfqKk0xoJnzuJT+SNEaIMRb8CM3mhFjZ
	zDAakXJrzGikx50ndM0ttHii8PMhbMYFOWBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp1Zu-0000000Fmpi-3op2;
	Fri, 13 Sep 2024 10:22:55 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH] um: always use the internal copy of the FP registers
Date: Fri, 13 Sep 2024 10:22:44 +0200
Message-ID: <20240913082244.767799-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_012300_933515_F67CFE41 
X-CRM114-Status: GOOD (  20.66  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

When switching from userspace to the kernel, all registers including the
FP registers are copied into the kernel and restored later on. As such,
the true source for the FP register state is actually already in the
kernel and they should never be grabbed from the userspace process.

Change the various places to simply copy the data from the internal FP
register storage area. Note that on i386 the format of PTRACE_GETFPREGS
and PTRACE_GETFPXREGS is different enough that conversion would be
needed. With this patch, -EINVAL is returned if the non-native format is
requested.

The upside is, that this patchset fixes setting registers via ptrace
(which simply did not work before) as well as fixing setting floating
point registers using the mcontext on signal return on i386.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

I think that ideally more changs should be done in this space. For a
start, one can remove support for hosts without PTRACE_GETFPXREGS. But,
more importantly, UML should probably implement the regset API, which
would considerably improve both ptrace and coredump generation and
should also make it easy to fix the cases where this patch returns an
error.
---
 arch/um/include/shared/registers.h |  6 ---
 arch/um/kernel/process.c           | 11 ++++-
 arch/x86/um/os-Linux/registers.c   | 12 +++---
 arch/x86/um/ptrace_32.c            | 50 ++++++++++++-----------
 arch/x86/um/ptrace_64.c            | 20 ++++-----
 arch/x86/um/signal.c               | 65 ++++++++++++++----------------
 6 files changed, 80 insertions(+), 84 deletions(-)

diff --git a/arch/um/include/shared/registers.h b/arch/um/include/shared/registers.h
index a0450326521c..7d81b2339a48 100644
--- a/arch/um/include/shared/registers.h
+++ b/arch/um/include/shared/registers.h
@@ -8,12 +8,6 @@
 
 #include <sysdep/ptrace.h>
 
-extern int save_i387_registers(int pid, unsigned long *fp_regs);
-extern int restore_i387_registers(int pid, unsigned long *fp_regs);
-extern int save_fp_registers(int pid, unsigned long *fp_regs);
-extern int restore_fp_registers(int pid, unsigned long *fp_regs);
-extern int save_fpx_registers(int pid, unsigned long *fp_regs);
-extern int restore_fpx_registers(int pid, unsigned long *fp_regs);
 extern int init_pid_registers(int pid);
 extern void get_safe_registers(unsigned long *regs, unsigned long *fp_regs);
 extern int get_fp_registers(int pid, unsigned long *regs);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index be2856af6d4c..ad798d40f8a4 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -290,8 +290,15 @@ unsigned long __get_wchan(struct task_struct *p)
 
 int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
 {
-	int cpu = current_thread_info()->cpu;
+#ifdef CONFIG_X86_32
+	extern int have_fpx_regs;
 
-	return save_i387_registers(userspace_pid[cpu], (unsigned long *) fpu);
+	/* FIXME: A plain copy does not work on i386 with have_fpx_regs */
+	if (have_fpx_regs)
+		return -1;
+#endif
+	memcpy(fpu, &t->thread.regs.regs.fp, sizeof(*fpu));
+
+	return 0;
 }
 
diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
index f3638dd09cec..f8e5516d9708 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -19,14 +19,14 @@
 
 static int have_xstate_support;
 
-int save_i387_registers(int pid, unsigned long *fp_regs)
+static int save_i387_registers(int pid, unsigned long *fp_regs)
 {
 	if (ptrace(PTRACE_GETFPREGS, pid, 0, fp_regs) < 0)
 		return -errno;
 	return 0;
 }
 
-int save_fp_registers(int pid, unsigned long *fp_regs)
+static int save_fp_registers(int pid, unsigned long *fp_regs)
 {
 #ifdef PTRACE_GETREGSET
 	struct iovec iov;
@@ -42,14 +42,14 @@ int save_fp_registers(int pid, unsigned long *fp_regs)
 		return save_i387_registers(pid, fp_regs);
 }
 
-int restore_i387_registers(int pid, unsigned long *fp_regs)
+static int restore_i387_registers(int pid, unsigned long *fp_regs)
 {
 	if (ptrace(PTRACE_SETFPREGS, pid, 0, fp_regs) < 0)
 		return -errno;
 	return 0;
 }
 
-int restore_fp_registers(int pid, unsigned long *fp_regs)
+static int restore_fp_registers(int pid, unsigned long *fp_regs)
 {
 #ifdef PTRACE_SETREGSET
 	struct iovec iov;
@@ -66,14 +66,14 @@ int restore_fp_registers(int pid, unsigned long *fp_regs)
 
 #ifdef __i386__
 int have_fpx_regs = 1;
-int save_fpx_registers(int pid, unsigned long *fp_regs)
+static int save_fpx_registers(int pid, unsigned long *fp_regs)
 {
 	if (ptrace(PTRACE_GETFPXREGS, pid, 0, fp_regs) < 0)
 		return -errno;
 	return 0;
 }
 
-int restore_fpx_registers(int pid, unsigned long *fp_regs)
+static int restore_fpx_registers(int pid, unsigned long *fp_regs)
 {
 	if (ptrace(PTRACE_SETFPXREGS, pid, 0, fp_regs) < 0)
 		return -errno;
diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
index b0a71c6cdc6e..b8b85a52eb6f 100644
--- a/arch/x86/um/ptrace_32.c
+++ b/arch/x86/um/ptrace_32.c
@@ -168,17 +168,18 @@ int peek_user(struct task_struct *child, long addr, long data)
 	return put_user(tmp, (unsigned long __user *) data);
 }
 
+/* FIXME: Do the required conversions instead of erroring out */
+extern int have_fpx_regs;
+
 static int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
 {
-	int err, n, cpu = task_cpu(child);
-	struct user_i387_struct fpregs;
+	int n;
 
-	err = save_i387_registers(userspace_pid[cpu],
-				  (unsigned long *) &fpregs);
-	if (err)
-		return err;
+	if (have_fpx_regs)
+		return -EINVAL;
 
-	n = copy_to_user(buf, &fpregs, sizeof(fpregs));
+	n = copy_to_user(buf, &child->thread.regs.regs.fp,
+			 sizeof(struct user_i387_struct));
 	if(n > 0)
 		return -EFAULT;
 
@@ -187,27 +188,28 @@ static int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *c
 
 static int set_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
 {
-	int n, cpu = task_cpu(child);
-	struct user_i387_struct fpregs;
+	int n;
+
+	if (have_fpx_regs)
+		return -EINVAL;
 
-	n = copy_from_user(&fpregs, buf, sizeof(fpregs));
+	n = copy_from_user(&child->thread.regs.regs.fp, buf,
+			   sizeof(struct user_i387_struct));
 	if (n > 0)
 		return -EFAULT;
 
-	return restore_i387_registers(userspace_pid[cpu],
-				    (unsigned long *) &fpregs);
+	return 0;
 }
 
 static int get_fpxregs(struct user_fxsr_struct __user *buf, struct task_struct *child)
 {
-	int err, n, cpu = task_cpu(child);
-	struct user_fxsr_struct fpregs;
+	int n;
 
-	err = save_fpx_registers(userspace_pid[cpu], (unsigned long *) &fpregs);
-	if (err)
-		return err;
+	if (!have_fpx_regs)
+		return -EINVAL;
 
-	n = copy_to_user(buf, &fpregs, sizeof(fpregs));
+	n = copy_to_user(buf, &child->thread.regs.regs.fp,
+			 sizeof(struct user_fxsr_struct));
 	if(n > 0)
 		return -EFAULT;
 
@@ -216,15 +218,17 @@ static int get_fpxregs(struct user_fxsr_struct __user *buf, struct task_struct *
 
 static int set_fpxregs(struct user_fxsr_struct __user *buf, struct task_struct *child)
 {
-	int n, cpu = task_cpu(child);
-	struct user_fxsr_struct fpregs;
+	int n;
 
-	n = copy_from_user(&fpregs, buf, sizeof(fpregs));
+	if (!have_fpx_regs)
+		return -EINVAL;
+
+	n = copy_from_user(&child->thread.regs.regs.fp, buf,
+			   sizeof(struct user_fxsr_struct));
 	if (n > 0)
 		return -EFAULT;
 
-	return restore_fpx_registers(userspace_pid[cpu],
-				     (unsigned long *) &fpregs);
+	return 0;
 }
 
 long subarch_ptrace(struct task_struct *child, long request,
diff --git a/arch/x86/um/ptrace_64.c b/arch/x86/um/ptrace_64.c
index aa68d83d3f44..f8bbad29cd0b 100644
--- a/arch/x86/um/ptrace_64.c
+++ b/arch/x86/um/ptrace_64.c
@@ -190,15 +190,10 @@ int peek_user(struct task_struct *child, long addr, long data)
 
 static int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
 {
-	int err, n, cpu = ((struct thread_info *) child->stack)->cpu;
-	struct user_i387_struct fpregs;
+	int n;
 
-	err = save_i387_registers(userspace_pid[cpu],
-				  (unsigned long *) &fpregs);
-	if (err)
-		return err;
-
-	n = copy_to_user(buf, &fpregs, sizeof(fpregs));
+	n = copy_to_user(buf, &child->thread.regs.regs.fp,
+			 sizeof(struct user_i387_struct));
 	if (n > 0)
 		return -EFAULT;
 
@@ -207,15 +202,14 @@ static int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *c
 
 static int set_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
 {
-	int n, cpu = ((struct thread_info *) child->stack)->cpu;
-	struct user_i387_struct fpregs;
+	int n;
 
-	n = copy_from_user(&fpregs, buf, sizeof(fpregs));
+	n = copy_from_user(&child->thread.regs.regs.fp, buf,
+			   sizeof(struct user_i387_struct));
 	if (n > 0)
 		return -EFAULT;
 
-	return restore_i387_registers(userspace_pid[cpu],
-				      (unsigned long *) &fpregs);
+	return 0;
 }
 
 long subarch_ptrace(struct task_struct *child, long request,
diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 2cc8c2309022..fa78c74e00cb 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -204,34 +204,30 @@ static int copy_sc_from_user(struct pt_regs *regs,
 
 #ifdef CONFIG_X86_32
 	if (have_fpx_regs) {
-		struct user_fxsr_struct fpx;
-		int pid = userspace_pid[current_thread_info()->cpu];
+		struct user_fxsr_struct *fpx;
+		fpx = (void *)&regs->regs.fp;
 
-		err = copy_from_user(&fpx,
-			&((struct _fpstate __user *)sc.fpstate)->_fxsr_env[0],
-				     sizeof(struct user_fxsr_struct));
+		err = convert_fxsr_from_user(fpx, (void *)sc.fpstate);
 		if (err)
 			return 1;
-
-		err = convert_fxsr_from_user(&fpx, (void *)sc.fpstate);
+	} else {
+		BUILD_BUG_ON(sizeof(regs->regs.fp) > sizeof(struct _fpstate));
+		err = copy_from_user(regs->regs.fp, (void *)sc.fpstate,
+				     sizeof(regs->regs.fp));
 		if (err)
 			return 1;
-
-		err = restore_fpx_registers(pid, (unsigned long *) &fpx);
-		if (err < 0) {
-			printk(KERN_ERR "copy_sc_from_user - "
-			       "restore_fpx_registers failed, errno = %d\n",
-			       -err);
-			return 1;
-		}
-	} else
-#endif
+	}
+#else
 	{
+		/* FIXME: Save/restore extended state (past the 16 YMM regs) */
+		BUILD_BUG_ON(sizeof(regs->regs.fp) < sizeof(struct _xstate));
+
 		err = copy_from_user(regs->regs.fp, (void *)sc.fpstate,
 				     sizeof(struct _xstate));
 		if (err)
 			return 1;
 	}
+#endif
 	return 0;
 }
 
@@ -291,34 +287,35 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 
 #ifdef CONFIG_X86_32
 	if (have_fpx_regs) {
-		int pid = userspace_pid[current_thread_info()->cpu];
-		struct user_fxsr_struct fpx;
+		struct user_fxsr_struct *fpx;
 
-		err = save_fpx_registers(pid, (unsigned long *) &fpx);
-		if (err < 0){
-			printk(KERN_ERR "copy_sc_to_user - save_fpx_registers "
-			       "failed, errno = %d\n", err);
-			return 1;
-		}
+		fpx = (void *)&regs->regs.fp;
 
-		err = convert_fxsr_to_user(&to_fp->fpstate, &fpx);
+		err = convert_fxsr_to_user(&to_fp->fpstate, fpx);
 		if (err)
 			return 1;
 
-		err |= __put_user(fpx.swd, &to_fp->fpstate.status);
+		err |= __put_user(fpx->swd, &to_fp->fpstate.status);
 		err |= __put_user(X86_FXSR_MAGIC, &to_fp->fpstate.magic);
 		if (err)
 			return 1;
 
-		if (copy_to_user(&to_fp->fpstate._fxsr_env[0], &fpx,
-				 sizeof(struct user_fxsr_struct)))
-			return 1;
-	} else
-#endif
-	{
-		if (copy_to_user(to_fp, regs->regs.fp, sizeof(struct _xstate)))
+	} else {
+		if (copy_to_user(to_fp, regs->regs.fp, sizeof(regs->regs.fp)))
 			return 1;
+
+		/* Need to fill in the sw_reserved bits ... */
+		BUILD_BUG_ON(offsetof(typeof(*to_fp),
+				      fpstate.sw_reserved.magic1) >=
+			     sizeof(struct _fpstate));
+		__put_user(0, &to_fp->fpstate.sw_reserved.magic1);
+		__put_user(sizeof(struct _fpstate),
+			   &to_fp->fpstate.sw_reserved.extended_size);
 	}
+#else
+	if (copy_to_user(to_fp, regs->regs.fp, sizeof(struct _xstate)))
+		return 1;
+#endif
 
 	return 0;
 }
-- 
2.46.0


