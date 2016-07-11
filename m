Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [PATCH v1 2/3] um/ptrace: Fix the syscall number update after a ptrace
Date: Mon, 11 Jul 2016 23:57:01 +0200
Message-Id: <1468274222-31726-3-git-send-email-mic@digikod.net>
In-Reply-To: <1468274222-31726-1-git-send-email-mic@digikod.net>
References: <1468274222-31726-1-git-send-email-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Kees Cook <keescook@chromium.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, James Morris <jmorris@namei.org>, Olof Johansson <olof@lixom.net>, user-mode-linux-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Update the syscall number after earch PTRACE_SETREGS on ORIG_*AX.

This is needed to get the potentially altered syscall number in the
seccomp filters after RET_TRACE.

This fix four seccomp_bpf tests:
> [ RUN      ] TRACE_syscall.skip_after_RET_TRACE
> seccomp_bpf.c:1560:TRACE_syscall.skip_after_RET_TRACE:Expected -1 (18446744073709551615) == syscall(39) (26)
> seccomp_bpf.c:1561:TRACE_syscall.skip_after_RET_TRACE:Expected 1 (1) == (*__errno_location ()) (22)
> [     FAIL ] TRACE_syscall.skip_after_RET_TRACE
> [ RUN      ] TRACE_syscall.kill_after_RET_TRACE
> TRACE_syscall.kill_after_RET_TRACE: Test exited normally instead of by signal (code: 1)
> [     FAIL ] TRACE_syscall.kill_after_RET_TRACE
> [ RUN      ] TRACE_syscall.skip_after_ptrace
> seccomp_bpf.c:1622:TRACE_syscall.skip_after_ptrace:Expected -1 (18446744073709551615) == syscall(39) (26)
> seccomp_bpf.c:1623:TRACE_syscall.skip_after_ptrace:Expected 1 (1) == (*__errno_location ()) (22)
> [     FAIL ] TRACE_syscall.skip_after_ptrace
> [ RUN      ] TRACE_syscall.kill_after_ptrace
> TRACE_syscall.kill_after_ptrace: Test exited normally instead of by signal (code: 1)
> [     FAIL ] TRACE_syscall.kill_after_ptrace

Fixes: 26703c636c1f ("um/ptrace: run seccomp after ptrace")

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: James Morris <jmorris@namei.org>
Cc: user-mode-linux-devel@lists.sourceforge.net
---
 arch/um/kernel/skas/syscall.c | 5 -----
 arch/x86/um/ptrace_32.c       | 3 +++
 arch/x86/um/ptrace_64.c       | 4 ++++
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 0728fee94398..b783ac87d98a 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -27,12 +27,7 @@ void handle_syscall(struct uml_pt_regs *r)
 	if (secure_computing(NULL) == -1)
 		goto out;
 
-	/* Update the syscall number after orig_ax has potentially been updated
-	 * with ptrace.
-	 */
-	UPT_SYSCALL_NR(r) = PT_SYSCALL_NR(r->gp);
 	syscall = UPT_SYSCALL_NR(r);
-
 	if (syscall >= 0 && syscall <= __NR_syscall_max)
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
index ebd4dd6ef73b..a7ef7b131e25 100644
--- a/arch/x86/um/ptrace_32.c
+++ b/arch/x86/um/ptrace_32.c
@@ -84,7 +84,10 @@ int putreg(struct task_struct *child, int regno, unsigned long value)
 	case EAX:
 	case EIP:
 	case UESP:
+		break;
 	case ORIG_EAX:
+		/* Update the syscall number. */
+		UPT_SYSCALL_NR(&child->thread.regs.regs) = value;
 		break;
 	case FS:
 		if (value && (value & 3) != 3)
diff --git a/arch/x86/um/ptrace_64.c b/arch/x86/um/ptrace_64.c
index faab418876ce..0b5c184dd5b3 100644
--- a/arch/x86/um/ptrace_64.c
+++ b/arch/x86/um/ptrace_64.c
@@ -78,7 +78,11 @@ int putreg(struct task_struct *child, int regno, unsigned long value)
 	case RSI:
 	case RDI:
 	case RBP:
+		break;
+
 	case ORIG_RAX:
+		/* Update the syscall number. */
+		UPT_SYSCALL_NR(&child->thread.regs.regs) = value;
 		break;
 
 	case FS:
-- 
2.8.1


