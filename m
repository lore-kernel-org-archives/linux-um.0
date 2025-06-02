Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D83C5B559
	for <linux-um@archiver.kernel.org>; Mon,  2 Jun 2025 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HAZpBKPUVrMOWHJoaxatCfc5gQvaqhdJSc6/dQvF/cY=; b=wc5nI8zSLlGpqv9cI19CY7yjQY
	lXjJl8GcAeov5LpA9t9R+Iu/d6irRPWOf+fwAguwolL9z4MkRHDzmGPcwQoNBIAXAyZZ5wzU10i1X
	NaJFv9ZbF6Mo0P4GPm3670ooM5bon6Je6Px5lMYhAhjL1pFTi9MR1ehZleU5xysPvR1nXD43mpf4u
	9A9+ZLFm4hP3aKVxwL0Nbe9SuahRogZ5yUksE3OtfhwXi0daip2FQ2c2lJTE7tM08GedE3QUihJLI
	j45KwtFhOjaNZ0JQE7sTNlrfoTVugn0QJggOwtOk3tVDoV7ctjzrH515yZnkXAVikg5hosVHhzfBT
	B6zEOsjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM4oL-00000007PnD-2eTr;
	Mon, 02 Jun 2025 13:02:41 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM4nO-00000007Pea-3tkS
	for linux-um@lists.infradead.org;
	Mon, 02 Jun 2025 13:01:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HAZpBKPUVrMOWHJoaxatCfc5gQvaqhdJSc6/dQvF/cY=;
	t=1748869302; x=1750078902; b=ZcKdbUvBpHS9Hzy3/arQ4TaL5MWLQB7Uqy2FccVZSmZABhM
	1kOvaea00WEHVODloNhRk8U55DdhOJ+M+Hmgk6ds4WYPeYNiwHsSGAEeliYmcCYTu7YgODq85iVEz
	DzRTk7zxft30BftP/NoCBxKCWmijlLy5J/hCDjlksczMp4ElHNMosmwqHGY1dBgWRXUPdQi0c9m7o
	ntpkDBWqfpAoBoDiBzhIR/LaRK8/kwoLA+rP+O/jmziXrUsTrwrHuSmpmo/xA9GZUn/N5oTSnwfxB
	llNa8cTfQ4FwfgsF1lbXbk/QV2Iajcx2Vf/N++FUIwjIQAC/12UHh14XWVI8WkXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uM4nK-00000005j9h-1zKI;
	Mon, 02 Jun 2025 15:01:38 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 3/7] um: Add helper functions to get/set state for SECCOMP
Date: Mon,  2 Jun 2025 15:00:48 +0200
Message-ID: <20250602130052.545733-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602130052.545733-1-benjamin@sipsolutions.net>
References: <20250602130052.545733-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250602_060143_144836_AB0C016A 
X-CRM114-Status: GOOD (  23.45  )
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

When not using ptrace, we need to both save and restore registers
through the mcontext as provided by the host kernel to our signal
handlers.

Add corresponding functions to store the state to an mcontext and
helpers to access the mcontext of the subprocess through the stub data.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

RFCv2:
- Proper FP register handling
---
 arch/x86/um/os-Linux/mcontext.c      | 218 ++++++++++++++++++++++++++-
 arch/x86/um/ptrace.c                 |  76 +++++++---
 arch/x86/um/shared/sysdep/mcontext.h |   9 ++
 3 files changed, 283 insertions(+), 20 deletions(-)

diff --git a/arch/x86/um/os-Linux/mcontext.c b/arch/x86/um/os-Linux/mcontext.c
index 37decaa74761..e661fdc44db9 100644
--- a/arch/x86/um/os-Linux/mcontext.c
+++ b/arch/x86/um/os-Linux/mcontext.c
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <sys/ucontext.h>
 #define __FRAME_OFFSETS
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <sys/ucontext.h>
 #include <asm/ptrace.h>
+#include <asm/sigcontext.h>
 #include <sysdep/ptrace.h>
 #include <sysdep/mcontext.h>
 #include <arch.h>
@@ -18,6 +21,10 @@ void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 	COPY2(UESP, ESP); /* sic */
 	COPY(EBX); COPY(EDX); COPY(ECX); COPY(EAX);
 	COPY(EIP); COPY_SEG_CPL3(CS); COPY(EFL); COPY_SEG_CPL3(SS);
+#undef COPY2
+#undef COPY
+#undef COPY_SEG
+#undef COPY_SEG_CPL3
 #else
 #define COPY2(X,Y) regs->gp[X/sizeof(unsigned long)] = mc->gregs[REG_##Y]
 #define COPY(X) regs->gp[X/sizeof(unsigned long)] = mc->gregs[REG_##X]
@@ -29,6 +36,8 @@ void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 	COPY2(EFLAGS, EFL);
 	COPY2(CS, CSGSFS);
 	regs->gp[SS / sizeof(unsigned long)] = mc->gregs[REG_CSGSFS] >> 48;
+#undef COPY2
+#undef COPY
 #endif
 }
 
@@ -42,3 +51,210 @@ void mc_set_rip(void *_mc, void *target)
 	mc->gregs[REG_RIP] = (unsigned long)target;
 #endif
 }
+
+/* Same thing, but the copy macros are turned around. */
+void get_mc_from_regs(struct uml_pt_regs *regs, mcontext_t *mc, int single_stepping)
+{
+#ifdef __i386__
+#define COPY2(X,Y) mc->gregs[REG_##Y] = regs->gp[X]
+#define COPY(X) mc->gregs[REG_##X] = regs->gp[X]
+#define COPY_SEG(X) mc->gregs[REG_##X] = regs->gp[X] & 0xffff;
+#define COPY_SEG_CPL3(X) mc->gregs[REG_##X] = (regs->gp[X] & 0xffff) | 3;
+	COPY_SEG(GS); COPY_SEG(FS); COPY_SEG(ES); COPY_SEG(DS);
+	COPY(EDI); COPY(ESI); COPY(EBP);
+	COPY2(UESP, ESP); /* sic */
+	COPY(EBX); COPY(EDX); COPY(ECX); COPY(EAX);
+	COPY(EIP); COPY_SEG_CPL3(CS); COPY(EFL); COPY_SEG_CPL3(SS);
+#else
+#define COPY2(X,Y) mc->gregs[REG_##Y] = regs->gp[X/sizeof(unsigned long)]
+#define COPY(X) mc->gregs[REG_##X] = regs->gp[X/sizeof(unsigned long)]
+	COPY(R8); COPY(R9); COPY(R10); COPY(R11);
+	COPY(R12); COPY(R13); COPY(R14); COPY(R15);
+	COPY(RDI); COPY(RSI); COPY(RBP); COPY(RBX);
+	COPY(RDX); COPY(RAX); COPY(RCX); COPY(RSP);
+	COPY(RIP);
+	COPY2(EFLAGS, EFL);
+	mc->gregs[REG_CSGSFS] = mc->gregs[REG_CSGSFS] & 0xffffffffffffl;
+	mc->gregs[REG_CSGSFS] |= (regs->gp[SS / sizeof(unsigned long)] & 0xffff) << 48;
+#endif
+
+	if (single_stepping)
+		mc->gregs[REG_EFL] |= X86_EFLAGS_TF;
+	else
+		mc->gregs[REG_EFL] &= ~X86_EFLAGS_TF;
+}
+
+#ifdef CONFIG_X86_32
+struct _xstate_64 {
+	struct _fpstate_64		fpstate;
+	struct _header			xstate_hdr;
+	struct _ymmh_state		ymmh;
+	/* New processor state extensions go here: */
+};
+
+/* Not quite the right structures as these contain more information */
+int um_i387_from_fxsr(struct _fpstate_32 *i387,
+		      const struct _fpstate_64 *fxsave);
+int um_fxsr_from_i387(struct _fpstate_64 *fxsave,
+		      const struct _fpstate_32 *from);
+#else
+#define _xstate_64 _xstate
+#endif
+
+static struct _fpstate *get_fpstate(struct stub_data *data,
+				    mcontext_t *mcontext,
+				    int *fp_size)
+{
+	struct _fpstate *res;
+
+	/* Assume floating point registers are on the same page */
+	res = (void *)(((unsigned long)mcontext->fpregs &
+			(UM_KERN_PAGE_SIZE - 1)) +
+		       (unsigned long)&data->sigstack[0]);
+
+	if ((void *)res + sizeof(struct _fpstate) >
+	    (void *)data->sigstack + sizeof(data->sigstack))
+		return NULL;
+
+	if (res->sw_reserved.magic1 != FP_XSTATE_MAGIC1) {
+		*fp_size = sizeof(struct _fpstate);
+	} else {
+		char *magic2_addr;
+
+		magic2_addr = (void *)res;
+		magic2_addr += res->sw_reserved.extended_size;
+		magic2_addr -= FP_XSTATE_MAGIC2_SIZE;
+
+		/* We still need to be within our stack */
+		if ((void *)magic2_addr >
+		    (void *)data->sigstack + sizeof(data->sigstack))
+			return NULL;
+
+		/* If we do not read MAGIC2, then we did something wrong */
+		if (*(__u32 *)magic2_addr != FP_XSTATE_MAGIC2)
+			return NULL;
+
+		/* Remove MAGIC2 from the size, we do not save/restore it */
+		*fp_size = res->sw_reserved.extended_size -
+			   FP_XSTATE_MAGIC2_SIZE;
+	}
+
+	return res;
+}
+
+int get_stub_state(struct uml_pt_regs *regs, struct stub_data *data,
+		   unsigned long *fp_size_out)
+{
+	mcontext_t *mcontext;
+	struct _fpstate *fpstate_stub;
+	struct _xstate_64 *xstate_stub;
+	int fp_size, xstate_size;
+
+	/* mctx_offset is verified by wait_stub_done_seccomp */
+	mcontext = (void *)&data->sigstack[data->mctx_offset];
+
+	get_regs_from_mc(regs, mcontext);
+
+	fpstate_stub = get_fpstate(data, mcontext, &fp_size);
+	if (!fpstate_stub)
+		return -EINVAL;
+
+#ifdef CONFIG_X86_32
+	xstate_stub = (void *)&fpstate_stub->_fxsr_env;
+	xstate_size = fp_size - offsetof(struct _fpstate_32, _fxsr_env);
+#else
+	xstate_stub = (void *)fpstate_stub;
+	xstate_size = fp_size;
+#endif
+
+	if (fp_size_out)
+		*fp_size_out = xstate_size;
+
+	if (xstate_size > host_fp_size)
+		return -ENOSPC;
+
+	memcpy(&regs->fp, xstate_stub, xstate_size);
+
+	/* We do not need to read the x86_64 FS_BASE/GS_BASE registers as
+	 * we do not permit userspace to set them directly.
+	 */
+
+#ifdef CONFIG_X86_32
+	/* Read the i387 legacy FP registers */
+	if (um_fxsr_from_i387((void *)&regs->fp, fpstate_stub))
+		return -EINVAL;
+#endif
+
+	return 0;
+}
+
+/* Copied because we cannot include regset.h here. */
+struct task_struct;
+struct user_regset;
+struct membuf {
+	void *p;
+	size_t left;
+};
+
+int fpregs_legacy_get(struct task_struct *target,
+		      const struct user_regset *regset,
+		      struct membuf to);
+
+int set_stub_state(struct uml_pt_regs *regs, struct stub_data *data,
+		   int single_stepping)
+{
+	mcontext_t *mcontext;
+	struct _fpstate *fpstate_stub;
+	struct _xstate_64 *xstate_stub;
+	int fp_size, xstate_size;
+
+	/* mctx_offset is verified by wait_stub_done_seccomp */
+	mcontext = (void *)&data->sigstack[data->mctx_offset];
+
+	if ((unsigned long)mcontext < (unsigned long)data->sigstack ||
+	    (unsigned long)mcontext >
+			(unsigned long) data->sigstack +
+			sizeof(data->sigstack) - sizeof(*mcontext))
+		return -EINVAL;
+
+	get_mc_from_regs(regs, mcontext, single_stepping);
+
+	fpstate_stub = get_fpstate(data, mcontext, &fp_size);
+	if (!fpstate_stub)
+		return -EINVAL;
+
+#ifdef CONFIG_X86_32
+	xstate_stub = (void *)&fpstate_stub->_fxsr_env;
+	xstate_size = fp_size - offsetof(struct _fpstate_32, _fxsr_env);
+#else
+	xstate_stub = (void *)fpstate_stub;
+	xstate_size = fp_size;
+#endif
+
+	memcpy(fpstate_stub, &regs->fp, fp_size);
+
+#ifdef __i386__
+	/*
+	 * On x86, the GDT entries are updated by arch_set_tls.
+	 */
+
+	/* Store the i387 legacy FP registers which the host will use */
+	if (um_i387_from_fxsr(fpstate_stub, (void *)&regs->fp))
+		return -EINVAL;
+#else
+	/*
+	 * On x86_64, we need to sync the FS_BASE/GS_BASE registers using the
+	 * arch specific data.
+	 */
+	if (data->arch_data.fs_base != regs->gp[FS_BASE / sizeof(unsigned long)]) {
+		data->arch_data.fs_base = regs->gp[FS_BASE / sizeof(unsigned long)];
+		data->arch_data.sync |= STUB_SYNC_FS_BASE;
+	}
+	if (data->arch_data.gs_base != regs->gp[GS_BASE / sizeof(unsigned long)]) {
+		data->arch_data.gs_base = regs->gp[GS_BASE / sizeof(unsigned long)];
+		data->arch_data.sync |= STUB_SYNC_GS_BASE;
+	}
+#endif
+
+	return 0;
+}
diff --git a/arch/x86/um/ptrace.c b/arch/x86/um/ptrace.c
index 57c504fd5626..3275870330fe 100644
--- a/arch/x86/um/ptrace.c
+++ b/arch/x86/um/ptrace.c
@@ -25,7 +25,8 @@ static inline unsigned short twd_i387_to_fxsr(unsigned short twd)
 	return tmp;
 }
 
-static inline unsigned long twd_fxsr_to_i387(struct user_fxsr_struct *fxsave)
+static inline unsigned long
+twd_fxsr_to_i387(const struct user_fxsr_struct *fxsave)
 {
 	struct _fpxreg *st = NULL;
 	unsigned long twd = (unsigned long) fxsave->twd;
@@ -69,12 +70,16 @@ static inline unsigned long twd_fxsr_to_i387(struct user_fxsr_struct *fxsave)
 	return ret;
 }
 
-/* Get/set the old 32bit i387 registers (pre-FPX) */
-static int fpregs_legacy_get(struct task_struct *target,
-			     const struct user_regset *regset,
-			     struct membuf to)
+/*
+ * Get/set the old 32bit i387 registers (pre-FPX)
+ *
+ * We provide simple wrappers for mcontext.c, they are only defined locally
+ * because mcontext.c is userspace facing and needs to a different definition
+ * of the structures.
+ */
+static int _um_i387_from_fxsr(struct membuf to,
+			      const struct user_fxsr_struct *fxsave)
 {
-	struct user_fxsr_struct *fxsave = (void *)target->thread.regs.regs.fp;
 	int i;
 
 	membuf_store(&to, (unsigned long)fxsave->cwd | 0xffff0000ul);
@@ -91,23 +96,36 @@ static int fpregs_legacy_get(struct task_struct *target,
 	return 0;
 }
 
-static int fpregs_legacy_set(struct task_struct *target,
+int um_i387_from_fxsr(struct user_i387_struct *i387,
+		      const struct user_fxsr_struct *fxsave);
+
+int um_i387_from_fxsr(struct user_i387_struct *i387,
+		      const struct user_fxsr_struct *fxsave)
+{
+	struct membuf to = {
+		.p = i387,
+		.left = sizeof(*i387),
+	};
+
+	return _um_i387_from_fxsr(to, fxsave);
+}
+
+static int fpregs_legacy_get(struct task_struct *target,
 			     const struct user_regset *regset,
-			     unsigned int pos, unsigned int count,
-			     const void *kbuf, const void __user *ubuf)
+			     struct membuf to)
 {
 	struct user_fxsr_struct *fxsave = (void *)target->thread.regs.regs.fp;
-	const struct user_i387_struct *from;
-	struct user_i387_struct buf;
-	int i;
 
-	if (ubuf) {
-		if (copy_from_user(&buf, ubuf, sizeof(buf)))
-			return -EFAULT;
-		from = &buf;
-	} else {
-		from = kbuf;
-	}
+	return _um_i387_from_fxsr(to, fxsave);
+}
+
+int um_fxsr_from_i387(struct user_fxsr_struct *fxsave,
+		      const struct user_i387_struct *from);
+
+int um_fxsr_from_i387(struct user_fxsr_struct *fxsave,
+		      const struct user_i387_struct *from)
+{
+	int i;
 
 	fxsave->cwd = (unsigned short)(from->cwd & 0xffff);
 	fxsave->swd = (unsigned short)(from->swd & 0xffff);
@@ -125,6 +143,26 @@ static int fpregs_legacy_set(struct task_struct *target,
 
 	return 0;
 }
+
+static int fpregs_legacy_set(struct task_struct *target,
+			     const struct user_regset *regset,
+			     unsigned int pos, unsigned int count,
+			     const void *kbuf, const void __user *ubuf)
+{
+	struct user_fxsr_struct *fxsave = (void *)target->thread.regs.regs.fp;
+	const struct user_i387_struct *from;
+	struct user_i387_struct buf;
+
+	if (ubuf) {
+		if (copy_from_user(&buf, ubuf, sizeof(buf)))
+			return -EFAULT;
+		from = &buf;
+	} else {
+		from = kbuf;
+	}
+
+	return um_fxsr_from_i387(fxsave, &buf);
+}
 #endif
 
 static int genregs_get(struct task_struct *target,
diff --git a/arch/x86/um/shared/sysdep/mcontext.h b/arch/x86/um/shared/sysdep/mcontext.h
index b724c54da316..6fe490cc5b98 100644
--- a/arch/x86/um/shared/sysdep/mcontext.h
+++ b/arch/x86/um/shared/sysdep/mcontext.h
@@ -6,7 +6,16 @@
 #ifndef __SYS_SIGCONTEXT_X86_H
 #define __SYS_SIGCONTEXT_X86_H
 
+#include <stub-data.h>
+
 extern void get_regs_from_mc(struct uml_pt_regs *, mcontext_t *);
+extern void get_mc_from_regs(struct uml_pt_regs *regs, mcontext_t *mc,
+			     int single_stepping);
+
+extern int get_stub_state(struct uml_pt_regs *regs, struct stub_data *data,
+			  unsigned long *fp_size_out);
+extern int set_stub_state(struct uml_pt_regs *regs, struct stub_data *data,
+			  int single_stepping);
 
 #ifdef __i386__
 
-- 
2.49.0


