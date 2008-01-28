Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Mon, 28 Jan 2008 16:38:31 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080128213831.GA10261@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [RFC PATCH 6/10] SKAS4 - Guest support for using
	PTRACE_GETSIGINFO
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: uml-user <user-mode-linux-user@lists.sourceforge.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

The nastiness in arch/um/include/siginfo_segv.h is defining the new
siginfo_t structure in place of the old one, which requires using CPP
to rename the old one out of the way.

diff --git a/arch/um/include/siginfo_segv.h b/arch/um/include/siginfo_segv.h
new file mode 100644
index 0000000..c000267
--- /dev/null
+++ b/arch/um/include/siginfo_segv.h
@@ -0,0 +1,133 @@
+/*
+ * Copyright (C) 2002- 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SIGINFO_SIGSEGV_H_
+#define __SIGINFO_SIGSEGV_H_
+
+/*
+ * Provide signal.h, except for replacing siginfo_t with one that has
+ * the CPU trap number and error code in the SIGSEGV case.
+ */
+
+#include <time.h>
+
+/* Rename the signal.h siginfo and siginfo_t out of the way */
+#define siginfo old_siginfo
+#define siginfo_t old_siginfo_t
+
+#include <signal.h>
+
+#undef siginfo
+#undef siginfo_t
+
+#define __ARCH_SI_TRAPNO
+#define __ARCH_SI_ERROR
+
+/* The new siginfo_t, plus associated definitions */
+
+/*
+ * This is the size (including padding) of the part of the
+ * struct siginfo that is before the union.
+ */
+#ifndef __ARCH_SI_PREAMBLE_SIZE
+#define __ARCH_SI_PREAMBLE_SIZE	(3 * sizeof(int))
+#endif
+
+#define SI_MAX_SIZE	128
+#ifndef SI_PAD_SIZE
+#define SI_PAD_SIZE	((SI_MAX_SIZE - __ARCH_SI_PREAMBLE_SIZE) / sizeof(int))
+#endif
+
+#ifndef __ARCH_SI_UID_T
+#define __ARCH_SI_UID_T	uid_t
+#endif
+
+/*
+ * The default "si_band" type is "long", as specified by POSIX.
+ * However, some architectures want to override this to "int"
+ * for historical compatibility reasons, so we allow that.
+ */
+#ifndef __ARCH_SI_BAND_T
+#define __ARCH_SI_BAND_T long
+#endif
+
+#define __user
+
+typedef struct siginfo {
+	int si_signo;
+	int si_errno;
+	int si_code;
+
+	union {
+		int _pad[SI_PAD_SIZE];
+
+		/* kill() */
+		struct {
+			pid_t _pid;		/* sender's pid */
+			__ARCH_SI_UID_T _uid;	/* sender's uid */
+		} _kill;
+
+		/* POSIX.1b timers */
+		struct {
+			timer_t _tid;		/* timer id */
+			int _overrun;		/* overrun count */
+			char _pad[sizeof( __ARCH_SI_UID_T) - sizeof(int)];
+			sigval_t _sigval;	/* same as below */
+			int _sys_private;       /* not to be passed to user */
+		} _timer;
+
+		/* POSIX.1b signals */
+		struct {
+			pid_t _pid;		/* sender's pid */
+			__ARCH_SI_UID_T _uid;	/* sender's uid */
+			sigval_t _sigval;
+		} _rt;
+
+		/* SIGCHLD */
+		struct {
+			pid_t _pid;		/* which child */
+			__ARCH_SI_UID_T _uid;	/* sender's uid */
+			int _status;		/* exit code */
+			clock_t _utime;
+			clock_t _stime;
+		} _sigchld;
+
+		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
+		struct {
+			void __user *_addr; /* faulting insn/memory ref. */
+#ifdef __ARCH_SI_TRAPNO
+			int _trapno;	/* TRAP # which caused the signal */
+#endif
+#ifdef __ARCH_SI_ERROR
+			int _error;	/* CPU error code */
+#endif
+		} _sigfault;
+
+		/* SIGPOLL */
+		struct {
+			__ARCH_SI_BAND_T _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
+			int _fd;
+		} _sigpoll;
+	} _sifields;
+} siginfo_t;
+
+#ifdef __ARCH_SI_TRAPNO
+#define si_trapno	_sifields._sigfault._trapno
+#endif
+#ifdef __ARCH_SI_ERROR
+#define si_error	_sifields._sigfault._error
+#endif
+
+#undef si_addr
+#define si_addr	_sifields._sigfault._addr
+
+#define GET_FAULTINFO_FROM_SI(fi, si) \
+	{ \
+		(fi).cr2 = (unsigned long) (si).si_addr; \
+		(fi).error_code = (si).si_error; \
+		(fi).trap_no = (si).si_trapno; \
+	}
+
+#endif
diff --git a/arch/um/include/skas/skas.h b/arch/um/include/skas/skas.h
index b073f8a..d6cbb4f 100644
--- a/arch/um/include/skas/skas.h
+++ b/arch/um/include/skas/skas.h
@@ -8,6 +8,8 @@
 
 #include "sysdep/ptrace.h"
 
+extern int have_siginfo_segv;
+
 extern int userspace_pid[];
 extern int proc_mm, ptrace_faultinfo, ptrace_ldt;
 extern int skas_needs_stub;
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index e8b7a97..82a0780 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -3,6 +3,9 @@
  * Licensed under the GPL
  */
 
+/* Include this first, before anything else includes <signal.h> */
+#include "siginfo_segv.h"
+
 #include <stdlib.h>
 #include <unistd.h>
 #include <sched.h>
@@ -91,11 +94,23 @@ bad_wait:
 
 extern unsigned long current_stub_stack(void);
 
+#ifndef PTRACE_GETSIGINFO
+#define PTRACE_GETSIGINFO	0x4202
+#endif
+
 void get_skas_faultinfo(int pid, struct faultinfo * fi)
 {
+	siginfo_t si;
 	int err;
 
-	if (ptrace_faultinfo) {
+	if(have_siginfo_segv){
+		err = ptrace(PTRACE_GETSIGINFO, pid, 0, &si);
+		if(err)
+			printk("PTRACE_GETSIGINFO failed, err = %d\n", errno);
+
+		GET_FAULTINFO_FROM_SI(*fi, si);
+	}
+	else if (ptrace_faultinfo) {
 		err = ptrace(PTRACE_FAULTINFO, pid, 0, fi);
 		if (err)
 			panic("get_skas_faultinfo - PTRACE_FAULTINFO failed, "
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 2576d70..0e0f738 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -3,6 +3,9 @@
  * Licensed under the GPL
  */
 
+/* Include this first, before anything else includes <signal.h> */
+#include "siginfo_segv.h"
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>
@@ -25,6 +28,7 @@
 #include "registers.h"
 #include "skas.h"
 #include "skas_ptrace.h"
+#include "sysdep/sigcontext.h"
 
 static int ptrace_child(void)
 {
@@ -154,6 +158,9 @@ static int disable_proc_mm;
 int have_switch_mm;
 static int disable_switch_mm;
 
+int have_siginfo_segv;
+static int disable_siginfo_segv;
+
 int skas_needs_stub;
 
 static int __init skas0_cmd_param(char *str, int* add)
@@ -162,6 +169,7 @@ static int __init skas0_cmd_param(char *str, int* add)
 	disable_ptrace_ldt = 1;
 	disable_proc_mm = 1;
 	disable_switch_mm = 1;
+	disable_siginfo_segv = 1;
 
 	return 0;
 }
@@ -475,6 +483,137 @@ static inline void check_skas3_proc_mm(void)
 	}
 }
 
+static void *fault_address;
+
+static int check_fault_info(struct faultinfo *fi)
+{
+	return (FAULT_ADDRESS(*fi) == (unsigned long) fault_address) &&
+		FAULT_WRITE(*fi) && SEGV_IS_FIXABLE(fi);
+}
+
+static jmp_buf siginfo_buf;
+
+static void segv_handler(int sig, siginfo_t *si, void *foo)
+{
+	struct faultinfo fi;
+	int n;
+
+	GET_FAULTINFO_FROM_SI(fi, *si);
+	n = check_fault_info(&fi) ? 1 : 2;
+	longjmp(siginfo_buf, n);
+}
+
+static int fault(void)
+{
+	struct sigaction sa, old;
+	int err, n;
+
+	/*
+	 * The cast is needed because the CPP manipulations of
+	 * siginfo_t resulted in sa_sigaction having an old_siginfo_t
+	 * parameter.
+	 */
+	sa.sa_sigaction = (void (*)(int, old_siginfo_t *, void *)) segv_handler;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_SIGINFO | SA_NODEFER;
+
+	err = sigaction(SIGSEGV, &sa, &old);
+	if (err)
+		fatal_perror("sigaction");
+
+	/*
+	 * Provide a guaranteed invalid address by mapping a page into
+	 * a hole in the address space and then unmapping it.
+	 */
+	fault_address = mmap(NULL, UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
+		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (fault_address == MAP_FAILED)
+		fatal_perror("mmap failed");
+
+	if (munmap(fault_address, UM_KERN_PAGE_SIZE) < 0)
+		fatal_perror("munmap failed");
+
+	n = setjmp(siginfo_buf);
+	if (n == 0)
+		*((unsigned long *) fault_address) = 0;
+
+	err = sigaction(SIGSEGV, &old, NULL);
+
+	return n;
+}
+
+static int __init nogetsiginfo_cmd_param(char *str, int *add)
+{
+	disable_siginfo_segv = 1;
+	return 0;
+}
+
+__uml_setup("nogetsiginfo", nogetsiginfo_cmd_param,
+"nogetsiginfo\n"
+"    Turns off usage of PTRACE_GETSIGINFO to read page fault information\n"
+"    from a child process, even if the host supports it.\n\n");
+
+#ifndef PTRACE_GETSIGINFO
+#define PTRACE_GETSIGINFO	0x4202
+#endif
+
+static int check_siginfo(void)
+{
+	siginfo_t si;
+	struct faultinfo fi;
+	int ok, pid, err, status;
+
+	non_fatal("\tFull CPU fault information in siginfo_t ... ");
+	ok = fault();
+	if (ok)
+		non_fatal("OK\n");
+	else {
+		non_fatal("Failed\n");
+		return 0;
+	}
+
+	non_fatal("\tFull CPU fault information in PTRACE_GETSIGINFO ... ");
+
+	pid = fork();
+	if (pid < 0)
+		fatal_perror("fork failed");
+	else if (pid == 0) {
+		ptrace(PTRACE_TRACEME, 0, 0, 0);
+		fault();
+		exit(1);
+	}
+
+	while(1){
+		err = waitpid(pid, &status, WUNTRACED);
+		if (err < 0)
+			fatal_perror("wait failed");
+
+		if (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGSEGV))
+			break;
+	}
+
+	err = ptrace(PTRACE_GETSIGINFO, pid, 0, &si);
+	if (err < 0)
+		fatal_perror("PTRACE_GETSIGINFO failed");
+
+	ptrace(PTRACE_KILL, pid, 0, 0);
+
+	GET_FAULTINFO_FROM_SI(fi, si);
+	ok = check_fault_info(&fi);
+	if (ok)
+		non_fatal("OK\n");
+	else
+		non_fatal("Failed\n");
+
+	if (disable_siginfo_segv)
+		non_fatal("Extended PTRACE_GETSIGINFO disabled on command "
+			  "line");
+	else
+		have_siginfo_segv = 1;
+
+	return ok;
+}
+
 void can_do_skas(void)
 {
 	non_fatal("Checking for the skas3 patch in the host:\n");
@@ -482,6 +621,7 @@ void can_do_skas(void)
 	check_skas3_proc_mm();
 	check_skas3_ptrace_faultinfo();
 	check_skas3_ptrace_ldt();
+	check_siginfo();
 
 	if (!proc_mm || !ptrace_faultinfo || !ptrace_ldt)
 		skas_needs_stub = 1;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
