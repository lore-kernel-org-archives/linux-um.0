Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUC1n-0001KX-L8	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 16:14:39 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DUC1m-00088n-Rp	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 May 2005 16:14:39 -0700
Message-Id: <200505062249.j46Mnbpo010490@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 11/12] UML - Fix process exit race
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
Date: Fri, 06 May 2005 18:49:37 -0400
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

tt-mode closes switch_pipes in exit_thread_tt and kills
processes in switch_to_tt, if the exit_state is 
EXIT_DEAD or EXIT_ZOMBIE.
In very rare cases the exiting process can be scheduled out
after having set exit_state and closed switch_pipes (from
release_task it calls proc_pid_flush, which might sleep).
If this process is to be restarted, UML failes in
switch_to_tt with:
   write of switch_pipe failed, err = 9
We fix this by closing switch_pipes not in exit_thread_tt,
but later in release_thread_tt. Additionally, we set
switch_pipe[0] = 0 after closing. switch_to_tt must not
kill "from" process depending on its exit_state, but must
kill it after release_thread was processed only, so it
examines switch_pipe[0] for its decision.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc3-mm/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/kernel/process_kern.c	2005-05-06 14:52:11.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/kernel/process_kern.c	2005-05-06 14:53:03.000000000 -0400
@@ -143,7 +143,6 @@
  
 void exit_thread(void)
 {
-	CHOOSE_MODE(exit_thread_tt(), exit_thread_skas());
 	unprotect_stack((unsigned long) current_thread);
 }
  
Index: linux-2.6.12-rc3-mm/arch/um/kernel/skas/include/mode_kern-skas.h
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/kernel/skas/include/mode_kern-skas.h	2005-05-06 14:35:08.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/kernel/skas/include/mode_kern-skas.h	2005-05-06 14:53:03.000000000 -0400
@@ -18,7 +18,6 @@
 			    unsigned long sp, unsigned long stack_top,
 			    struct task_struct *p, struct pt_regs *regs);
 extern void release_thread_skas(struct task_struct *task);
-extern void exit_thread_skas(void);
 extern void initial_thread_cb_skas(void (*proc)(void *), void *arg);
 extern void init_idle_skas(void);
 extern void flush_tlb_kernel_range_skas(unsigned long start,
Index: linux-2.6.12-rc3-mm/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/kernel/skas/process_kern.c	2005-05-06 14:35:08.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/kernel/skas/process_kern.c	2005-05-06 14:53:03.000000000 -0400
@@ -83,10 +83,6 @@
 {
 }
 
-void exit_thread_skas(void)
-{
-}
-
 void fork_handler(int sig)
 {
         change_sig(SIGUSR1, 1);
Index: linux-2.6.12-rc3-mm/arch/um/kernel/tt/include/mode_kern-tt.h
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/kernel/tt/include/mode_kern-tt.h	2005-05-06 14:35:08.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/kernel/tt/include/mode_kern-tt.h	2005-05-06 14:53:03.000000000 -0400
@@ -19,7 +19,6 @@
 			  unsigned long stack_top, struct task_struct *p,
 			  struct pt_regs *regs);
 extern void release_thread_tt(struct task_struct *task);
-extern void exit_thread_tt(void);
 extern void initial_thread_cb_tt(void (*proc)(void *), void *arg);
 extern void init_idle_tt(void);
 extern void flush_tlb_kernel_range_tt(unsigned long start, unsigned long end);
Index: linux-2.6.12-rc3-mm/arch/um/kernel/tt/process_kern.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/kernel/tt/process_kern.c	2005-05-06 14:35:08.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/kernel/tt/process_kern.c	2005-05-06 14:54:39.000000000 -0400
@@ -65,8 +65,7 @@
 		panic("write of switch_pipe failed, err = %d", -err);
 
 	reading = 1;
-	if((from->exit_state == EXIT_ZOMBIE) ||
-	   (from->exit_state == EXIT_DEAD))
+        if(from->thread.mode.tt.switch_pipe[0] == -1)
 		os_kill_process(os_getpid(), 0);
 
 	err = os_read_file(from->thread.mode.tt.switch_pipe[0], &c, sizeof(c));
@@ -81,8 +80,7 @@
 	 * in case it has not already killed itself.
 	 */
 	prev_sched = current->thread.prev_sched;
-	if((prev_sched->exit_state == EXIT_ZOMBIE) ||
-	   (prev_sched->exit_state == EXIT_DEAD))
+        if(prev_sched->thread.mode.tt.switch_pipe[0] == -1)
 		os_kill_process(prev_sched->thread.mode.tt.extern_pid, 1);
 
 	change_sig(SIGVTALRM, vtalrm);
@@ -101,14 +99,18 @@
 {
 	int pid = task->thread.mode.tt.extern_pid;
 
+	/*
+         * We first have to kill the other process, before
+         * closing its switch_pipe. Else it might wake up
+         * and receive "EOF" before we could kill it.
+         */
 	if(os_getpid() != pid)
 		os_kill_process(pid, 0);
-}
 
-void exit_thread_tt(void)
-{
-	os_close_file(current->thread.mode.tt.switch_pipe[0]);
-	os_close_file(current->thread.mode.tt.switch_pipe[1]);
+        os_close_file(task->thread.mode.tt.switch_pipe[0]);
+        os_close_file(task->thread.mode.tt.switch_pipe[1]);
+	/* use switch_pipe as flag: thread is released */
+        task->thread.mode.tt.switch_pipe[0] = -1;
 }
 
 void suspend_new_thread(int fd)



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
