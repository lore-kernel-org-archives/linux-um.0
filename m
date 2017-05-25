Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2] um: Allow building and running on older hosts
Date: Thu, 25 May 2017 11:36:26 -0700
Message-Id: <20170525183627.9375-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: elicooper@gmx.com, thomas@m3y3r.de, Florian Fainelli <f.fainelli@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>, "open list:USER-MODE LINUX" <user-mode-linux-devel@lists.sourceforge.net>, , "open list:USER-MODE LINUX" <user-mode-linux-user@lists.sourceforge.net>, 
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Commit a78ff1112263 ("um: add extended processor state save/restore
support") and b6024b21fec8 ("um: extend fpstate to _xstate to support
YMM registers") forced the use of the x86 FP _xstate and
PTRACE_GETREGSET/SETREGSET. On older hosts, we would neither be able to
build UML nor run it anymore with these two commits applied because we
don't have definitions for struct _xstate nor these two ptrace requests.

We can determine at build time which fp context structure to check
against, just like we can keep using the old i387 fp save/restore if
PTRACE_GETRESET/SETREGSET are not defined.

Fixes: a78ff1112263 ("um: add extended processor state save/restore support")
Fixes: b6024b21fec8 ("um: extend fpstate to _xstate to support YMM registers")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- re-arrange the #ifdef/curly braces to not take the branch

 arch/x86/um/os-Linux/registers.c | 12 ++++++++----
 arch/x86/um/user-offsets.c       |  4 ++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
index 00f54a91bb4b..28775f55bde2 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -26,6 +26,7 @@ int save_i387_registers(int pid, unsigned long *fp_regs)
 
 int save_fp_registers(int pid, unsigned long *fp_regs)
 {
+#ifdef PTRACE_GETREGSET
 	struct iovec iov;
 
 	if (have_xstate_support) {
@@ -34,9 +35,9 @@ int save_fp_registers(int pid, unsigned long *fp_regs)
 		if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
 			return -errno;
 		return 0;
-	} else {
+	} else
+#endif
 		return save_i387_registers(pid, fp_regs);
-	}
 }
 
 int restore_i387_registers(int pid, unsigned long *fp_regs)
@@ -48,6 +49,7 @@ int restore_i387_registers(int pid, unsigned long *fp_regs)
 
 int restore_fp_registers(int pid, unsigned long *fp_regs)
 {
+#ifdef PTRACE_SETREGSET
 	struct iovec iov;
 
 	if (have_xstate_support) {
@@ -56,9 +58,9 @@ int restore_fp_registers(int pid, unsigned long *fp_regs)
 		if (ptrace(PTRACE_SETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
 			return -errno;
 		return 0;
-	} else {
+	} else
+#endif
 		return restore_i387_registers(pid, fp_regs);
-	}
 }
 
 #ifdef __i386__
@@ -122,6 +124,7 @@ int put_fp_registers(int pid, unsigned long *regs)
 
 void arch_init_registers(int pid)
 {
+#ifdef PTRACE_GETREGSET
 	struct _xstate fp_regs;
 	struct iovec iov;
 
@@ -129,6 +132,7 @@ void arch_init_registers(int pid)
 	iov.iov_len = sizeof(struct _xstate);
 	if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) == 0)
 		have_xstate_support = 1;
+#endif
 }
 #endif
 
diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index cb3c22370cf5..8af0fb5d2780 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -50,7 +50,11 @@ void foo(void)
 	DEFINE(HOST_GS, GS);
 	DEFINE(HOST_ORIG_AX, ORIG_EAX);
 #else
+#if defined(PTRACE_GETREGSET) && defined(PTRACE_SETREGSET)
 	DEFINE(HOST_FP_SIZE, sizeof(struct _xstate) / sizeof(unsigned long));
+#else
+	DEFINE(HOST_FP_SIZE, sizeof(struct _fpstate) / sizeof(unsigned long));
+#endif
 	DEFINE_LONGS(HOST_BX, RBX);
 	DEFINE_LONGS(HOST_CX, RCX);
 	DEFINE_LONGS(HOST_DI, RDI);
-- 
2.12.2


