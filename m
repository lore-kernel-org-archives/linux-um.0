Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Qy4K3-0004Nt-BI
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2011 16:04:27 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qy4K1-0005sn-MV
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2011 16:04:27 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 29 Aug 2011 18:03:56 +0200
Message-Id: <1314633842-24515-4-git-send-email-richard@nod.at>
In-Reply-To: <1314633842-24515-1-git-send-email-richard@nod.at>
References: <1314633842-24515-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 3/9] um: Save FPU registers between task switches
To: akpm@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Ingo van Lil <inguin@gmx.de>

From: Ingo van Lil <inguin@gmx.de>

Some time ago Jeff prepared a patch (42daba3) for UML to stop saving the
process FP state between task switches. The assumption was that since
with SKAS0 every guest process runs inside a host process context the
host OS will take care of keeping the proper FP state. Unfortunately
this is not true for multi-threaded applications, where all guest
threads share a single host process context yet all may use the FPU on
their own. Although I haven't verified it I suspect things to be even
worse in SKAS3 mode where all guest processes run inside a single host
process.

The patch below reintroduces the saving and restoring of the FP context
between task switches.

Signed-off-by: Ingo van Lil <inguin@gmx.de>
Signed-off-by: Richard Weinberger <richard@nod.at>
Reported-by: gunnarlindroth@hotmail.com
Tested-by: gunnarlindroth@hotmail.com
CC: Stanislav Meduna <stano@meduna.org>

[richard@nod.at: Ingo posted this patch in 2009, sadly it was never applied
and got lost. Now in 2011 the problem was reported by Gunnar.]
---
 arch/um/include/shared/registers.h        |    2 +-
 arch/um/kernel/process.c                  |    2 +-
 arch/um/os-Linux/registers.c              |    9 ++++++++-
 arch/um/os-Linux/skas/mem.c               |    2 +-
 arch/um/os-Linux/skas/process.c           |   19 ++++++++++++++++++-
 arch/um/sys-i386/shared/sysdep/ptrace.h   |    1 +
 arch/um/sys-x86_64/shared/sysdep/ptrace.h |    1 +
 7 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/um/include/shared/registers.h b/arch/um/include/shared/registers.h
index b0b4589..f1e0aa5 100644
--- a/arch/um/include/shared/registers.h
+++ b/arch/um/include/shared/registers.h
@@ -16,7 +16,7 @@ extern int restore_fpx_registers(int pid, unsigned long *fp_regs);
 extern int save_registers(int pid, struct uml_pt_regs *regs);
 extern int restore_registers(int pid, struct uml_pt_regs *regs);
 extern int init_registers(int pid);
-extern void get_safe_registers(unsigned long *regs);
+extern void get_safe_registers(unsigned long *regs, unsigned long *fp_regs);
 extern unsigned long get_thread_reg(int reg, jmp_buf *buf);
 extern int get_fp_registers(int pid, unsigned long *regs);
 extern int put_fp_registers(int pid, unsigned long *regs);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index fab4371..21c1ae7 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -202,7 +202,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 		arch_copy_thread(&current->thread.arch, &p->thread.arch);
 	}
 	else {
-		get_safe_registers(p->thread.regs.regs.gp);
+		get_safe_registers(p->thread.regs.regs.gp, p->thread.regs.regs.fp);
 		p->thread.request.u.thread = current->thread.request.u.thread;
 		handler = new_thread_handler;
 	}
diff --git a/arch/um/os-Linux/registers.c b/arch/um/os-Linux/registers.c
index 830fe6a..b866b9e 100644
--- a/arch/um/os-Linux/registers.c
+++ b/arch/um/os-Linux/registers.c
@@ -8,6 +8,8 @@
 #include <string.h>
 #include <sys/ptrace.h>
 #include "sysdep/ptrace.h"
+#include "sysdep/ptrace_user.h"
+#include "registers.h"
 
 int save_registers(int pid, struct uml_pt_regs *regs)
 {
@@ -32,6 +34,7 @@ int restore_registers(int pid, struct uml_pt_regs *regs)
 /* This is set once at boot time and not changed thereafter */
 
 static unsigned long exec_regs[MAX_REG_NR];
+static unsigned long exec_fp_regs[FP_SIZE];
 
 int init_registers(int pid)
 {
@@ -42,10 +45,14 @@ int init_registers(int pid)
 		return -errno;
 
 	arch_init_registers(pid);
+	get_fp_registers(pid, exec_fp_regs);
 	return 0;
 }
 
-void get_safe_registers(unsigned long *regs)
+void get_safe_registers(unsigned long *regs, unsigned long *fp_regs)
 {
 	memcpy(regs, exec_regs, sizeof(exec_regs));
+
+	if (fp_regs)
+		memcpy(fp_regs, exec_fp_regs, sizeof(exec_fp_regs));
 }
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index d261f17..e771398 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -39,7 +39,7 @@ static unsigned long syscall_regs[MAX_REG_NR];
 
 static int __init init_syscall_regs(void)
 {
-	get_safe_registers(syscall_regs);
+	get_safe_registers(syscall_regs, NULL);
 	syscall_regs[REGS_IP_INDEX] = STUB_CODE +
 		((unsigned long) &batch_syscall_stub -
 		 (unsigned long) &__syscall_stub_start);
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index d6e0a22..dee0e8c 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -373,6 +373,9 @@ void userspace(struct uml_pt_regs *regs)
 		if (ptrace(PTRACE_SETREGS, pid, 0, regs->gp))
 			fatal_sigsegv();
 
+		if (put_fp_registers(pid, regs->fp))
+			fatal_sigsegv();
+
 		/* Now we set local_using_sysemu to be used for one loop */
 		local_using_sysemu = get_using_sysemu();
 
@@ -399,6 +402,12 @@ void userspace(struct uml_pt_regs *regs)
 			fatal_sigsegv();
 		}
 
+		if (get_fp_registers(pid, regs->fp)) {
+			printk(UM_KERN_ERR "userspace -  get_fp_registers failed, "
+			       "errno = %d\n", errno);
+			fatal_sigsegv();
+		}
+
 		UPT_SYSCALL_NR(regs) = -1; /* Assume: It's not a syscall */
 
 		if (WIFSTOPPED(status)) {
@@ -457,10 +466,11 @@ void userspace(struct uml_pt_regs *regs)
 }
 
 static unsigned long thread_regs[MAX_REG_NR];
+static unsigned long thread_fp_regs[FP_SIZE];
 
 static int __init init_thread_regs(void)
 {
-	get_safe_registers(thread_regs);
+	get_safe_registers(thread_regs, thread_fp_regs);
 	/* Set parent's instruction pointer to start of clone-stub */
 	thread_regs[REGS_IP_INDEX] = STUB_CODE +
 				(unsigned long) stub_clone_handler -
@@ -503,6 +513,13 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 		return err;
 	}
 
+	err = put_fp_registers(pid, thread_fp_regs);
+	if (err < 0) {
+		printk(UM_KERN_ERR "copy_context_skas0 : put_fp_registers "
+		       "failed, pid = %d, err = %d\n", pid, err);
+		return err;
+	}
+
 	/* set a well known return code for detection of child write failure */
 	child_data->err = 12345678;
 
diff --git a/arch/um/sys-i386/shared/sysdep/ptrace.h b/arch/um/sys-i386/shared/sysdep/ptrace.h
index d50e62e..c398a50 100644
--- a/arch/um/sys-i386/shared/sysdep/ptrace.h
+++ b/arch/um/sys-i386/shared/sysdep/ptrace.h
@@ -53,6 +53,7 @@ extern int sysemu_supported;
 
 struct uml_pt_regs {
 	unsigned long gp[MAX_REG_NR];
+	unsigned long fp[HOST_FPX_SIZE];
 	struct faultinfo faultinfo;
 	long syscall;
 	int is_user;
diff --git a/arch/um/sys-x86_64/shared/sysdep/ptrace.h b/arch/um/sys-x86_64/shared/sysdep/ptrace.h
index fdba545..8ee8f8e 100644
--- a/arch/um/sys-x86_64/shared/sysdep/ptrace.h
+++ b/arch/um/sys-x86_64/shared/sysdep/ptrace.h
@@ -85,6 +85,7 @@
 
 struct uml_pt_regs {
 	unsigned long gp[MAX_REG_NR];
+	unsigned long fp[HOST_FP_SIZE];
 	struct faultinfo faultinfo;
 	long syscall;
 	int is_user;
-- 
1.7.6.1


------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

