Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF84C433FE
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c4aFHu+l9Wzui/A/3IwKzlV1K0FpZfeLKVkNUBOOIUg=; b=hhNRvaFfvr4mgR
	/MLgQvgK1fXgKpmxL5Iwg8NsSNG9sa93g26dr+7uVXKxzVqHNOOQrJV8JtGgAys08cLP5jsGWfdjh
	MQbCKMkFnYit+NylG6plAwgiV/uqAGVjbLgPBKZ+VJRXmsIWeFZaQdkzgYiq/IfCWcFPyAOXP+a4U
	H2RqDTkQ1+KcZ4EpkOfqjl2db8H9EW9yPZGh/0DbG9xJ4RhT1RecVX0giVNROqqBAJQMgsqfpYohM
	e1LZ9KvPZaaK0idGDXrS9cwO2UWth3VhkEm6wk4zgzmUiND+LbKsoYd5LgNdZJev5JdHWA7vqNwdJ
	6nMiQBsRmQ8oIdr52TQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQFT-007g6x-Dc; Tue, 22 Nov 2022 10:11:27 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF2-007feb-Rd
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VcX66A7Z04I/ktDonzlZ4VvTIrbkSekpfhT9X9v0axM=;
	t=1669111860; x=1670321460; b=WM4vWLuOslp2dcMdLcoC7PXNQDrQUX0g3ErIMuDzm7IpoJ9
	RyDPf2wqv7Ni4CItfTNwEbAzVPLMOSCpFfpmk6ZOsdfM9DFEtDeqkd3qDA3mEqxJ3na1lCCJNpKUJ
	lK1bwqf5p++LsvQsGtRmoseNSt/LL0bhzzt0MTyPlOcUrUBhnCt3DDi9sDiWh2w5hKASgYWw1BQbH
	5fFFkMffOywnfZ8QWD6JcqPaIbIQd9llNs7A49G0SAVdpzVaxoZYofJQQBZUwjX4ZWSBHKfNZ65c2
	AjWWPlzjtwTNiqE4CB5vGrz4DoN9ECHdyvMAEJWzf3EWfza7cw0czNlO1iE3Oubg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEu-006IGn-0G;
	Tue, 22 Nov 2022 11:10:52 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 24/28] um: Add helper functions to get/set state for SECCOMP
Date: Tue, 22 Nov 2022 11:07:55 +0100
Message-Id: <20221122100759.208290-25-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_021101_140935_29504016 
X-CRM114-Status: GOOD (  16.98  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin@sipsolutions.net>

When not using ptrace, we need to both save and restore registers
through the mcontext as provided by the host kernel to our signal
handlers.

Add corresponding functions to store the state to an mcontext and
helpers to access the mcontext of the subprocess through the stub data.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/common-offsets.h |   9 +-
 arch/x86/um/os-Linux/mcontext.c         | 150 +++++++++++++++++++++++-
 arch/x86/um/shared/sysdep/mcontext.h    |   9 ++
 3 files changed, 166 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
index 579ed946a3a9..307dba626001 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -28,4 +28,11 @@ DEFINE(UML_CONFIG_64BIT, CONFIG_64BIT);
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
 DEFINE(UML_CONFIG_UML_TIME_TRAVEL_SUPPORT, CONFIG_UML_TIME_TRAVEL_SUPPORT);
 #endif
-
+#ifdef CONFIG_UML_SECCOMP
+DEFINE(UM_FPSTATE_EXTENDED_SIZE,
+       offsetof(struct _fpstate, sw_reserved)
+       + offsetof(struct _fpx_sw_bytes, extended_size));
+DEFINE(UM_FPSTATE_XSTATE_SIZE,
+       offsetof(struct _fpstate, sw_reserved)
+       + offsetof(struct _fpx_sw_bytes, xstate_size));
+#endif
diff --git a/arch/x86/um/os-Linux/mcontext.c b/arch/x86/um/os-Linux/mcontext.c
index 81b9d1f9f4e6..aabebe58fb25 100644
--- a/arch/x86/um/os-Linux/mcontext.c
+++ b/arch/x86/um/os-Linux/mcontext.c
@@ -1,8 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <sys/ucontext.h>
 #define __FRAME_OFFSETS
 #include <asm/ptrace.h>
 #include <sysdep/ptrace.h>
+#include <string.h>
+#include <signal.h>
+#include <sysdep/mcontext.h>
+#include <linux/errno.h>
+#include <generated/asm-offsets.h>
 
 void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 {
@@ -16,6 +20,10 @@ void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
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
@@ -27,5 +35,145 @@ void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 	COPY2(EFLAGS, EFL);
 	COPY2(CS, CSGSFS);
 	regs->gp[SS / sizeof(unsigned long)] = mc->gregs[REG_CSGSFS] >> 48;
+#undef COPY2
+#undef COPY
 #endif
 }
+
+#ifdef CONFIG_UML_SECCOMP
+/* Same thing, but the copy macros are turned around. */
+void get_mc_from_regs(struct uml_pt_regs *regs, mcontext_t *mc, int single_stepping)
+{
+#ifdef __i386__
+#define COPY2(X,Y) mc->gregs[REG_##Y] = regs->gp[X]
+#define COPY(X) mc->gregs[REG_##X] = regs->gp[X]
+#define COPY_SEG(X) mc->gregs[REG_##X] = mc->gregs[REG_##X] & 0xffff;
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
+int get_stub_state(struct uml_pt_regs *regs, struct stub_data *data)
+{
+	mcontext_t *mcontext;
+	unsigned long fp_regs;
+	int fp_size;
+
+	/* mctx_offset is verified by wait_stub_done_seccomp */
+	mcontext = (void *)&data->sigstack[data->mctx_offset];
+
+	get_regs_from_mc(regs, mcontext);
+
+	/* Assume floating point registers are on the same page */
+	fp_regs = (((unsigned long)mcontext->fpregs &
+		    (UM_KERN_PAGE_SIZE - 1)) +
+		   (unsigned long)&data->sigstack[0]);
+
+	/* Use extended_size, but never touch the trailing magic
+	 * (as it may not fit our internal storage)
+	 */
+	fp_size = *(int *)(fp_regs + UM_FPSTATE_EXTENDED_SIZE)
+		  - FP_XSTATE_MAGIC2_SIZE;
+
+	if (fp_size > sizeof(regs->fp))
+		return -ENOSPC;
+
+	if (fp_regs + fp_size > (unsigned long)data->sigstack +
+				sizeof(data->sigstack))
+		return -EINVAL;
+
+	memcpy(&regs->fp, (void *)fp_regs, fp_size);
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
+	unsigned long fp_regs;
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
+	fp_regs = (((unsigned long)mcontext->fpregs &
+		    (UM_KERN_PAGE_SIZE - 1)) +
+		   (unsigned long)&data->sigstack[0]);
+
+	/* Use extended_size, but never touch the trailing magic
+	 * (as it may not fit our internal storage)
+	 */
+	fp_size = *(int *)((unsigned long) &regs->fp +
+			   UM_FPSTATE_EXTENDED_SIZE) -
+		  FP_XSTATE_MAGIC2_SIZE;
+	fp_size_stub = *(int *)(fp_regs + UM_FPSTATE_EXTENDED_SIZE) -
+		       FP_XSTATE_MAGIC2_SIZE;
+
+	/* Can we fit it, or would we need an alternative memory location? */
+	if (fp_size > fp_size_stub)
+		return -ENOSPC;
+
+	if (fp_regs + fp_size > (unsigned long)data->sigstack +
+				sizeof(data->sigstack))
+		return -EINVAL;
+
+	memcpy((void *) fp_regs, &regs->fp, fp_size);
+
+#ifdef __i386__
+	/*
+	 * On x86, we need to sync the GDT entries for the thread local storage.
+	 */
+	#error "Not implemented"
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
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
