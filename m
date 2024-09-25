Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3787ECCF9EF
	for <linux-um@archiver.kernel.org>; Wed, 25 Sep 2024 20:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eCK5vzUWRbePHYtkZrpK4or/B1Y04fq1w6ul1uFBlxo=; b=QSHvX/ObH8XkxFrKpNvNmV0A4H
	h6vbkpM/DEyI648g5H3XrKRxXFWgYJIFV6712cHLt3ft8RKvopTQq6B503yBxn6fQX7qEqs8HHY5g
	kE9VgEFjUGvZLfIcwW8F68GpbZBJTHAYOQkgQwlG3LRPIgIAzujWvItBMCz91Qg2HDq9Jsjl7YHmh
	rQx2NIAInK8hv+8mx/A/BG0ZqY1NGWfhr7vDXJRToQqGwmSSeyGxGSQBcsybPof8OOCDPGpmhTf6U
	vd7dXDFiSW5CTwDB6uEqFOeVw9PiISXDBExSaFS0dWW+3DaHl93QzsztzvMQJq0KfM3VBx4oz5mfy
	oESZdYGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stYh3-00000006V3W-3tzd;
	Wed, 25 Sep 2024 20:33:01 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stYh0-00000006V1t-3wCl
	for linux-um@lists.infradead.org;
	Wed, 25 Sep 2024 20:33:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=eCK5vzUWRbePHYtkZrpK4or/B1Y04fq1w6ul1uFBlxo=;
	t=1727296378; x=1728505978; b=ocqy9/4ZK97X6I2BhE1i+CwtOSyWCMYoXSUY211y3bJMY+P
	OIvcXlChZ9c7Uhipjf+04mO6cdSBEbldJjhV9qHZMhxRQ4aaZBOOQYgIb3pndhbvzeXHUaGc46KPb
	MbcWRMobhYJDTjbaNp+IM3mk8T/Cd9LNquUpjRkUmc2vAEzSqUrvY0RCkm1iy557KzG801fSwB/TK
	a1+TmP/tjgBsBz1fH9tj+envBXRjQ6czXyNv2Y91mIPMJUehpEdbrx2OBiEa+W1gXCmd9FTeI5bKT
	U8oFsc41BdrLxlWDMZ8RVuuDJl2357q9aek/rj4wimF3yce0MrH3/65z/H2H41qA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1stYgx-00000001A19-0Yme;
	Wed, 25 Sep 2024 22:32:55 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH 5/9] um: Add helper functions to get/set state for SECCOMP
Date: Wed, 25 Sep 2024 22:32:28 +0200
Message-ID: <20240925203232.565086-6-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240925203232.565086-1-benjamin@sipsolutions.net>
References: <20240925203232.565086-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_133259_185105_D695F6A4 
X-CRM114-Status: GOOD (  21.78  )
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
 arch/x86/um/os-Linux/mcontext.c      | 200 ++++++++++++++++++++++++++-
 arch/x86/um/shared/sysdep/mcontext.h |   9 ++
 2 files changed, 208 insertions(+), 1 deletion(-)

diff --git a/arch/x86/um/os-Linux/mcontext.c b/arch/x86/um/os-Linux/mcontext.c
index 1b0d95328b2c..60589110c38a 100644
--- a/arch/x86/um/os-Linux/mcontext.c
+++ b/arch/x86/um/os-Linux/mcontext.c
@@ -1,9 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <sys/ucontext.h>
 #define __FRAME_OFFSETS
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <sys/ucontext.h>
 #include <asm/ptrace.h>
 #include <sysdep/ptrace.h>
 #include <sysdep/mcontext.h>
+#include <asm/sigcontext.h>
 
 void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 {
@@ -17,6 +20,10 @@ void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
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
@@ -28,5 +35,196 @@ void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 	COPY2(EFLAGS, EFL);
 	COPY2(CS, CSGSFS);
 	regs->gp[SS / sizeof(unsigned long)] = mc->gregs[REG_CSGSFS] >> 48;
+#undef COPY2
+#undef COPY
+#endif
+}
+
+#ifdef CONFIG_UML_SECCOMP
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
 #endif
+
+	if (single_stepping)
+		mc->gregs[REG_EFL] |= X86_EFLAGS_TF;
+	else
+		mc->gregs[REG_EFL] &= ~X86_EFLAGS_TF;
 }
+
+int get_stub_state(struct uml_pt_regs *regs, struct stub_data *data)
+{
+	mcontext_t *mcontext;
+	struct _fpstate *fpstate_stub;
+	int fp_size;
+
+	/* mctx_offset is verified by wait_stub_done_seccomp */
+	mcontext = (void *)&data->sigstack[data->mctx_offset];
+
+	get_regs_from_mc(regs, mcontext);
+
+	/* Assume floating point registers are on the same page */
+	fpstate_stub = (void *)(((unsigned long)mcontext->fpregs &
+				  (UM_KERN_PAGE_SIZE - 1)) +
+				 (unsigned long)&data->sigstack[0]);
+
+	if (fpstate_stub->sw_reserved.magic1 != FP_XSTATE_MAGIC1) {
+		fp_size = sizeof(struct _fpstate);
+	} else {
+		char *magic2_addr;
+
+		magic2_addr = (void *)fpstate_stub;
+		magic2_addr += fpstate_stub->sw_reserved.extended_size;
+		magic2_addr -= FP_XSTATE_MAGIC2_SIZE;
+
+		/* Bail out if there is no magic (cannot really happen here) */
+		if (*(__u32 *)magic2_addr != FP_XSTATE_MAGIC2)
+			return -EINVAL;
+
+		/* Remove MAGIC2 from the size, we do not save/restore it */
+		fp_size = fpstate_stub->sw_reserved.extended_size -
+			  FP_XSTATE_MAGIC2_SIZE;
+	}
+
+#ifdef __i386__
+	/*
+	 * FIXME: Storage is too small (at least on x86_64 host). See below.
+	 */
+	fp_size = sizeof(regs->fp);
+#else
+	if (fp_size > sizeof(regs->fp))
+		return -ENOSPC;
+
+	if ((unsigned long)fpstate_stub + fp_size >
+	    (unsigned long)data->sigstack + sizeof(data->sigstack))
+		return -EINVAL;
+#endif
+
+	memcpy(&regs->fp, fpstate_stub, fp_size);
+
+	/* We do not need to read the x86_64 FS_BASE/GS_BASE registers as
+	 * we do not permit userspace to set them directly.
+	 */
+
+	return 0;
+}
+
+int set_stub_state(struct uml_pt_regs *regs, struct stub_data *data,
+		   int single_stepping)
+{
+	mcontext_t *mcontext;
+#ifndef __i386__
+	struct _fpstate *fpstate;
+#endif
+	struct _fpstate *fpstate_stub;
+	int fp_size;
+	int fp_size_stub;
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
+	/* Assume floating point registers are on the same page */
+	fpstate_stub = (void *)(((unsigned long)mcontext->fpregs &
+				  (UM_KERN_PAGE_SIZE - 1)) +
+				 (unsigned long)&data->sigstack[0]);
+
+	if (fpstate_stub->sw_reserved.magic1 != FP_XSTATE_MAGIC1) {
+		fp_size_stub = sizeof(struct _fpstate);
+	} else {
+		char *magic2_addr;
+
+		magic2_addr = (void *)fpstate_stub;
+		magic2_addr += fpstate_stub->sw_reserved.extended_size;
+		magic2_addr -= FP_XSTATE_MAGIC2_SIZE;
+
+		/* Bail out if there is no magic (cannot really happen here) */
+		if (*(__u32 *)magic2_addr != FP_XSTATE_MAGIC2)
+			return -EINVAL;
+
+		/* Remove MAGIC2 from the size, we do not save/restore it */
+		fp_size_stub = fpstate_stub->sw_reserved.extended_size -
+			       FP_XSTATE_MAGIC2_SIZE;
+	}
+
+#ifdef __i386__
+	/*
+	 * FIXME: Our registers are too small (on a x86_64 host at least).
+	 * We need to mark this as not being an xstate, and we need to do that
+	 * explicitly here as the magic is not stored in the register set then.
+	 *
+	 * Really, we should just dynamically allocate the floating pointer
+	 * registers and use the unmodified host registers.
+	 */
+	fp_size = sizeof(regs->fp);
+	fpstate_stub->sw_reserved.magic1 = 0;
+	fpstate_stub->sw_reserved.extended_size = sizeof(struct _fpstate);
+#else
+	fpstate = (void *)regs->fp;
+	if (fpstate->sw_reserved.magic1 != FP_XSTATE_MAGIC1)
+		fp_size = sizeof(struct _fpstate);
+	else
+		fp_size = fpstate_stub->sw_reserved.xstate_size;
+#endif
+
+	/* Do our registers fit into the userspace context? */
+	if (fp_size > fp_size_stub)
+		return -ENOSPC;
+
+	/* And, does it really not cross a page boundary? */
+	if ((unsigned long)fpstate_stub + fp_size >
+	    (unsigned long)data->sigstack + sizeof(data->sigstack))
+		return -EINVAL;
+
+	memcpy(fpstate_stub, &regs->fp, fp_size);
+
+#ifdef __i386__
+	/*
+	 * On x86, the GDT entries are updated by arch_set_tls.
+	 */
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
+#endif
diff --git a/arch/x86/um/shared/sysdep/mcontext.h b/arch/x86/um/shared/sysdep/mcontext.h
index b724c54da316..3ea6da0dbe9d 100644
--- a/arch/x86/um/shared/sysdep/mcontext.h
+++ b/arch/x86/um/shared/sysdep/mcontext.h
@@ -6,7 +6,16 @@
 #ifndef __SYS_SIGCONTEXT_X86_H
 #define __SYS_SIGCONTEXT_X86_H
 
+#include <linux/kconfig.h>
+#include <stub-data.h>
+
 extern void get_regs_from_mc(struct uml_pt_regs *, mcontext_t *);
+extern void get_mc_from_regs(struct uml_pt_regs *regs, mcontext_t *mc,
+			     int single_stepping);
+
+extern int get_stub_state(struct uml_pt_regs *regs, struct stub_data *data);
+extern int set_stub_state(struct uml_pt_regs *regs, struct stub_data *data,
+			  int single_stepping);
 
 #ifdef __i386__
 
-- 
2.46.1


