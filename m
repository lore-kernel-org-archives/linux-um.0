Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKYBM-0005hk-56 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 01:20:24 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CKYBL-0006bm-0y
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 01:20:24 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: [uml-user] Host processes never terminate on
	2.6.9rc3 host (stuck in ptrace_stop)
Message-ID: <20041021075737.GA32566@bytesex>
References: <4173F1FD.6080004@colitti.com>
	<200410182118.09005.blaisorblade_spam@yahoo.it>
	<20041018212612.GA3052@bytesex>
	<200410190023.14067.blaisorblade_spam@yahoo.it>
	<20041019020055.A31791@almesberger.net>
	<31004.1098316468@marajade.sandelman.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31004.1098316468@marajade.sandelman.ottawa.on.ca>
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
Date: Thu, 21 Oct 2004 09:57:37 +0200
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: Werner Almesberger <wa@almesberger.net>, BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Lorenzo Colitti <lorenzo@colitti.com>, Massimo Rimondini <rimondin@dia.uniroma3.it>

>   I tend to believe that -9 should also override being traced as well.
> I can sort of understand that someone might think they can trace through
> a -9, but since that signal is never delivered to the process, nor can
> it be ignored, I can't understand why it matters.
>   Sure, let the ptrace'r know that the process got a -9.

Ok, found a way around that.  You can send a SIGKILL, then call
PTRACE_CONT, and now the process will see the SIGKILL and die.

The patch below fixes it for me for the skas case, not sure about
tt through.

  Gerd

Index: linux-uml-2.6.9/arch/um/include/os.h
===================================================================
--- linux-uml-2.6.9.orig/arch/um/include/os.h	2004-10-20 10:56:02.000000000 +0200
+++ linux-uml-2.6.9/arch/um/include/os.h	2004-10-20 16:58:00.000000000 +0200
@@ -156,7 +156,7 @@ extern int os_lock_file(int fd, int excl
 extern unsigned long os_process_pc(int pid);
 extern int os_process_parent(int pid);
 extern void os_stop_process(int pid);
-extern void os_kill_process(int pid, int reap_child);
+extern void os_kill_process(int pid, int reap_child, int trace_cont);
 extern void os_usr1_process(int pid);
 extern int os_getpid(void);
 
Index: linux-uml-2.6.9/arch/um/os-Linux/process.c
===================================================================
--- linux-uml-2.6.9.orig/arch/um/os-Linux/process.c	2004-10-20 10:55:52.000000000 +0200
+++ linux-uml-2.6.9/arch/um/os-Linux/process.c	2004-10-20 17:16:58.000000000 +0200
@@ -10,6 +10,7 @@
 #include <linux/unistd.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
+#include <sys/ptrace.h>
 #include "os.h"
 #include "user.h"
 #include "user_util.h"
@@ -86,12 +87,13 @@ void os_stop_process(int pid)
 	kill(pid, SIGSTOP);
 }
 
-void os_kill_process(int pid, int reap_child)
+void os_kill_process(int pid, int reap_child, int trace_cont)
 {
 	kill(pid, SIGKILL);
-	if(reap_child)
+	if (trace_cont)
+		ptrace(PTRACE_CONT, pid, NULL, NULL);
+	if (reap_child)
 		CATCH_EINTR(waitpid(pid, NULL, 0));
-		
 }
 
 void os_usr1_process(int pid)
Index: linux-uml-2.6.9/arch/um/drivers/port_kern.c
===================================================================
--- linux-uml-2.6.9.orig/arch/um/drivers/port_kern.c	2004-10-20 10:55:44.000000000 +0200
+++ linux-uml-2.6.9/arch/um/drivers/port_kern.c	2004-10-20 14:36:10.000000000 +0200
@@ -112,7 +112,7 @@ static int port_accept(struct port_list 
  out_close:
 	os_close_file(fd);
 	if(pid != -1) 
-		os_kill_process(pid, 1);
+		os_kill_process(pid, 1, 0);
  out:
 	return(ret);
 } 
@@ -262,9 +262,9 @@ void port_remove_dev(void *d)
 	struct port_dev *dev = d;
 
 	if(dev->helper_pid != -1)
-		os_kill_process(dev->helper_pid, 0);
+		os_kill_process(dev->helper_pid, 0, 0);
 	if(dev->telnetd_pid != -1)
-		os_kill_process(dev->telnetd_pid, 1);
+		os_kill_process(dev->telnetd_pid, 1, 0);
 	dev->helper_pid = -1;
 	dev->telnetd_pid = -1;
 }
Index: linux-uml-2.6.9/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-uml-2.6.9.orig/arch/um/drivers/ubd_kern.c	2004-10-20 10:56:28.000000000 +0200
+++ linux-uml-2.6.9/arch/um/drivers/ubd_kern.c	2004-10-20 14:36:49.000000000 +0200
@@ -470,7 +470,7 @@ static int io_pid = -1;
 void kill_io_thread(void)
 {
 	if(io_pid != -1) 
-		os_kill_process(io_pid, 1);
+		os_kill_process(io_pid, 1, 0);
 }
 
 __uml_exitcall(kill_io_thread);
Index: linux-uml-2.6.9/arch/um/drivers/line.c
===================================================================
--- linux-uml-2.6.9.orig/arch/um/drivers/line.c	2004-10-20 11:46:34.000000000 +0200
+++ linux-uml-2.6.9/arch/um/drivers/line.c	2004-10-20 14:34:38.000000000 +0200
@@ -638,7 +638,7 @@ static void winch_cleanup(void)
 			os_close_file(winch->fd);
 		}
 		if(winch->pid != -1) 
-			os_kill_process(winch->pid, 1);
+			os_kill_process(winch->pid, 1, 0);
 	}
 }
 __uml_exitcall(winch_cleanup);
Index: linux-uml-2.6.9/arch/um/kernel/skas/process.c
===================================================================
--- linux-uml-2.6.9.orig/arch/um/kernel/skas/process.c	2004-10-20 11:46:32.000000000 +0200
+++ linux-uml-2.6.9/arch/um/kernel/skas/process.c	2004-10-20 16:33:16.000000000 +0200
@@ -400,7 +400,7 @@ void switch_mm_skas(int mm_fd)
 void kill_off_processes_skas(void)
 {
 #warning need to loop over userspace_pids in kill_off_processes_skas
-	os_kill_process(userspace_pid[0], 1);
+	os_kill_process(userspace_pid[0], 1, 1);
 }
 
 void init_registers(int pid)
Index: linux-uml-2.6.9/arch/um/kernel/process.c
===================================================================
--- linux-uml-2.6.9.orig/arch/um/kernel/process.c	2004-10-20 10:56:58.000000000 +0200
+++ linux-uml-2.6.9/arch/um/kernel/process.c	2004-10-20 16:54:56.000000000 +0200
@@ -141,7 +141,7 @@ static int ptrace_child(void *arg)
 
 	if(ptrace(PTRACE_TRACEME, 0, 0, 0) < 0){
 		perror("ptrace");
-		os_kill_process(pid, 0);
+		os_kill_process(pid, 0, 0);
 	}
 	os_stop_process(pid);
 	_exit(os_getpid() == pid);
Index: linux-uml-2.6.9/arch/um/kernel/helper.c
===================================================================
--- linux-uml-2.6.9.orig/arch/um/kernel/helper.c	2004-10-20 10:56:28.000000000 +0200
+++ linux-uml-2.6.9/arch/um/kernel/helper.c	2004-10-20 16:38:22.000000000 +0200
@@ -45,7 +45,7 @@ static int helper_child(void *arg)
 	errval = errno;
 	printk("execvp of '%s' failed - errno = %d\n", argv[0], errno);
 	os_write_file(data->fd, &errval, sizeof(errval));
-	os_kill_process(os_getpid(), 0);
+	os_kill_process(os_getpid(), 0, 0);
 	return(0);
 }
 
@@ -106,7 +106,7 @@ int run_helper(void (*pre_exec)(void *),
 	return(pid);
 
  out_kill:
-	os_kill_process(pid, 1);
+	os_kill_process(pid, 1, 0);
  out_close:
 	os_close_file(fds[0]);
 	os_close_file(fds[1]);
Index: linux-uml-2.6.9/arch/um/kernel/tt/process_kern.c
===================================================================
--- linux-uml-2.6.9.orig/arch/um/kernel/tt/process_kern.c	2004-10-20 10:56:57.000000000 +0200
+++ linux-uml-2.6.9/arch/um/kernel/tt/process_kern.c	2004-10-20 16:31:31.000000000 +0200
@@ -66,7 +66,7 @@ void *switch_to_tt(void *prev, void *nex
 
 	reading = 1;
 	if((from->state == TASK_ZOMBIE) || (from->state == TASK_DEAD))
-		os_kill_process(os_getpid(), 0);
+		os_kill_process(os_getpid(), 0, 0);
 
 	err = os_read_file(from->thread.mode.tt.switch_pipe[0], &c, sizeof(c));
 	if(err != sizeof(c))
@@ -82,7 +82,7 @@ void *switch_to_tt(void *prev, void *nex
 	prev_sched = current->thread.prev_sched;
 	if((prev_sched->state == TASK_ZOMBIE) ||
 	   (prev_sched->state == TASK_DEAD))
-		os_kill_process(prev_sched->thread.mode.tt.extern_pid, 1);
+		os_kill_process(prev_sched->thread.mode.tt.extern_pid, 1, 1);
 
 	/* This works around a nasty race with 'jail'.  If we are switching
 	 * between two threads of a threaded app and the incoming process 
@@ -119,7 +119,7 @@ void release_thread_tt(struct task_struc
 	int pid = task->thread.mode.tt.extern_pid;
 
 	if(os_getpid() != pid)
-		os_kill_process(pid, 0);
+		os_kill_process(pid, 0, 0);
 }
 
 void exit_thread_tt(void)
@@ -331,10 +331,10 @@ void kill_off_processes_tt(void)
 	me = os_getpid();
         for_each_process(p){
 		if(p->thread.mode.tt.extern_pid != me) 
-			os_kill_process(p->thread.mode.tt.extern_pid, 0);
+			os_kill_process(p->thread.mode.tt.extern_pid, 0, 0);
 	}
 	if(init_task.thread.mode.tt.extern_pid != me) 
-		os_kill_process(init_task.thread.mode.tt.extern_pid, 0);
+		os_kill_process(init_task.thread.mode.tt.extern_pid, 0, 0);
 }
 
 void initial_thread_cb_tt(void (*proc)(void *), void *arg)
Index: linux-uml-2.6.9/arch/um/drivers/xterm.c
===================================================================
--- linux-uml-2.6.9.orig/arch/um/drivers/xterm.c	2004-10-20 11:46:34.000000000 +0200
+++ linux-uml-2.6.9/arch/um/drivers/xterm.c	2004-10-20 17:01:27.000000000 +0200
@@ -168,10 +168,10 @@ void xterm_close(int fd, void *d)
 	struct xterm_chan *data = d;
 	
 	if(data->pid != -1) 
-		os_kill_process(data->pid, 1);
+		os_kill_process(data->pid, 1, 0);
 	data->pid = -1;
 	if(data->helper_pid != -1) 
-		os_kill_process(data->helper_pid, 0);
+		os_kill_process(data->helper_pid, 0, 0);
 	data->helper_pid = -1;
 	os_close_file(fd);
 }
Index: linux-uml-2.6.9/arch/um/kernel/sigio_user.c
===================================================================
--- linux-uml-2.6.9.orig/arch/um/kernel/sigio_user.c	2004-10-20 10:57:05.000000000 +0200
+++ linux-uml-2.6.9/arch/um/kernel/sigio_user.c	2004-10-20 16:58:56.000000000 +0200
@@ -259,7 +259,7 @@ static void update_thread(void)
  fail:
 	sigio_lock();
 	if(write_sigio_pid != -1) 
-		os_kill_process(write_sigio_pid, 1);
+		os_kill_process(write_sigio_pid, 1, 0);
 	write_sigio_pid = -1;
 	os_close_file(sigio_private[0]);
 	os_close_file(sigio_private[1]);
@@ -386,7 +386,7 @@ void write_sigio_workaround(void)
 	return;
 
  out_kill:
-	os_kill_process(write_sigio_pid, 1);
+	os_kill_process(write_sigio_pid, 1, 0);
 	write_sigio_pid = -1;
  out_close2:
 	os_close_file(sigio_private[0]);
@@ -419,7 +419,7 @@ int read_sigio_fd(int fd)
 static void sigio_cleanup(void)
 {
 	if(write_sigio_pid != -1)
-		os_kill_process(write_sigio_pid, 1);
+		os_kill_process(write_sigio_pid, 1, 0);
 }
 
 __uml_exitcall(sigio_cleanup);


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
