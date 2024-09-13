Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2067FA3757
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 13:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hAMp5Ql8KHtYSQlUFA64weLxPvsYgQcQfAQmH9/5e04=; b=dRFUiGJGBrk/KOASbYw3UYsLpJ
	d1WRCiW8AJKjSPfBMn8FxKSGs9LdBShy/U0oP4s+K16lSk3RgvIrzj3HxfU0abXgaamJqeKlfm4vk
	tqfvGX0euh4nbQsEQ5LzZhJcyxRxyEx3YjvJU55vp486/MzELuF0tX1i+t8kVAd1TB/KMYM8jk6yW
	XcFhPmArTybvpIz5m4OyGJ7Xezrnv00ATznLK3ieCmsJIq8g51wC74XEsXX2pn48qJTEmtaV0o6gi
	usghEH3cYFyV1QYePjvXHz/4CXtYU6n2P8GNzwh3RrNjXsGIwpH1MHK225qy7upJo1RfIotDX+1mT
	xF+Y0x+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6W5-0000000G3i2-2DKE;
	Fri, 13 Sep 2024 13:39:17 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6W2-0000000G3gr-3Sub
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 13:39:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=hAMp5Ql8KHtYSQlUFA64weLxPvsYgQcQfAQmH9/5e04=; t=1726234754; x=1727444354; 
	b=BTXkKlMPZ5o5feuzRFH4xknKr6LxGjuEhTGPP7ZYkbOGTsa2QtsdLbKypzpcT49Tuk5UXu9qLxX
	Bxt4CGHC2kp7nOWK5nNbkrF0atdUUJxoayH1FJzXjDcAZkGkNT7PtRl7t7ei871GosuuvnVA5rcTQ
	ShY1NhxiVgZ7m43NFEMFrQ3NY97Pz2XHDmZZMADMSwRa9QB0trRLaubTnt4klJ2t5XlbF36wSJ//E
	N/dKd/hcgCsia8/mPg0+ahdiHZJTh8aaXH0Q3xIYDKHmUVcDE9qAXRGZe3eaqFHmXUoUSIcItT9CY
	ro6VHJ61NIs7O9/ZZHfaBADiggrRJCyTlQPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp6Vz-0000000GY9K-0ai9;
	Fri, 13 Sep 2024 15:39:11 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2] um: always use the internal copy of the FP registers
Date: Fri, 13 Sep 2024 15:38:45 +0200
Message-ID: <20240913133845.964292-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_063915_078351_454FA239 
X-CRM114-Status: GOOD (  20.64  )
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

v2: Fix elf_core_copy_task_fpregs return value, thanks to Tiwei Bie.
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
index be2856af6d4c..701b7bb2525e 100644
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
+		return 0;
+#endif
+	memcpy(fpu, &t->thread.regs.regs.fp, sizeof(*fpu));
+
+	return 1;
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


