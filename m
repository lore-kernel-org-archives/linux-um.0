Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J0P1A-0005nO-8m for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2007 14:16:28 -0800
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J0P17-0004SR-P3
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2007 14:16:26 -0800
From: Stanislaw Gruszka <stf_xl@wp.pl>
Date: Thu, 6 Dec 2007 23:21:24 +0100
References: <200712051853.45801.stf_xl@wp.pl>
	<20071206013920.GA10961@c2.user-mode-linux.org>
In-Reply-To: <20071206013920.GA10961@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200712062321.25013.stf_xl@wp.pl>
Subject: Re: [uml-devel] [PATCH] Avoid not intended gdb breakpoints removal
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thursday 06 December 2007 02:39, Jeff Dike wrote:
> This has bugged me forever, and I was too scared to go into gdb to
> figure out what its problem was.
:-)  I considered "debugging a debugger" as something strange but doable.
 
> A couple of comments:
> 1 - I think I would prefer to use __WCLONE instead of __WALL since
> we know what type of process we are creating, and it seems clearer in
> the code to say specifically what we want
I removed __WALL where possible. Some functions still use it, because must
wait for any kind of child.

> 1a - I think I would like to stick all those waits under some API in
> helper.c as we already have an interface for creating children, and as
> it stands now, the callers have knowlege about the internal aspects of
> child creation that they probably shouldn't.
Ok, I changed a little helper_wait() function and use it for drivers. 

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
index 90d7f2e..29185ca 100644
--- a/arch/um/drivers/net_user.c
+++ b/arch/um/drivers/net_user.c
@@ -201,7 +201,7 @@ static int change_tramp(char **argv, char *output, int output_len)
 	close(fds[1]);

 	if (pid > 0)
-		CATCH_EINTR(err = waitpid(pid, NULL, 0));
+		helper_wait(pid, 0, "change_tramp");
 	return pid;
 }

diff --git a/arch/um/drivers/slip_user.c b/arch/um/drivers/slip_user.c
index 5f06204..a97d942 100644
--- a/arch/um/drivers/slip_user.c
+++ b/arch/um/drivers/slip_user.c
@@ -109,15 +109,7 @@ static int slip_tramp(char **argv, int fd)
 	read_output(fds[0], output, output_len);
 	printk("%s", output);

-	CATCH_EINTR(err = waitpid(pid, &status, 0));
-	if (err < 0)
-		err = errno;
-	else if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0)) {
-		printk(UM_KERN_ERR "'%s' didn't exit with status 0\n", argv[0]);
-		err = -EINVAL;
-	}
-	else err = 0;
-
+	err = helper_wait(pid, 0, argv[0]);
 	close(fds[0]);

 out_free:
diff --git a/arch/um/drivers/slirp_user.c b/arch/um/drivers/slirp_user.c
index 1865089..89c1be2 100644
--- a/arch/um/drivers/slirp_user.c
+++ b/arch/um/drivers/slirp_user.c
@@ -79,7 +79,7 @@ out:
 static void slirp_close(int fd, void *data)
 {
 	struct slirp_data *pri = data;
-	int status,err;
+	int err;

 	close(fd);
 	close(pri->slave);
@@ -98,18 +98,9 @@ static void slirp_close(int fd, void *data)
 		       "(%d)\n", pri->pid, errno);
 	}
 #endif
-
-	CATCH_EINTR(err = waitpid(pri->pid, &status, WNOHANG));
-	if (err < 0) {
-		printk(UM_KERN_ERR "slirp_close: waitpid returned %d\n", errno);
-		return;
-	}
-
-	if (err == 0) {
-		printk(UM_KERN_ERR "slirp_close: process %d has not exited\n",
-		       pri->pid);
+	err = helper_wait(pri->pid, 1, "slirp_close");
+	if (err < 0)
 		return;
-	}

 	pri->pid = -1;
 }
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index 41d254b..48fc745 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -49,8 +49,7 @@ int start_io_thread(unsigned long sp, int *fd_out)
 		goto out_close;
 	}

-	pid = clone(io_thread, (void *) sp, CLONE_FILES | CLONE_VM | SIGCHLD,
-		    NULL);
+	pid = clone(io_thread, (void *) sp, CLONE_FILES | CLONE_VM, NULL);
 	if(pid < 0){
 		err = -errno;
 		printk("start_io_thread - clone failed : errno = %d\n", errno);
diff --git a/arch/um/include/os.h b/arch/um/include/os.h
index fbf0a87..6f0d1c7 100644
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -214,7 +214,7 @@ extern int execvp_noalloc(char *buf, const char *file, char *const argv[]);
 extern int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv);
 extern int run_helper_thread(int (*proc)(void *), void *arg,
 			     unsigned int flags, unsigned long *stack_out);
-extern int helper_wait(int pid);
+extern int helper_wait(int pid, int nohang, char *pname);


 /* tls.c */
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
index 4ff5536..07ca0cb 100644
--- a/arch/um/os-Linux/drivers/ethertap_user.c
+++ b/arch/um/os-Linux/drivers/ethertap_user.c
@@ -94,7 +94,7 @@ static int etap_tramp(char *dev, char *gate, int control_me,
 		      int control_remote, int data_me, int data_remote)
 {
 	struct etap_pre_exec_data pe_data;
-	int pid, status, err, n;
+	int pid, err, n;
 	char version_buf[sizeof("nnnnn\0")];
 	char data_fd_buf[sizeof("nnnnnn\0")];
 	char gate_buf[sizeof("nnn.nnn.nnn.nnn\0")];
@@ -131,13 +131,7 @@ static int etap_tramp(char *dev, char *gate, int control_me,
 	}
 	if (c != 1) {
 		printk(UM_KERN_ERR "etap_tramp : uml_net failed\n");
-		err = -EINVAL;
-		CATCH_EINTR(n = waitpid(pid, &status, 0));
-		if (n < 0)
-			err = -errno;
-		else if (!WIFEXITED(status) || (WEXITSTATUS(status) != 1))
-			printk(UM_KERN_ERR "uml_net didn't exit with "
-			       "status 1\n");
+		err = helper_wait(pid, 0, "uml_net");
 	}
 	return err;
 }
diff --git a/arch/um/os-Linux/drivers/tuntap_user.c b/arch/um/os-Linux/drivers/tuntap_user.c
index 6c55d3c..7b38289 100644
--- a/arch/um/os-Linux/drivers/tuntap_user.c
+++ b/arch/um/os-Linux/drivers/tuntap_user.c
@@ -107,7 +107,7 @@ static int tuntap_open_tramp(char *gate, int *fd_out, int me, int remote,
 		       "errno = %d\n", errno);
 		return err;
 	}
-	CATCH_EINTR(waitpid(pid, NULL, 0));
+	helper_wait(pid, 0, "tuntap_open_tramp");

 	cmsg = CMSG_FIRSTHDR(&msg);
 	if (cmsg == NULL) {
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 7a72dbb..813b15d 100644
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
+		CATCH_EINTR(waitpid(pid, NULL, __WCLONE));
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
+		CATCH_EINTR(pid = waitpid(pid, &status, __WCLONE));
 		if (pid < 0) {
 			err = -errno;
 			printk("run_helper_thread - wait failed, errno = %d\n",
@@ -150,14 +150,29 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 	return pid;
 }

-int helper_wait(int pid)
+int helper_wait(int pid, int nohang, char *pname)
 {
-	int ret;
+	int ret, status;
+	int wflags = __WCLONE;

-	CATCH_EINTR(ret = waitpid(pid, NULL, WNOHANG));
+	if (nohang)
+		wflags |= WNOHANG;
+
+	if (!pname)
+		pname = "helper_wait";
+
+	CATCH_EINTR(ret = waitpid(pid, &status, wflags));
 	if (ret < 0) {
-		ret = -errno;
-		printk("helper_wait : waitpid failed, errno = %d\n", errno);
-	}
-	return ret;
+		printk("%s : waitpid process %d failed, errno = %d\n",
+		        pname, pid, errno);
+		return -errno;
+	} else if (nohang && ret == 0) {
+		printk("%s : process %d has not exited\n", pname, pid);
+		return -ECHILD;
+	} else if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
+		printk(UM_KERN_ERR "%s : process %d didn't exit with status 0\n",
+		       pname, pid);
+		return -ECHILD;
+	} else
+		return 0;
 }
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
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index d77c81d..e8b7a97 100644
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
+		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED | __WALL));
 		if ((err < 0) || !WIFSTOPPED(status) ||
 		   (WSTOPSIG(status) != SIGTRAP + 0x80)) {
                         err = ptrace_dump_regs(pid);
@@ -255,16 +255,18 @@ int start_userspace(unsigned long stub_stack)
 		panic("start_userspace : mmap failed, errno = %d", errno);
 	sp = (unsigned long) stack + UM_KERN_PAGE_SIZE - sizeof(void *);

-	flags = CLONE_FILES | SIGCHLD;
+	flags = CLONE_FILES;
 	if (proc_mm)
 		flags |= CLONE_VM;
+	else
+		flags |= SIGCHLD;

 	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
 	if (pid < 0)
 		panic("start_userspace : clone failed, errno = %d", errno);

 	do {
-		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
 		if (n < 0)
 			panic("start_userspace : wait failed, errno = %d",
 			      errno);
@@ -314,7 +316,7 @@ void userspace(struct uml_pt_regs *regs)
 			      "pid=%d, ptrace operation = %d, errno = %d\n",
 			      pid, op, errno);

-		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
+		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED | __WALL));
 		if (err < 0)
 			panic("userspace - waitpid failed, errno = %d\n",
 			      errno);
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
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
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
