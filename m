Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWRSk-00081V-5g for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 19:35:30 -0800
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]
	helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CWRSh-0006vr-Tb
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 19:35:30 -0800
Message-Id: <200411230550.iAN5o8mY007302@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] The current fix-kill patch
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
Date: Tue, 23 Nov 2004 00:50:08 -0500
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

Here's the latest fix-kill patch in my tree.  Please test and report...

				Jeff

# This patch changes how UML kills ptraced processes in order to be more 
# correct in the presence of the ptrace changes in 2.6.9.  It used to be that
# ptrace stopped processes could simply be killed and they would go away.  Now,
# there's a new run state for ptraced processes which doesn't receive signals
# until they are PTRACE_KILLed or PTRACE_CONTinued.  So, this patch kills the
# process, as usual, then PTRACE_KILL and PTRACE_CONT.  This is done in
# os_kill_ptrace_process() for use from skas mode, and in tracer() when it
# sees a child process getting a SIGKILL.
Index: 2.6.9/arch/um/kernel/tt/exec_user.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/exec_user.c	2004-11-22 12:18:40.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/exec_user.c	2004-11-22 13:24:50.000000000 -0500
@@ -36,7 +36,7 @@
 		tracer_panic("do_exec failed to get registers - errno = %d",
 			     errno);
 
-	kill(old_pid, SIGKILL);
+	os_kill_ptraced_process(old_pid, 0);
 
 	if (ptrace(PTRACE_SETOPTIONS, new_pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
 		tracer_panic("do_exec: PTRACE_SETOPTIONS failed, errno = %d", errno);
Index: 2.6.9/arch/um/kernel/tt/process_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/process_kern.c	2004-11-18 21:24:08.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/process_kern.c	2004-11-22 12:18:43.000000000 -0500
@@ -65,7 +65,8 @@
 		panic("write of switch_pipe failed, err = %d", -err);
 
 	reading = 1;
-	if((from->exit_state == EXIT_ZOMBIE) || (from->exit_state == EXIT_DEAD))
+	if((from->exit_state == EXIT_ZOMBIE) ||
+	   (from->exit_state == EXIT_DEAD))
 		os_kill_process(os_getpid(), 0);
 
 	err = os_read_file(from->thread.mode.tt.switch_pipe[0], &c, sizeof(c));
@@ -82,7 +83,7 @@
 	prev_sched = current->thread.prev_sched;
 	if((prev_sched->exit_state == EXIT_ZOMBIE) ||
 	   (prev_sched->exit_state == EXIT_DEAD))
-		os_kill_ptraced_process(prev_sched->thread.mode.tt.extern_pid, 1);
+		os_kill_process(prev_sched->thread.mode.tt.extern_pid, 1);
 
 	/* This works around a nasty race with 'jail'.  If we are switching
 	 * between two threads of a threaded app and the incoming process 
Index: 2.6.9/arch/um/kernel/tt/tracer.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/tracer.c	2004-11-22 12:18:40.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/tracer.c	2004-11-22 13:28:01.000000000 -0500
@@ -320,7 +320,13 @@
 				case OP_HALT:
 					unmap_physmem();
 					kmalloc_ok = 0;
-					ptrace(PTRACE_KILL, pid, 0, 0);
+					os_kill_ptraced_process(pid, 0);
+					/* Now let's reap remaining zombies */
+					errno = 0;
+					do {
+						waitpid(-1, &status, 
+							WUNTRACED);
+					} while (errno != ECHILD);
 					return(op == OP_REBOOT);
 				case OP_NONE:
 					printf("Detaching pid %d\n", pid);
Index: 2.6.9/arch/um/os-Linux/process.c
===================================================================
--- 2.6.9.orig/arch/um/os-Linux/process.c	2004-11-18 21:24:08.000000000 -0500
+++ 2.6.9/arch/um/os-Linux/process.c	2004-11-22 12:18:43.000000000 -0500
@@ -95,9 +95,16 @@
 		
 }
 
+/* Kill off a ptraced child by all means available.  kill it normally first,
+ * then PTRACE_KILL it, then PTRACE_CONT it in case it's in a run state from
+ * which it can't exit directly.
+ */
+
 void os_kill_ptraced_process(int pid, int reap_child)
 {
+	kill(pid, SIGKILL);
 	ptrace(PTRACE_KILL, pid);
+	ptrace(PTRACE_CONT, pid);
 	if(reap_child)
 		CATCH_EINTR(waitpid(pid, NULL, 0));
 }



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
