Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CMTg3-0008IL-5h for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Oct 2004 08:56:03 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CMTg1-0003Mq-Qn for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Oct 2004 08:56:03 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VOnfBZJmH7Mj8G1"
Message-Id: <200410261756.05087.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] UML/Debian hwclock bug identified.
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
Date: Tue, 26 Oct 2004 17:56:05 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Matt Zimmerman <mdz@debian.org>


--Boundary-00=_VOnfBZJmH7Mj8G1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Finally, with my new broadband connection, I downloaded the Debian root_fs and 
finally identified the patch (it's part of 2.4.24-2) containing the bug.

However, sadly, the patch causing it is the fix for the "I'm tracing myself 
and can't get out" bug. It is attached in two parts.

I've split the patch in two part, but however without part-2 the patch does 
not work *at all*: when starting /sbin/init glibc throws out some messages 
and IIRC hangs; probably there is an unfixed SIGSEGV, because it can't read 
the mmap()'ed memory.

The idea for splitting out the 2nd part is that it allows UML to get an 
infinite number of segfaults, in a loop, which can actually happen. Sadly, 
I've not yet been able to debug it (I've never debugged UML in TT mode).

In fact, with this patch applied, a compiler bug showed up: the gcc-3.3.2 
(hammer branch) included in Mandrake miscompiles UML. In TT mode it still 
works, but only if this patch is excluded.

Also, this patch is also applied on 2.6 kernels, so it's quite important to 
fix it.

I've also seen this comment, which does not make sense to me:

+       /* This is done because to allow SIGSEGV to be delivered inside a SEGV
+        * handler.  This can happen in copy_user, and if SEGV is disabled,
+        * the process will die.
+        */
+       if(sig == SIGSEGV)
+               change_sig(SIGSEGV, 1);
+

If SIGSEGV is blocked, it will just be queued and/or ignored (no more than one 
signal can stay in the queue); in the 2nd case, the process will get it 
again. Could you take a look at this issue, Jeff?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_VOnfBZJmH7Mj8G1
Content-Type: text/x-diff; charset="us-ascii";
	name="SIG-filehandle-changes-part-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="SIG-filehandle-changes-part-2.patch"

diff -u um-linux-2.4.27-paolo/arch/um/kernel/process.c um-linux-2.4.27-paolo/arch/um/kernel/process.c
--- um-linux-2.4.27-paolo/arch/um/kernel/process.c	2004-10-26 11:27:13.932302432 +0200
+++ um-linux-2.4.27-paolo/arch/um/kernel/process.c	2004-10-23 04:37:19.392835272 +0200
@@ -56,11 +56,7 @@
 {
 	int flags = altstack ? SA_ONSTACK : 0;
 
-	/* NODEFER is set here because SEGV isn't turned back on when the
-	 * handler is ready to receive signals.  This causes any segfault
-	 * during a copy_user to kill the process because the fault is blocked.
-	 */
-	set_handler(SIGSEGV, (__sighandler_t) sig_handler, flags | SA_NODEFER,
+	set_handler(SIGSEGV, (__sighandler_t) sig_handler, flags,
 		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
 	set_handler(SIGTRAP, (__sighandler_t) sig_handler, flags,
 		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
diff -u um-linux-2.4.27-paolo/arch/um/kernel/tt/trap_user.c um-linux-2.4.27-paolo/arch/um/kernel/tt/trap_user.c
--- um-linux-2.4.27-paolo/arch/um/kernel/tt/trap_user.c	2004-10-26 11:27:13.934302128 +0200
+++ um-linux-2.4.27-paolo/arch/um/kernel/tt/trap_user.c	2004-10-23 04:37:19.394834968 +0200
@@ -23,6 +23,13 @@
 
 	unprotect_kernel_mem();
 
+	/* This is done because to allow SIGSEGV to be delivered inside a SEGV
+	 * handler.  This can happen in copy_user, and if SEGV is disabled,
+	 * the process will die.
+	 */
+	if(sig == SIGSEGV)
+		change_sig(SIGSEGV, 1);
+
 	r = &TASK_REGS(get_current())->tt;
 	save_regs = *r;
 	is_user = user_context(SC_SP(sc));

--Boundary-00=_VOnfBZJmH7Mj8G1
Content-Type: text/x-diff; charset="us-ascii";
	name="SIG-fileHandle-changes.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="SIG-fileHandle-changes.patch"


=46rom Jeff Dike's changelog:
=46ixed an exit on reboot by disabling all possible sources of pending sign=
als.

At least I think this is the change he speaks about.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
=2D--

 um-linux-2.4.27-paolo/arch/um/include/irq_user.h         |    1=20
 um-linux-2.4.27-paolo/arch/um/include/os.h               |    1=20
 um-linux-2.4.27-paolo/arch/um/include/time_user.h        |    1=20
 um-linux-2.4.27-paolo/arch/um/kernel/irq_user.c          |   14 ++++++++++=
+++
 um-linux-2.4.27-paolo/arch/um/kernel/process.c           |    2 -
 um-linux-2.4.27-paolo/arch/um/kernel/sigio_kern.c        |   14 ++++++++--=
=2D--
 um-linux-2.4.27-paolo/arch/um/kernel/skas/process_kern.c |    2 -
 um-linux-2.4.27-paolo/arch/um/kernel/time.c              |    9 ++++++++
 um-linux-2.4.27-paolo/arch/um/kernel/tt/exec_kern.c      |    3 ++
 um-linux-2.4.27-paolo/arch/um/kernel/tt/process_kern.c   |   16 ++++++++++=
+++++
 um-linux-2.4.27-paolo/arch/um/kernel/tt/trap_user.c      |    2 -
 um-linux-2.4.27-paolo/arch/um/main.c                     |   14 ++++++++++=
+++
 um-linux-2.4.27-paolo/arch/um/os-Linux/file.c            |   10 +++++++++
 13 files changed, 80 insertions(+), 9 deletions(-)

diff -puN arch/um/include/irq_user.h~SIG-fileHandle-changes arch/um/include=
/irq_user.h
=2D-- um-linux-2.4.27/arch/um/include/irq_user.h~SIG-fileHandle-changes	200=
4-10-26 11:24:00.681680992 +0200
+++ um-linux-2.4.27-paolo/arch/um/include/irq_user.h	2004-10-26 11:27:13.93=
0302736 +0200
@@ -14,6 +14,7 @@ extern void free_irq_by_irq_and_dev(int=20
 extern void free_irq_by_fd(int fd);
 extern void reactivate_fd(int fd, int irqnum);
 extern void deactivate_fd(int fd, int irqnum);
+extern int deactivate_all_fds(void);
 extern void forward_interrupts(int pid);
 extern void init_irq_signals(int on_sigstack);
 extern void forward_ipi(int fd, int pid);
diff -puN arch/um/include/os.h~SIG-fileHandle-changes arch/um/include/os.h
=2D-- um-linux-2.4.27/arch/um/include/os.h~SIG-fileHandle-changes	2004-10-2=
6 11:24:00.683680688 +0200
+++ um-linux-2.4.27-paolo/arch/um/include/os.h	2004-10-26 11:27:13.93130258=
4 +0200
@@ -140,6 +140,7 @@ extern int os_file_size(char *file, long
 extern int os_file_modtime(char *file, unsigned long *modtime);
 extern int os_pipe(int *fd, int stream, int close_on_exec);
 extern int os_set_fd_async(int fd, int owner);
+extern int os_clear_fd_async(int fd);
 extern int os_set_fd_block(int fd, int blocking);
 extern int os_accept_connection(int fd);
 extern int os_create_unix_socket(char *file, int len, int close_on_exec);
diff -puN arch/um/include/time_user.h~SIG-fileHandle-changes arch/um/includ=
e/time_user.h
=2D-- um-linux-2.4.27/arch/um/include/time_user.h~SIG-fileHandle-changes	20=
04-10-26 11:24:00.684680536 +0200
+++ um-linux-2.4.27-paolo/arch/um/include/time_user.h	2004-10-26 11:27:13.9=
31302584 +0200
@@ -11,6 +11,7 @@ extern void switch_timers(int to_real);
 extern void set_interval(int timer_type);
 extern void idle_sleep(int secs);
 extern void enable_timer(void);
+extern void disable_timer(void);
 extern unsigned long time_lock(void);
 extern void time_unlock(unsigned long);
=20
diff -puN arch/um/kernel/irq_user.c~SIG-fileHandle-changes arch/um/kernel/i=
rq_user.c
=2D-- um-linux-2.4.27/arch/um/kernel/irq_user.c~SIG-fileHandle-changes	2004=
=2D10-26 11:24:00.822659560 +0200
+++ um-linux-2.4.27-paolo/arch/um/kernel/irq_user.c	2004-10-26 11:27:13.932=
302432 +0200
@@ -364,6 +364,20 @@ void deactivate_fd(int fd, int irqnum)
 	irq_unlock(flags);
 }
=20
+int deactivate_all_fds(void)
+{
+	struct irq_fd *irq;
+	int err;
+
+	for(irq=3Dactive_fds;irq !=3D NULL;irq =3D irq->next){
+		err =3D os_clear_fd_async(irq->fd);
+		if(err)
+			return(err);
+	}
+
+	return(0);
+}
+
 void forward_ipi(int fd, int pid)
 {
 	int err;
diff -puN arch/um/kernel/process.c~SIG-fileHandle-changes arch/um/kernel/pr=
ocess.c
=2D-- um-linux-2.4.27/arch/um/kernel/process.c~SIG-fileHandle-changes	2004-=
10-26 11:24:01.281589792 +0200
+++ um-linux-2.4.27-paolo/arch/um/kernel/process.c	2004-10-26 11:27:13.9323=
02432 +0200
@@ -73,7 +73,7 @@ void init_new_thread_signals(int altstac
 	set_handler(SIGWINCH, (__sighandler_t) sig_handler, flags,
 		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
 	set_handler(SIGUSR2, (__sighandler_t) sig_handler,
=2D		    SA_NOMASK | flags, -1);
+		    flags, SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
 	signal(SIGHUP, SIG_IGN);
=20
 	init_irq_signals(altstack);
diff -puN arch/um/kernel/sigio_kern.c~SIG-fileHandle-changes arch/um/kernel=
/sigio_kern.c
=2D-- um-linux-2.4.27/arch/um/kernel/sigio_kern.c~SIG-fileHandle-changes	20=
04-10-26 11:24:01.282589640 +0200
+++ um-linux-2.4.27-paolo/arch/um/kernel/sigio_kern.c	2004-10-26 11:27:13.9=
33302280 +0200
@@ -15,7 +15,7 @@
 /* Protected by sigio_lock() called from write_sigio_workaround */
 static int sigio_irq_fd =3D -1;
=20
=2Dvoid sigio_interrupt(int irq, void *data, struct pt_regs *unused)
+static void sigio_interrupt(int irq, void *data, struct pt_regs *unused)
 {
 	read_sigio_fd(sigio_irq_fd);
 	reactivate_fd(sigio_irq_fd, SIGIO_WRITE_IRQ);
@@ -23,10 +23,14 @@ void sigio_interrupt(int irq, void *data
=20
 int write_sigio_irq(int fd)
 {
=2D	if(um_request_irq(SIGIO_WRITE_IRQ, fd, IRQ_READ, sigio_interrupt,
=2D			  SA_INTERRUPT | SA_SAMPLE_RANDOM, "write sigio",
=2D			  NULL)){
=2D		printk("write_sigio_irq : um_request_irq failed\n");
+	int err;
+
+	err =3D um_request_irq(SIGIO_WRITE_IRQ, fd, IRQ_READ, sigio_interrupt,
+			     SA_INTERRUPT | SA_SAMPLE_RANDOM, "write sigio",
+			     NULL);
+	if(err){
+		printk("write_sigio_irq : um_request_irq failed, err =3D %d\n",
+		       err);
 		return(-1);
 	}
 	sigio_irq_fd =3D fd;
diff -puN arch/um/kernel/skas/process_kern.c~SIG-fileHandle-changes arch/um=
/kernel/skas/process_kern.c
=2D-- um-linux-2.4.27/arch/um/kernel/skas/process_kern.c~SIG-fileHandle-cha=
nges	2004-10-26 11:24:01.283589488 +0200
+++ um-linux-2.4.27-paolo/arch/um/kernel/skas/process_kern.c	2004-10-26 11:=
27:13.933302280 +0200
@@ -161,9 +161,9 @@ int start_uml_skas(void)
 {
 	start_userspace(0);
 	capture_signal_stack();
=2D	idle_timer();
=20
 	init_new_thread_signals(1);
+	idle_timer();
=20
 	init_task.thread.request.u.thread.proc =3D start_kernel_proc;
 	init_task.thread.request.u.thread.arg =3D NULL;
diff -puN arch/um/kernel/time.c~SIG-fileHandle-changes arch/um/kernel/time.c
=2D-- um-linux-2.4.27/arch/um/kernel/time.c~SIG-fileHandle-changes	2004-10-=
26 11:24:01.284589336 +0200
+++ um-linux-2.4.27-paolo/arch/um/kernel/time.c	2004-10-26 11:27:13.9333022=
80 +0200
@@ -47,6 +47,15 @@ void enable_timer(void)
 		       errno);
 }
=20
+void disable_timer(void)
+{
+	struct itimerval disable =3D ((struct itimerval) { { 0, 0 }, { 0, 0 }});
+	if((setitimer(ITIMER_VIRTUAL, &disable, NULL) < 0) ||
+	   (setitimer(ITIMER_REAL, &disable, NULL) < 0))
+		printk("disnable_timer - setitimer failed, errno =3D %d\n",
+		       errno);
+}
+
 void switch_timers(int to_real)
 {
 	struct itimerval disable =3D ((struct itimerval) { { 0, 0 }, { 0, 0 }});
diff -puN arch/um/kernel/tt/exec_kern.c~SIG-fileHandle-changes arch/um/kern=
el/tt/exec_kern.c
=2D-- um-linux-2.4.27/arch/um/kernel/tt/exec_kern.c~SIG-fileHandle-changes	=
2004-10-26 11:24:01.297587360 +0200
+++ um-linux-2.4.27-paolo/arch/um/kernel/tt/exec_kern.c	2004-10-26 11:27:13=
=2E933302280 +0200
@@ -14,6 +14,7 @@
 #include "irq_user.h"
 #include "time_user.h"
 #include "mem_user.h"
+#include "signal_user.h"
 #include "os.h"
 #include "tlb.h"
 #include "mode.h"
@@ -53,7 +54,9 @@ void flush_thread_tt(void)
 	current->thread.request.u.exec.pid =3D new_pid;
 	unprotect_stack((unsigned long) current);
 	os_usr1_process(os_getpid());
+	change_sig(SIGUSR1, 1);
=20
+	change_sig(SIGUSR1, 0);
 	enable_timer();
 	free_page(stack);
 	protect_memory(uml_reserved, high_physmem - uml_reserved, 1, 1, 0, 1);
diff -puN arch/um/kernel/tt/process_kern.c~SIG-fileHandle-changes arch/um/k=
ernel/tt/process_kern.c
=2D-- um-linux-2.4.27/arch/um/kernel/tt/process_kern.c~SIG-fileHandle-chang=
es	2004-10-26 11:24:01.298587208 +0200
+++ um-linux-2.4.27-paolo/arch/um/kernel/tt/process_kern.c	2004-10-26 11:27=
:13.934302128 +0200
@@ -142,6 +142,12 @@ static void new_thread_handler(int sig)
 	sti();
 	if(!run_kernel_thread(fn, arg, &current->thread.exec_buf))
 		do_exit(0);
+
+	/* XXX No set_user_mode here because a newly execed process will
+	 * immediately segfault on its non-existent IP, coming straight back
+	 * to the signal handler, which will call set_user_mode on its way
+	 * out.  This should probably change since it's confusing.
+	 */
 }
=20
 static int new_thread_proc(void *stack)
@@ -162,6 +168,7 @@ static int new_thread_proc(void *stack)
 	cli();
 	init_new_thread_stack(stack, new_thread_handler);
 	os_usr1_process(os_getpid());
+	change_sig(SIGUSR1, 1);
 	return(0);
 }
=20
@@ -204,6 +211,7 @@ int fork_tramp(void *stack)
 	arch_init_thread();
 	init_new_thread_stack(stack, finish_fork_handler);
 	os_usr1_process(os_getpid());
+	change_sig(SIGUSR1, 1);
 	return(0);
 }
=20
@@ -256,6 +264,9 @@ int copy_thread_tt(int nr, unsigned long
 	current->thread.request.op =3D OP_FORK;
 	current->thread.request.u.fork.pid =3D new_pid;
 	os_usr1_process(os_getpid());
+	change_sig(SIGUSR1, 1);
+
+	change_sig(SIGUSR1, 0);
 	return(0);
 }
=20
@@ -263,12 +274,14 @@ void reboot_tt(void)
 {
 	current->thread.request.op =3D OP_REBOOT;
 	os_usr1_process(os_getpid());
+	change_sig(SIGUSR1, 1);
 }
=20
 void halt_tt(void)
 {
 	current->thread.request.op =3D OP_HALT;
 	os_usr1_process(os_getpid());
+	change_sig(SIGUSR1, 1);
 }
=20
 void kill_off_processes_tt(void)
@@ -297,6 +310,9 @@ void initial_thread_cb_tt(void (*proc)(v
 		current->thread.request.u.cb.proc =3D proc;
 		current->thread.request.u.cb.arg =3D arg;
 		os_usr1_process(os_getpid());
+		change_sig(SIGUSR1, 1);
+
+		change_sig(SIGUSR1, 0);
 	}
 }
=20
diff -puN arch/um/kernel/tt/trap_user.c~SIG-fileHandle-changes arch/um/kern=
el/tt/trap_user.c
=2D-- um-linux-2.4.27/arch/um/kernel/tt/trap_user.c~SIG-fileHandle-changes	=
2004-10-26 11:24:01.299587056 +0200
+++ um-linux-2.4.27-paolo/arch/um/kernel/tt/trap_user.c	2004-10-26 11:27:13=
=2E934302128 +0200
@@ -30,7 +30,6 @@ void sig_handler_common_tt(int sig, void
 	if(sig !=3D SIGUSR2)
 		r->syscall =3D -1;
=20
=2D	change_sig(SIGUSR1, 1);
 	info =3D &sig_info[sig];
 	if(!info->is_irq) unblock_signals();
=20
@@ -39,7 +38,6 @@ void sig_handler_common_tt(int sig, void
 	if(is_user){
 		interrupt_end();
 		block_signals();
=2D		change_sig(SIGUSR1, 0);
 		set_user_mode(NULL);
 	}
 	*r =3D save_regs;
diff -puN arch/um/main.c~SIG-fileHandle-changes arch/um/main.c
=2D-- um-linux-2.4.27/arch/um/main.c~SIG-fileHandle-changes	2004-10-26 11:2=
4:01.360577784 +0200
+++ um-linux-2.4.27-paolo/arch/um/main.c	2004-10-26 11:27:13.934302128 +0200
@@ -17,6 +17,8 @@
 #include "kern_util.h"
 #include "mem_user.h"
 #include "signal_user.h"
+#include "time_user.h"
+#include "irq_user.h"
 #include "user.h"
 #include "init.h"
 #include "mode.h"
@@ -147,8 +149,20 @@ int main(int argc, char **argv, char **e
=20
 	/* Reboot */
 	if(ret){
+		int err;
+
 		printf("\n");
=20
+		/* Let any pending signals fire, then disable them.  This
+		 * ensures that they won't be delivered after the exec, when
+		 * they are definitely not expected.
+		 */
+		unblock_signals();
+		disable_timer();
+		err =3D deactivate_all_fds();
+		if(err)
+			printf("deactivate_all_fds failed, errno =3D %d\n", -err);
+
 		execvp(new_argv[0], new_argv);
 		perror("Failed to exec kernel");
 		ret =3D 1;
diff -puN arch/um/os-Linux/file.c~SIG-fileHandle-changes arch/um/os-Linux/f=
ile.c
=2D-- um-linux-2.4.27/arch/um/os-Linux/file.c~SIG-fileHandle-changes	2004-1=
0-26 11:24:01.602541000 +0200
+++ um-linux-2.4.27-paolo/arch/um/os-Linux/file.c	2004-10-26 11:27:13.93530=
1976 +0200
@@ -495,6 +495,16 @@ int os_set_fd_async(int fd, int owner)
 	return(0);
 }
=20
+int os_clear_fd_async(int fd)
+{
+	int flags =3D fcntl(fd, F_GETFL);
+
+	flags &=3D ~(O_ASYNC | O_NONBLOCK);
+	if(fcntl(fd, F_SETFL, flags) < 0)
+		return(-errno);
+	return(0);
+}
+
 int os_set_fd_block(int fd, int blocking)
 {
 	int flags;
_

--Boundary-00=_VOnfBZJmH7Mj8G1--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
