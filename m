Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTw7-005VVw-33
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 16:01:21 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 23/27] um: Add helper functions to get/set state for SECCOMP
Date: Wed,  3 Mar 2021 16:55:19 +0100
Message-Id: <20210303155523.124277-24-benjamin@sipsolutions.net>
In-Reply-To: <20210303155523.124277-1-benjamin@sipsolutions.net>
References: <20210303155523.124277-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>

When not using ptrace, we need to both save and restore registers
through the mcontext as provided by the host kernel to our signal
handlers.

Add corresponding functions to store the state to an mcontext and
helpers to access the mcontext of the subprocess through the stub data.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/x86/um/os-Linux/mcontext.c      | 100 +++++++++++++++++++++++++++
 arch/x86/um/shared/sysdep/mcontext.h |   9 +++
 2 files changed, 109 insertions(+)

diff --git a/arch/x86/um/os-Linux/mcontext.c b/arch/x86/um/os-Linux/mcontext.c
index 81b9d1f9f4e6..506ce0aa7108 100644
--- a/arch/x86/um/os-Linux/mcontext.c
+++ b/arch/x86/um/os-Linux/mcontext.c
@@ -3,6 +3,9 @@
 #define __FRAME_OFFSETS
 #include <asm/ptrace.h>
 #include <sysdep/ptrace.h>
+#include <string.h>
+#include <signal.h>
+#include <sysdep/mcontext.h>
 
 void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 {
@@ -16,6 +19,10 @@ void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
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
@@ -27,5 +34,98 @@ void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
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
+void get_stub_state(struct uml_pt_regs *regs, struct stub_data *data)
+{
+	mcontext_t *mcontext;
+
+	if (data->mctx_offset > sizeof(data->sigstack) - sizeof(*mcontext))
+		panic("%s - Invalid mcontext offset from child!\n", __func__);
+
+	mcontext = (void *)&data->sigstack[data->mctx_offset];
+
+	get_regs_from_mc(regs, mcontext);
+	/* Copy floating point registers. As fpregs is a pointer, we need to make some
+	 * assumptions here in order to dereference it.
+	 * As such, assume it is on the same memory page.
+	 */
+	memcpy(&regs->fp,
+	       (void *) (((unsigned long) mcontext->fpregs & (UM_KERN_PAGE_SIZE - 1)) +
+			 (unsigned long) data),
+	       sizeof(*mcontext->fpregs));
+
+	/* We do not need to read the x86_64 FS_BASE/GS_BASE registers as
+	 * we do not permit userspace to set them directly.
+	 */
+}
+
+void set_stub_state(struct uml_pt_regs *regs, struct stub_data *data, int single_stepping)
+{
+	mcontext_t *mcontext = (void *)&data->sigstack[data->mctx_offset];
+
+	get_mc_from_regs(regs, mcontext, single_stepping);
+
+	/* Copy floating point registers (note that mc->fpregs is a userspace address) */
+	memcpy((void *) ((unsigned long) mcontext->fpregs - STUB_DATA +
+			 (unsigned long) data),
+	       &regs->fp, sizeof(*mcontext->fpregs));
+
+#ifdef __i386__
+	/*
+	 * On x86, we need to sync the GDT entries for the thread local storage.
+	 */
+	#error "Not implemented"
+#else
+	/*
+	 * On x86_64, we need to sync back the FS_BASE/GS_BASE registers
+	 * using the arch specific data.
+	 */
+	data->arch_data.sync = 0;
+
+	if (data->arch_data.fs_base != regs->gp[FS_BASE / sizeof(unsigned long)])
+		data->arch_data.sync |= 0x1;
+	if (data->arch_data.gs_base != regs->gp[GS_BASE / sizeof(unsigned long)])
+		data->arch_data.sync |= 0x2;
+
+	data->arch_data.fs_base = regs->gp[FS_BASE / sizeof(unsigned long)];
+	data->arch_data.gs_base = regs->gp[GS_BASE / sizeof(unsigned long)];
+#endif
+}
+#endif
diff --git a/arch/x86/um/shared/sysdep/mcontext.h b/arch/x86/um/shared/sysdep/mcontext.h
index b724c54da316..63334c36c269 100644
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
+extern void get_stub_state(struct uml_pt_regs *regs, struct stub_data *data);
+extern void set_stub_state(struct uml_pt_regs *regs, struct stub_data *data,
+			   int single_stepping);
 
 #ifdef __i386__
 
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

