Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJZOQ-0007na-LP for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 08:58:06 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DJZON-0005P8-S7 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 08:58:06 -0700
Message-ID: <42555869.9060209@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <4253E3D6.2000809@fujitsu-siemens.com>
	<20050406203558.GA3307@ccure.user-mode-linux.org>
In-Reply-To: <20050406203558.GA3307@ccure.user-mode-linux.org>
Content-Type: multipart/mixed; boundary="------------060901060506020501020607"
Subject: [uml-devel] Re: UML-patches to prepare UML/s390
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 07 Apr 2005 17:57:29 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060901060506020501020607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Dike wrote:
> On Wed, Apr 06, 2005 at 03:27:50PM +0200, Bodo Stroesser wrote:
> 
>>Here are the patches (tarball attached), that I've applied to
>>UML 2.6.11 + incrementals, before adding s390-files.
>>These patches are tested a bit on x86, but not on x86_64.
> 
> 
> I merged these, except for the restartnointr one because I don't have
> ERESTARTNOINTR in my /usr/include, inside a #ifdef KERNEL or not.
> 
> 				Jeff
Here is a revised patch, that solves the problem according to
Blaisorblade's suggestion, to use kernel's definition of
ERESTARTNOINTR, if host headers do not provide it.
So UM_ERESTARTNOINTR is added to kern_constants.h and used
depending on what host's errno.h gave us.

	Bodo

--------------060901060506020501020607
Content-Type: text/x-diff;
 name="check-restart-skipping.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="check-restart-skipping.patch"


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

s390 normally doesn't support a method, that allows us to force
the host to skip its syscall restart handling.
I implemented a new method in the host, which also is posted to
LKML to hopefully be inserted in s390 mainline.
To check availability of this change, I added a new check, which
is done in a slightly different way for the other arches, too.
Success in check_ptrace() and success in the new check are
absolutely necessary for UML to ru in any mode.
So I changed the sequence of checks to:
1) check_ptrace() being called at startup very early
2) check_ptrace() calls the new check, too
3) can_do_skas() is called after check_ptrace()
check_ptrace() will never return, if it failes, but it now uses
printf() and exit() instead of panic().

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---


diff -puN arch/um/os-Linux/start_up.c~check-restart-skipping arch/um/os-Linux/start_up.c
--- linux-2.6.11/arch/um/os-Linux/start_up.c~check-restart-skipping	2005-04-06 14:44:05.000000000 +0200
+++ linux-2.6.11-root/arch/um/os-Linux/start_up.c	2005-04-07 17:12:35.000000000 +0200
@@ -48,6 +48,18 @@
 #include "mem_user.h"
 #include "kern_constants.h"
 
+/* In some cases, host's headers don't provide ERESTARTNOINTR.
+ * If so, we use the definition from our own kernel headers.
+ * As kernel headers must not be included in this user-obj, we
+ * provide kernel's ERESTARTNOINTR as UM_ERESTARTNOINTR in
+ * kern_constants.h.
+ * Here we trust in ERESTARTNOINTR being a part of the ABI for
+ * strace and debuggers, so it shouldn't change.
+ */
+#ifndef ERESTARTNOINTR
+#define ERESTARTNOINTR UM_ERESTARTNOINTR
+#endif
+
 static int ptrace_child(void *arg)
 {
 	int ret;
@@ -74,9 +86,19 @@ static int ptrace_child(void *arg)
 		ret = 2; /*Serious trouble! This could be caused by a bug in
 			   host 2.6 SKAS3/2.6 patch before release -V6, together
 			   with a bug in the UML code itself.*/
+			 /*In ckeck_skas_restart_skip, this is the expected
+			   case, if everything works fine. (see below for
+			   additional info)*/
 	_exit(ret);
 }
 
+static void errout(char *str, int error)
+{
+	printf(str, error);
+	putchar('\n');
+	exit(1);
+}
+
 static int start_ptraced_child(void **stack_out)
 {
 	void *stack;
@@ -86,53 +108,52 @@ static int start_ptraced_child(void **st
 	stack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
 		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	if(stack == MAP_FAILED)
-		panic("check_ptrace : mmap failed, errno = %d", errno);
+		errout("start_ptraced_child : mmap failed, errno = %d", errno);
 	sp = (unsigned long) stack + PAGE_SIZE - sizeof(void *);
 	pid = clone(ptrace_child, (void *) sp, SIGCHLD, NULL);
 	if(pid < 0)
-		panic("check_ptrace : clone failed, errno = %d", errno);
+		errout("start_ptraced_child : clone failed, errno = %d", errno);
 	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 	if(n < 0)
-		panic("check_ptrace : wait failed, errno = %d", errno);
+		errout("start_ptraced_child : wait failed, errno = %d", errno);
 	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP))
-		panic("check_ptrace : expected SIGSTOP, got status = %d",
-		      status);
+		errout("start_ptraced_child : expected SIGSTOP, "
+		       "got status = %d", status);
 
 	*stack_out = stack;
 	return(pid);
 }
 
 /* When testing for SYSEMU support, if it is one of the broken versions, we 
- * must just avoid using sysemu, not panic, but only if SYSEMU features are 
+ * must just avoid using sysemu, not exit, but only if SYSEMU features are
  * broken.
- * So only for SYSEMU features we test mustpanic, while normal host features
+ * So only for SYSEMU features we test mustexit, while normal host features
  * must work anyway!
  */
-static int stop_ptraced_child(int pid, void *stack, int exitcode, int mustpanic)
+static int stop_ptraced_child(int pid, void *stack, int exitcode, int mustexit)
 {
 	int status, n, ret = 0;
 
 	if(ptrace(PTRACE_CONT, pid, 0, 0) < 0)
-		panic("check_ptrace : ptrace failed, errno = %d", errno);
+		errout("stop_ptraced_child : ptrace failed, errno = %d", errno);
 	CATCH_EINTR(n = waitpid(pid, &status, 0));
 	if(!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode)) {
 		int exit_with = WEXITSTATUS(status);
 		if (exit_with == 2)
-			printk("check_ptrace : child exited with status 2. "
-			       "Serious trouble happening! Try updating your "
-			       "host skas patch!\nDisabling SYSEMU support.");
-		printk("check_ptrace : child exited with exitcode %d, while "
-		      "expecting %d; status 0x%x", exit_with,
-		      exitcode, status);
-		if (mustpanic)
-			panic("\n");
-		else
-			printk("\n");
+			printf("stop_ptraced_child : child exited with "
+			       "status 2. Serious trouble happening! "
+			       "Try updating your host skas patch!\n"
+			       "Disabling SYSEMU support.\n");
+		printf("stop_ptraced_child : child exited with exitcode %d, "
+		       "while expecting %d; status 0x%x\n", exit_with,
+		       exitcode, status);
+		if (mustexit)
+			exit(1);
 		ret = -1;
 	}
 
 	if(munmap(stack, PAGE_SIZE) < 0)
-		panic("check_ptrace : munmap failed, errno = %d", errno);
+		errout("stop_ptraced_child : munmap failed, errno = %d", errno);
 	return ret;
 }
 
@@ -158,7 +179,7 @@ static void __init check_sysemu(void)
 	void *stack;
 	int pid, n, status, count=0;
 
-	printk("Checking syscall emulation patch for ptrace...");
+	printf("Checking syscall emulation patch for ptrace...");
 	sysemu_supported = 0;
 	pid = start_ptraced_child(&stack);
 
@@ -167,59 +188,61 @@ static void __init check_sysemu(void)
 
 	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 	if (n < 0)
-		panic("check_sysemu : wait failed, errno = %d", errno);
+		errout("check_sysemu : wait failed, errno = %d", errno);
 	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
-		panic("check_sysemu : expected SIGTRAP, "
-		      "got status = %d", status);
+		errout("check_sysemu : expected SIGTRAP, "
+		       "got status = %d", status);
 
 	n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_RET_OFFSET,
 		   os_getpid());
 	if(n < 0)
-		panic("check_sysemu : failed to modify system "
-		      "call return, errno = %d", errno);
+		errout("check_sysemu : failed to modify system "
+		       "call return, errno = %d", errno);
 
 	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
 		goto fail_stopped;
 
 	sysemu_supported = 1;
-	printk("OK\n");
+	printf("OK\n");
 	set_using_sysemu(!force_sysemu_disabled);
 
-	printk("Checking advanced syscall emulation patch for ptrace...");
+	printf("Checking advanced syscall emulation patch for ptrace...");
 	pid = start_ptraced_child(&stack);
 
 	if(ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
-		panic("check_ptrace: PTRACE_SETOPTIONS failed, errno = %d",
-		      errno);
+		errout("check_sysemu: PTRACE_SETOPTIONS failed, errno = %d",
+		       errno);
 
 	while(1){
 		if(ptrace(PTRACE_SYSEMU_SINGLESTEP, pid, 0, 0) < 0)
 			goto fail;
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if(n < 0)
-			panic("check_ptrace : wait failed, errno = %d", errno);
+			errout("check_sysemu : wait failed, errno = %d", errno);
 		if(WIFSTOPPED(status) && (WSTOPSIG(status) == (SIGTRAP|0x80))){
-			if (!count)
-				panic("check_ptrace : SYSEMU_SINGLESTEP doesn't"
-				      " singlestep");
+			if (!count) {
+				printf("check_sysemu : SYSEMU_SINGLESTEP "
+				       "doesn't singlestep");
+				exit(1);
+			}
 			n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_RET_OFFSET,
 				   os_getpid());
 			if(n < 0)
-				panic("check_sysemu : failed to modify system "
-				      "call return, errno = %d", errno);
+				errout("check_sysemu : failed to modify system "
+				       "call return, errno = %d", errno);
 			break;
 		}
 		else if(WIFSTOPPED(status) && (WSTOPSIG(status) == SIGTRAP))
 			count++;
 		else
-			panic("check_ptrace : expected SIGTRAP or "
-			      "(SIGTRAP|0x80), got status = %d", status);
+			errout("check_sysemu : expected SIGTRAP or "
+			       "(SIGTRAP|0x80), got status = %d", status);
 	}
 	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
 		goto fail_stopped;
 
 	sysemu_supported = 2;
-	printk("OK\n");
+	printf("OK\n");
 
 	if ( !force_sysemu_disabled )
 		set_using_sysemu(sysemu_supported);
@@ -228,7 +251,7 @@ static void __init check_sysemu(void)
 fail:
 	stop_ptraced_child(pid, stack, 1, 0);
 fail_stopped:
-	printk("missing\n");
+	printf("missing\n");
 }
 
 void __init check_ptrace(void)
@@ -236,23 +259,23 @@ void __init check_ptrace(void)
 	void *stack;
 	int pid, syscall, n, status;
 
-	printk("Checking that ptrace can change system call numbers...");
+	printf("Checking that ptrace can change system call numbers...");
 	pid = start_ptraced_child(&stack);
 
 	if(ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
-		panic("check_ptrace: PTRACE_SETOPTIONS failed, errno = %d",
-		      errno);
+		errout("check_ptrace: PTRACE_SETOPTIONS failed, errno = %d",
+		       errno);
 
 	while(1){
 		if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
-			panic("check_ptrace : ptrace failed, errno = %d", 
-			      errno);
+			errout("check_ptrace : ptrace failed, errno = %d",
+			       errno);
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if(n < 0)
-			panic("check_ptrace : wait failed, errno = %d", errno);
+			errout("check_ptrace : wait failed, errno = %d", errno);
 		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != (SIGTRAP|0x80)))
-			panic("check_ptrace : expected (SIGTRAP|0x80), "
-			      "got status = %d", status);
+			errout("check_ptrace : expected (SIGTRAP|0x80), "
+			       "got status = %d", status);
 		
 		syscall = ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_NR_OFFSET,
 				 0);
@@ -260,13 +283,13 @@ void __init check_ptrace(void)
 			n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_NR_OFFSET,
 				   __NR_getppid);
 			if(n < 0)
-				panic("check_ptrace : failed to modify system "
-				      "call, errno = %d", errno);
+				errout("check_ptrace : failed to modify system "
+				       "call, errno = %d", errno);
 			break;
 		}
 	}
 	stop_ptraced_child(pid, stack, 0, 1);
-	printk("OK\n");
+	printf("OK\n");
 	check_sysemu();
 }
 
@@ -314,6 +337,126 @@ __uml_setup("noptraceldt", noptraceldt_c
 "    the current skas3 patch.\n\n");
 
 #ifdef UML_CONFIG_MODE_SKAS
+
+/*
+ * check_skas_restart_skip() will check, if the host can be forced to
+ * not do syscall restarting, even if the result of a UML-syscall is
+ * -ERESTARTxxxxx. Normally the -ERESTARTxxxxx result isn't passed to
+ * the user, because UML will replace it by -EINTR or the syscall-#
+ * to restart the syscall. So, the host won't see -ERESTARTxxxx in this
+ * case.
+ * But if the syscall in UML is sys_(rt)sigreturn, *every* result may
+ * be passed to the user, because it isn't a real result, but the
+ * interrupted processes register contents. So the host might see
+ * -ERESTARTxxxxx and could do syscall-restarting. This would produce
+ * unpredictible errors in UML.
+ * Thus, we have to force the host to skip syscall-restarting.
+ * Normally, this can be done by setting the syscall-# to -1 on exit
+ * from syscall (e.g. i386, x86_64). But that wouldn't work for s390,
+ * because s390 has syscall-result and syscall-# in the same register.
+ * s390 instead has a "trap" value in host's pt_regs, to distinguish
+ * between syscall / non-syscall. Unfortunately, "trap" isn't readable
+ * or writeable via ptrace.
+ * So, I modified the s390-host in a way, that it will change "trap",s
+ * if the syscall-# is written to -1 on syscall-entry.
+ * check_skas_restart_skip() will check presence of the change in
+ * s390-host. Also, it checks the "normal" way of skipping for the
+ * other arches.
+ * If syscall restarting can't be skipped, there is no safe way to run
+ * skas, no matter if skas0 or skas3.
+ * Due to the different syscall-handling in tt, a good result from
+ * check_ptrace is enough to run tt.
+ *
+ * What does the check:
+ * When the ptraced child is stopped at syscall entry, the syscall-# is
+ * overwritten by PT_SYSCALL_NR_SKIP_RESTART, which normally is
+ * __NR_getpid, so nothing is changed. But on s390 -1 is written, what
+ * should change "trap" in the host.
+ * Then the syscall is resumed with PTRACE_SYSCALL. On syscall exit,
+ * the result is replaced by -ERESTARTNOINTR, and if syscall-# and result
+ * are in different registers, the syscall-# is written with -1 (not on
+ * s390).
+ * Then, we send a SIGUSR1 to the child, forcing the host to do signal
+ * processing, which normally would cause syscall restarting. We
+ * intercept and suppress the signal via ptrace.
+ * Now, the ptraced child is resumed and the result is checked
+ * (stop_ptraced_child). What we expect is, that -ERESTARTNOINTR is the
+ * result of the syscall. If the host would do restarting, getpid()
+ * would be done again, and the result would be the child's pid.
+ * So the expected result of the child must be 2.
+ */
+static inline int check_skas_restart_skip(void)
+{
+	void *stack;
+	int pid, syscall, n, status;
+
+	printf("Checking if syscall restart handling in host can be skipped...");
+	pid = start_ptraced_child(&stack);
+
+	while(1){
+		if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
+			errout("check_skas_restart_skip : ptrace failed, "
+			       "errno = %d", errno);
+		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+		if(n < 0)
+			errout("check_skas_restart_skip : wait failed, "
+			       "errno = %d", errno);
+		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
+			errout("check_skas_restart_skip : expected "
+			       "SIGTRAP, got status = %d", status);
+
+		syscall = ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_NR_OFFSET, 0);
+		if(syscall == __NR_getpid){
+			n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_NR_OFFSET,
+				   PT_SYSCALL_NR_SKIP_RESTART);
+			if(n < 0)
+				errout("check_skas_restart_skip : failed to "
+				       "modify system call, errno = %d", errno);
+			break;
+		}
+	}
+
+	if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
+		errout("check_skas_restart_skip : ptrace failed, "
+		       "errno = %d", errno);
+	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+	if(n < 0)
+		errout("check_skas_restart_skip : wait failed, "
+		       "errno = %d", errno);
+	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
+		errout("check_skas_restart_skip : expected "
+		       "SIGTRAP, got status = %d", status);
+
+	n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_RET_OFFSET, -ERESTARTNOINTR);
+	if(n < 0)
+		errout("check_skas_restart_skip : failed to modify system "
+		       "call result, errno = %d", errno);
+
+	if (PT_SYSCALL_NR_OFFSET != PT_SYSCALL_RET_OFFSET){
+		n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_NR_OFFSET, -1);
+		if(n < 0)
+			errout("check_skas_restart_skip : failed to modify "
+			       "system call number, errno = %d", errno);
+	}
+
+	kill(pid, SIGUSR1);
+
+	if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
+		errout("check_skas_restart_skip : ptrace failed, "
+		       "errno = %d", errno);
+	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+	if(n < 0)
+		errout("check_skas_restart_skip : wait failed, "
+		       "errno = %d", errno);
+	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGUSR1))
+		errout("check_skas_restart_skip : expected "
+		       "SIGTRAP, got status = %d", status);
+
+	n = stop_ptraced_child(pid, stack, 2, 0);
+	printf("%s\n", n ? "failed" : "OK");
+	return n;
+}
+
 static inline void check_skas3_ptrace_faultinfo(void)
 {
 	struct ptrace_faultinfo fi;
@@ -400,6 +543,9 @@ static inline void check_skas3_proc_mm(v
 
 int can_do_skas(void)
 {
+	if(check_skas_restart_skip())
+		return 0;
+
 	printf("Checking for the skas3 patch in the host:\n");
 
 	check_skas3_proc_mm();
@@ -636,7 +782,6 @@ void __init check_sigio(void)
 /*-------------------*/
 void os_check_bugs(void)
 {
-	check_ptrace();
 	check_sigio();
 	check_devanon();
 }
diff -puN arch/um/include/sysdep-i386/ptrace_user.h~check-restart-skipping arch/um/include/sysdep-i386/ptrace_user.h
--- linux-2.6.11/arch/um/include/sysdep-i386/ptrace_user.h~check-restart-skipping	2005-04-06 14:44:05.000000000 +0200
+++ linux-2.6.11-root/arch/um/include/sysdep-i386/ptrace_user.h	2005-04-06 14:44:05.000000000 +0200
@@ -15,6 +15,8 @@
 #define PT_SYSCALL_NR(regs) ((regs)[ORIG_EAX])
 #define PT_SYSCALL_NR_OFFSET PT_OFFSET(ORIG_EAX)
 
+#define PT_SYSCALL_NR_SKIP_RESTART __NR_getpid
+
 #define PT_SYSCALL_ARG1_OFFSET PT_OFFSET(EBX)
 #define PT_SYSCALL_ARG2_OFFSET PT_OFFSET(ECX)
 #define PT_SYSCALL_ARG3_OFFSET PT_OFFSET(EDX)
diff -puN arch/um/include/sysdep-x86_64/ptrace_user.h~check-restart-skipping arch/um/include/sysdep-x86_64/ptrace_user.h
--- linux-2.6.11/arch/um/include/sysdep-x86_64/ptrace_user.h~check-restart-skipping	2005-04-06 14:44:05.000000000 +0200
+++ linux-2.6.11-root/arch/um/include/sysdep-x86_64/ptrace_user.h	2005-04-06 14:44:05.000000000 +0200
@@ -18,6 +18,8 @@
 #define PT_SYSCALL_NR(regs) ((regs)[PT_INDEX(ORIG_RAX)])
 #define PT_SYSCALL_NR_OFFSET (ORIG_RAX)
 
+#define PT_SYSCALL_NR_SKIP_RESTART __NR_getpid
+
 #define PT_SYSCALL_ARG1(regs) (((unsigned long *) (regs))[PT_INDEX(RDI)])
 #define PT_SYSCALL_ARG1_OFFSET (RDI)
 
diff -puN arch/um/kernel/um_arch.c~check-restart-skipping arch/um/kernel/um_arch.c
--- linux-2.6.11/arch/um/kernel/um_arch.c~check-restart-skipping	2005-04-06 14:44:05.000000000 +0200
+++ linux-2.6.11-root/arch/um/kernel/um_arch.c	2005-04-06 14:44:05.000000000 +0200
@@ -320,6 +320,10 @@ int linux_main(int argc, char **argv)
 	}
 	if(have_root == 0) add_arg(DEFAULT_COMMAND_LINE);
 
+	/* First we check ptrace capabilities for UML's minimum need */
+	/* This won't return, if ptrace isn't sufficient */
+	check_ptrace();
+	/* Now can_do_skas tells us, whether we may run skas or not */
 	mode_tt = force_tt ? 1 : !can_do_skas();
 #ifndef CONFIG_MODE_TT
 	if (mode_tt) {
diff -puN arch/um/kernel/skas/process.c~check-restart-skipping arch/um/kernel/skas/process.c
--- linux-2.6.11/arch/um/kernel/skas/process.c~check-restart-skipping	2005-04-06 14:44:05.000000000 +0200
+++ linux-2.6.11-root/arch/um/kernel/skas/process.c	2005-04-07 16:44:19.000000000 +0200
@@ -117,7 +117,8 @@ static void handle_trap(int pid, union u
 
 	if (!local_using_sysemu)
 	{
-		err = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_NR_OFFSET, __NR_getpid);
+		err = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_NR_OFFSET,
+			     PT_SYSCALL_NR_SKIP_RESTART);
 		if(err < 0)
 			panic("handle_trap - nullifying syscall failed errno = %d\n",
 			      errno);
@@ -297,7 +298,8 @@ void userspace(union uml_pt_regs *regs)
 			interrupt_end();
 
 			/* Avoid -ERESTARTSYS handling in host */
-			PT_SYSCALL_NR(regs->skas.regs) = -1;
+			if(PT_SYSCALL_NR_OFFSET != PT_SYSCALL_RET_OFFSET)
+				PT_SYSCALL_NR(regs->skas.regs) = -1;
 		}
 	}
 }
diff -puN arch/um/util/offsets.h~check-restart-skipping arch/um/util/offsets.h
--- linux-2.6.11/arch/um/util/offsets.h~check-restart-skipping	2005-04-07 17:19:12.000000000 +0200
+++ linux-2.6.11-root/arch/um/util/offsets.h	2005-04-07 17:20:32.000000000 +0200
@@ -12,3 +12,4 @@ DEFINE_STR(UM_KERN_WARNING, KERN_WARNING
 DEFINE_STR(UM_KERN_NOTICE, KERN_NOTICE);
 DEFINE_STR(UM_KERN_INFO, KERN_INFO);
 DEFINE_STR(UM_KERN_DEBUG, KERN_DEBUG);
+DEFINE(UM_ERESTARTNOINTR, ERESTARTNOINTR);
diff -puN arch/um/util/mk_constants.c~check-restart-skipping arch/um/util/mk_constants.c
--- linux-2.6.11/arch/um/util/mk_constants.c~check-restart-skipping	2005-04-07 17:20:47.000000000 +0200
+++ linux-2.6.11-root/arch/um/util/mk_constants.c	2005-04-07 17:21:14.000000000 +0200
@@ -26,6 +26,8 @@ int main(int argc, char **argv)
   SHOW_STR(UM_KERN_DEBUG);
 
   SHOW_INT(UM_NSEC_PER_SEC);
+
+  SHOW_INT(UM_ERESTARTNOINTR);
   printf("\n");
   printf("#endif\n");
   return(0);
_

--------------060901060506020501020607--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
