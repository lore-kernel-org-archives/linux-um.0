Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DGiHZ-00015E-F9 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 10:51:13 -0800
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DGiHY-0002a4-Ht for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 10:51:13 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050330173341.41F25EFED3@zion>
Subject: [uml-devel] [patch 1/8] uml: fix sigio spinlock [for 2.6.12]
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
Date: Wed, 30 Mar 2005 19:33:41 +0200
To: torvalds@osdl.org
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


I just saw a "take twice spinlock" deadlock with the Spinlock debugging
enabled on this lock, and static code analysis revealed this is the culprit:
update_thread can take (in an error path) the sigio_lock, which is already
held by all its callers (it's a static function, so it's easy to verify).

Added some comments to mark where this function needs the lock, in case
someone wants to reduce the locking here.

Also clean an exitcall to mark the thread as killed (won't hurt, and could
be useful if things go wrong).

As a bonus, some CodingStyle cleanups.

This should go in 2.6.12 for its simplicity and usefulness.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/sigio_user.c |   29 ++++++++++---------------
 1 files changed, 12 insertions(+), 17 deletions(-)

diff -puN arch/um/kernel/sigio_user.c~uml-fix-sigio-spinlock arch/um/kernel/sigio_user.c
--- linux-2.6.11/arch/um/kernel/sigio_user.c~uml-fix-sigio-spinlock	2005-03-24 11:37:00.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/sigio_user.c	2005-03-24 11:37:00.000000000 +0100
@@ -108,12 +108,14 @@ static void tty_output(int master, int s
 		panic("check_sigio : write failed, errno = %d\n", errno);
 	while(((n = os_read_file(slave, buf, sizeof(buf))) > 0) && !got_sigio) ;
 
-	if(got_sigio){
+	if (got_sigio) {
 		printk("Yes\n");
 		pty_output_sigio = 1;
+	} else if (n == -EAGAIN) {
+		printk("No, enabling workaround\n");
+	} else {
+		panic("check_sigio : read failed, err = %d\n", n);
 	}
-	else if(n == -EAGAIN) printk("No, enabling workaround\n");
-	else panic("check_sigio : read failed, err = %d\n", n);
 }
 
 static void tty_close(int master, int slave)
@@ -235,6 +237,8 @@ static int need_poll(int n)
 	return(0);
 }
 
+/* Must be called with sigio_lock held, because it's needed by the marked
+ * critical section. */
 static void update_thread(void)
 {
 	unsigned long flags;
@@ -257,7 +261,7 @@ static void update_thread(void)
 	set_signals(flags);
 	return;
  fail:
-	sigio_lock();
+	/* Critical section start */
 	if(write_sigio_pid != -1) 
 		os_kill_process(write_sigio_pid, 1);
 	write_sigio_pid = -1;
@@ -265,7 +269,7 @@ static void update_thread(void)
 	os_close_file(sigio_private[1]);
 	os_close_file(write_sigio_fds[0]);
 	os_close_file(write_sigio_fds[1]);
-	sigio_unlock();
+	/* Critical section end */
 	set_signals(flags);
 }
 
@@ -418,19 +422,10 @@ int read_sigio_fd(int fd)
 
 static void sigio_cleanup(void)
 {
-	if(write_sigio_pid != -1)
+	if (write_sigio_pid != -1) {
 		os_kill_process(write_sigio_pid, 1);
+		write_sigio_pid = -1;
+	}
 }
 
 __uml_exitcall(sigio_cleanup);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
_


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
