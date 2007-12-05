Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IzyMk-0002xK-5b for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2007 09:48:58 -0800
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IzyMf-00053k-1u
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2007 09:48:56 -0800
Received: from ccn138.neoplus.adsl.tpnet.pl (HELO asus.local)
	(stf_xl@wp.pl@[83.30.137.138]) (envelope-sender <stf_xl@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	5 Dec 2007 18:48:44 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
Date: Wed, 5 Dec 2007 18:53:45 +0100
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200712051853.45801.stf_xl@wp.pl>
Subject: [uml-devel] [PATCH] Avoid not intended gdb breakpoints removal
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
To: user-mode-linux-devel@lists.sourceforge.net

Hi.

Sometimes when UML is debugged gdb miss breakpoints.  

When process traced by gdb do fork, debugger remove breakpoints from child
address space. There is possibility to trace more than one fork, but this not
work with UML, I guess (only guess) there is a deadlock - gdb waits for UML 
and UML waits for gdb.  

When clone() is called with SIGCHLD and CLONE_VM flags, gdb see this as 
PTRACE_EVENT_FORK not as PTRACE_EVENT_CLONE and remove breakpoints 
from child and at the same time from traced process, because either have
the same address space.

Maybe it is possible to do fix in gdb, but I'm not sure if there is easy way to
findout if traced and child processes share memory. So I do fix for UML,
it simply do not call clone() with both SIGCHLD and CLONE_VM flags together. 
Additionally __WALL flag is used for waitpid() to assure not miss clone
and normal process events.

-- 
Regards
Stanislaw Gruszka

diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
index 90d7f2e..09d497a 100644
--- a/arch/um/drivers/net_user.c
+++ b/arch/um/drivers/net_user.c
@@ -201,7 +201,7 @@ static int change_tramp(char **argv, char *output, int output_len)
 	close(fds[1]);

 	if (pid > 0)
-		CATCH_EINTR(err = waitpid(pid, NULL, 0));
+		CATCH_EINTR(err = waitpid(pid, NULL, __WALL));
 	return pid;
 }

diff --git a/arch/um/drivers/port_kern.c b/arch/um/drivers/port_kern.c
diff --git a/arch/um/drivers/slip_user.c b/arch/um/drivers/slip_user.c
index 5f06204..ffc473d 100644
--- a/arch/um/drivers/slip_user.c
+++ b/arch/um/drivers/slip_user.c
@@ -109,7 +109,7 @@ static int slip_tramp(char **argv, int fd)
 	read_output(fds[0], output, output_len);
 	printk("%s", output);

-	CATCH_EINTR(err = waitpid(pid, &status, 0));
+	CATCH_EINTR(err = waitpid(pid, &status, __WALL));
 	if (err < 0)
 		err = errno;
 	else if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0)) {
diff --git a/arch/um/drivers/slirp_user.c b/arch/um/drivers/slirp_user.c
index 1865089..f8b0987 100644
--- a/arch/um/drivers/slirp_user.c
+++ b/arch/um/drivers/slirp_user.c
@@ -99,7 +99,7 @@ static void slirp_close(int fd, void *data)
 	}
 #endif

-	CATCH_EINTR(err = waitpid(pri->pid, &status, WNOHANG));
+	CATCH_EINTR(err = waitpid(pri->pid, &status, WNOHANG | __WALL));
 	if (err < 0) {
 		printk(UM_KERN_ERR "slirp_close: waitpid returned %d\n", errno);
 		return;
diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index 41d254b..875b1f3 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -49,7 +49,7 @@ int start_io_thread(unsigned long sp, int *fd_out)
 		goto out_close;
 	}

-	pid = clone(io_thread, (void *) sp, CLONE_FILES | CLONE_VM | SIGCHLD,
+	pid = clone(io_thread, (void *) sp, CLONE_FILES | CLONE_VM,
 		    NULL);
 	if(pid < 0){
 		err = -errno;
diff --git a/arch/um/drivers/xterm.c b/arch/um/drivers/xterm.c
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
diff --git a/arch/um/kernel/syscall.c b/arch/um/kernel/syscall.c
diff --git a/arch/um/os-Linux/aio.c b/arch/um/os-Linux/aio.c
index 4158118..93dc0c8 100644
--- a/arch/um/os-Linux/aio.c
+++ b/arch/um/os-Linux/aio.c
@@ -218,7 +218,7 @@ static int init_aio_24(void)
 		goto out_close_pipe;

 	err = run_helper_thread(not_aio_thread, NULL,
-				CLONE_FILES | CLONE_VM | SIGCHLD, &aio_stack);
+				CLONE_FILES | CLONE_VM, &aio_stack);
 	if (err < 0)
 		goto out_close_pipe;

@@ -254,7 +254,7 @@ static int init_aio_26(void)
 	}

 	err = run_helper_thread(aio_thread, NULL,
-				CLONE_FILES | CLONE_VM | SIGCHLD, &aio_stack);
+				CLONE_FILES | CLONE_VM, &aio_stack);
 	if (err < 0)
 		return err;

diff --git a/arch/um/os-Linux/drivers/ethertap_user.c b/arch/um/os-Linux/drivers/ethertap_user.c
index 4ff5536..99d3a50 100644
--- a/arch/um/os-Linux/drivers/ethertap_user.c
+++ b/arch/um/os-Linux/drivers/ethertap_user.c
@@ -132,7 +132,7 @@ static int etap_tramp(char *dev, char *gate, int control_me,
 	if (c != 1) {
 		printk(UM_KERN_ERR "etap_tramp : uml_net failed\n");
 		err = -EINVAL;
-		CATCH_EINTR(n = waitpid(pid, &status, 0));
+		CATCH_EINTR(n = waitpid(pid, &status, __WALL));
 		if (n < 0)
 			err = -errno;
 		else if (!WIFEXITED(status) || (WEXITSTATUS(status) != 1))
diff --git a/arch/um/os-Linux/drivers/tuntap_user.c b/arch/um/os-Linux/drivers/tuntap_user.c
index 6c55d3c..ff52a58 100644
--- a/arch/um/os-Linux/drivers/tuntap_user.c
+++ b/arch/um/os-Linux/drivers/tuntap_user.c
@@ -107,7 +107,7 @@ static int tuntap_open_tramp(char *gate, int *fd_out, int me, int remote,
 		       "errno = %d\n", errno);
 		return err;
 	}
-	CATCH_EINTR(waitpid(pid, NULL, 0));
+	CATCH_EINTR(waitpid(pid, NULL, __WALL));

 	cmsg = CMSG_FIRSTHDR(&msg);
 	if (cmsg == NULL) {
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 7a72dbb..2201b99 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -76,7 +76,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 	data.fd = fds[1];
 	data.buf = __cant_sleep() ? kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
 					kmalloc(PATH_MAX, UM_GFP_KERNEL);
-	pid = clone(helper_child, (void *) sp, CLONE_VM | SIGCHLD, &data);
+	pid = clone(helper_child, (void *) sp, CLONE_VM, &data);
 	if (pid < 0) {
 		ret = -errno;
 		printk("run_helper : clone failed, errno = %d\n", errno);
@@ -101,7 +101,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 			ret = n;
 			kill(pid, SIGKILL);
 		}
-		CATCH_EINTR(waitpid(pid, NULL, 0));
+		CATCH_EINTR(waitpid(pid, NULL, __WALL));
 	}

 out_free2:
@@ -126,7 +126,7 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 		return -ENOMEM;

 	sp = stack + UM_KERN_PAGE_SIZE - sizeof(void *);
-	pid = clone(proc, (void *) sp, flags | SIGCHLD, arg);
+	pid = clone(proc, (void *) sp, flags, arg);
 	if (pid < 0) {
 		err = -errno;
 		printk("run_helper_thread : clone failed, errno = %d\n",
@@ -134,7 +134,7 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 		return err;
 	}
 	if (stack_out == NULL) {
-		CATCH_EINTR(pid = waitpid(pid, &status, 0));
+		CATCH_EINTR(pid = waitpid(pid, &status, __WALL));
 		if (pid < 0) {
 			err = -errno;
 			printk("run_helper_thread - wait failed, errno = %d\n",
@@ -154,7 +154,7 @@ int helper_wait(int pid)
 {
 	int ret;

-	CATCH_EINTR(ret = waitpid(pid, NULL, WNOHANG));
+	CATCH_EINTR(ret = waitpid(pid, NULL, WNOHANG | __WALL));
 	if (ret < 0) {
 		ret = -errno;
 		printk("helper_wait : waitpid failed, errno = %d\n", errno);
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 37781db..bda5c31 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -101,7 +101,7 @@ void os_kill_process(int pid, int reap_child)
 {
 	kill(pid, SIGKILL);
 	if (reap_child)
-		CATCH_EINTR(waitpid(pid, NULL, 0));
+		CATCH_EINTR(waitpid(pid, NULL, __WALL));
 }

 /* This is here uniquely to have access to the userspace errno, i.e. the one
@@ -130,7 +130,7 @@ void os_kill_ptraced_process(int pid, int reap_child)
 	ptrace(PTRACE_KILL, pid);
 	ptrace(PTRACE_CONT, pid);
 	if (reap_child)
-		CATCH_EINTR(waitpid(pid, NULL, 0));
+		CATCH_EINTR(waitpid(pid, NULL, __WALL));
 }

 /* Don't use the glibc version, which caches the result in TLS. It misses some
diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index d77c81d..634fa31 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -64,7 +64,7 @@ void wait_stub_done(int pid)
 	int n, status, err;

 	while (1) {
-		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
 		if ((n < 0) || !WIFSTOPPED(status))
 			goto bad_wait;

@@ -153,7 +153,7 @@ static void handle_trap(int pid, struct uml_pt_regs *regs,
 			panic("handle_trap - continuing to end of syscall "
 			      "failed, errno = %d\n", errno);

-		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
+		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED |__WALL));
 		if ((err < 0) || !WIFSTOPPED(status) ||
 		   (WSTOPSIG(status) != SIGTRAP + 0x80)) {
                         err = ptrace_dump_regs(pid);
@@ -255,16 +255,19 @@ int start_userspace(unsigned long stub_stack)
 		panic("start_userspace : mmap failed, errno = %d", errno);
 	sp = (unsigned long) stack + UM_KERN_PAGE_SIZE - sizeof(void *);

-	flags = CLONE_FILES | SIGCHLD;
+	flags = CLONE_FILES;
 	if (proc_mm)
 		flags |= CLONE_VM;
-
+	else {
+		flags |= SIGCHLD;
+	}
+
 	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
 	if (pid < 0)
 		panic("start_userspace : clone failed, errno = %d", errno);

 	do {
-		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
 		if (n < 0)
 			panic("start_userspace : wait failed, errno = %d",
 			      errno);
@@ -314,7 +317,7 @@ void userspace(struct uml_pt_regs *regs)
 			      "pid=%d, ptrace operation = %d, errno = %d\n",
 			      pid, op, errno);

-		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
+		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED | __WALL));
 		if (err < 0)
 			panic("userspace - waitpid failed, errno = %d\n",
 			      errno);
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 7b81f6c..6adebd0 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -101,7 +101,7 @@ static int start_ptraced_child(void)
 	else if (pid < 0)
 		fatal_perror("start_ptraced_child : fork failed");

-	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
 	if (n < 0)
 		fatal_perror("check_ptrace : waitpid failed");
 	if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP))
@@ -123,7 +123,7 @@ static int stop_ptraced_child(int pid, int exitcode, int mustexit)

 	if (ptrace(PTRACE_CONT, pid, 0, 0) < 0)
 		fatal_perror("stop_ptraced_child : ptrace failed");
-	CATCH_EINTR(n = waitpid(pid, &status, 0));
+	CATCH_EINTR(n = waitpid(pid, &status, __WALL));
 	if (!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode)) {
 		int exit_with = WEXITSTATUS(status);
 		if (exit_with == 2)
@@ -198,7 +198,7 @@ static void __init check_sysemu(void)
 	if (ptrace(PTRACE_SYSEMU, pid, 0, 0) < 0)
 		goto fail;

-	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
 	if (n < 0)
 		fatal_perror("check_sysemu : wait failed");
 	if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
@@ -238,7 +238,7 @@ static void __init check_sysemu(void)
 		count++;
 		if (ptrace(PTRACE_SYSEMU_SINGLESTEP, pid, 0, 0) < 0)
 			goto fail;
-		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
 		if (n < 0)
 			fatal_perror("check_ptrace : wait failed");

@@ -291,7 +291,7 @@ static void __init check_ptrace(void)
 		if (ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
 			fatal_perror("check_ptrace : ptrace failed");

-		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
 		if (n < 0)
 			fatal_perror("check_ptrace : wait failed");

diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index ef09543..3e058ce 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -141,7 +141,7 @@ void os_dump_core(void)
 	 * nothing reasonable to do if that fails.
 	 */

-	while ((pid = waitpid(-1, NULL, WNOHANG)) > 0)
+	while ((pid = waitpid(-1, NULL, WNOHANG | __WALL)) > 0)
 		os_kill_ptraced_process(pid, 0);

 	abort();
  

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
