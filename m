Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CScgl-0004tV-7D for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Nov 2004 06:46:11 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CScgk-0000Fx-6B for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Nov 2004 06:46:11 -0800
Message-ID: <4194CCAD.2020701@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [Patch 1/1] uml: fix uml-hang-on-2.6.9-host.patch
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
Date: Fri, 12 Nov 2004 15:46:05 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

The patch needs to be corrected. The use of
os_kill_ptraced_process() is restricted to the tracer-thread!
No other process is allowed to do ptrace(PTRACE_KILL).
So I had "dead" processes hanging in my host system until UML
was shutdown. And I had panic()s, because processes were not
stopped.
Thus, I implemented request_kill_ptraced_process(), which lets
the tracer do the ptrace(PTRACE_KILL). Sorry, this method is
slow, but I didn't see an other solution.
Also, I modified some other places to use the new call instead
of os_kill_process(). But this didn't work on the first step.
kill_off_processes_tt() couldn't kill the remaining processes
on shutdown. This happens, because ptrace(PTRACE_KILL) doesn't
really send a SIGKILL to the process, but writes SIGKILL to the
exit_code. That does results in send_sig(SIGKILL) for processes
being stopped on a ptrace event only, but not even for all of
these events.
So I added an option to request_kill_ptraced_process() that
allows to force an additional os_kill_process() to be executed
before the os_kill_ptraced_process().
Summary: The behavior of 2.6.9 host is very uggly. You need to
do kill() and ptrace(PTRACE_KILL) to be shure, a process will
really exit. If the host is changed to be more consistent, we
should change all this again.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

--- a/include/asm-um/processor-generic.h	2004-11-11 20:08:28.382687160 +0100
+++ b/include/asm-um/processor-generic.h	2004-11-11 20:09:09.167486928 +0100
@@ -54,7 +54,8 @@ struct thread_struct {
  		union {
  			struct {
  				int pid;
-			} fork, exec;
+				int mode;
+			} fork, exec, kill;
  			struct {
  				int (*proc)(void *);
  				void *arg;
--- a/arch/um/kernel/tt/include/mode-tt.h	2004-11-11 20:05:55.383946504 +0100
+++ b/arch/um/kernel/tt/include/mode-tt.h	2004-11-11 20:06:44.263515680 +0100
@@ -8,7 +8,7 @@

  #include "sysdep/ptrace.h"

-enum { OP_NONE, OP_EXEC, OP_FORK, OP_TRACE_ON, OP_REBOOT, OP_HALT, OP_CB };
+enum { OP_NONE, OP_EXEC, OP_FORK, OP_KILL, OP_TRACE_ON, OP_REBOOT, OP_HALT, OP_CB };

  extern int tracing_pid;

--- a/arch/um/kernel/tt/exec_user.c	2004-11-11 19:43:38.511182056 +0100
+++ b/arch/um/kernel/tt/exec_user.c	2004-11-11 19:50:41.288910072 +0100
@@ -16,6 +16,7 @@
  #include "kern_util.h"
  #include "user.h"
  #include "ptrace_user.h"
+#include "os.h"

  void do_exec(int old_pid, int new_pid)
  {
@@ -36,7 +37,7 @@ void do_exec(int old_pid, int new_pid)
  		tracer_panic("do_exec failed to get registers - errno = %d",
  			     errno);

-	kill(old_pid, SIGKILL);
+	os_kill_ptraced_process(old_pid, 0);

  	if (ptrace(PTRACE_SETOPTIONS, new_pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
  		tracer_panic("do_exec: PTRACE_SETOPTIONS failed, errno = %d", errno);
--- a/arch/um/kernel/tt/process_kern.c	2004-11-11 20:03:15.852199016 +0100
+++ b/arch/um/kernel/tt/process_kern.c	2004-11-11 21:03:59.624261464 +0100
@@ -82,7 +82,7 @@ void *switch_to_tt(void *prev, void *nex
  	prev_sched = current->thread.prev_sched;
  	if((prev_sched->state == TASK_ZOMBIE) ||
  	   (prev_sched->state == TASK_DEAD))
-		os_kill_ptraced_process(prev_sched->thread.mode.tt.extern_pid, 1);
+		request_kill_ptraced_process( prev_sched->thread.mode.tt.extern_pid, 1);

  	/* This works around a nasty race with 'jail'.  If we are switching
  	 * between two threads of a threaded app and the incoming process
@@ -119,7 +119,7 @@ void release_thread_tt(struct task_struc
  	int pid = task->thread.mode.tt.extern_pid;

  	if(os_getpid() != pid)
-		os_kill_process(pid, 0);
+		request_kill_ptraced_process(pid, 0);
  }

  void exit_thread_tt(void)
@@ -330,10 +330,10 @@ void kill_off_processes_tt(void)
  	me = os_getpid();
          for_each_process(p){
  		if(p->thread.mode.tt.extern_pid != me)
-			os_kill_process(p->thread.mode.tt.extern_pid, 0);
+			request_kill_ptraced_process(p->thread.mode.tt.extern_pid, 2);
  	}
  	if(init_task.thread.mode.tt.extern_pid != me)
-		os_kill_process(init_task.thread.mode.tt.extern_pid, 0);
+		request_kill_ptraced_process(init_task.thread.mode.tt.extern_pid, 2);
  }

  void initial_thread_cb_tt(void (*proc)(void *), void *arg)
@@ -352,6 +352,20 @@ void initial_thread_cb_tt(void (*proc)(v
  	}
  }

+void request_kill_ptraced_process(int pid, int mode)
+{
+	/* The tracer has to do the kill, since killing must be
+	 * done with ptrace(PTRACE_KILL, pid), which is possible
+	 * from the father only! */
+	current->thread.request.op = OP_KILL;
+	current->thread.request.u.exec.pid = pid;
+	current->thread.request.u.exec.mode = mode;
+	os_usr1_process(os_getpid());
+	change_sig(SIGUSR1, 1);
+
+	change_sig(SIGUSR1, 0);
+}
+
  int do_proc_op(void *t, int proc_id)
  {
  	struct task_struct *task;
@@ -374,6 +388,12 @@ int do_proc_op(void *t, int proc_id)
  	case OP_FORK:
  		attach_process(thread->request.u.fork.pid);
  		break;
+	case OP_KILL:
+		if ( thread->request.u.kill.mode > 1 )
+			os_kill_process(thread->request.u.kill.pid, 0);
+		os_kill_ptraced_process(thread->request.u.kill.pid,
+		                        thread->request.u.kill.mode);
+		break;
  	case OP_CB:
  		(*thread->request.u.cb.proc)(thread->request.u.cb.arg);
  		break;
--- a/arch/um/kernel/tt/include/mode-tt.h	2004-11-12 12:14:24.239057776 +0100
+++ b/arch/um/kernel/tt/include/mode-tt.h	2004-11-12 12:15:17.496961344 +0100
@@ -20,6 +20,7 @@ extern void reboot_tt(void);
  extern void halt_tt(void);
  extern int is_tracer_winch(int pid, int fd, void *data);
  extern void kill_off_processes_tt(void);
+extern void request_kill_ptraced_process(int pid, int mode);

  #endif

--- a/arch/um/kernel/reboot.c	2004-11-12 12:18:29.356794216 +0100
+++ b/arch/um/kernel/reboot.c	2004-11-12 12:19:20.996943720 +0100
@@ -22,7 +22,7 @@ static void kill_idlers(int me)
  	for(i = 0; i < sizeof(idle_threads)/sizeof(idle_threads[0]); i++){
  		p = idle_threads[i];
  		if((p != NULL) && (p->thread.mode.tt.extern_pid != me))
-			os_kill_process(p->thread.mode.tt.extern_pid, 0);
+			request_kill_ptraced_process(p->thread.mode.tt.extern_pid, 2);
  	}
  #endif
  }


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
