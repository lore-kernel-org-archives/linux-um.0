Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIAmO-0006Ok-1O for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Oct 2004 11:56:48 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CIAmL-0004lL-Qg for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Oct 2004 11:56:47 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Kernel panic: check_ptrace : child exited with status
	0x100
References: <200410081159.i98Bxgr03954@trolli.pdb.fsc.net>
In-Reply-To: <200410081159.i98Bxgr03954@trolli.pdb.fsc.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iZsbBM9sDZ6oDyQ"
Message-Id: <200410142033.06629.blaisorblade_spam@yahoo.it>
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
Date: Thu, 14 Oct 2004 20:33:06 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: bodo.stroesser@fujitsu-siemens.com, Lars.Ellenberg@linbit.com, jdike@addtoit.com, "Christopher S. Aker" <caker@theshore.net>


--Boundary-00=_iZsbBM9sDZ6oDyQ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 08 October 2004 13:59, bodo.stroesser@fujitsu-siemens.com wrote:
> caker@theshore.net said:
> > Ok, so a new combination.  This is 2.4.27 + 2.4.26-um + all the
> > incremental + Bodo's sysemu-panic patch.  It works fine on non-sysemu
> > hosts, and on a host with the original version of sysemu.

> > I think the key here is that this host has the latest (v5) SKAS patch,
> > whereas the 2.6.7 host kernel used the standard sysemu patch.
Yes, and I'm sorry for that.
> Please note, my knowledge about this only comes from reading the source
> code only. Thus, if I'm wrong, tell me.

> AFAICS, the behavior of the latest skas patches for 2.4 and 2.6 regarding
> sysemu is *very* different. And I believe, the 2.6 is wrong!

Yes, I have now finished studying well all the code acting here. And I now 
understand by myself almost every single word you said, and agree on all.

> Problem:
> On both host versions a process will stop, if it is started with
> PTRACE_SYSEMU and if it tries to execute a systemcall. But what happens
> with the traced systemcall when it is resumed differs between the two host
> versions.

> On host 2.4 the syscall will immediately return to user presenting the
> result that had been written to the stack via ptrace(). This is done no
> matter if the process is resumed with PTRACE_SYSEMU, PTRACE_SYSCALL,
> PTRACE_SINGLESTEP or PTRACE_CONT. On host 2.6 the syscall will immediately
> return to user only if the process is restarted with PTREACE_SYSEMU! In the
> other cases the syscall will be executed on the host, the result from this
> will overwrite the result written via ptrace().
Yes, I confirm the patch I sent in my previous email for the host. I still 
need to test that, but I'll do this soon. It's reattached as 
"fix-sysemu-when-changing-state.patch".

> The check for host's 
> sysemu-support done in UML differs between the sysemu-patches for UML-2.4
> and UML-2.6:
> - In UML-2.4 "getpid()" is written as result (eax) of the systemcall, which
> fakes the syscall-result on a 2.4-host, but does nothing on a 2.6, where it
> again is overwritten by running the syscall on the host! Thus, a UML-2.4
> will run on hosts with sysemu-support only, if it is a 2.4 host!

I.e. UML-2.4 will run on everything but a 2.6 sysemu-supporting host, unless 
the host has the patch I sent in the last mail (supposing it does what it 
should do). I.e. the 2.4 UML check is written the right way. Compliments to 
Jeff for this. However, you did not realize he was fixing it, or I'll flame 
you Jeff, for fixing it without notice in the description.

And the test will fail because it _exit(os_getpid() == pid); will become 
_exit(1);. Btw, with Jeff Dike I don't feel really the danger of comment 
bloat!

> - In UML-2.6 "getpid()" is written to the number of the systemcall! But the
> result in eax is not written, it still contains the original syscall
> number. On a 2.4-host this number is returned. In most cases this will let
> the further checks in UML succeed, but no guarantee...

Well, instead of checking simply that getpid() != truePid, we should also 
check that it either returns either the real getpid() value or the real 
getppid() value (the parent thread makes sure that it gets either one, 
doesn't it?), and have a special failure case when this is false. However, 
this is a separate patch, named uml-more-careful-test-startup.patch.

Instead, the fix for this (against the 2.6.9-rc2 tree; the version Jeff Dike 
included in his tree was correct in this regard) is attached as 
"uml-fix-sysemu-test-startup".

Also, the same difference applies also for 2.4: the original um-sysemu patch 
from Laurent Vivier has the same bug you see on 2.6 - Jeff Dike fixed both 
versions in his trees (I guess he didn't notice the difference, and was 
probably just making it portable; he didn't think that the code used 
orig_eax, he just read Laurent Vivier's mind :-@ ).

>   On a 2.6-host the systemcall with the faked number now will be processed
> on the host. In most cases the number should be invalid, thus the result is
> -ENOSYS, the checks in UML will succeed. But what happens, if the faked
> syscall number is a number known on the host ...
>   Thus a UML-2.6 will run on all host versions (in most cases ...)

> Solution:
> - the host-patch for 2.6 should be modified. Before calling ptrace_notify()
>   do_syscall_trace() should save the state of the PTRACE_SYSEMU
> (true/false) and should use that saved state as return value.
> - check_sysemu() in UML-2.6 should be modified to write the result, not the
> sycall number. And it should do it in a portable way.
You refer to the usage of regs.orig_eax, instead of the portable 
PT_SYSCALL_RET_OFFSET used elsewhere (or in general PT_SYSCALL_*_OFFSET)

> By the way: it is not enough to change the checks only. The 2.6-host's
> behavior will cause problems as well, if a process in UML is singlestepped.

> And there will be problems, if someone switches off sysemu while UML is
> running.
Experienced them, as I said.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_iZsbBM9sDZ6oDyQ
Content-Type: text/x-diff; charset="iso-8859-15";
	name="fix-sysemu-when-changing-state.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix-sysemu-when-changing-state.patch"


In do_syscall_trace, we check the status of the TIF_SYSCALL_EMU flag only
after doing the debugger notification; but the debugger might have changed the
status of this flag because he continued execution with PTRACE_SYSCALL, so
this is buggy. This patch fixes it by saving the flag status before calling
ptrace_notify.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/i386/kernel/ptrace.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/ptrace.c~fix-sysemu-when-changing-state arch/i386/kernel/ptrace.c
--- linux-2.6.9-current/arch/i386/kernel/ptrace.c~fix-sysemu-when-changing-state	2004-10-14 18:35:47.798088672 +0200
+++ linux-2.6.9-current-paolo/arch/i386/kernel/ptrace.c	2004-10-14 18:35:47.885075448 +0200
@@ -589,6 +589,7 @@ out:
 __attribute__((regparm(3)))
 int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
+	int is_sysemu;
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
 			audit_syscall_entry(current, regs->orig_eax,
@@ -597,10 +598,11 @@ int do_syscall_trace(struct pt_regs *reg
 		else
 			audit_syscall_exit(current, regs->eax);
 	}
+	is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    !test_thread_flag(TIF_SINGLESTEP) &&
-	    !test_thread_flag(TIF_SYSCALL_EMU))
+	    !is_sysemu)
 		return 0;
 	if (!(current->ptrace & PT_PTRACED))
 		return 0;
@@ -619,5 +621,5 @@ int do_syscall_trace(struct pt_regs *reg
 		current->exit_code = 0;
 	}
 	/* != 0 if nullifying the syscall, 0 if running it normally */
-	return test_thread_flag(TIF_SYSCALL_EMU);
+	return is_sysemu;
 }
_

--Boundary-00=_iZsbBM9sDZ6oDyQ
Content-Type: text/x-diff; charset="iso-8859-15";
	name="uml-fix-sysemu-test-startup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="uml-fix-sysemu-test-startup.patch"


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>, Bodo Stroesser <bodo.stroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

Currently, the test for the SYSEMU support on the host is completely wrong, as
Bodo noticed. We should change the syscall result (inserting the host pid) and
check if it is received correctly by the guest. What we actually do, without
this patch, is to overwrite the syscall number.

This went unnoticed because we only check that the getpid() syscall from the
child does not return its pid. We don't check that it returns the correct
value.

Also, override the result portably, using the PT_SYSCALL_RET_OFFSET macro
which abstract away the host stack frame layout (took from Jeff Dike code).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/process.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff -puN arch/um/kernel/process.c~uml-fix-sysemu-test-startup arch/um/kernel/process.c
--- linux-2.6.9-current/arch/um/kernel/process.c~uml-fix-sysemu-test-startup	2004-10-14 18:57:30.224089824 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/process.c	2004-10-14 19:31:19.840541224 +0200
@@ -214,8 +214,6 @@ static void __init check_sysemu(void)
 	sysemu_supported = 0;
 	pid = start_ptraced_child(&stack);
 	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) >= 0) {
-		struct user_regs_struct regs;
-
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if (n < 0)
 			panic("check_ptrace : wait failed, errno = %d", errno);
@@ -223,18 +221,16 @@ static void __init check_sysemu(void)
 			panic("check_ptrace : expected SIGTRAP, "
 			      "got status = %d", status);
 
-		if (ptrace(PTRACE_GETREGS, pid, 0, &regs) < 0)
-			panic("check_ptrace : failed to read child "
-			      "registers, errno = %d", errno);
-		regs.orig_eax = pid;
-		if (ptrace(PTRACE_SETREGS, pid, 0, &regs) < 0)
-			panic("check_ptrace : failed to modify child "
-			      "registers, errno = %d", errno);
+		n = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_RET_OFFSET,
+			   os_getpid());
+		if(n < 0)
+			panic("check_ptrace : failed to modify system "
+			      "call return, errno = %d", errno);
 
 		stop_ptraced_child(pid, stack, 0);
 
 		sysemu_supported = 1;
-		printk("found\n");
+		printk("OK\n");
 	}
 	else
 	{
_

--Boundary-00=_iZsbBM9sDZ6oDyQ
Content-Type: text/x-diff; charset="iso-8859-15";
	name="uml-more-careful-test-startup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="uml-more-careful-test-startup.patch"


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>, Bodo Stroesser <bodo.stroesser@fujitsu-siemens.com>

While testing the host ptrace(2) features, we modify the stack frame of a test
child which is doing a syscall (namely getpid). Either we override the syscall
number or the return value, which become the parent's pid, or we don't, and
the return value is the child's pid.

Actually, we only compared the return value with the child's pid, so we did
not notice a bug where the return value happened to be different from both. So
I added a stricter test here.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/process.c |   41 +++++++++++++++------
 1 files changed, 31 insertions(+), 10 deletions(-)

diff -puN arch/um/kernel/process.c~uml-more-careful-test-startup arch/um/kernel/process.c
--- linux-2.6.9-current/arch/um/kernel/process.c~uml-more-careful-test-startup	2004-10-14 20:05:22.894949744 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/process.c	2004-10-14 20:25:05.601151072 +0200
@@ -137,14 +137,30 @@ int start_fork_tramp(void *thread_arg, u
 
 static int ptrace_child(void *arg)
 {
-	int pid = os_getpid();
+	int ret;
+	int pid = os_getpid(), ppid = getppid();
+	int sc_result;
 
 	if(ptrace(PTRACE_TRACEME, 0, 0, 0) < 0){
 		perror("ptrace");
 		os_kill_process(pid, 0);
 	}
 	os_stop_process(pid);
-	_exit(os_getpid() == pid);
+
+	/*This syscall will be intercepted by the parent. Don't call more than
+	 * once, please.*/
+	sc_result = os_getpid();
+
+	if (sc_result == pid)
+		ret = 1; /*Nothing modified by the parent, we are running
+			   normally.*/
+	else if (sc_result == ppid)
+		ret = 0; /*Expected in check_ptrace and check_sysemu when they
+			   succeed in modifying the stack frame*/
+	else
+		ret = 2; /*Serious trouble! This can be caused by a bug in
+			   host 2.6 SKAS3/2.6 patch before release -V6.*/
+	_exit(ret);
 }
 
 static int start_ptraced_child(void **stack_out)
@@ -179,8 +195,16 @@ static void stop_ptraced_child(int pid, 
 	if(ptrace(PTRACE_CONT, pid, 0, 0) < 0)
 		panic("check_ptrace : ptrace failed, errno = %d", errno);
 	CATCH_EINTR(n = waitpid(pid, &status, 0));
-	if(!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode))
-		panic("check_ptrace : child exited with status 0x%x", status);
+	if(!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode)) {
+		int exit_with = WEXITSTATUS(status);
+		if (exit_with == 2)
+			printk("check_ptrace : child exited with status 2. "
+			       "Serious trouble happening! Try updating your "
+			       "host skas patch!");
+		panic("check_ptrace : child exited with exitcode %d, while "
+		      "expecting %d; status 0x%x", exit_with,
+		      exitcode, status);
+	}
 
 	if(munmap(stack, PAGE_SIZE) < 0)
 		panic("check_ptrace : munmap failed, errno = %d", errno);
@@ -207,24 +231,21 @@ static void __init check_sysemu(void)
 	void *stack;
 	int pid, n, status;
 
-	if (mode_tt)
-		return;
-
 	printk("Checking syscall emulation patch for ptrace...");
 	sysemu_supported = 0;
 	pid = start_ptraced_child(&stack);
 	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) >= 0) {
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if (n < 0)
-			panic("check_ptrace : wait failed, errno = %d", errno);
+			panic("check_sysemu : wait failed, errno = %d", errno);
 		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
-			panic("check_ptrace : expected SIGTRAP, "
+			panic("check_sysemu : expected SIGTRAP, "
 			      "got status = %d", status);
 
 		n = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_RET_OFFSET,
 			   os_getpid());
 		if(n < 0)
-			panic("check_ptrace : failed to modify system "
+			panic("check_sysemu : failed to modify system "
 			      "call return, errno = %d", errno);
 
 		stop_ptraced_child(pid, stack, 0);
_

--Boundary-00=_iZsbBM9sDZ6oDyQ--



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
