Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZEFn-0002Md-J7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 12:05:39 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CZEFm-0000l0-Rs for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 12:05:39 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041130200848.2A3DD8BAFE@zion.localdomain>
Subject: [uml-devel] [patch 2/2] uml: finish fixing run_helper failure path
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
Date: Tue, 30 Nov 2004 21:08:48 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Fix some bugs left in the failure path of run_helper by the previous patch: it
was missing one

os_close_file(fds[1])

which is conditional. To use the goto handling model, I set the fd to -1 if
it's already closed (I don't want to check if keeping one more pipe-end open
is no problem).

Also do some cosmethic cleanup:

* "err" was what we returned even on success, so just use a neutral "ret".

* use tabs, not spaces.

* a little more comments.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/arch/um/drivers/net_user.c |    3 -
 linux-2.6.10-rc-paolo/arch/um/kernel/helper.c    |   48 ++++++++++++-----------
 2 files changed, 29 insertions(+), 22 deletions(-)

diff -puN arch/um/kernel/helper.c~uml-finish-fixing-helper-failure-path arch/um/kernel/helper.c
--- linux-2.6.10-rc/arch/um/kernel/helper.c~uml-finish-fixing-helper-failure-path	2004-11-30 21:08:16.526952792 +0100
+++ linux-2.6.10-rc-paolo/arch/um/kernel/helper.c	2004-11-30 21:08:16.530952184 +0100
@@ -49,14 +49,14 @@ static int helper_child(void *arg)
 	return(0);
 }
 
-/* XXX The alloc_stack here breaks if this is called in the tracing thread */
-
+/* Returns either the pid of the child process we run or -E* on failure.
+ * XXX The alloc_stack here breaks if this is called in the tracing thread */
 int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv,
 	       unsigned long *stack_out)
 {
 	struct helper_data data;
 	unsigned long stack, sp;
-	int pid, fds[2], err, n;
+	int pid, fds[2], ret, n;
 
 	if((stack_out != NULL) && (*stack_out != 0))
 		stack = *stack_out;
@@ -64,16 +64,16 @@ int run_helper(void (*pre_exec)(void *),
 	if(stack == 0)
 		return(-ENOMEM);
 
-	err = os_pipe(fds, 1, 0);
-	if(err < 0){
-		printk("run_helper : pipe failed, err = %d\n", -err);
+	ret = os_pipe(fds, 1, 0);
+	if(ret < 0){
+		printk("run_helper : pipe failed, ret = %d\n", -ret);
 		goto out_free;
 	}
 
-	err = os_set_exec_close(fds[1], 1);
-	if(err < 0){
-		printk("run_helper : setting FD_CLOEXEC failed, err = %d\n",
-		       -err);
+	ret = os_set_exec_close(fds[1], 1);
+	if(ret < 0){
+		printk("run_helper : setting FD_CLOEXEC failed, ret = %d\n",
+		       -ret);
 		goto out_close;
 	}
 
@@ -85,30 +85,36 @@ int run_helper(void (*pre_exec)(void *),
 	pid = clone(helper_child, (void *) sp, CLONE_VM | SIGCHLD, &data);
 	if(pid < 0){
 		printk("run_helper : clone failed, errno = %d\n", errno);
-		err = -errno;
+		ret = -errno;
 		goto out_close;
 	}
 
 	os_close_file(fds[1]);
-	n = os_read_file(fds[0], &err, sizeof(err));
+	fds[1] = -1;
+
+	/*Read the errno value from the child.*/
+	n = os_read_file(fds[0], &ret, sizeof(ret));
 	if(n < 0){
-		printk("run_helper : read on pipe failed, err = %d\n", -n);
-		err = n;
+		printk("run_helper : read on pipe failed, ret = %d\n", -n);
+		ret = n;
 		os_kill_process(pid, 1);
 	}
 	else if(n != 0){
 		CATCH_EINTR(n = waitpid(pid, NULL, 0));
-		pid = -errno;
+		ret = -errno;
+	} else {
+		ret = pid;
 	}
-	err = pid;
 
- out_close:
+out_close:
+	if (fds[1] != -1)
+		os_close_file(fds[1]);
 	os_close_file(fds[0]);
- out_free:
+out_free:
 	if(stack_out == NULL)
 		free_stack(stack, 0);
-        else *stack_out = stack;
-	return(err);
+	else *stack_out = stack;
+	return(ret);
 }
 
 int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags, 
@@ -139,7 +145,7 @@ int run_helper_thread(int (*proc)(void *
 			       "0x%x\n", status);
 		free_stack(stack, stack_order);
 	}
-        else *stack_out = stack;
+	else *stack_out = stack;
 	return(pid);
 }
 
diff -puN arch/um/drivers/net_user.c~uml-finish-fixing-helper-failure-path arch/um/drivers/net_user.c
--- linux-2.6.10-rc/arch/um/drivers/net_user.c~uml-finish-fixing-helper-failure-path	2004-11-30 21:08:16.528952488 +0100
+++ linux-2.6.10-rc-paolo/arch/um/drivers/net_user.c	2004-11-30 21:08:16.530952184 +0100
@@ -177,7 +177,8 @@ static int change_tramp(char **argv, cha
 	os_close_file(fds[0]);
 	os_close_file(fds[1]);
 
-	CATCH_EINTR(err = waitpid(pid, NULL, 0));
+	if (pid > 0)
+		CATCH_EINTR(err = waitpid(pid, NULL, 0));
 	return(pid);
 }
 
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
