Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdakQ-0003ne-Vv for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Jun 2004 13:23:02 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BdakP-0003BN-FV for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Jun 2004 13:23:01 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: [PATCH] The fix for: Re: [uml-devel] Kernel panic: handle_trap -
	failed to wait at end of syscall, ...
References: <000f01c45593$35c20e00$0201a8c0@hawk>
	<40D831B2.8060108@nortelnetworks.com>
	<20040622154320.GA28615@ccure.user-mode-linux.org>
In-Reply-To: <20040622154320.GA28615@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fdc2AemGIaV1xNK"
Message-Id: <200406232009.35109.blaisorblade_spam@yahoo.it>
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
Date: Wed, 23 Jun 2004 20:09:35 +0200
To: Jeff Dike <jdike@addtoit.com>, Joe Marzot <gmarzot@nortelnetworks.com>
Cc: "Christopher S. Aker" <caker@theshore.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>



--Boundary-00=_fdc2AemGIaV1xNK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 17:43, marted=EC 22 giugno 2004, Jeff Dike ha scritto:
> On Tue, Jun 22, 2004 at 09:18:42AM -0400, Joe Marzot wrote:
> > would this be something simple like
> >
> > do {
> >    err =3D waitpid(pid, &status, WUNTRACED);
> > } while ((err < 0) && (errno =3D=3D EINTR));
>
> Yup, it would be that simple.

Since this is needed in so many places (see the attached patch to realize),=
=20
I've decided to write a macro for this:

#define CATCH_EINTR(expr) while ( ((expr) < 0) && errno =3D=3D EINTR)

I found this to be the more natural way. In some cases it would have been=20
useful if CATCH_EINTR were a rvalue, but this could be workarounded, and th=
e=20
original form gave more problems (sometimes I had no "err" available, and=20
adding it was useless):

#define CATCH_EINTR(err, expr) do { (err) =3D (expr); } while (((err) < 0) =
&&=20
(errno =3D=3D EINTR))

I also built the attached patch, which adds a few usages of it. If you grep=
=20
for waitpid() you'll find a lot more ones, I just did not catch them all.

Plus the ones for other calls; there is a ton of them; grep your man pages=
=20
with

bzgrep -l EINTR /usr/share/man/man2/* |sed -e 's!.*/!!;s!\.2\.bz2!!'

(use zgrep if needed) to get a raw feeling of how much there are (some of=20
these are bogus references, anyway).

I'm going to compile all this, ASAP I'll post the second version which will=
=20
actually compile :-)!

Bye
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_fdc2AemGIaV1xNK
Content-Type: text/x-diff; charset="iso-8859-1"; name="EINTR_safety.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="EINTR_safety.patch"

---

 uml-linux-2.6.7-paolo/arch/um/drivers/net_user.c               |    3 +-
 uml-linux-2.6.7-paolo/arch/um/drivers/slip_user.c              |    6 +++--
 uml-linux-2.6.7-paolo/arch/um/drivers/slirp_user.c             |    8 +++----
 uml-linux-2.6.7-paolo/arch/um/include/user_util.h              |    1 
 uml-linux-2.6.7-paolo/arch/um/kernel/frame.c                   |    8 ++++---
 uml-linux-2.6.7-paolo/arch/um/kernel/helper.c                  |    3 +-
 uml-linux-2.6.7-paolo/arch/um/kernel/process.c                 |   11 +++++-----
 uml-linux-2.6.7-paolo/arch/um/kernel/skas/exec_user.c          |    6 +++--
 uml-linux-2.6.7-paolo/arch/um/kernel/skas/process.c            |    6 ++---
 uml-linux-2.6.7-paolo/arch/um/kernel/trap_user.c               |    9 +++++++-
 uml-linux-2.6.7-paolo/arch/um/kernel/tt/exec_user.c            |    9 ++++++--
 uml-linux-2.6.7-paolo/arch/um/kernel/tt/ptproxy/proxy.c        |    4 +--
 uml-linux-2.6.7-paolo/arch/um/kernel/tt/tracer.c               |    4 +--
 uml-linux-2.6.7-paolo/arch/um/kernel/user_util.c               |   10 +++------
 uml-linux-2.6.7-paolo/arch/um/os-Linux/drivers/ethertap_user.c |    4 ++-
 uml-linux-2.6.7-paolo/arch/um/os-Linux/drivers/tuntap_user.c   |    3 +-
 uml-linux-2.6.7-paolo/arch/um/os-Linux/process.c               |    3 +-
 17 files changed, 61 insertions(+), 37 deletions(-)

diff -puN arch/um/kernel/skas/process.c~EINTR_safety arch/um/kernel/skas/process.c
--- uml-linux-2.6.7/arch/um/kernel/skas/process.c~EINTR_safety	2004-06-23 18:28:50.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/skas/process.c	2004-06-23 19:48:54.000000000 +0200
@@ -81,7 +81,7 @@ static void handle_trap(int pid, union u
 			panic("handle_trap - continuing to end of syscall failed, "
 			      "errno = %d\n", errno);
 
-		err = waitpid(pid, &status, WUNTRACED);
+		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
 		if((err < 0) || !WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
 			panic("handle_trap - failed to wait at end of syscall, "
 			      "errno = %d, status = %d\n", errno, status);
@@ -121,7 +121,7 @@ void start_userspace(int cpu)
 		panic("start_userspace : clone failed, errno = %d", errno);
 
 	do {
-		n = waitpid(pid, &status, WUNTRACED);
+		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if(n < 0)
 			panic("start_userspace : wait failed, errno = %d", 
 			      errno);
@@ -154,7 +154,7 @@ void userspace(union uml_pt_regs *regs)
 		panic("userspace - PTRACE_SYSCALL failed, errno = %d\n", 
 		       errno);
 	while(1){
-		err = waitpid(pid, &status, WUNTRACED);
+		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
 		if(err < 0)
 			panic("userspace - waitpid failed, errno = %d\n", 
 			      errno);
diff -puN arch/um/include/user_util.h~EINTR_safety arch/um/include/user_util.h
--- uml-linux-2.6.7/arch/um/include/user_util.h~EINTR_safety	2004-06-23 18:29:42.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/include/user_util.h	2004-06-23 19:46:19.000000000 +0200
@@ -92,6 +92,7 @@ extern void arch_init_thread(void);
 extern int __raw(int fd, int complain, int now);
 #define raw(fd, complain) __raw((fd), (complain), 1)
 
+#define CATCH_EINTR(expr) while ( ((expr) < 0) && errno == EINTR)
 #endif
 
 /*
diff -puN arch/um/kernel/user_util.c~EINTR_safety arch/um/kernel/user_util.c
--- uml-linux-2.6.7/arch/um/kernel/user_util.c~EINTR_safety	2004-06-23 18:30:03.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/user_util.c	2004-06-23 20:04:19.000000000 +0200
@@ -81,11 +81,10 @@ int wait_for_stop(int pid, int sig, int 
 	int status, ret;
 
 	while(1){
-		ret = waitpid(pid, &status, WUNTRACED);
+		CATCH_EINTR(ret = waitpid(pid, &status, WUNTRACED));
 		if((ret < 0) ||
 		   !WIFSTOPPED(status) || (WSTOPSIG(status) != sig)){
 			if(ret < 0){
-				if(errno == EINTR) continue;
 				printk("wait failed, errno = %d\n",
 				       errno);
 			}
@@ -125,8 +124,7 @@ int __raw(int fd, int complain, int now)
 	int err;
 	int when;
 
-	while (((err = tcgetattr(fd, &tt)) < 0) && errno == EINTR)
-		;
+	CATCH_EINTR(err = tcgetattr(fd, &tt));
 
 	if (err < 0) {
 		if (complain)
@@ -141,8 +139,8 @@ int __raw(int fd, int complain, int now)
 	else
 		when = TCSADRAIN;
 
-	while (((err = tcsetattr(fd, when, &tt)) < 0) && errno == EINTR)
-		;
+	CATCH_EINTR(err = tcsetattr(fd, when, &tt));
+
 	if (err < 0) {
 		if (complain)
 			printk("tcsetattr failed, errno = %d\n", errno);
diff -puN arch/um/kernel/process.c~EINTR_safety arch/um/kernel/process.c
--- uml-linux-2.6.7/arch/um/kernel/process.c~EINTR_safety	2004-06-23 18:43:16.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/process.c	2004-06-23 20:04:19.000000000 +0200
@@ -125,7 +125,7 @@ int start_fork_tramp(void *thread_arg, u
 	/* Start the process and wait for it to kill itself */
 	new_pid = clone(outer_tramp, (void *) sp, clone_flags, &arg);
 	if(new_pid < 0) return(-errno);
-	while(((err = waitpid(new_pid, &status, 0)) < 0) && (errno == EINTR)) ;
+	CATCH_EINTR(err = waitpid(new_pid, &status, 0));
 	if(err < 0) panic("Waiting for outer trampoline failed - errno = %d", 
 			  errno);
 	if(!WIFSIGNALED(status) || (WTERMSIG(status) != SIGKILL))
@@ -171,7 +171,7 @@ static int start_ptraced_child(void **st
 	pid = clone(ptrace_child, (void *) sp, SIGCHLD, NULL);
 	if(pid < 0)
 		panic("check_ptrace : clone failed, errno = %d", errno);
-	n = waitpid(pid, &status, WUNTRACED);
+	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 	if(n < 0)
 		panic("check_ptrace : wait failed, errno = %d", errno);
 	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP))
@@ -188,7 +188,7 @@ static void stop_ptraced_child(int pid, 
 
 	if(ptrace(PTRACE_CONT, pid, 0, 0) < 0)
 		panic("check_ptrace : ptrace failed, errno = %d", errno);
-	n = waitpid(pid, &status, 0);
+	CATCH_EINTR(n = waitpid(pid, &status, 0));
 	if(!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode))
 		panic("check_ptrace : child exited with status 0x%x", status);
 
@@ -224,7 +224,7 @@ void __init check_ptrace(void)
 		if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
 			panic("check_ptrace : ptrace failed, errno = %d", 
 			      errno);
-		n = waitpid(pid, &status, WUNTRACED);
+		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if(n < 0)
 			panic("check_ptrace : wait failed, errno = %d", errno);
 		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
@@ -251,7 +251,8 @@ void __init check_ptrace(void)
 	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) >= 0) {
 		struct user_regs_struct regs;
 
-		if (waitpid(pid, &status, WUNTRACED) < 0)
+		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+		if (n < 0)
 			panic("check_ptrace : wait failed, errno = %d", errno);
 		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
 			panic("check_ptrace : expected SIGTRAP, "
diff -puN arch/um/kernel/frame.c~EINTR_safety arch/um/kernel/frame.c
--- uml-linux-2.6.7/arch/um/kernel/frame.c~EINTR_safety	2004-06-23 18:46:29.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/frame.c	2004-06-23 20:04:19.000000000 +0200
@@ -21,6 +21,7 @@
 #include "sysdep/sigcontext.h"
 #include "frame_user.h"
 #include "kern_util.h"
+#include "user_util.h"
 #include "ptrace_user.h"
 #include "os.h"
 
@@ -40,7 +41,7 @@ static int capture_stack(int (*child)(vo
 	/* Wait for it to stop itself and continue it with a SIGUSR1 to force 
 	 * it into the signal handler.
 	 */
-	n = waitpid(pid, &status, WUNTRACED);
+	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 	if(n < 0){
 		printf("capture_stack : waitpid failed - errno = %d\n", errno);
 		exit(1);
@@ -60,7 +61,7 @@ static int capture_stack(int (*child)(vo
 	 * At this point, the handler has stuffed the addresses of
 	 * sig, sc, and SA_RESTORER in raw.
 	 */
-	n = waitpid(pid, &status, WUNTRACED);
+	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 	if(n < 0){
 		printf("capture_stack : waitpid failed - errno = %d\n", errno);
 		exit(1);
@@ -82,7 +83,8 @@ static int capture_stack(int (*child)(vo
 		       errno);
 		exit(1);
 	}
-	if(waitpid(pid, &status, 0) < 0){
+	CATCH_EINTR(n = waitpid(pid, &status, 0));
+	if(n < 0){
 		printf("capture_stack : waitpid failed - errno = %d\n", errno);
 		exit(1);
 	}
diff -puN arch/um/drivers/net_user.c~EINTR_safety arch/um/drivers/net_user.c
--- uml-linux-2.6.7/arch/um/drivers/net_user.c~EINTR_safety	2004-06-23 19:35:31.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/drivers/net_user.c	2004-06-23 20:05:42.000000000 +0200
@@ -175,7 +175,8 @@ static int change_tramp(char **argv, cha
 
 	os_close_file(fds[1]);
 	read_output(fds[0], output, output_len);
-	waitpid(pid, NULL, 0);	
+
+	CATCH_EINTR(err = waitpid(pid, NULL, 0));
 	return(pid);
 }
 
diff -puN arch/um/drivers/slip_user.c~EINTR_safety arch/um/drivers/slip_user.c
--- uml-linux-2.6.7/arch/um/drivers/slip_user.c~EINTR_safety	2004-06-23 19:35:32.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/drivers/slip_user.c	2004-06-23 20:04:19.000000000 +0200
@@ -4,7 +4,7 @@
 #include <stddef.h>
 #include <sched.h>
 #include <string.h>
-#include <sys/errno.h>
+#include <errno.h>
 #include <sys/termios.h>
 #include <sys/wait.h>
 #include <sys/signal.h>
@@ -100,7 +100,9 @@ static int slip_tramp(char **argv, int f
 			printk("%s", output);
 			kfree(output);
 		}
-		if(waitpid(pid, &status, 0) < 0) err = errno;
+		CATCH_EINTR(err = waitpid(pid, &status, 0));
+		if(err < 0)
+			err = errno;
 		else if(!WIFEXITED(status) || (WEXITSTATUS(status) != 0)){
 			printk("'%s' didn't exit with status 0\n", argv[0]);
 			err = -EINVAL;
diff -puN arch/um/drivers/slirp_user.c~EINTR_safety arch/um/drivers/slirp_user.c
--- uml-linux-2.6.7/arch/um/drivers/slirp_user.c~EINTR_safety	2004-06-23 19:35:33.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/drivers/slirp_user.c	2004-06-23 20:04:19.000000000 +0200
@@ -4,7 +4,7 @@
 #include <stddef.h>
 #include <sched.h>
 #include <string.h>
-#include <sys/errno.h>
+#include <errno.h>
 #include <sys/wait.h>
 #include <sys/signal.h>
 #include "user_util.h"
@@ -113,13 +113,13 @@ static void slirp_close(int fd, void *da
 	}
 #endif
 
-	err = waitpid(pri->pid, &status, WNOHANG);
-	if(err<0) {
+	CATCH_EINTR(err = waitpid(pri->pid, &status, WNOHANG));
+	if(err < 0) {
 		printk("slirp_close: waitpid returned %d\n", errno);
 		return;
 	}
 
-	if(err==0) {
+	if(err == 0) {
 		printk("slirp_close: process %d has not exited\n");
 		return;
 	}
diff -puN arch/um/kernel/helper.c~EINTR_safety arch/um/kernel/helper.c
--- uml-linux-2.6.7/arch/um/kernel/helper.c~EINTR_safety	2004-06-23 19:35:34.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/helper.c	2004-06-23 20:04:19.000000000 +0200
@@ -12,6 +12,7 @@
 #include <sys/wait.h>
 #include "user.h"
 #include "kern_util.h"
+#include "user_util.h"
 #include "os.h"
 
 struct helper_data {
@@ -96,7 +97,7 @@ int run_helper(void (*pre_exec)(void *),
 		goto out_kill;
 	}
 	else if(n != 0){
-		waitpid(pid, NULL, 0);
+		CATCH_EINTR(n = waitpid(pid, NULL, 0));
 		pid = -errno;
 	}
 
diff -puN arch/um/kernel/skas/exec_user.c~EINTR_safety arch/um/kernel/skas/exec_user.c
--- uml-linux-2.6.7/arch/um/kernel/skas/exec_user.c~EINTR_safety	2004-06-23 19:35:36.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/skas/exec_user.c	2004-06-23 20:04:19.000000000 +0200
@@ -11,6 +11,7 @@
 #include <sys/ptrace.h>
 #include "user.h"
 #include "kern_util.h"
+#include "user_util.h"
 #include "os.h"
 #include "time_user.h"
 
@@ -26,7 +27,7 @@ static int user_thread_tramp(void *arg)
 
 int user_thread(unsigned long stack, int flags)
 {
-	int pid, status;
+	int pid, status, err;
 
 	pid = clone(user_thread_tramp, (void *) stack_sp(stack), 
 		    flags | CLONE_FILES | SIGCHLD, NULL);
@@ -35,7 +36,8 @@ int user_thread(unsigned long stack, int
 		return(pid);
 	}
 
-	if(waitpid(pid, &status, WUNTRACED) < 0){
+	CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
+	if(err < 0){
 		printk("user_thread - waitpid failed, errno = %d\n", errno);
 		return(-errno);
 	}
diff -puN arch/um/kernel/trap_user.c~EINTR_safety arch/um/kernel/trap_user.c
--- uml-linux-2.6.7/arch/um/kernel/trap_user.c~EINTR_safety	2004-06-23 19:35:37.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/trap_user.c	2004-06-23 20:04:19.000000000 +0200
@@ -32,7 +32,14 @@ void kill_child_dead(int pid)
 {
 	kill(pid, SIGKILL);
 	kill(pid, SIGCONT);
-	while(waitpid(pid, NULL, 0) > 0) kill(pid, SIGCONT);
+	do {
+		int n;
+		CATCH_EINTR(n = waitpid(pid, NULL, 0));
+		if (n > 0)
+			kill(pid, SIGCONT);
+		else
+			break;
+	} while(1);
 }
 
 /* Unlocked - don't care if this is a bit off */
diff -puN arch/um/kernel/tt/exec_user.c~EINTR_safety arch/um/kernel/tt/exec_user.c
--- uml-linux-2.6.7/arch/um/kernel/tt/exec_user.c~EINTR_safety	2004-06-23 19:35:38.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/tt/exec_user.c	2004-06-23 20:04:19.000000000 +0200
@@ -19,13 +19,18 @@
 void do_exec(int old_pid, int new_pid)
 {
 	unsigned long regs[FRAME_SIZE];
+	int err;
 
 	if((ptrace(PTRACE_ATTACH, new_pid, 0, 0) < 0) ||
-	   (ptrace(PTRACE_CONT, new_pid, 0, 0) < 0) ||
-	   (waitpid(new_pid, 0, WUNTRACED) < 0))
+	   (ptrace(PTRACE_CONT, new_pid, 0, 0) < 0))
 		tracer_panic("do_exec failed to attach proc - errno = %d",
 			     errno);
 
+	CATCH_EINTR(err = waitpid(new_pid, 0, WUNTRACED));
+	if (err < 0)
+		tracer_panic("do_exec failed to attach proc in waitpid - errno = %d",
+			     errno);
+
 	if(ptrace_getregs(old_pid, regs) < 0)
 		tracer_panic("do_exec failed to get registers - errno = %d",
 			     errno);
diff -puN arch/um/kernel/tt/ptproxy/proxy.c~EINTR_safety arch/um/kernel/tt/ptproxy/proxy.c
--- uml-linux-2.6.7/arch/um/kernel/tt/ptproxy/proxy.c~EINTR_safety	2004-06-23 19:35:40.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/tt/ptproxy/proxy.c	2004-06-23 20:04:19.000000000 +0200
@@ -272,7 +272,7 @@ void fake_child_exit(void)
 
 	child_proxy(1, W_EXITCODE(0, 0));
 	while(debugger.waiting == 1){
-		pid = waitpid(debugger.pid, &status, WUNTRACED);
+		CATCH_EINTR(pid = waitpid(debugger.pid, &status, WUNTRACED));
 		if(pid != debugger.pid){
 			printk("fake_child_exit - waitpid failed, "
 			       "errno = %d\n", errno);
@@ -280,7 +280,7 @@ void fake_child_exit(void)
 		}
 		debugger_proxy(status, debugger.pid);
 	}
-	pid = waitpid(debugger.pid, &status, WUNTRACED);
+	CATCH_EINTR(pid = waitpid(debugger.pid, &status, WUNTRACED));
 	if(pid != debugger.pid){
 		printk("fake_child_exit - waitpid failed, "
 		       "errno = %d\n", errno);
diff -puN arch/um/kernel/tt/tracer.c~EINTR_safety arch/um/kernel/tt/tracer.c
--- uml-linux-2.6.7/arch/um/kernel/tt/tracer.c~EINTR_safety	2004-06-23 19:35:41.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/tt/tracer.c	2004-06-23 20:04:19.000000000 +0200
@@ -192,7 +192,7 @@ int tracer(int (*init_proc)(void *), voi
 	printf("tracing thread pid = %d\n", tracing_pid);
 
 	pid = clone(signal_tramp, sp, CLONE_FILES | SIGCHLD, init_proc);
-	n = waitpid(pid, &status, WUNTRACED);
+	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 	if(n < 0){
 		printf("waitpid on idle thread failed, errno = %d\n", errno);
 		exit(1);
@@ -233,7 +233,7 @@ int tracer(int (*init_proc)(void *), voi
 	}
 	set_cmdline("(tracing thread)");
 	while(1){
-		pid = waitpid(-1, &status, WUNTRACED);
+		CATCH_EINTR(pid = waitpid(-1, &status, WUNTRACED));
 		if(pid <= 0){
 			if(errno != ECHILD){
 				printf("wait failed - errno = %d\n", errno);
diff -puN arch/um/os-Linux/drivers/ethertap_user.c~EINTR_safety arch/um/os-Linux/drivers/ethertap_user.c
--- uml-linux-2.6.7/arch/um/os-Linux/drivers/ethertap_user.c~EINTR_safety	2004-06-23 19:35:43.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/os-Linux/drivers/ethertap_user.c	2004-06-23 20:04:19.000000000 +0200
@@ -16,6 +16,7 @@
 #include <net/if.h>
 #include "user.h"
 #include "kern_util.h"
+#include "user_util.h"
 #include "net_user.h"
 #include "etap.h"
 #include "helper.h"
@@ -125,7 +126,8 @@ static int etap_tramp(char *dev, char *g
 	if(c != 1){
 		printk("etap_tramp : uml_net failed\n");
 		err = -EINVAL;
-		if(waitpid(pid, &status, 0) < 0)
+		CATCH_EINTR(n = waitpid(pid, &status, 0));
+		if(n < 0)
 			err = -errno;
 		else if(!WIFEXITED(status) || (WEXITSTATUS(status) != 1))
 			printk("uml_net didn't exit with status 1\n");
diff -puN arch/um/os-Linux/drivers/tuntap_user.c~EINTR_safety arch/um/os-Linux/drivers/tuntap_user.c
--- uml-linux-2.6.7/arch/um/os-Linux/drivers/tuntap_user.c~EINTR_safety	2004-06-23 19:35:45.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/os-Linux/drivers/tuntap_user.c	2004-06-23 20:04:19.000000000 +0200
@@ -18,6 +18,7 @@
 #include "net_user.h"
 #include "tuntap.h"
 #include "kern_util.h"
+#include "user_util.h"
 #include "user.h"
 #include "helper.h"
 #include "os.h"
@@ -108,7 +109,7 @@ static int tuntap_open_tramp(char *gate,
 		       errno);
 		return(-errno);
 	}
-	waitpid(pid, NULL, 0);
+	CATCH_EINTR(waitpid(pid, NULL, 0));
 
 	cmsg = CMSG_FIRSTHDR(&msg);
 	if(cmsg == NULL){
diff -puN arch/um/os-Linux/process.c~EINTR_safety arch/um/os-Linux/process.c
--- uml-linux-2.6.7/arch/um/os-Linux/process.c~EINTR_safety	2004-06-23 19:35:46.000000000 +0200
+++ uml-linux-2.6.7-paolo/arch/um/os-Linux/process.c	2004-06-23 20:04:19.000000000 +0200
@@ -12,6 +12,7 @@
 #include <sys/wait.h>
 #include "os.h"
 #include "user.h"
+#include "user_util.h"
 
 #define ARBITRARY_ADDR -1
 #define FAILURE_PID    -1
@@ -87,7 +88,7 @@ void os_kill_process(int pid, int reap_c
 {
 	kill(pid, SIGKILL);
 	if(reap_child)
-		waitpid(pid, NULL, 0);
+		CATCH_EINTR(waitpid(pid, NULL, 0));
 		
 }
 

_

--Boundary-00=_fdc2AemGIaV1xNK--




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
