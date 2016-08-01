Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [PATCH v2 1/3] um/ptrace: Fix the syscall_trace_leave call
Date: Mon,  1 Aug 2016 23:01:55 +0200
Message-Id: <1470085317-11932-2-git-send-email-mic@digikod.net>
In-Reply-To: <1470085317-11932-1-git-send-email-mic@digikod.net>
References: <alpine.LRH.2.20.1608011053430.15475@namei.org>
 <1470085317-11932-1-git-send-email-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Kees Cook <keescook@chromium.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, James Morris <jmorris@namei.org>, Olof Johansson <olof@lixom.net>, user-mode-linux-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Keep the same semantic as before the commit 26703c636c1f: deallocate
audit context and fake a proper syscall exit.

This fix a kernel panic triggered by the seccomp_bpf test:
> [ RUN      ] global.ERRNO_valid
> BUG: failure at kernel/auditsc.c:1504/__audit_syscall_entry()!
> Kernel panic - not syncing: BUG!

Fixes: 26703c636c1f ("um/ptrace: run seccomp after ptrace")

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: James Morris <jmorris@namei.org>
Cc: user-mode-linux-devel@lists.sourceforge.net
---
 arch/um/kernel/skas/syscall.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index ef4b8f949b51..0728fee94398 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -21,11 +21,11 @@ void handle_syscall(struct uml_pt_regs *r)
 	PT_REGS_SET_SYSCALL_RETURN(regs, -ENOSYS);
 
 	if (syscall_trace_enter(regs))
-		return;
+		goto out;
 
 	/* Do the seccomp check after ptrace; failures should be fast. */
 	if (secure_computing(NULL) == -1)
-		return;
+		goto out;
 
 	/* Update the syscall number after orig_ax has potentially been updated
 	 * with ptrace.
@@ -37,5 +37,6 @@ void handle_syscall(struct uml_pt_regs *r)
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
 
+out:
 	syscall_trace_leave(regs);
 }
-- 
2.8.1


