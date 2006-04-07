Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRs0k-0003Gb-5d for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:30 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRs0j-0003Zp-0W
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:30 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060407143117.19201.85132.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 12/17] uml: fix hang on run_helper() failure on
	uml_net
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
Date: Fri, 07 Apr 2006 16:31:17 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix an hang on a pipe when run_helper() fails when called by change_tramp()
(i.e. when calling uml_net) - reproduced the bug and verified this fixes it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/net_user.c |    4 +++-
 arch/um/os-Linux/helper.c  |   10 +++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
index 0e2f061..0a7786e 100644
--- a/arch/um/drivers/net_user.c
+++ b/arch/um/drivers/net_user.c
@@ -182,7 +182,9 @@ static int change_tramp(char **argv, cha
 	pe_data.stdout = fds[1];
 	pid = run_helper(change_pre_exec, &pe_data, argv, NULL);
 
-	read_output(fds[0], output, output_len);
+	if (pid > 0)	/* Avoid hang as we won't get data in failure case. */
+		read_output(fds[0], output, output_len);
+
 	os_close_file(fds[0]);
 	os_close_file(fds[1]);
 
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 6490a4f..6987d1d 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -43,7 +43,7 @@ static int helper_child(void *arg)
 		(*data->pre_exec)(data->pre_data);
 	execvp(argv[0], argv);
 	errval = errno;
-	printk("execvp of '%s' failed - errno = %d\n", argv[0], errno);
+	printk("helper_child - execve of '%s' failed - errno = %d\n", argv[0], errno);
 	os_write_file(data->fd, &errval, sizeof(errval));
 	kill(os_getpid(), SIGKILL);
 	return(0);
@@ -92,15 +92,15 @@ int run_helper(void (*pre_exec)(void *),
 	close(fds[1]);
 	fds[1] = -1;
 
-	/*Read the errno value from the child.*/
+	/* Read the errno value from the child, if the exec failed, or get 0 if
+	 * the exec succeeded because the pipe fd was set as close-on-exec. */
 	n = os_read_file(fds[0], &ret, sizeof(ret));
-	if(n < 0){
+	if (n < 0) {
 		printk("run_helper : read on pipe failed, ret = %d\n", -n);
 		ret = n;
 		kill(pid, SIGKILL);
 		CATCH_EINTR(waitpid(pid, NULL, 0));
-	}
-	else if(n != 0){
+	} else if(n != 0){
 		CATCH_EINTR(n = waitpid(pid, NULL, 0));
 		ret = -errno;
 	} else {


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
