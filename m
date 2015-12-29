Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Date: Tue, 29 Dec 2015 21:35:47 +0100
Message-Id: <1451421347-9468-5-git-send-email-mic@digikod.net>
In-Reply-To: <1451421347-9468-1-git-send-email-mic@digikod.net>
References: <1451421347-9468-1-git-send-email-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH v3 4/4] um: Add seccomp support
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Shuah Khan <shuahkh@osg.samsung.com>, Chris Metcalf <cmetcalf@ezchip.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, James Hogan <james.hogan@imgtec.com>, Thomas Meyer <thomas@m3y3r.de>, Nicolas Iooss <nicolas.iooss_linux@m4x.org>, Anton Ivanov <aivanov@brocade.com>, user-mode-linux-devel@lists.sourceforge.net, Meredydd Luff <meredydd@senatehouse.org>, David Drysdale <drysdale@google.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This brings SECCOMP_MODE_STRICT and SECCOMP_MODE_FILTER support through
prctl(2) and seccomp(2) to User-mode Linux for i386 and x86_64
subarchitectures.

secure_computing() is called first in handle_syscall() so that the
syscall emulation will be aborted quickly if matching a seccomp rule.

This is inspired from Meredydd Luff's patch
(https://gerrit.chromium.org/gerrit/21425).

Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Meredydd Luff <meredydd@senatehouse.org>
Cc: David Drysdale <drysdale@google.com>
---
 .../features/seccomp/seccomp-filter/arch-support.txt     |  2 +-
 arch/um/Kconfig.common                                   |  1 +
 arch/um/Kconfig.um                                       | 16 ++++++++=
++++++++
 arch/um/include/asm/thread_info.h                        |  2 ++
 arch/um/kernel/skas/syscall.c                            |  5 +++++
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/features/seccomp/seccomp-filter/arch-support=
=2Etxt b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
index 76d39d66a5d7..4f66ec133951 100644
--- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
+++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
@@ -33,7 +33,7 @@
     |          sh: | TODO |
     |       sparc: | TODO |
     |        tile: |  ok  |
-    |          um: | TODO |
+    |          um: |  ok  |
     |   unicore32: | TODO |
     |         x86: |  ok  |
     |      xtensa: | TODO |
diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index d195a87ca542..cc0013475444 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -2,6 +2,7 @@ config UML
 	bool
 	default y
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_UID16
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select GENERIC_IRQ_SHOW
diff --git a/arch/um/Kconfig.um b/arch/um/Kconfig.um
index 28a9885e3a37..4b2ed5858b2e 100644
--- a/arch/um/Kconfig.um
+++ b/arch/um/Kconfig.um
@@ -104,3 +104,19 @@ config PGTABLE_LEVELS
 	int
 	default 3 if 3_LEVEL_PGTABLES
 	default 2
+
+config SECCOMP
+	def_bool y
+	prompt "Enable seccomp to safely compute untrusted bytecode"
+	---help---
+	  This kernel feature is useful for number crunching applications
+	  that may need to compute untrusted bytecode during their
+	  execution. By using pipes or other transports made available to
+	  the process as file descriptors supporting the read/write
+	  syscalls, it's possible to isolate those applications in
+	  their own address space using seccomp. Once seccomp is
+	  enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
+	  and the task is only allowed to execute a few safe syscalls
+	  defined by each seccomp mode.
+
+	  If unsure, say Y.
diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/th=
read_info.h
index 53968aaf76f9..053baff03674 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -62,11 +62,13 @@ static inline struct thread_info *current_thread_in=
fo(void)
 #define TIF_SYSCALL_AUDIT	6
 #define TIF_RESTORE_SIGMASK	7
 #define TIF_NOTIFY_RESUME	8
+#define TIF_SECCOMP		9	/* secure computing */
=20
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
+#define _TIF_SECCOMP		(1 << TIF_SECCOMP)
=20
 #endif
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscal=
l.c
index 6cadce761bcf..48b0dcbd87be 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -5,6 +5,7 @@
=20
 #include <linux/kernel.h>
 #include <linux/ptrace.h>
+#include <linux/seccomp.h>
 #include <kern_util.h>
 #include <sysdep/ptrace.h>
 #include <sysdep/ptrace_user.h>
@@ -19,6 +20,10 @@ void handle_syscall(struct uml_pt_regs *r)
 	UPT_SYSCALL_NR(r) =3D PT_SYSCALL_NR(r->gp);
 	PT_REGS_SET_SYSCALL_RETURN(regs, -ENOSYS);
=20
+	/* Do the secure computing check first; failures should be fast. */
+	if (secure_computing() =3D=3D -1)
+		return;
+
 	if (syscall_trace_enter(regs))
 		goto out;
=20
--=20
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

