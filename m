Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTwN-005Va5-Na
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 16:01:38 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 22/27] um: Add stub side of SECCOMP/futex based process
 handling
Date: Wed,  3 Mar 2021 16:55:18 +0100
Message-Id: <20210303155523.124277-23-benjamin@sipsolutions.net>
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
Cc: Benjamin Berg <benjamin@sipsolutions.net>, Johannes Berg <johannes@sipsolutions.net>

This adds the stub side for the new seccomp process management code. In
this case we do register save/restore through the signal handler
mcontext. For the FS_BASE/GS_BASE register we need special handling.

Co-authored-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/skas/stub-data.h | 15 +++++++
 arch/um/kernel/skas/clone.c             | 25 ++++++++++++
 arch/um/kernel/skas/stub.c              | 53 +++++++++++++++++++++++++
 arch/x86/um/shared/sysdep/stub-data.h   | 11 +++++
 arch/x86/um/shared/sysdep/stub.h        |  3 ++
 arch/x86/um/shared/sysdep/stub_32.h     |  5 +++
 arch/x86/um/shared/sysdep/stub_64.h     | 10 +++++
 7 files changed, 122 insertions(+)
 create mode 100644 arch/x86/um/shared/sysdep/stub-data.h

diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index efa78bc359cb..e130c428cda9 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -8,8 +8,13 @@
 #ifndef __STUB_DATA_H
 #define __STUB_DATA_H
 
+#include <linux/kconfig.h>
 #include <linux/compiler_types.h>
 #include <as-layout.h>
+#include <sysdep/stub-data.h>
+
+#define FUTEX_IN_CHILD 0
+#define FUTEX_IN_KERN 1
 
 #define STUB_NEXT_SYSCALL(s) \
 	((struct stub_syscall *) (((unsigned long) s) + (s)->cmd_len))
@@ -32,6 +37,16 @@ struct stub_data {
 	unsigned char syscall_data[UM_KERN_PAGE_SIZE - MINSIGSTKSZ - 128]
 		      __aligned(16);
 
+	/* data shared with signal handler (only used in seccomp mode) */
+	short restart_wait;
+	unsigned int futex;
+	int signal;
+	unsigned short si_offset;
+	unsigned short mctx_offset;
+
+	/* seccomp architecture specific state restore */
+	struct stub_data_arch arch_data;
+
 	/* Stack for our signal handlers and for calling into . */
 	unsigned char sigstack[MINSIGSTKSZ + 32] __aligned(16);
 };
diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
index a680d80b3870..d6e0742c77fd 100644
--- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -49,3 +49,28 @@ stub_clone_handler(void)
  done:
 	trap_myself();
 }
+
+#ifdef CONFIG_UML_SECCOMP
+void __attribute__ ((__section__ (".__syscall_stub")))
+stub_clone_handler_seccomp(void)
+{
+	int stack;
+	struct stub_data *data = (void *) ((unsigned long)&stack & ~(UM_KERN_PAGE_SIZE - 1));
+	long err;
+
+	/* Use the syscall data as a temporary stack area. */
+	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
+			    (unsigned long) data->syscall_data +
+					    sizeof(data->syscall_data) -
+					    sizeof(void *));
+	if (err) {
+		data->err = err;
+		goto done;
+	}
+
+	remap_stack_and_trap();
+
+ done:
+	trap_myself();
+}
+#endif
diff --git a/arch/um/kernel/skas/stub.c b/arch/um/kernel/skas/stub.c
index 5d1bcc883866..4bf32fdf4599 100644
--- a/arch/um/kernel/skas/stub.c
+++ b/arch/um/kernel/skas/stub.c
@@ -5,6 +5,13 @@
 
 #include <sysdep/stub.h>
 
+#ifdef CONFIG_UML_SECCOMP
+#include <linux/futex.h>
+#include <errno.h>
+
+#define CATCH_EINTR(expr) while ((res = (expr)) && (res == -EINTR))
+#endif
+
 static __always_inline int
 syscall_handler(struct stub_data *d)
 {
@@ -50,3 +57,49 @@ stub_syscall_handler(void)
 
 	trap_myself();
 }
+
+#ifdef CONFIG_UML_SECCOMP
+void __attribute__ ((__section__ (".__syscall_stub")))
+stub_signal_interrupt(int sig, siginfo_t *info, void *p)
+{
+	int stack;
+	struct stub_data *d = (void *) ((unsigned long)&stack & ~(UM_KERN_PAGE_SIZE - 1));
+	ucontext_t *uc = p;
+	long res;
+
+	d->signal = sig;
+	d->si_offset = (unsigned long)info - (unsigned long)&d->sigstack[0];
+	d->mctx_offset = (unsigned long)&uc->uc_mcontext - (unsigned long)&d->sigstack[0];
+
+restart_wait:
+	d->futex = FUTEX_IN_KERN;
+	CATCH_EINTR(stub_syscall3(__NR_futex, (unsigned long)&d->futex,
+				  FUTEX_WAKE, 1));
+	do {
+		res = stub_syscall4(__NR_futex, (unsigned long)&d->futex,
+				    FUTEX_WAIT, FUTEX_IN_KERN, 0);
+	} while (res == -EINTR || d->futex == FUTEX_IN_KERN);
+
+	if (res < 0 && res != -EAGAIN)
+		stub_syscall2(__NR_kill, 0, SIGKILL);
+
+	/* Try running queued syscalls. */
+	if (syscall_handler(d) < 0 || d->restart_wait) {
+		/* Report SIGTRAP if we restart. */
+		d->signal = SIGTRAP;
+		d->restart_wait = 0;
+		goto restart_wait;
+	}
+
+	/* Restore arch dependent state that is not part of the mcontext */
+	stub_seccomp_restore_state(&d->arch_data);
+
+	/* Return so that the host modified mcontext is restored. */
+}
+
+void __attribute__ ((__section__ (".__syscall_stub")))
+stub_signal_restorer(void)
+{
+	stub_syscall0(__NR_rt_sigreturn);
+}
+#endif
diff --git a/arch/x86/um/shared/sysdep/stub-data.h b/arch/x86/um/shared/sysdep/stub-data.h
new file mode 100644
index 000000000000..2e71b48ebb1f
--- /dev/null
+++ b/arch/x86/um/shared/sysdep/stub-data.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifdef __i386__
+struct stub_data_arch { };
+#else
+struct stub_data_arch {
+	int sync;
+	unsigned long fs_base;
+	unsigned long gs_base;
+};
+#endif
+
diff --git a/arch/x86/um/shared/sysdep/stub.h b/arch/x86/um/shared/sysdep/stub.h
index 579681d12158..eb2e3a24d40b 100644
--- a/arch/x86/um/shared/sysdep/stub.h
+++ b/arch/x86/um/shared/sysdep/stub.h
@@ -14,3 +14,6 @@
 extern void stub_segv_handler(int, siginfo_t *, void *);
 extern void stub_syscall_handler(void);
 extern void stub_clone_handler(void);
+extern void stub_signal_interrupt(int, siginfo_t *, void *);
+extern void stub_signal_restorer(void);
+extern void stub_clone_handler_seccomp(void);
diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index 3fb8559fe994..62aa7597576a 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -130,4 +130,9 @@ static __always_inline void remap_stack_and_trap(void)
 		"memory");
 }
 
+static __always_inline void stub_seccomp_restore_state(struct stub_data_arch *arch)
+{
+	/* No extra arch specific restore */
+}
+
 #endif
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index c41ae0462c8f..69f9aeca8cee 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -8,6 +8,7 @@
 
 #include <sysdep/ptrace_user.h>
 #include <generated/asm-offsets.h>
+#include <asm/prctl.h>
 
 #define STUB_MMAP_NR __NR_mmap
 #define MMAP_OFFSET(o) (o)
@@ -125,4 +126,13 @@ static __always_inline void remap_stack_and_trap(void)
 		__syscall_clobber, "r10", "r8", "r9");
 }
 
+static __always_inline void stub_seccomp_restore_state(struct stub_data_arch *arch)
+{
+	/* TODO: Use _writefsbase_u64/_writegsbase_u64 when possible */
+	if (arch->sync & 0x1)
+		stub_syscall2(__NR_arch_prctl, ARCH_SET_FS, arch->fs_base);
+	if (arch->sync & 0x2)
+		stub_syscall2(__NR_arch_prctl, ARCH_SET_GS, arch->gs_base);
+}
+
 #endif
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

