Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTww-005Vjd-8c
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 16:02:16 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 24/27] um: Add SECCOMP support detection and initialization
Date: Wed,  3 Mar 2021 16:55:20 +0100
Message-Id: <20210303155523.124277-25-benjamin@sipsolutions.net>
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

This detects seccomp support, sets the global using_seccomp variable and
initilizes the exec registers. For now, the implementation simply falls
through to the ptrace startup code, meaning that it is unused.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/skas/skas.h |   6 ++
 arch/um/os-Linux/registers.c       |   4 +-
 arch/um/os-Linux/skas/process.c    |   3 +
 arch/um/os-Linux/start_up.c        | 132 ++++++++++++++++++++++++++++-
 4 files changed, 141 insertions(+), 4 deletions(-)

diff --git a/arch/um/include/shared/skas/skas.h b/arch/um/include/shared/skas/skas.h
index c93d2cbc8f32..f10599995d4d 100644
--- a/arch/um/include/shared/skas/skas.h
+++ b/arch/um/include/shared/skas/skas.h
@@ -6,8 +6,14 @@
 #ifndef __SKAS_H
 #define __SKAS_H
 
+#include <linux/kconfig.h>
 #include <sysdep/ptrace.h>
 
+#ifdef CONFIG_UML_SECCOMP
+extern int using_seccomp;
+#else
+#define using_seccomp 0
+#endif
 extern int userspace_pid[];
 
 extern int user_thread(unsigned long stack, int flags);
diff --git a/arch/um/os-Linux/registers.c b/arch/um/os-Linux/registers.c
index 52823368e15a..7c86e0414db0 100644
--- a/arch/um/os-Linux/registers.c
+++ b/arch/um/os-Linux/registers.c
@@ -13,8 +13,8 @@
 
 /* This is set once at boot time and not changed thereafter */
 
-static unsigned long exec_regs[MAX_REG_NR];
-static unsigned long exec_fp_regs[FP_SIZE];
+unsigned long exec_regs[MAX_REG_NR];
+unsigned long exec_fp_regs[FP_SIZE];
 
 int init_registers(int pid)
 {
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 3bfc28d28fc0..a3f0dd0f47d0 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -251,6 +251,9 @@ static int userspace_tramp(void *stack)
 	return 0;
 }
 
+#ifdef CONFIG_UML_SECCOMP
+int using_seccomp;
+#endif
 int userspace_pid[NR_CPUS];
 int kill_userspace_mm[NR_CPUS];
 
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 8e6f8c4f3f62..2a581ea1b0ef 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (C) 2021 Benjamin Berg <benjamin@sipsolutions.net>
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
+#include <linux/kconfig.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>
@@ -22,6 +24,13 @@
 #include <os.h>
 #include <mem_user.h>
 #include <ptrace_user.h>
+#ifdef CONFIG_UML_SECCOMP
+#include <stub-data.h>
+#include <sys/prctl.h>
+#include <linux/seccomp.h>
+#include <linux/filter.h>
+#include <sysdep/mcontext.h>
+#endif
 #include <registers.h>
 #include <skas.h>
 
@@ -221,6 +230,112 @@ static void __init check_ptrace(void)
 	check_sysemu();
 }
 
+#ifdef CONFIG_UML_SECCOMP
+extern unsigned long exec_regs[MAX_REG_NR];
+extern unsigned long exec_fp_regs[FP_SIZE];
+
+static struct stub_data __initdata *seccomp_shared_page;
+
+static void __init sigsys_handler(int sig, siginfo_t *info, void *p)
+{
+	ucontext_t *uc = p;
+
+	/* Stow away the location of the mcontext in the stack */
+	seccomp_shared_page->mctx_offset = (unsigned long)&uc->uc_mcontext -
+					   (unsigned long)&seccomp_shared_page->sigstack[0];
+	exit(0);
+}
+
+static bool __init init_seccomp(void)
+{
+	int pid;
+	int status;
+	int n;
+
+	/* We check that we can install a seccomp filter and then exit(0)
+	 * from a trapped syscall.
+	 *
+	 * Note that we cannot verify that no seccomp filter already exists
+	 * for a syscall that results in the process/thread to be killed.
+	 */
+
+	os_info("Checking that seccomp filters can be installed...");
+
+	seccomp_shared_page = mmap(0, UM_KERN_PAGE_SIZE,
+				   PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANON, 0, 0);
+
+	pid = fork();
+	if (pid == 0) {
+		static struct sock_filter filter[] = {
+			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
+				offsetof(struct seccomp_data, nr)),
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_exit_group, 0, 1),
+			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
+			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_TRAP),
+		};
+		static struct sock_fprog prog = {
+			.len = ARRAY_SIZE(filter),
+			.filter = filter,
+		};
+		struct sigaction sa;
+
+		set_sigstack(seccomp_shared_page->sigstack,
+			     sizeof(seccomp_shared_page->sigstack));
+
+		sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
+		sa.sa_sigaction = (void *) sigsys_handler;
+		sa.sa_restorer = NULL;
+		if (sigaction(SIGSYS, &sa, NULL) < 0)
+			exit(1);
+
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+		if (syscall(__NR_seccomp, SECCOMP_SET_MODE_FILTER,
+			    SECCOMP_FILTER_FLAG_TSYNC, &prog) != 0)
+			exit(2);
+
+		sleep(0);
+
+		/* Never reached. */
+		exit(3);
+	}
+
+	if (pid < 0)
+		fatal_perror("check_seccomp : fork failed");
+
+	CATCH_EINTR(n = waitpid(pid, &status, 0));
+	if (n < 0)
+		fatal_perror("check_seccomp : waitpid failed");
+
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
+		struct uml_pt_regs regs = { 0 };
+
+		/* XXX: Can we add something like this easily anywhere?
+		 * COMPILE_BUG_ON(sizeof(*mc->fpregs) > sizeof(regs->fp));
+		 */
+
+		/* Copy registers, the init_registers function assumes ptrace. */
+		get_stub_state(&regs, seccomp_shared_page);
+
+		memcpy(exec_regs, regs.gp, sizeof(exec_regs));
+		memcpy(exec_fp_regs, regs.fp, sizeof(exec_fp_regs));
+
+		munmap(seccomp_shared_page, sizeof(mcontext_t));
+
+		os_info("OK\n");
+
+		return true;
+	}
+
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 2)
+		os_info("missing\n");
+	else
+		os_info("error\n");
+
+	munmap(seccomp_shared_page, sizeof(mcontext_t));
+	return false;
+}
+#endif
+
 extern void check_tmpexec(void);
 
 static void __init check_coredump_limit(void)
@@ -253,13 +368,26 @@ void __init os_early_checks(void)
 	/* Print out the core dump limits early */
 	check_coredump_limit();
 
-	check_ptrace();
-
 	/* Need to check this early because mmapping happens before the
 	 * kernel is running.
 	 */
 	check_tmpexec();
 
+#ifdef CONFIG_UML_SECCOMP
+	using_seccomp = 0;
+
+	if (init_seccomp()) {
+		/* Not fully implemented */
+#if 0
+		using_seccomp = 1;
+
+		return;
+#endif
+	}
+#endif
+
+	check_ptrace();
+
 	pid = start_ptraced_child();
 	if (init_registers(pid))
 		fatal("Failed to initialize default registers");
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

