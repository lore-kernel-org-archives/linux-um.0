Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CSc7y-0000RZ-Th for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Nov 2004 06:10:14 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CSc7y-0002y1-4W for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Nov 2004 06:10:14 -0800
Message-ID: <4194C43D.6030107@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [Patch 1/1] uml: fix uml-use-sysemu-for-tt.patch
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
Date: Fri, 12 Nov 2004 15:10:05 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

The patch needs some small corrections:
1) local_using_sysemu must be sampled *before* the next
    ptrace(PTRACE_SYSEMU/SYSCALL) and must stay the same until do_syscall()
    has been done. Currently it is sampled before do_syscall() and is used
    after this for ptrace(PTRACE_SYSEMU/SYSCALL). Even if no problem is
    visible to the UML user, a single syscall could be executed on the host
    when switching on sysemu. The result of this then is overwritten by the
    syscall execution in UML.
    Since the first event the tracer has to handle is not a syscall, it's
    enough to initialize local_using_sysemu to 0;
2) Even if the host never *does* a syscall in SYSEMU, we have to write the
    syscall number with -1, to not have the host doing syscall restarting.
    This would happen only with an invalid syscall number equal to one of
    the -ERESTART values. But to be perfect ...
Additionally I changed do_syscall() to be void instead of int.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

--- a/arch/um/kernel/tt/include/tt.h	2004-11-11 21:27:08.405134680 +0100
+++ b/arch/um/kernel/tt/include/tt.h	2004-11-11 21:27:23.807793120 +0100
@@ -26,7 +26,7 @@ extern void set_tracing(void *t, int tra
  extern int is_tracing(void *task);
  extern void syscall_handler(int sig, union uml_pt_regs *regs);
  extern void exit_kernel(int pid, void *task);
-extern int do_syscall(void *task, int pid, int local_using_sysemu);
+extern void do_syscall(void *task, int pid, int local_using_sysemu);
  extern void do_sigtrap(void *task);
  extern int is_valid_pid(int pid);
  extern void remap_data(void *segment_start, void *segment_end, int w);
--- a/arch/um/kernel/tt/tracer.c	2004-11-12 10:28:46.776498528 +0100
+++ a/arch/um/kernel/tt/tracer.c	2004-11-12 10:34:41.381590360 +0100
@@ -186,7 +186,7 @@ int tracer(int (*init_proc)(void *), voi
  	unsigned long eip = 0;
  	int status, pid = 0, sig = 0, cont_type, tracing = 0, op = 0;
  	int last_index, proc_id = 0, n, err, old_tracing = 0, strace = 0;
-	int pt_syscall_parm, local_using_sysemu;
+	int pt_syscall_parm, local_using_sysemu = 0;

  	signal(SIGPIPE, SIG_IGN);
  	setup_tracer_winch();
@@ -305,9 +305,6 @@ int tracer(int (*init_proc)(void *), voi
  			if ( tracing ) /* Assume: no syscall, when coming from user */
  				do_sigtrap(task);

-			local_using_sysemu = get_using_sysemu();
-			pt_syscall_parm = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
-
  			switch(sig){
  			case SIGUSR1:
  				sig = 0;
@@ -385,6 +382,9 @@ int tracer(int (*init_proc)(void *), voi
  				continue;
  			}

+			local_using_sysemu = get_using_sysemu();
+			pt_syscall_parm = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
+
  			if(tracing){
  				if(singlestepping(task))
  					cont_type = PTRACE_SINGLESTEP;
--- a/arch/um/kernel/tt/syscall_user.c	2004-11-12 10:30:32.181474536 +0100
+++ b/arch/um/kernel/tt/syscall_user.c	2004-11-12 10:41:04.146401264 +0100
@@ -48,7 +48,7 @@ void do_sigtrap(void *task)
  	UPT_SYSCALL_NR(TASK_REGS(task)) = -1;
  }

-int do_syscall(void *task, int pid, int local_using_sysemu)
+void do_syscall(void *task, int pid, int local_using_sysemu)
  {
  	unsigned long proc_regs[FRAME_SIZE];

@@ -61,14 +61,11 @@ int do_syscall(void *task, int pid, int
  	   ((unsigned long *) PT_IP(proc_regs) <= &_etext))
  		tracer_panic("I'm tracing myself and I can't get out");

-	if(local_using_sysemu)
-		return(1);
-
+	/* syscall number -1 in sysemu skips syscall restarting in host */
  	if(ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET,
-		  __NR_getpid) < 0)
+		  local_using_sysemu ? -1 : __NR_getpid) < 0)
  		tracer_panic("do_syscall : Nullifying syscall failed, "
  			     "errno = %d", errno);
-	return(1);
  }

  /*



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
